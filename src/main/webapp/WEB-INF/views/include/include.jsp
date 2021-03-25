<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!-- 제이쿼리 -->
<script type="text/javascript" src="${path}/resources/js/jquery-3.5.1.js"></script>
<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">
<script src="${path}/resources/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">

<script type="text/javascript">
	if('${msg}'!=''){
		alert('${msg}');
	}
</script>
