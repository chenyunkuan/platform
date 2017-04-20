<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>多级字典管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/mdict/">多级字典列表</a></li>
		<shiro:hasPermission name="sys:mdict:edit"><li><a href="${ctx}/sys/mdict/form">多级字典添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="mdict" action="${ctx}/sys/mdict/" method="post" class="breadcrumb form-search">
		<ul class="ul-form">
			<li><label>所有父级编号：</label>
				<form:input path="parentIds" htmlEscape="false" maxlength="2000" class="input-medium"/>
			</li>
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>父级编号</th>
				<th>名称</th>
				<th>排序</th>
				<th>描述</th>
				<th>更新者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="sys:mdict:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td><a href="${ctx}/sys/mdict/form?id={{row.id}}">
				{{row.parent.id}}
			</a></td>
			<td>
				{{row.name}}
			</td>
			<td>
				{{row.sort}}
			</td>
			<td>
				{{row.description}}
			</td>
			<td>
				{{row.updateBy.id}}
			</td>
			<td>
				{{row.updateDate}}
			</td>
			<td>
				{{row.remarks}}
			</td>
			<shiro:hasPermission name="sys:mdict:edit"><td>
   				<a href="${ctx}/sys/mdict/form?id={{row.id}}">修改</a>
				<a href="${ctx}/sys/mdict/delete?id={{row.id}}" onclick="return confirmx('确认要删除该多级字典及所有子多级字典吗？', this.href)">删除</a>
				<a href="${ctx}/sys/mdict/form?parent.id={{row.id}}">添加下级多级字典</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>