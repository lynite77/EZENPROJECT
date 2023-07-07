package scheduler.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;

import scheduler.tasks.MyScheduledTasks;

@Configuration
@EnableScheduling
public class SchedulingConfig {
    
    @Bean
    public TaskScheduler taskScheduler() {
    	System.out.println("SchedulingConfig : taskScheduler()");
        ThreadPoolTaskScheduler taskScheduler = new ThreadPoolTaskScheduler();
        taskScheduler.setPoolSize(3); // 스레드 풀 크기 설정
        return taskScheduler;
    }
    
	@Bean
	public MyScheduledTasks myScheduledTasks() {
		return new MyScheduledTasks();
	}
    
}


