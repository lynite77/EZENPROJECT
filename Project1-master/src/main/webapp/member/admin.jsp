<%@ page import="java.util.List" %>
<%@ page import="member.MemberMgr" %>
<%@ page import="member.MemberBean" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
// 현재 로그인한 사용자의 권한 가져오기
String role = (String) session.getAttribute("role");
String tPath = request.getContextPath();
// 권한에 따른 페이지 접근 제어
if (role == null) {
    // 로그인하지 않은 경우, 로그인 페이지로 이동
    response.sendRedirect("login.jsp");
} else if (role.equals("admin")) {
    // admin 권한의 경우에만 접속 가능
    %>
    <!DOCTYPE html>
    <html>
    <head>
        <title>관리자 페이지</title>
        <link href="style2.css" rel="stylesheet" type="text/css">
        <style>    
            .container {
                max-width: 960px;
                margin: 0 auto;
                padding: 20px;
            }

            .header {
                text-align: center;
                margin-bottom: 20px;
            }

            .nav {
                text-align: center;
                margin-bottom: 20px;
            }

            .nav a {
                margin-right: 10px;
                text-decoration: none;
                color: #333;
                font-weight: bold;
            }

            .nav a:last-child {
                margin-right: 0;
            }

            .menu-list {
                list-style-type: none;
                padding: 0;
                margin: 0;
                display: flex;
                flex-direction: column-reverse;
                align-items: left;
                margin-left: 39%;
            }

            .menu-list li {
                margin-bottom: 10px;
            }
            
            .menu-list li a {
                display: inline-block;
                padding: 10px 20px;
                background-color: #996600;
                color: #ffffff;
                text-decoration: none;
                border-radius: 5px;
            }
            
            .menu-list li a:hover {
                background-color: #003399;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header">
                <h1>관리자 페이지</h1>
            </div>
            <ul class="menu-list" id="reversed-menu-list">
                <li><a href="update.jsp">회원정보 수정</a></li>
                <li><a href="grant.jsp">권한 수정</a></li>
                <li><a href="delete.jsp">회원 삭제</a></li>
            </ul>
        </div>
        
        <script>
            // 리스트를 역순으로 변경하는 JavaScript 함수
            function reverseList() {
                const menuList = document.getElementById("reversed-menu-list");
                const reversedItems = Array.from(menuList.children).reverse();
                menuList.innerHTML = ""; // 리스트 내용을 비우고
                reversedItems.forEach(item => menuList.appendChild(item)); // 역순으로 다시 추가
            }

            // 페이지 로드 후에 리스트를 역순으로 변경
            window.onload = function() {
                reverseList();
            };
        </script>
    </body>
    </html>
    <%
} else {
    // admin 권한이 아닌 경우 접속불가 페이지로 이동
    response.sendRedirect("access-denied.jsp");
}
%>
