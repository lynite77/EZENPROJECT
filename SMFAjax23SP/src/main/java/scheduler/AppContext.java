package scheduler;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppContext {

	@Bean
	public MyScheduledTasks myScheduledTasks() {
		System.out.println("[AppContext] @Bean myScheduledTasks...");
		return new MyScheduledTasks();
	}
}
