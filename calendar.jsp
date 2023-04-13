<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.ZoneId"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="ja_JP" />
<%!private static Map eventMap = new HashMap();
	static {
		eventMap.put("20190101", "お正月");
		eventMap.put("20191225", "クリスマス");
		eventMap.put("20191231", "大晦日");
	}%>

<%
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

LocalDate localDate = null;
if (year == null || month == null || day == null) {

	localDate = LocalDate.now();

	year = String.valueOf(localDate.getYear());
	month = String.valueOf(localDate.getMonthValue());
	day = String.valueOf(localDate.getDayOfMonth());
} else {

	localDate = LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), Integer.parseInt(day));
}
String[] dates = { year, month, day };

request.setAttribute("dates", dates);
request.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));

String event = (String) eventMap.get(year + month + day);
request.setAttribute("event", event);
%>

<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
	list-style: none;
}
</style>
</head>
<body>
	<form method="post" action="/jsp/calendar.jsp">

		<ul>
			<li><input type="text" name="year" value="${param['year']}" /><label
				for="year">年 </label><input type="text" name="month"
				value="${param['month']}" /><label for="month">月 </label><input
				type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>

			<li><input type="submit" value="送信" />
			<li><c:out value="${fn:join(dates, '/')}" /> (<fmt:formatDate
					value="${date}" pattern="E" />)</li>
			<li><c:out value="${event}" /></li>
		</ul>
	</form>
</body>
</html>
