<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>销售订单详情管理</title>
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

			$('#goOnSave').click(function () {
				$('#inputForm').attr('action',"${ctx}/bus/saleOrderDetail/goOnSave");
                $('#inputForm').submit();
            });

			$('#productId').change(function(){
                var price = $(this).find('option:selected').attr('data-price');
                var name = $(this).find('option:selected').text();
				$('input[name=price]').val(price);
				$('#productName').val(name);
			});

		});
		var calSquare = function(){
            var height = parseFloat($('input[name=height]').val());
            var width = parseFloat($('input[name=width]').val());
            if(!isNaN(height)&&height>0&&!isNaN(width)&&width>0){
                var square = height*width;
                $('input[name=square]').val(square);
            }
		}
		var calAmount = function(){
            var price = parseFloat($('input[name=price]').val());
            var quantity = parseFloat($('input[name=quantity]').val());
            if(!isNaN(price)&&price>0&&!isNaN(quantity)&&quantity>0){
                var amount = price*quantity;
                $('input[name=amount]').val(amount);
            }
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<%--<li><a href="${ctx}/bus/saleOrderDetail/">销售订单详情列表</a></li>--%>
		<%--<li class="active"><a href="${ctx}/bus/saleOrderDetail/form?id=${saleOrderDetail.id}">销售订单详情<shiro:hasPermission name="bus:saleOrderDetail:edit">${not empty saleOrderDetail.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bus:saleOrderDetail:edit">查看</shiro:lacksPermission></a></li>--%>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="saleOrderDetail" action="${ctx}/bus/saleOrderDetail/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">商品：</label>
			<div class="controls">
				<select id="productId" name="productId" class="input-xlarge required">
					<option value=""></option>
					<c:forEach items="${fns:listProduct()}" var="product" >
						<option value="${product.id}" <c:if test="${product.id == saleOrderDetail.productId}">selected </c:if> data-price="${product.price}">${product.name}</option>
					</c:forEach>
				</select>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
			<input type="hidden" name="productName" id="productName"/>
		</div>
		<div class="control-group">
			<label class="control-label">单价：</label>
			<div class="controls">
				<form:input id="price" path="price" htmlEscape="false" class="input-xlarge required number" onblur="calAmount();"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">宽：</label>
			<div class="controls">
				<form:input path="width" htmlEscape="false" class="input-xlarge required number" onblur="calSquare()"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">高：</label>
			<div class="controls">
				<form:input path="height" htmlEscape="false" class="input-xlarge required number" onblur="calSquare()"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">平方：</label>
			<div class="controls">
				<form:input path="square" htmlEscape="false" class="input-xlarge required number" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">数量：</label>
			<div class="controls">
				<form:input path="quantity" htmlEscape="false" maxlength="11" class="input-xlarge required  digits" onblur="calAmount();"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">金额：</label>
			<div class="controls">
				<form:input path="amount" htmlEscape="false" class="input-xlarge required number" readonly="true"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">填充材料：</label>
			<div class="controls">
				<form:input path="fillMaterial" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xlarge "/>
			</div>
		</div>
		<%--<div class="form-actions">
			<shiro:hasPermission name="bus:saleOrderDetail:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<shiro:hasPermission name="bus:saleOrderDetail:edit"><input id="goOnSave" class="btn btn-success" type="button" value="继续添加"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>--%>
	</form:form>
</body>
</html>