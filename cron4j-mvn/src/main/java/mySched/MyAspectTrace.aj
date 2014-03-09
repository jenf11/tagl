package mySched;

import it.sauronsoftware.cron4j.Task;
import it.sauronsoftware.cron4j.TaskExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

/**
 * it.sauronsoftware.cron4j
 * User: jennifer
 * Date: 28/02/14
 * Time: 10:57
 *
 */
public aspect MyAspectTrace {

    public static final Logger LOGGER = LoggerFactory.getLogger(MyAspectTrace.class);


    private Map<Task, AtomicLong> counters = new HashMap<Task, AtomicLong>();
    private ThreadLocal<AtomicLong> local = new ThreadLocal<AtomicLong>();

     /*create a new pointcut called run (we can call it whatever we want)
      * the below expression will run when the class runnabletask's method execute
      * is called, with a parameter of TaskExecuteContext.
      */

    pointcut run(TaskExecutionContext context) :
        execution(public void it.sauronsoftware.cron4j.RunnableTask.execute(it.sauronsoftware.cron4j.TaskExecutionContext))
        && args(context);


    /*this is the code that gets inserted before each pointcut. It is known as advice
     * We provide the name of the pointcut it applies to run().
     * In our case wow hello will printed each time. Before(pramaters can go here) parameters
      * can be added in before and after run()
     */
    before(TaskExecutionContext context) : run(context) {
        // We don't use a thread local because we have no guaranty that the task won't be executed by several threads.
        // Actually, it would be surprising for a scheduler to execute the task with the same thread every time, as it
        // won't survive errors.
        // So we use a global map of counter. We are probably creating a memory leak here as we keep a reference on the
        // task object. A weak reference, or just keeping the task hash would fix it.

        // Well, cron4j spawn a new thread per task execution... meaning that thread locals are not really usable.
        // To illustrate this, we implement a version with the TL, and we will see that the counter is always reset.
        // We dump the thread id in the logged message to see the different threads executing the task.

        // Below the two versions: n1 using the global map, n2 the thread local to depict the issue.
        Task task = context.getTaskExecutor().getTask();

        // Code using the global map
        AtomicLong count = counters.get(task);
        if (count == null) {
            count = new AtomicLong(0);
            counters.put(task, count);
        }
        long n1 = count.incrementAndGet();

        // Code using the thread local
        count = local.get();
        if (count == null) {
            count = new AtomicLong(0);
            local.set(count);
        }
        long n2 = count.incrementAndGet();
        LOGGER.info("Calling {} - execution #{},{} - thread[{}]", task, n1, n2, Thread.currentThread().getId());
    }

    after(TaskExecutionContext context) : run(context) {
        Task task = context.getTaskExecutor().getTask();
        // Cannot be null, it was necessarily set in `before`.
        long n1 = counters.get(task).get();
        long n2 = local.get().get();
        LOGGER.info("End of {}#{},{}", task, n1, n2);
    }
}

