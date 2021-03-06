<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>会员代金币汇总管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/customer/customerGoldCoinSnapshot/">会员代金币汇总列表</a></li>
		<shiro:hasPermission name="customer:customerGoldCoinSnapshot:edit"><li><a href="${ctx}/customer/customerGoldCoinSnapshot/form">会员代金币汇总添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="customerGoldCoinSnapshot" action="${ctx}/customer/customerGoldCoinSnapshot/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>当前代币值：</label>
				<form:input path="goldBalance" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>当前代币值</th>
				<th>即将过期代币值</th>
				<shiro:hasPermission name="customer:customerGoldCoinSnapshot:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customerGoldCoinSnapshot">
			<tr>
				<td><a href="${ctx}/customer/customerGoldCoinSnapshot/form?id=${customerGoldCoinSnapshot.id}">
					${customerGoldCoinSnapshot.goldBalance}
				</a></td>
				<td>
					${customerGoldCoinSnapshot.outtimeVal}
				</td>
				<shiro:hasPermission name="customer:customerGoldCoinSnapshot:edit"><td>
    				<a href="${ctx}/customer/customerGoldCoinSnapshot/form?id=${customerGoldCoinSnapshot.id}">修改</a>
					<a href="${ctx}/customer/customerGoldCoinSnapshot/delete?id=${customerGoldCoinSnapshot.id}" onclick="return confirmx('确认要删除该会员代金币汇总吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>