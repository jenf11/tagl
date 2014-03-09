package it.sauronsoftware;

import it.sauronsoftware.cron4j.Scheduler;
import it.sauronsoftware.cron4j.SchedulingPattern;
import it.sauronsoftware.cron4j.InvalidPatternException;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import mySched.MyTask;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Test;

import java.util.*;

public class TestForAspect {

    @BeforeClass
    public static void testSetup() {
    }

    @AfterClass
    public static void testCleanup() {
        // Teardown for data used by the unit tests
    }

    @Test(expected = InvalidPatternException.class)
    public void testExceptionIsThrown() {
        SchedulingPattern sp = new SchedulingPattern("0 5 * *");
    }

    @Test
    public void testPattern() {
        String pattern;
        pattern = "0 5 * * *|8 10 * * *|22 17 * * *";
        assertTrue(pattern + "is correct", SchedulingPattern.validate(pattern));
        pattern = "0 5 * * *";
        assertTrue(pattern + "is correct", SchedulingPattern.validate(pattern));
        pattern = "* 12 1-15,17,20-25 * *";
        assertTrue(pattern + "is correct", SchedulingPattern.validate(pattern));
    }

    @Test
    public void testForTest() {
        System.out.println("@Test-testForTest");
    }

    @Test
    public void run() {
        System.out.println("@Test-run");
        // Prepares the task.
        MyTask task = new MyTask("task");
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
