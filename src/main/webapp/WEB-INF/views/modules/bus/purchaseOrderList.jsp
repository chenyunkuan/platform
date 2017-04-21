<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>采购订单管理</title>
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
		<li class="active"><a href="${ctx}/bus/purchaseOrder/">采购订单列表</a></li>
		<shiro:hasPermission name="bus:purchaseOrder:edit"><li><a href="${ctx}/bus/purchaseOrder/form">采购订单添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="purchaseOrder" action="${ctx}/bus/purchaseOrder/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>申请人：</label>
				<form:input path="applyBy" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>申请日期：</label>
				<input name="applyDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${purchaseOrder.applyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>审批人：</label>
				<form:input path="auditBy" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>审批日期：</label>
				<input name="auditDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${purchaseOrder.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>总数量</th>
				<th>总金额</th>
				<th>申请人</th>
				<th>申请日期</th>
				<th>审批人</th>
				<th>审批日期</th>
				<th>付款总金额</th>
				<th>付款日期</th>
				<th>状态</th>
				<th>备注</th>
				<th>更新者</th>
				<th>更新时间</th>
				<shiro:hasPermission name="bus:purchaseOrder:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="purchaseOrder">
			<tr>
				<td><a href="${ctx}/bus/purchaseOrder/form?id=${purchaseOrder.id}">
					${purchaseOrder.totalQuantity}
				</a></td>
				<td>
					${purchaseOrder.totalAmount}
				</td>
				<td>
					${purchaseOrder.applyBy}
				</td>
				<td>
					<fmt:formatDate value="${purchaseOrder.applyDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${purchaseOrder.auditBy}
				</td>
				<td>
					<fmt:formatDate value="${purchaseOrder.auditDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${purchaseOrder.payTotalAmount}
				</td>
				<td>
					<fmt:formatDate value="${purchaseOrder.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(purchaseOrder.status, '', '')}
				</td>
				<td>
					${purchaseOrder.remarks}
				</td>
				<td>
					${purchaseOrder.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${purchaseOrder.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="bus:purchaseOrder:edit"><td>
    				<a href="${ctx}/bus/purchaseOrder/form?id=${purchaseOrder.id}">修改</a>
					<a href="${ctx}/bus/purchaseOrder/delete?id=${purchaseOrder.id}" onclick="return confirmx('确认要删除该采购订单吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>