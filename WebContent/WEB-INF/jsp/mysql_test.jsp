<%@ page import = "java.sql.*" %>
<%@ page import = "java.text.NumberFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset='utf-8'>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/menu_styles.css">
<script src="http://code.jquery.com/jquery-latest.min.js"
	type="text/javascript"></script>

</head>

<body>
	<jsp:include page="top_menu.jsp" flush="false" />
<%                                                                                  
String DB_URL = "jdbc:mysql://127.0.0.1:3306/medi";
String USERNAME = "userdb";
String PASSWORD = "dPdnjs2";

Connection conn = null;
Statement stmt = null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    conn = DriverManager.getConnection(DB_URL,USERNAME,PASSWORD);
    stmt = conn.createStatement();

    String sql;
    sql = "SELECT * FROM check_money;";
    ResultSet rs = stmt.executeQuery(sql);
%>    
    <table>
    <tr>
      <th width="100" align="center">고기명</th>
      <th width="100" align="center">거래처</th>
      <th width="100" align="center">알람코드</th>
      <th width="100" align="center">제조사</th>
      <th width="100" align="center">물_건</th>
      <th width="50" align="center">단가</th>
      <th width="50" align="center">판매량</th>
      <th width="50" align="center">사용금액</th>
      <th width="50" align="center">수수료율</th>
      <th width="100" align="center">수수료(VAT포함)</th>
      <th width="50" align="center">지급률</th>
      <th width="50" align="center">총지급금액</th>
      <th width="100" align="center">수수료(VAT제외)</th>
      <th width="50" align="center">VAT</th>
    </tr>
  </table>

<%
    while(rs.next()){
		String Company = rs.getString("company");
		String Name = rs.getString("name");
		String Hcode = rs.getString("hcode");
		String Ospital = rs.getString("hospital");
		String Rugs = rs.getString("drugs");
		int iPrice = rs.getInt("price");
		String Price = NumberFormat.getIntegerInstance().format(iPrice);
		int iSellCnt = rs.getInt("sellCnt");
		String SellCnt = NumberFormat.getIntegerInstance().format(iSellCnt);
		double TreatPay = rs.getDouble("treatPay"); 
		double CommisionRate = rs.getDouble("commisionRate");
		double CommWithVat = rs.getDouble("commWithVat");
		double PaymentRate = rs.getDouble("paymentRate");
		double TotalPayment = rs.getDouble("totalpayment");
		double CommnoVat = rs.getDouble("commnoVat");
		double Vat = rs.getDouble("vat"); 
%>
            <table id="Minfo">
              <tr>
                <td width="100" align="center"><%=Company%></td>
                <td width="100" align="center"><%=Name%></td>
                <td width="100" align="center"><%=Hcode%></td>
                <td width="100" align="center"><%=Ospital%></td>
                <td width="100" align="center"><%=Rugs%></td>
                <td width="50" align="center"><%=Price%></td>
                <td width="50" align="center"><%=SellCnt%></td>
                <td width="50" align="center"><%=TreatPay%></td>
                <td width="50" align="center"><%=CommisionRate%></td>
                <td width="100" align="center"><%=CommWithVat%></td>
                <td width="50" align="center"><%=PaymentRate%></td>
                <td width="50" align="center"><%=TotalPayment%></td>
                <td width="100" align="center"><%=CommnoVat%></td>
                <td width="50" align="center"><%=Vat%></td>
              </tr>
            </table>

<%
    }
    rs.close();
    stmt.close();
    conn.close();
} catch(SQLException se1){
    se1.printStackTrace();
} catch(Exception ex){
    ex.printStackTrace();
} finally{
    try {
        if(stmt!=null)
            stmt.close();
    } catch (SQLException se2){

    }
    try{
        if(conn!=null)
            conn.close();
    } catch (SQLException se){
        se.printStackTrace();
    }
}
%>


</body>
</html>