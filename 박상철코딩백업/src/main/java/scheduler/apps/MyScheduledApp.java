package scheduler.apps;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

import scheduler.config.SchedulingConfig;

@EnableScheduling
public class MyScheduledApp {

	public static void main(String[] args) {
		System.out.println("[작업시작]");

		AnnotationConfigApplicationContext ctx = new AnnotationConfigApplicationContext(SchedulingConfig.class);
		
		/*
		MyScheduledTasks st = ctx.getBean("myScheduledTasks", MyScheduledTasks.class);
		st.setTitle("스케줄러 1번");
		*/
		
		// 10초 기다림
		try {
			Thread.sleep(10000);
		} 
		catch (InterruptedException e) {
			e.printStackTrace();
		}
       
		ctx.close();		
	
		System.out.println("[작업종료]");
	}

}
