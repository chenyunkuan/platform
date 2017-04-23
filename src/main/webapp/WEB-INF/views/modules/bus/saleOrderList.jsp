<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售订单管理</title>
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
		<li class="active"><a href="${ctx}/bus/saleOrder/">销售订单列表</a></li>
		<shiro:hasPermission name="bus:saleOrder:edit"><li><a href="${ctx}/bus/saleOrder/form">销售订单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="saleOrder" action="${ctx}/bus/saleOrder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>客户：</label>
				<form:select path="customer" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>订单日期：</label>
				<input name="orderDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${saleOrder.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>发货日期：</label>
				<input name="deliveryDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${saleOrder.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>发货周期：</label>
				<form:input path="deliveryCycle" htmlEscape="false" maxlength="4" class="input-medium"/>
			</li>
			<li><label>售后：</label>
				<form:input path="hasAfterSale" htmlEscape="false" maxlength="4" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>客户</th>
				<th>总价</th>
				<th>总数量</th>
				<th>状态</th>
				<th>订单日期</th>
				<th>发货日期</th>
				<th>发货周期</th>
				<th>售后</th>
				<th>售后金额</th>
				<th>售后详情</th>
				<th>备注</th>
				<%--<th>更新者</th>--%>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:saleOrder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="saleOrder">
			<tr>
				<td><a href="${ctx}/bus/saleOrder/form?id=${saleOrder.id}">
					${saleOrder.customer.companyName}
				</a></td>
				<td>
					${saleOrder.totalAmount}
				</td>
				<td>
					${saleOrder.totalQuantity}
				</td>
				<td>
					${saleOrder.status}
				</td>
				<td>
					<fmt:formatDate value="${saleOrder.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${saleOrder.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${saleOrder.deliveryCycle}
				</td>
				<td>
					${saleOrder.hasAfterSale}
				</td>
				<td>
					${saleOrder.afterSaleAmount}
				</td>
				<td>
					${saleOrder.afterSaleDetail}
				</td>
				<td>
					${saleOrder.remarks}
				</td>
				<%--<td>--%>
					<%--${saleOrder.updateBy.id}--%>
				<%--</td>--%>
				<td>
					<fmt:formatDate value="${saleOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:saleOrder:edit"><td>
    				<a href="${ctx}/bus/saleOrder/form?id=${saleOrder.id}">修改</a>
					<a href="${ctx}/bus/saleOrder/delete?id=${saleOrder.id}" onclick="return confirmx('确认要删除该销售订单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>