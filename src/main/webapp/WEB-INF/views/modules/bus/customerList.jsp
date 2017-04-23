<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>客户管理</title>
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
		<li class="active"><a href="${ctx}/bus/customer/">客户列表</a></li>
		<shiro:hasPermission name="bus:customer:edit"><li><a href="${ctx}/bus/customer/form">客户添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="customer" action="${ctx}/bus/customer/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>地区：</label>
				<sys:treeselect id="area" name="area.id" value="${customer.area.id}" labelName="area.name" labelValue="${customer.area.name}"
					title="区域" url="/sys/area/treeData" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>公司名称：</label>
				<form:input path="companyName" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>联系人：</label>
				<form:input path="contactPerson" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>手机：</label>
				<form:input path="cellphone" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>地区</th>
				<th>公司名称</th>
				<th>联系人</th>
				<th>座机</th>
				<th>手机</th>
				<th>发货物流</th>
				<%--<th>更新人</th>--%>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:customer:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="customer">
			<tr>
				<td><a href="${ctx}/bus/customer/form?id=${customer.id}">
					${customer.area.name}
				</a></td>
				<td>
					${customer.companyName}
				</td>
				<td>
					${customer.contactPerson}
				</td>
				<td>
					${customer.telephone}
				</td>
				<td>
					${customer.cellphone}
				</td>
				<td>
					${fns:getDictLabel(customer.express, 'express_company', '')}
				</td>
				<%--<td>--%>
					<%--${customer.updateBy.id}--%>
				<%--</td>--%>
				<td>
					<fmt:formatDate value="${customer.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:customer:edit"><td>
    				<a href="${ctx}/bus/customer/form?id=${customer.id}">修改</a>
					<a href="${ctx}/bus/customer/delete?id=${customer.id}" onclick="return confirmx('确认要删除该客户吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>