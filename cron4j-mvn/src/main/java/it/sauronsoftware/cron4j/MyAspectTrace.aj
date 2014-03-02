package it.sauronsoftware.cron4j;

/**
 * it.sauronsoftware.cron4j
 * User: jennifer
 * Date: 28/02/14
 * Time: 10:57
 *
 */
public aspect MyAspectTrace {
     //create a new pointcut called run (we can call it whatever we want)

    pointcut run() : execution(public void RunnableTask.execute(TaskExecutionContext));


    //this is the code that gets inserted at each point cut before. It is known as advice
    before() : run() {
        System.out.println(" Wow hello");
    }
}
