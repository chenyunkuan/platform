<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售订单详情管理</title>
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
		<li class="active"><a href="${ctx}/bus/saleOrderDetail/">销售订单详情列表</a></li>
		<shiro:hasPermission name="bus:saleOrderDetail:edit"><li><a href="${ctx}/bus/saleOrderDetail/form">销售订单详情添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="saleOrderDetail" action="${ctx}/bus/saleOrderDetail/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>销售订单：</label>
				<form:input path="saleOrder" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>商品：</label>
				<form:select path="product" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>数量：</label>
				<form:input path="quantity" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>单价：</label>
				<form:input path="price" htmlEscape="false" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>销售订单</th>
				<th>商品</th>
				<th>填充材料</th>
				<th>宽</th>
				<th>高</th>
				<th>平方</th>
				<th>数量</th>
				<th>单价</th>
				<th>金额</th>
				<th>备注</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:saleOrderDetail:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<template v-for="item in items">
			<tr>
				<td><a href="${ctx}/bus/saleOrderDetail/form?id=">
				</a>
					{{item.id}}
				</td>
				<td>
				</td>
				<td>
					{{item.fillMaterial}}
				</td>
				<td>
					{{item.width}}
				</td>
				<td>
					{{item.height}}
				</td>
				<td>
					{{item.square}}
				</td>
				<td>
					{{item.quantity}}
				</td>
				<td>
					{{item.price}}
				</td>
				<td>
					{{item.amount}}
				</td>
				<td>
					{{item.remarks}}
				</td>
				<td>
					{{item.updateDate}}
				</td>
				<shiro:hasPermission name="bus:saleOrderDetail:edit"><td>
					<a href="${ctx}/bus/saleOrderDetail/form?id={{item.id}}">修改</a>
					<a href="${ctx}/bus/saleOrderDetail/delete?id={{item.id}}" onclick="return confirmx('确认要删除该销售订单详情吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</template>

		<%--<c:forEach items="${page.list}" var="saleOrderDetail">
			<tr>
				<td><a href="${ctx}/bus/saleOrderDetail/form?id=${saleOrderDetail.id}">
					${saleOrderDetail.saleOrder}
				</a></td>
				<td>
					${fns:getDictLabel(saleOrderDetail.product, '', '')}
				</td>
				<td>
					${saleOrderDetail.fillMaterial}
				</td>
				<td>
					${saleOrderDetail.width}
				</td>
				<td>
					${saleOrderDetail.height}
				</td>
				<td>
					${saleOrderDetail.square}
				</td>
				<td>
					${saleOrderDetail.quantity}
				</td>
				<td>
					${saleOrderDetail.price}
				</td>
				<td>
					${saleOrderDetail.amount}
				</td>
				<td>
					${saleOrderDetail.remarks}
				</td>
				<td>
					${saleOrderDetail.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${saleOrderDetail.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:saleOrderDetail:edit"><td>
    				<a href="${ctx}/bus/saleOrderDetail/form?id=${saleOrderDetail.id}">修改</a>
					<a href="${ctx}/bus/saleOrderDetail/delete?id=${saleOrderDetail.id}" onclick="return confirmx('确认要删除该销售订单详情吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>--%>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	<script>
        new Vue({
            el: '#contentTable',
            data: {
                items:${fns:toJson(page.list)}
            }
        })
	</script>
</body>
</html>