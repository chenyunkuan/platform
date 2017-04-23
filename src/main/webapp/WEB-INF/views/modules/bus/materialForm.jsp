<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>原料管理</title>
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
				$('#inputForm').attr('action',"${ctx}/bus/material/goOnSave");
                $('#inputForm').submit();
            });
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/bus/material/">原料列表</a></li>
		<li class="active"><a href="${ctx}/bus/material/form?id=${material.id}">原料<shiro:hasPermission name="bus:material:edit">${not empty material.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="bus:material:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="material" action="${ctx}/bus/material/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">原料名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原料类型：</label>
			<div class="controls">
				<sys:treeselect id="type" name="type.id" value="${material.type.id}" labelName="area.name" labelValue="${material.type.name}"
								title="原料类型" url="/sys/mdict/treeData" cssClass="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原料颜色：</label>
			<div class="controls">
				<form:select path="color" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('material_color')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单位：</label>
			<div class="controls">
				<form:select path="unit" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('unit')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">库存数量：</label>
			<div class="controls">
				<form:input path="quantity" htmlEscape="false" maxlength="11" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单价：</label>
			<div class="controls">
				<form:input path="price" htmlEscape="false" class="input-xlarge required number"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">原料属性：</label>
			<div class="controls">
				<form:input path="attribute" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">规格：</label>
			<div class="controls">
				<form:input path="specification" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="128" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="bus:material:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<shiro:hasPermission name="bus:material:edit"><input id="goOnSave" class="btn btn-success" type="button" value="继续添加"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>