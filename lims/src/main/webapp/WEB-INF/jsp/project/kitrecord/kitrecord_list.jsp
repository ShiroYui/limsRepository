<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
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
							
						<!-- 检索  -->
						<form action="kitrecord/list.do" method="post" name="Form" id="Form">
						<table style="margin-top:5px;">
							<tr>
								<td>
								<div style=" padding-top: 20px; padding-bottom: 10px;">
									<select class="chosen-select form-control" id="sl1" name="sl1" data-placeholder="请选择项目" style="width: 170px">
										<option value=""></option>
										<option value="">全部</option>
										<c:forEach items="${projectAll}" var="user">
											<option value="${user.project_name}" <c:if test="${pd.sl1==user.project_name}">selected</c:if> >${user.project_name }</option>
										</c:forEach>
									</select>
								</div>
								</td>
								<td style="vertical-align:top;padding-top: 20px; padding-bottom: 10px;padding-left: 20px">
								 	<select class="chosen-select form-control" name="name" id="id" data-placeholder="请选择类型" style="vertical-align:top;width: 120px;">
									<option value=""></option>
									<option value="">全部</option>
									<option value="1" <c:if test="${pd.name=='1'}">selected</c:if>>出库</option>
									<option value="0" <c:if test="${pd.name=='0'}">selected</c:if>>入库</option>
								  	</select>
								</td>
								<td style="vertical-align:top;padding-top: 20px; padding-bottom: 10px;padding-left: 10px"><a class="btn btn-light btn-xs" onclick="tosearch();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								<td style="vertical-align:top;padding-top: 25px; padding-bottom: 10px;padding-left: 10px;text-align: center">
								<p style="text-align: center">项目总出入库:</p>
								</td>
								<td style="vertical-align:top;padding-top: 20px; padding-bottom: 10px;padding-left: 10px"><input class="span10 date-picker" name="lastLoginStart" id="lastLoginStart"  value="${pd.lastLoginStart}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="开始日期" title="开始日期"/></td>
								<td style="vertical-align:top;padding-top: 20px; padding-bottom: 10px;padding-left: 10px"><input class="span10 date-picker" name="lastLoginEnd" id="lastLoginEnd"  value="${pd.lastLoginEnd}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" placeholder="结束日期" title="结束日期"/></td>
								<td style="vertical-align:top;padding-top: 20px; padding-bottom: 10px;padding-left: 10px"><a class="btn btn-light btn-xs" onclick="searchs1();"  title="检索"><i id="nav-search-icon1" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>

							</tr>
						</table>
						<!-- 检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">	
							<thead>
								<tr>
									<th class="center" style="width:50px;">序号</th>
									<th class="center">产品名称</th>
									<th class="center">项目名称</th>

									<th class="center">操作者</th>
									<th class="center">调整类型</th>
									<th class="center">当前库存数量</th>
									<th class="center">调整数量</th>

									<th class="center">调整后数量</th>
									<th class="center">出库原因</th>
									<th class="center">操作时间</th>

								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty varList}">
									<c:forEach items="${varList}" var="var" varStatus="vs">
										<tr>
											<td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
											<td class='center'>${var.kit_name}</td>
											<td class='center'>${var.project_name}</td>
											<td class='center'>${var.NAME}</td>
											<c:if test="${var.CHANGE_TYPE==1}">
											<td class='center'>出库</td>
										</c:if>
											<c:if test="${var.CHANGE_TYPE==0}">
												<td class='center'>入库</td>
											</c:if>
											<td class='center'>${var.CURRENT_COUNT}</td>
											<td class='center'>${var.CHANGE_COUNT}</td>
											<td class='center'>${var.COMPLETE_COUNT}</td>
											<td class='center'>${var.decrease_reason}</td>

											<td class='center'>${var.newDate}</td>

										</tr>
									
									</c:forEach>
									<%--<c:if test="${QX.cha == 0 }">--%>
										<%--<tr>--%>
											<%--<td colspan="100" class="center">您无权查看</td>--%>
										<%--</tr>--%>
									<%--</c:if>--%>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>

						</table>
							<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
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

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	<script type="text/javascript">
		$(top.hangge());//关闭加载状态
		//检索
		function tosearch(){
			top.jzts();
			$("#Form").submit();
		}
		$(function() {
		
			//日期框
			$('.date-picker').datepicker({
				autoclose: true,
				todayHighlight: true
			});
			
			//下拉框
			if(!ace.vars['touch']) {
				$('.chosen-select').chosen({allow_single_deselect:true}); 
				$(window)
				.off('resize.chosen')
				.on('resize.chosen', function() {
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				}).trigger('resize.chosen');
				$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
					if(event_name != 'sidebar_collapsed') return;
					$('.chosen-select').each(function() {
						 var $this = $(this);
						 $this.next().css({'width': $this.parent().width()});
					});
				});
				$('#chosen-multiple-style .btn').on('click', function(e){
					var target = $(this).find('input[type=radio]');
					var which = parseInt(target.val());
					if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
					 else $('#form-field-select-4').removeClass('tag-input-style');
				});
			}

		});

		//查看库存列表
		function searchs1(){
			var start = document.getElementById("lastLoginStart").value;
			var end = document.getElementById("lastLoginEnd").value;
			top.jzts();
			var diag = new top.Dialog();
			diag.Drag=true;
			diag.Title ="出入库记录";
			diag.URL = '<%=basePath%>kitrecord/listProjectRep.do?lastLoginStart='+start+"&lastLoginEnd="+end;
			diag.Width = 550;
			diag.Height = 355;
			diag.Modal = true;				//有无遮罩窗口
			diag. ShowMaxButton = true;	//最大化按钮
			diag.ShowMinButton = true;		//最小化按钮
			diag.CancelEvent = function(){ //关闭事件
				diag.close();
			};
			diag.show();
		}



		//导出excel
		function toExcel(){
			window.location.href='<%=basePath%>kitrecord/excel.do';
		}
	</script>


</body>
</html>