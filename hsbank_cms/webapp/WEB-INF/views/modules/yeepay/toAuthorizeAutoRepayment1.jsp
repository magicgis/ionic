<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>易宝测试入口</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@include file="/WEB-INF/views/include/head.jsp"%>

<script>
	
</script>
</head>
<body>
	<div id="lA9" class="tab-pane">
		<h3>9自动还款授权明细</h3>
		<hr />
		<form:form class="form-horizontal"
			modelAttribute="toAuthorizeAutoRepaymentReq"
			action="${ctx}/yeepay/toAuthorizeAutoRepayment">
			<div class="control-group">
				<label class="control-label">商户编号：</label>
				<div class="controls">
					<label><%=request.getParameter("platformNo")%></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">请求流水号：</label>
				<div class="controls">
					<label><%=request.getParameter("requestNo")%></label>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label">标的号：</label>
				<div class="controls">
					<label><%=request.getParameter("orderNo")%></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">标的借款人编号：</label>
				<div class="controls">
				<label><%=request.getParameter("platformUserNo")%></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">页面调回Url：</label>
				<div class="controls">
					<label><%=request.getParameter("callbackUrl")%></label>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">服务通知URL：</label>
				<div class="controls">
					<label><%=request.getParameter("notifyUrl")%></label>
				</div>
			</div>
		</form:form>
		<form method="post"  action="<%=request.getAttribute("yeepayURL")%>">

			<textarea style="width: 500px; height: 200px; display: none"
				name="req"><%=request.getAttribute("req")%></textarea>
			<input type="hidden" name="sign"
				value="<%=request.getAttribute("sign")%>" />

			<div class="form:form-actions">
				<input id="lA1Go" class="btn btn-success" type="submit" value="确定" />

			</div>
		</form>
	</div>

</body>
</html>