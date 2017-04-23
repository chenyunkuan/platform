<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>销售订单管理</title>
    <meta name="decorator" content="default"/>
    <script src="//cdn.bootcss.com/jquery-serialize-object/2.5.0/jquery.serialize-object.min.js"></script>
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
            console.info(row);
            saleOrderDetailRowIdx = saleOrderDetailRowIdx + 1;
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

        function editDetail(detailId) {
            top.$.jBox.open("iframe:${ctx}/bus/saleOrderDetail/form?id="+detailId, "详情", 600, 600, {
                buttons: {"确定": "ok", "关闭": true}, submit: function (v, h, f) {
                    if (v == "ok") {
                        var d = h.find('#jbox-iframe')[0].contentWindow.document;
                        var iform = $(d).find('form')[0];
                        $(iform).submit();
                        var jsonuserinfo = $(iform).serializeObject();
                        console.info(jsonuserinfo);
                        addRow('#saleOrderDetailList', saleOrderDetailRowIdx, saleOrderDetailTpl, jsonuserinfo);
                    }
                }, loaded: function (h) {
                    $(".jbox-content", top.document).css("overflow-y", "hidden");
                }
            });
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/bus/saleOrder/">销售订单列表</a></li>
    <li class="active"><a href="${ctx}/bus/saleOrder/form?id=${saleOrder.id}">销售订单<shiro:hasPermission
            name="bus:saleOrder:edit">${not empty saleOrder.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
            name="bus:saleOrder:edit">查看</shiro:lacksPermission></a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="saleOrder" action="${ctx}/bus/saleOrder/save" method="post"
           class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">销售订单详情：</label>
        <div class="controls">
            <table id="contentTable" class="table table-striped table-bordered table-condensed">
                <thead>
                <tr>
                    <th class="hide"></th>
                    <th>商品</th>
                    <th>填充材料</th>
                    <th>宽</th>
                    <th>高</th>
                    <th>平方</th>
                    <th>数量</th>
                    <th>单价</th>
                    <th>金额</th>
                    <th>备注</th>
                    <shiro:hasPermission name="bus:saleOrder:edit">
                        <th width="10">&nbsp;</th>
                    </shiro:hasPermission>
                </tr>
                </thead>
                <tbody id="saleOrderDetailList">
                </tbody>
                <shiro:hasPermission name="bus:saleOrder:edit">
                    <tfoot>
                    <tr>
                        <td colspan="11"><a href="javascript:"
                                            onclick="editDetail()"
                                            class="btn">新增</a></td>
<%--
                        <td colspan="11"><a href="javascript:"
                                            onclick=" addRow('#saleOrderDetailList', saleOrderDetailRowIdx, saleOrderDetailTpl);"
                                            class="btn">新增</a></td>
--%>
                    </tr>
                    </tfoot>
                </shiro:hasPermission>
            </table>
            <script type="text/template" id="saleOrderDetailTpl">
						<tr id="saleOrderDetailList{{idx}}">
							<td class="hide">
								<input id="saleOrderDetailList{{idx}}_id" name="saleOrderDetailList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="saleOrderDetailList{{idx}}_delFlag" name="saleOrderDetailList[{{idx}}].delFlag" type="hidden" value="0"/>
								<input name="saleOrderDetailList[{{idx}}].productId" type="hidden" value="{{row.productId}}"/>
							</td>
							<td>
                                <input readonly name="saleOrderDetailList[{{idx}}].productName" type="text" value="{{row.productName}}" maxlength="64" class="input-mini required"/>
							</td>
							<td>
								<input readonly  name="saleOrderDetailList[{{idx}}].fillMaterial" type="text" value="{{row.fillMaterial}}" maxlength="64" class="input-small required"/>
							</td>
							<td>
								<input readonly name="saleOrderDetailList[{{idx}}].width" type="text" value="{{row.width}}" class="input-mini required number"/>
							</td>
							<td>
								<input readonly name="saleOrderDetailList[{{idx}}].height" type="text" value="{{row.height}}" class="input-mini required number"/>
							</td>
							<td>
								<input readonly name="saleOrderDetailList[{{idx}}].square" type="text" value="{{row.square}}" class="input-mini required number"/>
							</td>
							<td>
								<input readonly  name="saleOrderDetailList[{{idx}}].quantity" type="text" value="{{row.quantity}}" maxlength="11" class="input-mini  digits"/>
							</td>
							<td>
								<input readonly  name="saleOrderDetailList[{{idx}}].price" type="text" value="{{row.price}}" class="input-mini required number"/>
							</td>
							<td>
								<input readonly name="saleOrderDetailList[{{idx}}].amount" type="text" value="{{row.amount}}" class="input-mini required number"/>
							</td>
							<td>
								<input readonly name="saleOrderDetailList[{{idx}}].remarks" type="text" maxlength="200" class="input-small " value="{{row.remarks}}"/>
							</td>
							<shiro:hasPermission name="bus:saleOrder:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#saleOrderDetailList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>
            </script>
            <script type="text/javascript">
                var saleOrderDetailRowIdx = 0,
                    saleOrderDetailTpl = $("#saleOrderDetailTpl").html();
                $(document).ready(function () {
                    var data = ${fns:toJson(saleOrder.saleOrderDetailList)};
                    for (var i = 0; i < data.length; i++) {
                        addRow('#saleOrderDetailList', saleOrderDetailRowIdx, saleOrderDetailTpl, data[i]);
                    }
                });
            </script>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">客户：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${saleOrder.id != null}">
                    <input type="text" value="${saleOrder.customer.companyName}" class="input-xlarge" readonly>
                    <form:hidden path="customer.id"/>
                </c:when>
                <c:otherwise>
                    <select name="customer.id" class="input-xlarge required">
                        <option value=""></option>
                        <c:forEach items="${fns:listCustomer()}" var="entity">
                            <option value="${entity.id}">${entity.companyName}:${entity.contactPerson}</option>
                        </c:forEach>
                    </select>
                </c:otherwise>
            </c:choose>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">总价：</label>
        <div class="controls">
            <form:input path="totalAmount" htmlEscape="false" class="input-xlarge required number"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">总数量：</label>
        <div class="controls">
            <form:input path="totalQuantity" htmlEscape="false" maxlength="11" class="input-xlarge required digits"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">发货日期：</label>
        <div class="controls">
            <input name="deliveryDate" type="text" readonly="readonly" maxlength="20"
                   class="input-medium Wdate required"
                   value="<fmt:formatDate value="${saleOrder.deliveryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">发货周期：</label>
        <div class="controls">
            <form:input path="deliveryCycle" htmlEscape="false" maxlength="4" class="input-xlarge required"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">售后：</label>
        <div class="controls">
            <form:radiobuttons path="hasAfterSale" items="${fns:getDictList('true_false')}" itemValue="value"
                               itemLabel="label"/>
            <span class="help-inline"><font color="red">*</font> </span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">售后金额：</label>
        <div class="controls">
            <form:input path="afterSaleAmount" htmlEscape="false" class="input-xlarge  number"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">售后详情：</label>
        <div class="controls">
            <form:input path="afterSaleDetail" htmlEscape="false" maxlength="256" class="input-xlarge "/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">备注：</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="512" class="input-xxlarge "/>
        </div>
    </div>

    <div class="form-actions">
        <shiro:hasPermission name="bus:saleOrder:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                              value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>