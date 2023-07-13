//[등록]팝업창으로 작업지시등록 기능
//CSV, EXCEL 형식으로 되어있는 지시생성/생산계획을 불러와 지시생성이 가능하며, 모든 레퍼런스가 관리

package work;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class WorkOrderRegistration2 {
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String DB_USER = "SMFUSER";
    private static final String DB_PASSWORD = "SMFUSER";

    public static void main(String[] args) {
        String csvFilePath = "path/to/workorders.csv";

        try {
            // CSV 파일 읽기
            BufferedReader reader = new BufferedReader(new FileReader(csvFilePath));
            String line;
            while ((line = reader.readLine()) != null) {
                // CSV 데이터 파싱
                String[] data = line.split(",");

                // 작업지시 생성 및 저장
                WorkOrder workOrder = createWorkOrder(data);

                // 작업지시 데이터베이스에 저장
                saveWorkOrder(workOrder);
            }
            reader.close();

            System.out.println("작업지시 등록이 완료되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static WorkOrder createWorkOrder(String[] data) {
        // CSV 데이터를 기반으로 작업지시 객체 생성
        String workOrderNumber = data[0];
        String productName = data[1];
        String manager = data[2];
     

        return new WorkOrder(workOrderNumber, productName, manager);
    }

    private static void saveWorkOrder(WorkOrder workOrder) {
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement statement = conn.prepareStatement(
                     "INSERT INTO work_orders (work_order_number, product_name, manager) VALUES (?, ?, ?)")) {

            // 작업지시 데이터베이스에 저장
            statement.setString(1, workOrder.getWorkOrderNumber());
            statement.setString(2, workOrder.getProductName());
            statement.setString(3, workOrder.getManager());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

