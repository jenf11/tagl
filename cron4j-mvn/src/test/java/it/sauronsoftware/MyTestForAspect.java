package it.sauronsoftware;

import it.sauronsoftware.cron4j.Scheduler;
import mySched.MyTask;
package it.sauronsoftware;

import it.sauronsoftware.cron4j.CronParser;
import java.util.Date;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;

/**
 * it.sauronsoftware
 * User: jennifer
 * Date: 28/02/14
 * Time: 11:10
 */
public class MyTestForAspect {
    public void run(){
        // Prepares the task.
        MyTask task = new MyTask();
        // Creates the scheduler.
        Scheduler scheduler = new Scheduler();
        // Schedules the task, once every minute.
        scheduler.schedule("* * * * *", task);
        // Starts the scheduler.
        scheduler.start();
        // Stays alive for five minutes.
        try {
            Thread.sleep(5L * 60L * 1000L);
        } catch (InterruptedException e) {
            ;
        }
        // Stops the scheduler.
        scheduler.stop();
    }
}
