<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2024-02-24
  Time: 오후 8:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport"
        content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>단일 파일 업로드</title>
</head>
<body>
<form action="/fileUpload" name="fileForm" method="post" enctype="multipart/form-data">
<%--  폴더명 지정--%>
  <input type="hidden" name="fileFolder" value="media"><br>
<%--  파일 --%>
  파일명: <input type="file" name="uploadFile"><br>
  <input type="submit" value="파일 업로드">
</form>
</body>
</html>





