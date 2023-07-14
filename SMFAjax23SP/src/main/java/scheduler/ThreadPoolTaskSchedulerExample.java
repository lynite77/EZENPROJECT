package scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.CronTrigger;

import java.util.Date;
import java.util.concurrent.ScheduledFuture;

public class ThreadPoolTaskSchedulerExample {

    private static final int POOL_SIZE = 5;

    private ThreadPoolTaskScheduler taskScheduler;
    private ScheduledFuture<?> scheduledFuture;

    public ThreadPoolTaskSchedulerExample() {
        // ThreadPoolTaskScheduler 생성
        taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(POOL_SIZE);
        taskScheduler.initialize();
    }

    public void startScheduler() {
        // 작업 스케줄링 : 2초마다 작업이 실행
        // scheduledFuture = taskScheduler.schedule(new MyTask(), new CronTrigger("0/2 * * * * ?"));
    	
        // 작업 스케줄링 : 2초마다 작업이 실행
    	scheduledFuture = taskScheduler.scheduleAtFixedRate(new MyTask(), 2000);
    }

    public void stopScheduler() {
        // 작업 스케줄링 중지
        if (scheduledFuture != null) {
            scheduledFuture.cancel(true);
        }
    }

    static class MyTask implements Runnable {
    	int cnt = 0;
        @Override
        public void run() {
            // 스케줄링된 작업의 로직을 여기에 작성합니다.
            System.out.println("스케줄링된 작업 실행 중... cnt=" + cnt++);
        }
    }

    public static void main(String[] args) {
        ThreadPoolTaskSchedulerExample task = new ThreadPoolTaskSchedulerExample();
        task.startScheduler();

        // 10초 후에 스케줄링된 작업 중지
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        task.stopScheduler();
        
		System.out.println("스케줄링된 작업 종료");
    }
}
