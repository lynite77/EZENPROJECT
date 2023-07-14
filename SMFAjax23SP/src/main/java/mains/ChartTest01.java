package mains;

public class ChartTest01 {

	public static void main(String[] args) {
		int[] chartVals = new int[7];
		for(int cnt=0; cnt < 7; cnt++) {
			chartVals[cnt] = (int)(Math.random() * 200);
		}
		
		for(int x : chartVals) {
			String s = String.valueOf(x);
			System.out.println(x + ", " + s);
		}
		
	}

}
