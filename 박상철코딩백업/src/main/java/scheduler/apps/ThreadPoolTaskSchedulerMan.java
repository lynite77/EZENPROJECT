package scheduler.apps;

import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import java.util.concurrent.ScheduledFuture;

public class ThreadPoolTaskSchedulerMan {
    static class MyTask implements Runnable {
    	int cnt = 0;

        public void run() {
            // 스케줄링된 작업의 로직을 여기에 작성합니다.
            System.out.println("스케줄링된 작업 실행 중... cnt=" + cnt++);
        }
    }

	// 동시에 실행될 작업 스레드 갯수
    private static final int POOL_SIZE = 5;

    private ThreadPoolTaskScheduler taskScheduler;

    public ThreadPoolTaskSchedulerMan() {
        // ThreadPoolTaskScheduler 생성
        taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(POOL_SIZE);
        taskScheduler.initialize();
    }

    public ScheduledFuture<?> startScheduler(Runnable task) {
        // 작업 스케줄링 : 2초마다 작업이 실행
    	return taskScheduler.scheduleAtFixedRate(task, 2000);
    }

    public void stopScheduler(ScheduledFuture<?> scheduledFuture) {
        // 작업 스케줄링 중지
        if (scheduledFuture != null) {
            scheduledFuture.cancel(true);
        }
    }


    public static void main(String[] args) {
        ThreadPoolTaskSchedulerMan task = new ThreadPoolTaskSchedulerMan();
        ScheduledFuture<?> myTask = task.startScheduler(new MyTask());

        try {
            Thread.sleep(10000); // 10초 후에 스케줄링된 작업 중지
        } 
        catch (InterruptedException e) {
            e.printStackTrace();
        }
        
        task.stopScheduler(myTask);
        
		System.out.println("스케줄링된 작업 종료");
    }
}
