package register;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRegistrationConfirm1 {
    private static final String url = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String user = "SMFUSER";
    private static final String password = "SMFUSER";

    public static void main(String[] args) {
        List<Productconfirm> products = getProducts();
        generateHTML(products);
    }

    private static List<Productconfirm> getProducts() {
        List<Productconfirm> products = new ArrayList<>();
        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT code, pname, manager FROM product")) {

            while (rs.next()) {
                int code = rs.getInt("code");
                String name = rs.getString("pname");
                String manager = rs.getString("manager");
                Productconfirm product = new Productconfirm(code, name, manager);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    private static void generateHTML(List<Productconfirm> products) {
        StringBuilder html = new StringBuilder();
        html.append("<html><head><title>Registered Products</title></head><body>");
        html.append("<table><thead><tr><th>Code</th><th>Name</th><th>Manager</th></tr></thead><tbody>");
        for (Productconfirm product : products) {
            html.append("<tr>");
            html.append("<td>").append(product.getCode()).append("</td>");
            html.append("<td>").append(product.getName()).append("</td>");
            html.append("<td>").append(product.getManager()).append("</td>");
            html.append("</tr>");
        }
        html.append("</tbody></table>");
        html.append("</body></html>");

        System.out.println(html.toString());
    }
}
