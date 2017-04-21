<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>厂商管理</title>
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
		<li class="active"><a href="${ctx}/bus/factory/">厂商列表</a></li>
		<shiro:hasPermission name="bus:factory:edit"><li><a href="${ctx}/bus/factory/form">厂商添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="factory" action="${ctx}/bus/factory/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>联系人</th>
				<th>银行卡号</th>
				<th>备注</th>
				<th>更新者</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:factory:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="factory">
			<tr>
				<td><a href="${ctx}/bus/factory/form?id=${factory.id}">
					${factory.name}
				</a></td>
				<td>
					${factory.contactPerson}
				</td>
				<td>
					${factory.bankCardNo}
				</td>
				<td>
					${factory.remarks}
				</td>
				<td>
					${factory.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${factory.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:factory:edit"><td>
    				<a href="${ctx}/bus/factory/form?id=${factory.id}">修改</a>
					<a href="${ctx}/bus/factory/delete?id=${factory.id}" onclick="return confirmx('确认要删除该厂商吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>