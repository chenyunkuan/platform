<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>商品管理</title>
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
		<li class="active"><a href="${ctx}/bus/product/">商品列表</a></li>
		<shiro:hasPermission name="bus:product:edit"><li><a href="${ctx}/bus/product/form">商品添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="product" action="${ctx}/bus/product/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>商品名称：</label>
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
				<th>商品名称</th>
				<th>图片</th>
				<th>单价</th>
				<th>颜色</th>
				<th>备注</th>
				<%--<th>更新者</th>--%>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:product:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="product">
			<tr>
				<td><a href="${ctx}/bus/product/form?id=${product.id}">
					${product.name}
				</a></td>
				<td>
					<input type="hidden" id="image_${product.id}" value="${product.image}">
					<sys:ckfinder input="image_${product.id}" maxWidth="100" maxHeight="100" type="images" uploadPath="/bus/product" selectMultiple="false" readonly="true"/>
				</td>
				<td>
					${product.price}
				</td>
				<td>
					${fns:getDictLabel(product.color, 'product_color', '')}
				</td>
				<td>
					${product.remarks}
				</td>
				<%--<td>--%>
					<%--${product.updateBy.id}--%>
				<%--</td>--%>
				<td>
					<fmt:formatDate value="${product.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:product:edit"><td>
    				<a href="${ctx}/bus/product/form?id=${product.id}">修改</a>
					<a href="${ctx}/bus/product/delete?id=${product.id}" onclick="return confirmx('确认要删除该商品吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>