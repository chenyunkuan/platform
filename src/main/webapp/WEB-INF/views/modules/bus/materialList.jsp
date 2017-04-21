<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>原料管理</title>
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
		<li class="active"><a href="${ctx}/bus/material/">原料列表</a></li>
		<shiro:hasPermission name="bus:material:edit"><li><a href="${ctx}/bus/material/form">原料添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="material" action="${ctx}/bus/material/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>原料类型：</label>
				<sys:treeselect id="type" name="type.id" value="${material.type.id}" labelName="area.name" labelValue="${material.type.name}"
								title="原料类型" url="/sys/mdict/treeData" cssClass="required"/>
			</li>
			<li><label>原料名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>库存数量：</label>
				<form:input path="quantity" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>原料名称</th>
				<th>原料类型</th>
				<th>原料颜色</th>
				<th>规格</th>
				<th>单位</th>
				<th>库存数量</th>
				<th>单价</th>
				<th>原料属性</th>
				<th>更新人</th>
				<th>更新日期</th>
				<shiro:hasPermission name="bus:material:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="material">
			<tr>
				<td><a href="${ctx}/bus/material/form?id=${material.id}">
					${material.name}
				</a></td>
				<td>
					${material.type.name}
				</td>
				<td>
					${fns:getDictLabel(material.color, 'material_color', '')}
				</td>
				<td>
					${material.specification}
				</td>
				<td>
					${fns:getDictLabel(material.unit, 'unit', '')}
				</td>
				<td>
					${material.quantity}
				</td>
				<td>
					${material.price}
				</td>
				<td>
					${material.attribute}
				</td>
				<td>
					${material.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${material.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:material:edit"><td>
    				<a href="${ctx}/bus/material/form?id=${material.id}">修改</a>
					<a href="${ctx}/bus/material/delete?id=${material.id}" onclick="return confirmx('确认要删除该原料吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>