package it.sauronsoftware.cron4j;

import org.aspectj.lang.annotation.After;

/**
 * it.sauronsoftware.cron4j
 * User: jennifer
 * Date: 28/02/14
 * Time: 10:57
 *
 */
public aspect MyAspectTrace {
     /*create a new pointcut called run (we can call it whatever we want)
      * the below expression will run when the class runnabletask's method execute
      * is called, with a parameter of TaskExecuteContext.
      */

    pointcut run() : execution(public void RunnableTask.execute(TaskExecutionContext));


    /*this is the code that gets inserted before each pointcut. It is known as advice
     * We provide the name of the pointcut it applies to run().
     * In our case wow hello will printed each time. Before(pramaters can go here) parameters
      * can be added in before and after run()
     */
    before() : run() {
        System.out.println(" Wow hello");
    }

    /*After() : returntypegoes here {
    System.out.println("Done");

    }  */
}

