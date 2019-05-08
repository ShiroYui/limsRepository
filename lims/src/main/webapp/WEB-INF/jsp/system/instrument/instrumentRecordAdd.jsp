<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
	<!-- 下拉框 -->
	<link rel="stylesheet" href="static/ace/css/chosen.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<%--<link rel="stylesheet" href="static/ace/css/bootstrap-datetimepicker.css" />--%>
</head>
<body class="no-skin">
<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container">
	<!-- /section:basics/sidebar -->
	<div class="main-content">
		<div class="main-content-inner">
			<div class="page-content">
				<div class="row">
					<div class="col-xs-12">

						<form action="instrument/${msg }.do" name="Form" id="Form" method="post">
							<input type="hidden" name="ID" id="id" value="${pd.ID}"/>
							<div id="zhongxin" style="padding-top: 13px;">
								<table id="table_report" class="table table-striped table-bordered table-hover">
									<tr>
										<td style="width:75px;text-align: right;padding-top: 13px;">仪器型号:</td>
										<td>
											<select  name="INSTRUMENT_ID" id="type" style="vertical-align:top;width:98%;" >
												<option value='' disabled selected style='display:none;'>请选择仪器型号</option>
												<c:forEach var="list" items="${list}">
													<option value="${list.ID}" <c:if test="${list.INSTRUMENT_TYPE==pd.INSTRUMENT_TYPE}">selected</c:if>>
															${list.INSTRUMENT_TYPE}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td style="width:75px;text-align: right;padding-top: 13px;">使用者:</td>
										<td>
											<select  name="INSTRUMENT_USER" id="user" style="vertical-align:top;width:98%;" >
												<option value='' disabled selected style='display:none;'>请选择使用者</option>
												<c:forEach var="nameList" items="${nameList}">
													<option value="${nameList.USER_ID}" <c:if test="${nameList.NAME==pd.NAME}">selected</c:if>>
															${nameList.NAME}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<td style="width:75px;text-align: right;padding-top: 13px;">使用时间:</td>
										<td>
											<input class="span10 date-picker" name="INSTRUMENT_TIME" id="time" value="${pd.INSTRUMENT_TIME}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="选择日期"  style="width:98%;"/>
										</td>
									</tr>
									<tr>
										<td style="text-align: center;" colspan="10">
											<a class="btn btn-mini btn-primary" onclick="save();">保存</a>
											<a class="btn btn-mini btn-danger" onclick="top.Dialog.close();">取消</a>
										</td>
									</tr>
								</table>
							</div>
							<div id="zhongxin2" class="center" style="display:none"><br/><br/><br/><br/><br/><img src="static/images/jiazai.gif" /><br/><h4 class="lighter block green">提交中...</h4></div>
						</form>
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
	</div>
	<!-- /.main-content -->
</div>
<!-- /.main-container -->


<!-- 页面底部js¨ -->
<%@ include file="../../system/index/foot.jsp"%>
<%--<script src="static/ace/js/ace/ace.js"></script>--%>
<!-- 下拉框 -->
<script src="static/ace/js/chosen.jquery.js"></script>
<!-- 日期框 -->
<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
<%--<script src="static/ace/js/date-time/moment.js"></script>
<script src="static/ace/js/date-time/locales.js"></script>
<script src="static/ace/js/date-time/bootstrap-datetimepicker.js"></script>--%>
<!--提示框-->
<script type="text/javascript" src="static/js/jquery.tips.js"></script>
<script type="text/javascript">

    $(top.hangge());
    //保存
    function save(){
        if($("#type").val()=="" || $("#type").val() == null){
            $("#type").tips({
                side:3,
                msg:'输入仪器型号',
                bg:'#AE81FF',
                time:3
            });
            $("#type").focus();
            return false;
        }
        if($("#user").val()=="" || $("#user").val() == null){
            $("#user").tips({
                side:3,
                msg:'输入使用者',
                bg:'#AE81FF',
                time:3
            });
            $("#user").focus();
            return false;
        }
        if($("#time").val()=="" || $("#time").val() == null){
            $("#time").tips({
                side:3,
                msg:'输入时间',
                bg:'#AE81FF',
                time:3
            });
            $("#time").focus();
            return false;
        }
        $("#Form").submit();
        $("#zhongxin").hide();
        $("#zhongxin2").show();
    }

    $(function() {
        //日期框
        $('.date-picker').datepicker({autoclose: true,todayHighlight: true});
    });
</script>
</body>
</html>