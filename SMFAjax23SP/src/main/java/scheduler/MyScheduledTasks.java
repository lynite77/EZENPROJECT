package scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MyScheduledTasks {
	private String title = "스케줄러 0번";
	private int cnt = 0;

	public void setTitle(String title) {
		this.title = title;
	}

    @Scheduled(fixedRate = 1000) // 1초마다 실행
    public void doTask() {
        System.out.printf("MyScheduledTasks : doTask(%s), count=%d\n", title, cnt++);
    }
}