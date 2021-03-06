<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员可免费提现次数变更流水管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/customer/customerFreeWithdrawCountHis/">会员可免费提现次数变更流水列表</a></li>
		<li class="active"><a href="${ctx}/customer/customerFreeWithdrawCountHis/form?id=${customerFreeWithdrawCountHis.id}">会员可免费提现次数变更流水<shiro:hasPermission name="customer:customerFreeWithdrawCountHis:edit">${not empty customerFreeWithdrawCountHis.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="customer:customerFreeWithdrawCountHis:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="customerFreeWithdrawCountHis" action="${ctx}/customer/customerFreeWithdrawCountHis/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">账号编号：</label>
			<div class="controls">
				<form:input path="accountId" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">变更值：</label>
			<div class="controls">
				<form:input path="changeVal" htmlEscape="false" maxlength="11" class="input-xlarge  digits"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">变更类型：</label>
			<div class="controls">
				<form:select path="changeTypeCode" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('customer_free_withdraw_count_change_type_dict')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">获取时间：</label>
			<div class="controls">
				<input name="getDt" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${customerFreeWithdrawCountHis.getDt}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提现请求流水号：</label>
			<div class="controls">
				<form:input path="requestNo" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">使用时间：</label>
			<div class="controls">
				<input name="useDt" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${customerFreeWithdrawCountHis.useDt}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="customer:customerFreeWithdrawCountHis:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>