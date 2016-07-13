<%@ page import = "java.text.NumberFormat" %>
<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

   <meta charset='utf-8'>
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="css/menu_styles.css">
   <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
   <script src="script.js"></script>
   <title>FortaCloud Resource Check</title>

</head>
<body>
<div id='cssmenu'>
<ul>
   <li><a href='resource_display.jsp'><span>자원조회</span></a></li>
   <li class='active has-sub'><a href='#'><span>M1</span></a>
      <ul>
         <li class='has-sub'><a href='#'><span>최소</span></a>
            <ul>
               <li><a href='#'><span>50,000</span></a></li>
               <li><a href='#'><span>100,000</span></a></li>
               <li class='last'><a href='#'><span>직접입력</span></a></li>
            </ul>
         </li>
         <li class='has-sub'><a href='#'><span>최대</span></a>
            <ul>
               <li><a href='#'><span>10,000,000</span></a></li>
               <li class='last'><a href='#'><span>직접입력</span></a></li>
            </ul>
         </li>
      </ul>
   </li>
   <li class='active has-sub'><a href='#'><span>M2</span></a>
     <ul>
         <li class='has-sub'><a href='#'><span>범위</span></a>
            <ul>
               <li><a href='#'><span>100 이상</span></a></li>
               <li><a href='#'><span>100 미만</span></a></li>
               <li class='last'><a href='#'><span>직접입력</span></a></li>
            </ul>
         </li>
      </ul>
   </li>
   <li><a href='#'><span>test</span></a></li>
   <li class='last'><a href='contact_email.jsp'><span>Contact</span></a></li>
</ul>
</div>
<br> <br>
</body>
</html>