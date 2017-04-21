<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>采购订单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
        function addRow(list, idx, tpl, row) {
            $(list).append(Mustache.render(tpl, {
                idx: idx, delBtn: true, row: row
            }));
            $(list + idx).find("select").each(function () {
                $(this).val($(this).attr("data-value"));
            });
            $(list + idx).find("input[type='checkbox'], input[type='radio']").each(function () {
                var ss = $(this).attr("data-value").split(',');
                for (var i = 0; i < ss.length; i++) {
                    if ($(this).val() == ss[i]) {
                        $(this).attr("checked", "checked");
                    }
                }
            });
        }
        function delRow(obj, prefix) {
            var id = $(prefix + "_id");
            var delFlag = $(prefix + "_delFlag");
            if (id.val() == "") {
                $(obj).parent().parent().remove();
            } else if (delFlag.val() == "0") {
                delFlag.val("1");
                $(obj).html("&divide;").attr("title", "撤销删除");
                $(obj).parent().parent().addClass("error");
            } else if (delFlag.val() == "1") {
                delFlag.val("0");
                $(obj).html("&times;").attr("title", "删除");
                $(obj).parent().parent().removeClass("error");
            }
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bus/purchaseOrder/">采购订单列表</a></li>
    <li class="active"><a href="${ctx}/bus/purchaseOrder/form?id=${purchaseOrder.id}">采购订单<shiro:hasPermission
            name="bus:purchaseOrder:edit">${not empty purchaseOrder.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bus:purchaseOrder:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="purchaseOrder" action="${ctx}/bus/purchaseOrder/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">采购订单详情：</label>
        <div class="controls">
            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr>
                    <th class="hide"></th>
                    <th>原料</th>
                    <th>厂商</th>
                    <th>数量</th>
                    <th>金额</th>
                    <shiro:hasPermission name="bus:purchaseOrder:edit">
                        <th width="10">&nbsp;</th>
                    </shiro:hasPermission>
                </tr>
                </thead>
                <tbody id="purchaseOrderDetailList">
                </tbody>
                <shiro:hasPermission name="bus:purchaseOrder:edit">
                    <tfoot>
                    <tr>
                        <td colspan="7"><a href="javascript:"
                                           onclick="addRow('#purchaseOrderDetailList', purchaseOrderDetailRowIdx, purchaseOrderDetailTpl);purchaseOrderDetailRowIdx = purchaseOrderDetailRowIdx + 1;"
                                           class="btn">新增</a></td>
                    </tr>
                    </tfoot>
                </shiro:hasPermission>
            </table>
            <script type="text/template" id="purchaseOrderDetailTpl">//<!--
						<tr id="purchaseOrderDetailList{{idx}}">
							<td class="hide">
								<input id="purchaseOrderDetailList{{idx}}_id" name="purchaseOrderDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="purchaseOrderDetailList{{idx}}_delFlag" name="purchaseOrderDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<select id="purchaseOrderDetailList{{idx}}_materialId" name="purchaseOrderDetailList[{{idx}}].materialId" data-value="{{row.materialId}}" class="input-medium required">
									<option value=""></option>
									<c:forEach items="${fns:listMaterial()}" var="entity">
										<option value="${entity.id}">${entity.name}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<select id="purchaseOrderDetailList{{idx}}_factoryId" name="purchaseOrderDetailList[{{idx}}].factoryId" data-value="{{row.factoryId}}" class="input-medium required">
									<option value=""></option>
									<c:forEach items="${fns:listFactory()}" var="entity">
										<option value="${entity.id}">${entity.name}</option>
									</c:forEach>
								</select>
							</td>
							<td>
								<input id="purchaseOrderDetailList{{idx}}_quantity" name="purchaseOrderDetailList[{{idx}}].quantity" type="text" value="{{row.quantity}}" maxlength="11" class="input-small required digits"/>
							</td>
							<td>
								<input readonly id="purchaseOrderDetailList{{idx}}_amount" name="purchaseOrderDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-small"/>
							</td>
							<shiro:hasPermission name="bus:purchaseOrder:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#purchaseOrderDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>//-->
            </script>
            <script type="text/javascript">
                var purchaseOrderDetailRowIdx = 0,
                    purchaseOrderDetailTpl = $("#purchaseOrderDetailTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g, "");
                $(document).ready(function () {
                    var data = ${fns:toJson(purchaseOrder.purchaseOrderDetailList)};
                    for (var i = 0; i < data.length; i++) {
                        addRow('#purchaseOrderDetailList', purchaseOrderDetailRowIdx, purchaseOrderDetailTpl, data[i]);
                        purchaseOrderDetailRowIdx = purchaseOrderDetailRowIdx + 1;
                    }
                });
            </script>
        </div>
    </div>

    <div class="control-group">
        <label class="control-label">备注：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge "/>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="bus:purchaseOrder:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                                  value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>