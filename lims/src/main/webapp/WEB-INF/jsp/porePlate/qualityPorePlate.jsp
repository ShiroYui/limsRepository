﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	<link rel="stylesheet" href="static/ace/css/mymodel.css" />
	<!-- jsp文件头和头部 -->
	<%@ include file="../system/index/top.jsp"%>
	<!-- 日期框 -->
	<link rel="stylesheet" href="static/ace/css/datepicker.css" />
	<script type="text/javascript" charset="utf-8" src="plugins/tab/js/tab.js"></script>
</head>
<style>
	.tableW{
		width: 100px;
	}
	.result-selected {
		display: list-item;
		color: #ccc;
		cursor: default;
	}
</style>
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
						<form action="customer/list.do" method="post" name="userForm" id="userForm">
							<table style="    float: right;">
								<tr>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" onclick="fromExcel('MyDiv','fade');">导入布板</a>
									</td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" onclick="toExcel();">生成版标</a>
									</td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" onclick="openP();">打印</a>
									</td>
								</tr>
							</table><br/>
							<table style="margin-top:5px;">
								<tr>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" style="font-size: 15px" id="buban" onclick="completeLayout();">完成布板</a>
										<img style="margin-top: -3px;width: 70px;" id="bubanimg"  src="static/images/blueArrow.png">
										<%--<span class="label label-success arrowed"></span>--%>
									</td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" style="font-size: 15px" id="dakong" onclick="completeOther(2,'dakong');">完成打孔</a>
										<img style="margin-top: -3px;    width: 70px;"  id="dakongimg" src="static/images/blueArrow.png">

									</td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" style="font-size: 15px" id="pcr" onclick="selectInstrument()" <%--onclick="completeOther(3);"--%>>完成PCR扩增</a>
										<img style="margin-top: -3px;    width: 70px;" id="pcrimg"  src="static/images/blueArrow.png">
									</td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" style="font-size: 15px" id="jiance" onclick="selectInstrumentForTest()" <%--onclick="completeOther(5);"--%>>完成检测</a>
										<img style="margin-top: -3px;    width: 70px;" id="jianceimg"  src="static/images/blueArrow.png">
									</td>

									<c:if test="${pd.pore_plate_type == 2}">
										<td style="padding-left:2px;">
											<a class="btn btn-mini btn-info" style="font-size: 15px" id="wanncheng" onclick="completeOther(4,'wanncheng');">完成</a>
										</td></c:if>
									<c:if test="${pd.pore_plate_type!=2}">
										<td style="padding-left:2px;">
											<a class="btn btn-mini btn-info" style="font-size: 15px" id="fenxi" onclick="completeOther(4,'fenxi');">完成分析</a>
											<img style="margin-top: -3px;    width: 70px;" id="fenxiimg"  src="static/images/blueArrow.png">
										</td>
										<td style="padding-left:2px;">
											<span style="font-size: 15px">复核检测</span>
											<a class="btn btn-mini btn-info" style="font-size: 15px" id="tongguo" onclick="completeOtherFuhe(1);">通过</a>
											<a class="btn btn-mini btn-info" style="font-size: 15px" id="butongguo" onclick="completeOtherFuhe(2);">不通过</a>
										</td>
									</c:if>
								</tr>
							</table>
							<table style="margin-top:5px;">
								<tr>
									<td>
										自动布板：
										<input type="text" name="num" id="num" maxlength="32" placeholder="请输入起始样本编号(扫码输入)" title="起始样本编号" autocomplete="off">
									</td>
									<td style="padding-left:2px;">起始位置坐标:<input type="text" name="startnum" id="startnum" maxlength="32" placeholder="请输入起始位置坐标" title="起始位置坐标" autocomplete="off"></td>
									<td style="padding-left:2px;">结束位置坐标:<input type="text" name="endnum" id="endnum" maxlength="32" placeholder="请输入结束位置坐标" title="结束位置坐标" autocomplete="off"></td>
									<td style="padding-left:2px;">
										<a class="btn btn-mini btn-info" onclick="autoPore();">自动生成</a>
									</td>
									<c:if test="${pd.pore_plate_type!=2}">
										<td style="padding-left:2px;">生成复核孔:<input type="number" onkeyup="value=value.replace(/[^2-5]/g,'')"  min="2" max="5" style="width: 42%" value="${recheck_hole_amount}" placeholder="个数" id="CompoundHoleNum" title="复合孔个数"></td>
										<td style="padding-left:2px;">
											<a class="btn btn-mini btn-purple" id="createCompoundHole" onclick="createCompoundHoleClick();">生成</a>
										</td>
										<td style="padding-left:2px;">
											<a class="btn btn-mini btn-danger" onclick="cancelCompoundHole();">取消复核孔</a>
										</td>
										<td style="padding-left:2px;">是否整版重扩:
											<a class="btn btn-mini btn-purple" id="yes"  onclick="entirety(1);">是</a>
											<a class="btn btn-mini btn-purple" id="no" onclick="entirety(2);">否</a>
											<div style="display: none"> <input type="radio" checked id="pore_plate_entirety" name="pore_plate_entirety" value="1" title="是否整版重扩"><input type="radio" name="pore_plate_entirety" value="2" title="是否整版重扩"></div>
										</td>
									</c:if>
								</tr>
							</table>
							<!-- 检索  -->
							<input type="hidden" value="${pd.id}" name="poreId" id="poreId"/>
							<input type="hidden" value="${pd.keyWord}" name="keyWord" id="keyWord"/>
							<input type="hidden" value="${pd.current_procedure}" name="current_procedureTest" id="current_procedureTest"/>
							<input type="hidden" value="${pd.pore_plate_name}" name="pore_plate_name" id="pore_plate_name"/>
							<input type="hidden" value="${msg}" name="msg" id="msg"/>
							<input type="hidden" value="${pd.plate_project_id}" name="plate_project_id" id="plate_project_id"/>
							<input type="hidden" value="${pd.pore_plate_type}" name="pore_plate_type" id="pore_plate_type"/>
							<input type="hidden" value="" name="pore_plate_quality" id="pore_plate_quality"/>
							<input type="hidden" value="" name="current_procedure" id="current_procedure"/>
							<input type="hidden" value="" name="NAME" id="NAME"/>
							<input type="hidden" value="" name="lims_pore_serial" id="lims_pore_serial"/>
							<input type="hidden" value="${projectPermission.project_permission}" name="projectPermission" id="projectPermission"/>
							<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
								<thead>
								<%--A--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<c:if test="${x == 1}">
												<th class="center tableW" style="background-color: #0a0a0a">A0${x}</th>
											</c:if>
											<c:if test="${x != 1}">
												<th class="center tableW">A0${x}</th>
											</c:if>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW">A${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x == 1}">
												<th class="center tableW">
													<input style="width: 100%; " type="text" id="a${x}" value="LADDER" disabled autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option selected value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x == 1}">
												<th class="center tableW">
													<input style="width: 100%; " type="text" id="a${x}" value="LADDER" disabled autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option selected value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>

										<c:if test="${x != 1}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="a${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
									</c:forEach>
								</tr>
								<%--A--%>
								<%--B--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">B0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW">B${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<th class="center tableW">
											<input style="width: 100%;" type="text" id="b${x}" value="" autocomplete="off">
											<select class="chosen-select form-control" onchange="setNum(this)">
												<option value="1">普通样本</option>
												<option value="6">空孔</option>
												<option value="2">P</option>
												<option value="3">O</option>
												<option value="7" selected>质检孔</option>
												<option value="4">复核孔</option>
												<option value="5">LADDER</option>
											</select>
												<%--动态复核孔列表--%>
											<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
												<option value="">请选择</option>
												<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
													<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
												</c:forEach>
											</select>
											<input type="hidden">
										</th>
									</c:forEach>
								</tr>
								<%--B--%>
								<%--C--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">C0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW">C${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<th class="center tableW">
											<input style="width: 100%;" type="text" id="c${x}" value="" autocomplete="off">
											<select class="chosen-select form-control" onchange="setNum(this)">
												<option value="1">普通样本</option>
												<option value="6">空孔</option>
												<option value="2">P</option>
												<option value="3">O</option>
												<option value="7" selected>质检孔</option>
												<option value="4">复核孔</option>
												<option value="5">LADDER</option>
											</select>
												<%--动态复核孔列表--%>
											<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
												<option value="">请选择</option>
												<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
													<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
												</c:forEach>
											</select>
											<input type="hidden">
										</th>
									</c:forEach>
								</tr>
								<%--C--%>
								<%--D--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">D0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW">D${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x==5}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="d${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4" >复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${x!=5 && x!=12}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="d${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>

													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>

										<c:if test="${x==12}">
											<th class="center tableW">
											<input style="width: 100%;" type="text" id="d${x}" value="" autocomplete="off">
											<select class="chosen-select form-control" onchange="setNum(this)">
												<option value="1">普通样本</option>
												<option value="6">空孔</option>
												<option value="2">P</option>
												<option value="3">O</option>
												<option value="7" selected>质检孔</option>
												<option value="4">复核孔</option>
												<option value="5">LADDER</option>
											</select>
											<%--动态复核孔列表--%>
											<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
												<option value="">请选择</option>
												<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
													<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
												</c:forEach>
											</select>
											<input type="hidden">
										</c:if>
										</th>
										<%--</c:if>--%>

									</c:forEach>
								</tr>
								<%--D--%>
								<%--E--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">E0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<c:if test="${x!=12}">
												<th class="center tableW">E${x}</th>
											</c:if>
											<c:if test="${x==12}">
												<th class="center tableW" style="background-color: blue">E${x}</th>
											</c:if>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x==8}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="e${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${x!=8 && x!=12}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="e${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
												<input style="width: 100%;" type="text"  id="e${x}" value="O" disabled autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2" selected>P</option>
													<option selected value="3">O</option>
													<option value="7" >质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
												<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</c:if>
											</th>
										</c:if>
										<%--</c:if>--%>
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
												<input style="width: 100%;" type="text"  id="e${x}" value="O" disabled autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2" >P</option>
													<option selected value="3">O</option>
													<option value="7" >质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
												<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</c:if>
											</th>
										</c:if>
										<%--</c:if>--%>
									</c:forEach>
								</tr>
								<%--E--%>
								<%--F--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">F0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<c:if test="${x!=12}">
												<th class="center tableW">F${x}</th>
											</c:if>
											<c:if test="${x==12}">
												<th class="center tableW" style="background-color: green">F${x}</th>
											</c:if>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x!=12}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="f${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
												<input style="width: 100%;" type="text"  id="f${x}" value="P" disabled autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option selected value="2">P</option>
													<option value="3">O</option>
													<option value="7" >质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
												<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</c:if>
											</th>
										</c:if>
										<%--</c:if>--%>
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
													<input style="width: 100%;" type="text"  id="f${x}" value="P" disabled autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option selected value="2">P</option>
														<option value="3">O</option>
														<option value="7" >质检孔</option>
														<option value="4">复核孔</option>
														<option value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">

												</th>
											</c:if>
										</c:if>
									</c:forEach>
								</tr>
								<%--F--%>
								<%--G--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<th class="center tableW">G0${x}</th>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW" >G${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x!=12}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="g${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="g${x}" value="" autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option  value="2">P</option>
														<option value="3">O</option>
														<option  value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="g${x}" value="" autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">

												</th>
											</c:if>
										</c:if>
									</c:forEach>
								</tr>
								<%--G--%>
								<%--H--%>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${x < 10}">
											<c:if test="${x == 6}">
												<th class="center tableW" style="background-color: #0a0a0a">H0${x}</th>
											</c:if>
											<c:if test="${x != 6}">
												<th class="center tableW">H0${x}</th>
											</c:if>
										</c:if>
										<c:if test="${x>=10}">
											<th class="center tableW" >H${x}</th>
										</c:if>
									</c:forEach>
								</tr>
								<tr>
									<c:forEach var="x" begin="1" end="12" step="1">
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x==6}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="h${x}" value="LADDER" disabled autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option selected value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x==6}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="h${x}" value="LADDER" disabled autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option selected value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
										<c:if test="${x!=6 && x!=12}">
											<th class="center tableW">
												<input style="width: 100%;" type="text" id="h${x}" value="" autocomplete="off">
												<select class="chosen-select form-control" onchange="setNum(this)">
													<option value="1">普通样本</option>
													<option value="6">空孔</option>
													<option value="2">P</option>
													<option value="3">O</option>
													<option value="7" selected>质检孔</option>
													<option value="4">复核孔</option>
													<option value="5">LADDER</option>
												</select>
													<%--动态复核孔列表--%>
												<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
													<option value="">请选择</option>
													<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
														<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
													</c:forEach>
												</select>
												<input type="hidden">
											</th>
										</c:if>
										<c:if test="${msg == 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="h${x}" value="" autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option  value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
										<c:if test="${msg != 'editPorePlate'}">
											<c:if test="${x==12}">
												<th class="center tableW">
													<input style="width: 100%;" type="text" id="h${x}" value="" autocomplete="off">
													<select class="chosen-select form-control" onchange="setNum(this)">
														<option value="1">普通样本</option>
														<option value="6">空孔</option>
														<option value="2">P</option>
														<option value="3">O</option>
														<option value="7" selected>质检孔</option>
														<option value="4">复核孔</option>
														<option value="5">LADDER</option>
													</select>
														<%--动态复核孔列表--%>
													<select class="chosen-select form-control" onmousemove="changeSelect(this)" onchange="setNumForZhijian(this)">
														<option value="">请选择</option>
														<c:forEach items="${checkHoleList}" var="checkHole" varStatus="vs">
															<option value="${checkHole.sample_number}">${checkHole.pore_plate_name}-${checkHole.sample_number}</option>
														</c:forEach>
													</select>
													<input type="hidden">
												</th>
											</c:if>
										</c:if>
									</c:forEach>
								</tr>
								<%--H--%>
								</thead>
								<tbody>
								</tbody>
							</table>
							<div class="page-header position-relative">
								<table style="width:100%;">
									<tr>
										<td style="vertical-align:top;">
											<c:if test="${QX.add == 1 }">
												<a class="btn btn-mini btn-success" onclick="add();">新增</a>
											</c:if>
											<c:if test="${QX.del == 1 }">
												<a title="批量删除" class="btn btn-mini btn-danger" onclick="makeAll('确定要删除选中的数据吗?');" ><i class='ace-icon fa fa-trash-o bigger-120'></i></a>
											</c:if>
										</td>
										<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
									</tr>
								</table>
							</div>
						</form>

					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->
			</div>
			<!-- /.page-content -->
		</div>
		<%--_________________________________________________   --%>
		<div id="fade" class="black_overlay">
		</div>
		<div id="MyDiv" class="white_content">
			<div style="text-align: right; cursor: default; height: 40px;">
				<a class="btn btn-mini btn-info"  onclick="CloseDiv('MyDiv','fade')">X</a>
			</div>
			<div class="main-container" id="main-container">
				<!-- /section:basics/sidebar -->
				<div class="main-content">
					<div class="main-content-inner">
						<div class="page-content">
							<div class="row">
								<div class="col-xs-12">
									<form action="user/readExcel.do" name="Form" id="Form" method="post" enctype="multipart/form-data">
										<div id="zhongxin">
											<table style="width:95%;" >
												<tr>
													<td style="padding-top: 20px;"><input type="file" id="excel" name="excel" style="width:50px;" onchange="fileType(this)" /></td>
												</tr>
												<tr>
													<td style="text-align: center;padding-top: 10px;">
														<a class="btn btn-mini btn-primary" onclick="saveExcel();">导入</a>
														<a class="btn btn-mini btn-danger" onclick="CloseDiv('MyDiv','fade')">取消</a>
														<a class="btn btn-mini btn-success" onclick="window.location.href='<%=basePath%>/user/downExcel.do'">下载模版</a>
													</td>
												</tr>
											</table>
										</div>
										<div id="zhongxin2" class="center" style="display:none"><br/><img src="static/images/jzx.gif" /><br/><h4 class="lighter block green"></h4></div>
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
		</div>
		<%--_________________________________________________   --%>
	</div>
	<!-- /.main-content -->
	<div style="display: none">
		<form id="openP" action="<%=basePath%>/porePlate/printPage.do" method="post" target="newWin">
			<textarea id="json" name="json"></textarea>
			<input id="pore_plate_name1" name="pore_plate_name"/>
			<input id="name1" name="name1"/>
			<input id="pore_plate_quality1" name="pore_plate_quality1"/>
			<input type="hidden" value="${pd.dakongren}" name="dakongren" id="dakongren"/>
			<input type="hidden" value="${pd.kuozhengren}" name="kuozhengren" id="kuozhengren"/>
			<input type="hidden" value="${pd.fenxiren}" name="fenxiren" id="fenxiren"/>
			<input type="hidden" value="${pd.userName}" name="userName" id="userName"/>
		</form>

        <form id="toExcel" action="<%=basePath%>/porePlate/excel.do" method="post">
            <textarea id="json2" name="json"></textarea>
            <input id="pore_plate_name2" name="pore_plate_name"/>
            <input id="pore_plate_quality2" name="pore_plate_quality"/>
            <input id="NAME2" name="NAME"/>
            <input id="id2" name="id"/>
        </form>
	</div>
	<!-- 返回顶部 -->
	<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
		<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
	</a>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- 上传控件 -->
	<script src="static/ace/js/ace/elements.fileinput.js"></script>
	<script type="text/javascript" src="static/js/myjs/head.js"></script>
	<script type="text/javascript" src="static/js/function.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
</body>

<script type="text/javascript">
    $(function() {
        //上传
        $('#excel').ace_file_input({
            no_file:'请选择EXCEL ...',
            btn_choose:'选择',
            btn_change:'更改',
            droppable:false,
            onchange:null,
            thumbnail:false, //| true | large
            whitelist:'xls|xls',
            blacklist:'gif|png|jpg|jpeg'
            //onchange:''
        });
    });
    $(top.hangge());
    var html = "<select class=\"chosen-select form-control\" name=\"fh\" onmousemove=\"changeSelect(this)\" onchange=\"setNumForZhijian(this)\"><option value='0'>请选择复核孔</option>";
    $(document).ready(function(){
        var checkHoleList = '${checkHoleList}';
        if(checkHoleList!=''){
            var reg=/=/g;
            checkHoleList = checkHoleList.replace(reg,":");
            var jsonData1 = eval(checkHoleList);
            for (var i = 0; i < jsonData1.length; i++) {
                html+= " <option value='"+jsonData1[i].sample_number+"'>"+jsonData1[i].sample_number+"</option>";
            }
        }
        html+=" </select>";
        //加载页面自动生成复核孔  现在不要了  注释
        /* if('${recheck_hole_amount}' != '' && '${pd.current_procedure}'==0){
            createCompoundHole(${recheck_hole_amount});
		}*/
        var current_procedure_now = '${pd.current_procedure}';
        if('${poreList}'!=""){
            var poreList = '${poreList}';
            var reg=/=/g;
            poreList = poreList.replace(reg,":");
            var jsonData = eval(poreList);
            //遍历jsonData：
            for (var i = 0; i < jsonData.length; i++) {

                console.log(jsonData[i].hole_number);
                var inputId = jsonData[i].hole_number;
                if(inputId!=undefined ){
                    //将大写转成小写
                    inputId = inputId.toLowerCase();
                    //获取结尾数字   将01转成1
                    var idNum = inputId.substring(1,inputId.length);
                    inputId = inputId.substring(0,1);
                    idNum = parseInt(idNum);
                    //获取最终的input框id
                    inputId = inputId+idNum;
                    $("#"+inputId).val(jsonData[i].sample_number);
                    //设置input的name为hole_type表的id
                    $("#"+inputId).attr("name",jsonData[i].htId);
                    $("#"+inputId).next().val(jsonData[i].hole_type);
                    if(jsonData[i].hole_type == "7"){
                        $("#"+inputId).next().next().val(jsonData[i].sample_number);
                    }
                    //如果是复核孔  变黄
                    if(jsonData[i].hole_type == "4"){
                        var z = $("#"+inputId).parent().index();
                        $("#"+inputId).removeAttr("disabled");
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','yellow');
                    }
                    if(jsonData[i].hole_type == "7"){
                        var z = $("#"+inputId).parent().index();
                        $("#"+inputId).removeAttr("disabled");
                        $("#"+inputId).next().next().remove();
                        $("#"+inputId).parent().append(html);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
                    }

                    if(jsonData[i].hole_type == "3"){
                        var z = $("#"+inputId).parent().index();
                        $("#"+inputId).val("O");
                        $("#"+inputId).attr("disabled","disabled")
                        $("#"+inputId).next().next().remove();
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','blue');
                    }

                    if(jsonData[i].hole_type == "2"){
                        var z = $("#"+inputId).parent().index();
                        $("#"+inputId).val("P");
                        $("#"+inputId).attr("disabled","disabled")
                        $("#"+inputId).next().next().remove();
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','green');
                    }
/*
                    if(current_procedure_now > 1 && jsonData[i].hole_type != "7"){
                        /!* alert(inputId);
                         alert(jsonData[i].hole_special_sample);*!/
                        $("#"+inputId).next().next().val(jsonData[i].hole_special_sample);
                    }*/
                }

            }

            var pore_plate_entirety = jsonData[0].pore_plate_entirety;

            //是否整版重扩选中
            if(pore_plate_entirety ==1){
                $("input[type=radio][name=pore_plate_entirety][value='1']").attr("checked",'checked')
            }else{
                $("input[type=radio][name=pore_plate_entirety][value='2']").attr("checked",'checked')
            }
            //步骤
            var current_procedure = 0;
            if ('${REBUILDNAME}' == null || '${REBUILDNAME}' == ''){
                current_procedure = jsonData[0].current_procedure;
            }
            var pore_plate_quality = jsonData[0].pore_plate_quality;
            var lims_pore_serial = jsonData[0].lims_pore_serial;
            $("#lims_pore_serial").val(lims_pore_serial);
            var NAME = jsonData[0].NAME;
            $("#pore_plate_quality").val(pore_plate_quality);
            $("#current_procedure").val(current_procedure);
            $("#NAME").val(NAME);
            if(current_procedure == 1){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
            }
            if(current_procedure == 2){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
            }
            if(current_procedure<2){
                $("#yes").removeAttr("onclick");
                $("#no").removeAttr("onclick");
            }
            if(current_procedure == 3){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
                $("#pcr").attr("class","btn btn-mini btn-success");
                $("#pcrimg").attr('src',"static/images/greenArrow.png");
            }
            if(current_procedure == 5){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
                $("#pcr").attr("class","btn btn-mini btn-success");
                $("#pcrimg").attr('src',"static/images/greenArrow.png");
                $("#jiance").attr("class","btn btn-mini btn-success");
                $("#jianceimg").attr('src',"static/images/greenArrow.png");
            }
            if(current_procedure == 4){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
                $("#pcr").attr("class","btn btn-mini btn-success");
                $("#pcrimg").attr('src',"static/images/greenArrow.png");
                $("#jiance").attr("class","btn btn-mini btn-success");
                $("#jianceimg").attr('src',"static/images/greenArrow.png");
                $("#fenxi").attr("class","btn btn-mini btn-success");
                $("#wanncheng").attr("class","btn btn-mini btn-success");
                $("#fenxiimg").attr('src',"static/images/greenArrow.png");
            }

            if(current_procedure == 4 && pore_plate_quality == 1){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
                $("#pcr").attr("class","btn btn-mini btn-success");
                $("#pcrimg").attr('src',"static/images/greenArrow.png");
                $("#jiance").attr("class","btn btn-mini btn-success");
                $("#jianceimg").attr('src',"static/images/greenArrow.png");
                $("#fenxi").attr("class","btn btn-mini btn-success");
                $("#fenxiimg").attr('src',"static/images/greenArrow.png");
                $("#tongguo").attr("class","btn btn-mini btn-success");
                $("#buban").removeAttr("onclick");
                $("#dakong").removeAttr("onclick");
                $("#pcr").removeAttr("onclick");
                $("#jiance").removeAttr("onclick");
                $("#fenxi").removeAttr("onclick");
                $("#tongguo").removeAttr("onclick");
                $("#butongguo").removeAttr("onclick");
                $("#yes").removeAttr("onclick");
                $("#no").removeAttr("onclick");
            }
            if(current_procedure == 4 && pore_plate_quality == 2){
                $("#buban").attr("class","btn btn-mini btn-success");
                $("#bubanimg").attr('src',"static/images/greenArrow.png");
                $("#dakong").attr("class","btn btn-mini btn-success");
                $("#dakongimg").attr('src',"static/images/greenArrow.png");
                $("#pcr").attr("class","btn btn-mini btn-success");
                $("#pcrimg").attr('src',"static/images/greenArrow.png");
                $("#jiance").attr("class","btn btn-mini btn-success");
                $("#jianceimg").attr('src',"static/images/greenArrow.png");
                $("#fenxi").attr("class","btn btn-mini btn-success");
                $("#fenxiimg").attr('src',"static/images/greenArrow.png");
                $("#butongguo").attr("class","btn btn-mini btn-success");
                $("#buban").removeAttr("onclick");
                $("#dakong").removeAttr("onclick");
                $("#pcr").removeAttr("onclick");
                $("#jiance").removeAttr("onclick");
                $("#fenxi").removeAttr("onclick");
                $("#tongguo").removeAttr("onclick");
                $("#butongguo").removeAttr("onclick");
                $("#yes").removeAttr("onclick");
                $("#no").removeAttr("onclick");
            }
        }
    });
    //根据下拉框选中  修改input内容
    function setNum(obj) {
        var s = $(obj).find("option:selected").text();
        var current_procedure = $("#current_procedure").val();
        if($(obj).prev().val()=='' || $(obj).prev().val()=='O'|| $(obj).prev().val()=='空孔' || $(obj).prev().val()=='P' || $(obj).prev().val()=='普通样本' || $(obj).prev().val()=='质检孔' || $(obj).prev().val()=='复核孔' || $(obj).prev().val()=='LADDER'){
            $(obj).prev().val(s);
        }

        var selectHtml = "";
        if(current_procedure==1 || current_procedure==2 || current_procedure == 3){
            selectHtml  = " <select class=\"chosen-select form-control\" >\n" +
                "            <option value=\"9\">问题样本</option>\n" +
                "            <option value=\"7\">空卡</option>\n" +
                "            <option value=\"8\">其他问题</option>\n" +
                "            </select>";
        }
        if(current_procedure==4 || current_procedure==5){
            selectHtml  =" <select class=\"chosen-select form-control\" onchange=\"showInput(this)\">\n" +
                "                                                        <option value=\"9\">特殊问题样本</option>\n" +
                "                                                        <option value=\"0\">正常</option>\n" +
                "                                                        <option value=\"1\">微变异</option>\n" +
                "                                                        <option value=\"2\">稀有等位</option>\n" +
                "                                                        <option value=\"3\">多拷贝</option>\n" +
                "                                                        <option value=\"6\">其他特殊样本</option>\n" +
                "                                                        <option value=\"4\">重复分型</option>\n" +
                "                                                        <option value=\"5\">失败</option>\n" +
                "                                                        <option value=\"7\">空卡</option>\n" +
                "                                                        <option value=\"8\">其他问题</option>\n" +
                "                                                    </select>";
        }


        if(s=="复核孔"){
            //获取到该节点在th中的下标
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().append(selectHtml);

            var z = $(obj).parent().index();
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','yellow');
        }else if(s=="LADDER"){
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().append(selectHtml);

            var z = $(obj).parent().index();
            $(obj).prev().attr("disabled","disabled");
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','black');
        }else if(s=="普通样本"){
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().append(selectHtml);

            $(obj).prev().val("");
            var z = $(obj).parent().index();
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
        }else if(s=="O"){
            var z = $(obj).parent().index();
            $(obj).prev().attr("disabled","disabled");
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','blue');
        }else if(s=="P"){
            var z = $(obj).parent().index();
            $(obj).prev().attr("disabled","disabled");
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','green');
        }else if(s=="质检孔"){
            $(obj).prev().removeAttr("disabled");
            $(obj).next().remove();
            $(obj).parent().append(html);
            var z = $(obj).parent().index();

            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
        }else if(s=="空孔"){
            $(obj).prev().val("");
            $(obj).prev().removeAttr("disabled");
            $(obj).parent().append(selectHtml);

            $(obj).prev().removeAttr("disabled");
            var z = $(obj).parent().index();
            $(obj).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
        }
        if(s!="质检孔") {
            if ($(obj).next().html() != undefined) {
                $(obj).next().remove();
            }
        }
    }

    //根据下拉框选中  修改input内容
    function setNumForZhijian(obj) {
        var s = $(obj).find("option:selected").text();
        if($(obj).prev().prev().attr("type")==undefined){
            $(obj).prev().prev().prev().val(s);
        }else{

            $(obj).prev().prev().val(s);
        }

    }
    //自动生成按钮方法
    function autoPore(){
        if($("#num").val()==""){
            $("#num").tips({
                side:3,
                msg:'请输入起始样本编号',
                bg:'#AE81FF',
                time:3
            });
            $("#num").focus();
            return false;
        }
        var num = $("#num").val();
        var reg = /^.*\d$/;
        if (!reg.exec(num)){
            $("#num").tips({
                side:3,
                msg:'请输入正确起始样本编号(必须数字结尾)',
                bg:'#AE81FF',
                time:3
            });
            $("#num").focus();
            return false;
        }


        if($("#startnum").val()==""){
            $("#startnum").tips({
                side:3,
                msg:'请输入起始位置角标',
                bg:'#AE81FF',
                time:3
            });
            $("#startnum").focus();
            return false;
        }


        var startnum = $("#startnum").val();
        var startnum1= startnum.substring(1,startnum.length);
        startnum1 = parseInt(startnum1);
        var endnum = $("#endnum").val();
        var endnum1= endnum.substring(1,endnum.length);
        var patrn = /^[a-hA-H].{1,3}$/;
        if (!patrn.exec(startnum)|| startnum1>12 || startnum1==0){
            $("#startnum").tips({
                side:3,
                msg:'请输入正确起始位置角标',
                bg:'#AE81FF',
                time:3
            });
            $("#startnum").focus();
            return false;
        }
        if($("#endnum").val()==""){
            $("#endnum").tips({
                side:3,
                msg:'请输入结束位置角标',
                bg:'#AE81FF',
                time:3
            });
            $("#endnum").focus();
            return false;
        }
        if (!patrn.exec(endnum)|| endnum1>12 || endnum1==0){
            $("#endnum").tips({
                side:3,
                msg:'请输入正确结束位置角标',
                bg:'#AE81FF',
                time:3
            });
            $("#endnum").focus();
            return false;
        }
        var compare = compareSizes(startnum,endnum);
        if(!compare){
            $("#endnum").tips({
                side:3,
                msg:'结束角标位置不能小于起始角标位置',
                bg:'#AE81FF',
                time:3
            });
            $("#endnum").focus();
            return false;
        }
        var number =$("#num").val();
        var end = new RegExp(/\d+$/);
        //获取到结尾的数字
        var endshuzi = end.exec(number);

        //结尾数字之前的内容
        var statrneirong = "";
        var s = parseInt(endshuzi);
        statrneirong = number.substr(0, number.lastIndexOf(endshuzi));
        statrneirong+= endshuzi.toString().substr(0,endshuzi.toString().lastIndexOf(s));

        //定义一个数字 来看有几位数字
        var tongjishuzi = "";
        //根据结尾数字计算出不跨位有多少个数字
        var endshuzilength = endshuzi.toString().length;
        var numNeirong = endshuzi.toString();
        for(var i = 0 ;i<endshuzilength;i++){
            tongjishuzi+="9";
        }
        //角标数量
        var  CompareNum = getCompareNum(startnum,endnum);
        //计算是否会跨位
        if( parseInt(CompareNum) + (parseInt(endshuzi)-1) > parseInt(tongjishuzi)){
            $("#num").tips({
                side:3,
                msg:'请输入正确起始样本编号(不可跨位数)',
                bg:'#AE81FF',
                time:3
            });
            $("#num").focus();
            return false;
        }
        startnum = startnum.toLowerCase();
        var z = startnum.substr(0, 1);
        var num = startnum.substr(1, startnum.length-1);
        //起始角标
        var startjiaobiao = z + parseInt(num);
        endnum = endnum.toLowerCase();
        var z1 = endnum.substr(0, 1);
        var num1 = endnum.substr(1, endnum.length-1);
        //结束角标
        var endjiaobiao = z1 + parseInt(num1);

        for (var i = 0;i<parseInt(CompareNum);i++){

            var jiaobiaoid = z+parseInt(num);
            var hole_type = $("#"+jiaobiaoid).next().val();
            //如果是laeder孔跳过
            if(hole_type != "7"){
                if(z=="h" || z=="H"){
                    z="a";
                    num++;
                }else{
                    z=getNextWord(z);;
                }
                if(z=="h" && num>12){
                    break;
                }
                continue;
            }
            var inputVal = getInputVal(statrneirong,s,endshuzi++);
            /*if(statrneirong.lastIndexOf("0")>=0 && endshuzi>9){
                $("#"+jiaobiaoid).val(statrneirong.substring(0,statrneirong.lastIndexOf("0"))+(endshuzi++));
            }else{
                $("#"+jiaobiaoid).val(statrneirong+(endshuzi++));
            }*/
            $("#"+jiaobiaoid).val(inputVal);
            //$("#"+jiaobiaoid).next().val("1");
            //获取下拉框的下标  修改样式
            var index = $("#"+jiaobiaoid).next().parent().index();
            //$("#"+jiaobiaoid).next().parent().parent().prev().children().eq(parseInt(index)).css('background-color','');
            //如果数字大于12  将a变成B  类推
            if(z=="h" || z=="H"){
                z="a";
                num++;
            }else{
                z=getNextWord(z);;
            }
            /*if(z=="h" && num==12){
                alert("角标输超过最大角标");
                break;
            }*/

        }
    }
    function getNextWord(z){
        if(z=="a"||z=="A"){
            z= "b";
            return z;
        } if(z=="b"||z=="B"){
            z= "c";
            return z;
        } if(z=="c"||z=="C"){
            z= "d";
            return z;
        } if(z=="d"||z=="D"){
            z= "e";
            return z;
        }  if(z=="e"||z=="E"){
            z= "f";
            return z;
        }  if(z=="f"||z=="F"){
            z= "g";
            return z;
        } if(z=="g"||z=="G"){
            z= "h";
            return z;
        }
    }

    function getCompareNum(s,e) {
        var z = s.substr(0, 1);
        var n = s.substr(1,s.length);
        if(z=="a"||z=="A"){
            z= 8;
        }if(z=="b"||z=="B"){
            z= 7;
        }if(z=="c"||z=="C"){
            z= 6;
        }if(z=="d"||z=="D"){
            z=5;
        }if(z=="e"||z=="E"){
            z= 4;
        }if(z=="f"||z=="F"){
            z= 3;
        }if(z=="g"||z=="G"){
            z= 2;
        }if(z=="h"||z=="H"){
            z= 1;
        }
        var z1 = e.substr(0, 1);
        var n1 = e.substr(1,e.length);
        if(z1=="a"||z1=="A"){
            z1= 1;
        }if(z1=="b"||z1=="B"){
            z1= 2;
        }if(z1=="c"||z1=="C"){
            z1= 3;
        }if(z1=="d"||z1=="D"){
            z1= 4;
        }if(z1=="e"||z1=="E"){
            z1= 5;
        }if(z1=="f"||z1=="F"){
            z1= 6;
        }if(z1=="g"||z1=="G"){
            z1= 7;
        }if(z1=="h"||z1=="H"){
            z1= 8;
        }
        var num = s.substr(1, s.length-1);
        num = parseInt(num);
        var num1 = e.substr(1, e.length-1);
        num1 = parseInt(num1);
        var comparenum= (z+z1)+(n1-n-1)*8;
        return comparenum ;
    }

    function compareSizes(s,e){
        var z = s.substr(0, 1);
        if(z=="a"||z=="A"){
            z= 8;
        }if(z=="b"||z=="B"){
            z= 7;
        }if(z=="c"||z=="C"){
            z= 6;
        }if(z=="d"||z=="D"){
            z= 5;
        }if(z=="e"||z=="E"){
            z= 4;
        }if(z=="f"||z=="F"){
            z= 3;
        }if(z=="g"||z=="G"){
            z= 2;
        }if(z=="h"||z=="H"){
            z= 1;
        }
        var z1 = e.substr(0, 1);
        if(z1=="a"||z1=="A"){
            z1= 8;
        }if(z1=="b"||z1=="B"){
            z1= 7;
        }if(z1=="c"||z1=="C"){
            z1= 6;
        }if(z1=="d"||z1=="D"){
            z1= 5;
        }if(z1=="e"||z1=="E"){
            z1= 4;
        }if(z1=="f"||z1=="F"){
            z1= 3;
        }if(z1=="g"||z1=="G"){
            z1= 2;
        }if(z1=="h"||z1=="H"){
            z1= 1;
        }
        var num = s.substr(1, s.length-1);
        num = parseInt(num);
        var num1 = e.substr(1, e.length-1);
        num1 = parseInt(num1);
        if(num1<num){
            return false;
        }
        if(num1==num && z<z1){
            return false;
        }
        return true;
    }
    function createCompoundHoleClick() {
        if($("#CompoundHoleNum").val()<2||$("#CompoundHoleNum").val()>5){
            $("#CompoundHoleNum").tips({
                side:3,
                msg:'请输入正确的孔板个数',
                bg:'#AE81FF',
                time:3
            });
            $("#CompoundHoleNum").focus();
            return false;
        }
        createCompoundHole($("#CompoundHoleNum").val());

    }





    /**
     * 产生随机整数，包含下限值，但不包括上限值
     * @param {Number} lower 下限
     * @param {Number} upper 上限
     * @return {Number} 返回在下限到上限之间的一个随机整数
     */
    function random(lower, upper) {
        return Math.floor(Math.random() * (upper - lower)) + lower;
    }


    //完成布板方法
    function completeLayout(){
        var current_procedure_now = $("#current_procedure").val();
        var projectPermission = $("#projectPermission").val();
        if(current_procedure_now != 0 && projectPermission == 2){
            $("#buban").tips({
                side:3,
                msg:'您没有权限修改',
                bg:'#AE81FF',
                time:3
            });
            $("#buban").focus();
            return false;
        }
        var sampleNumber = 0;
        //是否整版重扩
        //var pore_plate_entirety = $("input[name='pore_plate_entirety']:checked").val();
        var pore_plate_type = $("#pore_plate_type").val();


        var json = "{'programmers':["
        var allnum = "";
        var goorreturn = true;
        $("#simple-table input[type='text']").each(function(){
            var inputval = $(this).val();
            var firstSelect = $(this).next().val();
            var sampleId = $(this).attr('name');
            if (inputval !="" ) {
                if( firstSelect != "5" && firstSelect != "6" && firstSelect!="7"){
                    if(allnum.indexOf(inputval)>=0){
                        alert("有重复的样本编号,编号为:"+inputval);
                        goorreturn = false;
                    }
                    allnum += inputval+",";
                }
                var fuhekongId = "";
                if(firstSelect=="7"){
                    fuhekongId = $(this).next().next().find("option:selected").attr("name")
                    if(fuhekongId == undefined){
                        fuhekongId = "";
                    }
                }
                if(firstSelect!="5" && firstSelect!="2" && firstSelect!="3" && firstSelect !="7"){
                    sampleNumber ++;
                }
                var z = $(this).next().parent().index();
                var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
                json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"',"+"'hole_type':'"+$(this).next().val()+"','htId':'"+sampleId+"','fuhekongId':'"+fuhekongId+"'},"
            }
        });
        json = json.substring(0,json.length-1);
        json+="]}";
        var msg = $("#msg").val();
        var url ="";
        if(msg == "editPorePlate"){
            url = '<%=basePath%>porePlate/editPorePlateDetailed'
        }else {
            url = '<%=basePath%>porePlate/savePorePlateDetailed';
        }
        if($("#current_procedure").val()=="0"){
            url = '<%=basePath%>porePlate/savePorePlateDetailed';
        }
        if($("#lims_pore_serial").val()!=1 && $("#lims_pore_serial").val()!=''){
            url = '<%=basePath%>porePlate/editPorePlateDetailed';
        }
        if(goorreturn){
            $.ajax({
                type : "POST",
                async:false,
                cache: false,
                url : url,
                data: {plate_project_id:$("#plate_project_id").val(),sample_sum:sampleNumber,json:json,id:$("#poreId").val(),pore_plate_name:$("#pore_plate_name").val()},
                dataType : "json",
                success: function (data) {
                    if(data.msg!=undefined){
                        alert(data.msg);
                        return;
                    }
                    console.log(data.msg);
                    siMenu('z150','lm144','孔板管理','porePlate/list.do');

                }
            });
        }

    }

    //导出excel
    function toExcel(){
        var json = "{'programmers':["
        $("#simple-table input[type='text']").each(function(){
            var z = $(this).next().parent().index();
            var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
            json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"','hole_type':'"+$(this).next().val()+"'},"
        });
        json = json.substring(0,json.length-1);
        json+="]}";
        $("#json2").val(json);
        $("#pore_plate_name2").val($("#pore_plate_name").val());
        $("#pore_plate_name2").val($("#pore_plate_name").val());
        $("#pore_plate_quality2").val($("#pore_plate_quality").val());
        $("#NAME2").val($("#NAME").val());
        $("#id2").val($("#poreId").val());
        $("#toExcel").submit();

        //window.location.href='<%=basePath%>porePlate/excel.do?json='+json+"&pore_plate_name="+$("#pore_plate_name").val()+"&pore_plate_quality="+$("#pore_plate_quality").val()+"&NAME="+$("#NAME").val()+"&id="+$("#poreId").val();
    }

    function openP(){
        var json = "{'programmers':["
        $("#simple-table input[type='text']").each(function(){
            var inputval = $(this).val();
            if (inputval !="") {
                var z = $(this).next().parent().index();
                var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
                json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"',"+"'hole_type':'"+$(this).next().val()+"','hole_special_sample':'"+$(this).next().next().val()+"'},"
            }
        });
        json = json.substring(0,json.length-1);
        json+="]}";
        $("#json").val(json);
        $("#pore_plate_name1").val($("#pore_plate_name").val());
        $("#name1").val($("#NAME").val());
        $("#pore_plate_quality1").val($("#pore_plate_quality").val());
        window.open("", "newWin", 'left=250,top=150,width=750,height=500,toolbar=no,menubar=no,status=no,scrollbars=yes,resizable=yes');
        $("#openP").submit();
    }

    //打开上传excel页面
    function fromExcel(show_div,bg_div){
        document.getElementById(show_div).style.display='block';
        document.getElementById(bg_div).style.display='block' ;
        var bgdiv = document.getElementById(bg_div);
        bgdiv.style.width = document.body.scrollWidth;
        $("#"+bg_div).height($(document).height());
    }

    //关闭弹出层
    function CloseDiv(show_div,bg_div)
    {
        document.getElementById(show_div).style.display='none';
        document.getElementById(bg_div).style.display='none';
    };


    //保存
    function saveExcel(){
        if($("#excel").val()=="" || document.getElementById("excel").files[0] =='请选择xls格式的文件'){

            $("#excel").tips({
                side:3,
                msg:'请选择文件',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        /*$("#Form").submit();*/
        var form = new FormData(document.getElementById("Form"));
        $.ajax({
            url:"<%=basePath%>porePlate/readExcel",
            type:"post",
            data:form,
            processData:false,
            contentType:false,
            success:function(data){
                CloseDiv('MyDiv','fade');
                var poreList = data.data;
                var jsonData = eval(poreList);
                //遍历jsonData：
                for (var i = 0; i < jsonData.length; i++) {
                    console.log(jsonData[i].var0);
                    var inputId = jsonData[i].var0;
                    //将大写转成小写
                    inputId = inputId.toLowerCase();
                    //获取结尾数字   将01转成1
                    var idNum = inputId.substring(1,inputId.length);
                    inputId = inputId.substring(0,1);
                    idNum = parseInt(idNum);
                    //获取最终的input框id
                    inputId = inputId+idNum;
                    $("#"+inputId).val(jsonData[i].var1);
                    var z = $("#"+inputId).parent().index();
                    if(jsonData[i].var2==""){
                        $("#"+inputId).next().val(1);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
                    }
                    if(jsonData[i].var2=="LADDER"){
                        $("#"+inputId).next().val(5);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','black');
                    }
                    if(jsonData[i].var2=="P"){
                        $("#"+inputId).next().val(2);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','green');
                    }
                    if(jsonData[i].var2=="O"){
                        $("#"+inputId).next().val(3);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','blue');
                    }
                    if(jsonData[i].var2=="QC-"){
                        $("#"+inputId).next().val(7);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','');
                    }
                    if(jsonData[i].var2=="QC"){
                        $("#"+inputId).next().val(4);
                        $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','yellow');
                    }

                    /* $("#"+inputId).next().val(jsonData[i].var1);
                     //如果是复核孔  变黄
                     if(jsonData[i].hole_type == "4"){
                         var z = $("#"+inputId).parent().index();
                         $("#"+inputId).parent().parent().prev().children().eq(parseInt(z)).css('background-color','yellow');
                     }
                     $("#"+inputId).next().next().val(jsonData[i].var2);*/
                }
            },
            error:function(e){
                alert("错误！！");
                CloseDiv('MyDiv','fade')
            }
        });
    }

    function fileType(obj){
        var fileType=obj.value.substr(obj.value.lastIndexOf(".")).toLowerCase();//获得文件后缀名
        if(fileType != '.xls'){
            $("#excel").tips({
                side:3,
                msg:'请上传xls格式的文件',
                bg:'#AE81FF',
                time:3
            });
            $("#excel").val('');
            document.getElementById("excel").files[0] = '请选择xls格式的文件';
        }
    }


    function completeOther(current_procedure,id){
        var current_procedure_now = $("#current_procedure").val();
        var projectPermission = $("#projectPermission").val();
        if(current_procedure_now != 1 &&  current_procedure ==2 && projectPermission == 2){
            $("#"+id).tips({
                side:3,
                msg:'您没有权限修改',
                bg:'#AE81FF',
                time:3
            });
            $("#"+id).focus();
            return false;
        }

        if(current_procedure_now == current_procedure && projectPermission == 2){
            $("#"+id).tips({
                side:3,
                msg:'您没有权限修改',
                bg:'#AE81FF',
                time:3
            });
            $("#"+id).focus();
            return false;
        }

        if(current_procedure_now == 0){
            $("#buban").tips({
                side:3,
                msg:'当前处于准备状态,请先完成布板!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        if(current_procedure_now == 1 && current_procedure>2){
            $("#dakong").tips({
                side:3,
                msg:'当前处于布板状态,请先完成打孔!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        if(current_procedure_now == 2 && current_procedure>3){
            $("#pcr").tips({
                side:3,
                msg:'当前处于打孔状态,请先完成扩增!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }

        if(current_procedure_now == 3 && current_procedure>5){
            $("#jiance").tips({
                side:3,
                msg:'当前处于打扩增状态,请先完成检测!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        if(current_procedure_now == 5 && current_procedure>4){
            $("#fenxi").tips({
                side:3,
                msg:'当前处于打检测状态,请先完成分析!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }


        var sampleNumber = 0;
        //是否整版重扩
        var pore_plate_entirety = $("input[name='pore_plate_entirety']:checked").val();
        var pore_plate_type = $("#pore_plate_type").val();
        if(pore_plate_type == 1){
            if(pore_plate_entirety == undefined){
                $("#pore_plate_entirety").tips({
                    side:3,
                    msg:'请选择是否整版重扩',
                    bg:'#AE81FF',
                    time:3
                });
                $("#pore_plate_entirety").focus();
                return false;
            }
        }
        if(current_procedure!=4){
            var json = "{'programmers':["
            $("#simple-table input[type='text']").each(function(){
                var inputval = $(this).val();
                var sampleId = $(this).attr('name');
                if (inputval !="") {
                    sampleNumber ++;
                    var z = $(this).next().parent().index();
                    var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
                    json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"',"+"'hole_type':'"+$(this).next().val()+"','hole_special_sample':'"+$(this).next().next().val()+"','htId':'"+sampleId+"','hole_sample_remark':'"+$(this).next().next().next().val()+"'},"
                }
            });
            json = json.substring(0,json.length-1);
            json+="]}";
            console.log(json);
        }else{
            var json = "{'programmers':["
            $("#simple-table input[type='text']").each(function(){
                var inputval = $(this).val();
                var sampleId = $(this).attr('name');
                if (inputval !="") {
                    sampleNumber ++;
                    var z = $(this).next().parent().index();
                    var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
                    json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"',"+"'hole_type':'"+$(this).next().val()+"','hole_special_sample':'"+$(this).next().next().val()+"','htId':'"+sampleId+"','hole_sample_remark':'"+$(this).next().next().next().val()+"'},"
                }
            });
            json = json.substring(0,json.length-1);
            json+="]}";
            console.log(json);
        }

        var msg = $("#msg").val();
        var url ="";
        if(msg == "editPorePlate"){
            url ='<%=basePath%>porePlate/completeOther';
        }else {
            url = '<%=basePath%>porePlate/completeOther';
        }
        $.ajax({
            type : "POST",
            cache: false,
            url : url,
            data: {current_procedure:current_procedure,plate_project_id:$("#plate_project_id").val(),pore_plate_entirety:pore_plate_entirety,sample_sum:sampleNumber,json:json,id:$("#poreId").val(),pore_plate_name:$("#pore_plate_name").val()},
            dataType : "json",
            success: function () {
                if(current_procedure == 2){
                    siMenu('z154','lm145','打孔待办','punching/list.do?current_procedure=1');
                }else if(current_procedure == 4){
                    siMenu('z157','lm148','分析待办','punching/list.do?current_procedure=5');
                }else{
                    siMenu('z150','lm144','孔板管理','porePlate/list.do');
                }
            }
        });

    }

    function completeOtherFuhe(pore_plate_quality){
        var current_procedure_now = $("#current_procedure").val();
        if(current_procedure_now != 4){
            $("#fenxi").tips({
                side:3,
                msg:'请先完成分析!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        $.ajax({
            type : "POST",
            cache: false,
            url : '<%=basePath%>porePlate/completeOtherFuhe',
            data: { id:$("#poreId").val(),pore_plate_quality:pore_plate_quality},
            dataType : "json",
            success: function () {
                siMenu('z150','lm144','孔板管理','porePlate/list.do');
            }
        });
    }

    //选择仪器方法
    function selectInstrument(){
        var current_procedure_now = $("#current_procedure").val();
        var projectPermission = $("#projectPermission").val();
        if(current_procedure_now != 2 && projectPermission == 2){
            $("#pcr").tips({
                side:3,
                msg:'您没有权限修改',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }

        if(current_procedure_now == 1){
            $("#buban").tips({
                side:3,
                msg:'当前处于布板状态,请先完成打孔!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        var sampleNumber = 0 ;
        /* var json = "{'programmers':["
         $("#simple-table input[type='text']").each(function(){
             var inputval = $(this).val();
             var sampleId = $(this).attr('name');
             if (inputval !="") {
                 sampleNumber ++;
                 var z = $(this).next().parent().index();
                 var hole_number =  $(this).next().parent().parent().prev().children().eq(parseInt(z)).text();
                 json+="{'hole_number':'"+hole_number+"','poreNum':'"+$(this).val()+"',"+"'hole_type':'"+$(this).next().val()+"','hole_special_sample':'"+$(this).next().next().val()+"','htId':'"+sampleId+"'},"
             }
         });
         json = json.substring(0,json.length-1);
         json+="]}";*/
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="完成PCR扩增";
        diag.URL = '<%=basePath%>porePlate/goSelectInstrument.do?current_procedure=3&plate_project_id='+$("#plate_project_id").val()+"&sample_sum="+sampleNumber+"&id="+$("#poreId").val()+"&pore_plate_name="+$("#pore_plate_name").val();
        diag.Width = 520;
        diag.Height = 450;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                diag.close();
            }
            diag.close();
        };
        diag.show();
    }


    //选择仪器方法
    function selectInstrumentForTest(){
        var current_procedure_now = $("#current_procedure").val();
        var projectPermission = $("#projectPermission").val();
        if(current_procedure_now != 3 && projectPermission == 2){
            $("#jiance").tips({
                side:3,
                msg:'您没有权限修改!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        if(current_procedure_now == 1){
            $("#buban").tips({
                side:3,
                msg:'当前处于布板状态,请先完成打孔!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        if(current_procedure_now == 2){
            $("#dakong").tips({
                side:3,
                msg:'当前处于打孔状态,请先完成PCR扩增!',
                bg:'#AE81FF',
                time:3
            });
            return false;
        }
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="完成检测";
        diag.URL = '<%=basePath%>porePlate/goSelectInstrumentForTest.do?id='+$("#poreId").val();
        diag.Width = 600;
        diag.Height = 450;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                diag.close();
            }
            diag.close();
        };
        diag.show();
    }

    //是否整版重扩
    function entirety(pore_plate_entirety){
        $.ajax({
            type : "POST",
            cache: false,
            url : '<%=basePath%>porePlate/entirety',
            data: { id:$("#poreId").val(),pore_plate_entirety:pore_plate_entirety},
            dataType : "json",
            success: function () {
                siMenu('z150','lm144','孔板管理','porePlate/list.do');
            }
        });
    }

    //将当前页面复核孔填入下拉框
    function changeSelect(obj) {
        var pore_plate_name = $("#pore_plate_name").val();
        if($(obj).prev().attr("type")=="hidden"){
            $(obj).prev().remove();
        }
        $(obj).find('.n').remove();
        var html = "";
        var fhnum = "";
        $("#simple-table input[type='text']").each(function(){
            var type = $(this).next().val();
            var fuhe = $(this).next().next().val();

            if(type == "4" ){

                var num = $(this).val();
                //判断是否有重复的选项
                var isExist = false;
                var count = $(obj).find('option').length;

                for(var i=0;i<count;i++)
                {
                    if($(obj).get(0).options[i].value == pore_plate_name+"-"+num)
                    {
                        isExist = true;
                        break;
                    }
                }
                //有就不添加
                if(!isExist){
                    html+="<option class='n' value='"+pore_plate_name+" - "+num+"'>"+pore_plate_name+"-"+num+"</option>"
                }
            }

            if(type == "7"){
                var num1 = $(this).val();
                fhnum+=num1+",";
            }
        });
        $(obj).append(html);
        $(obj).children().each(function(){
            if(fhnum.indexOf($(this).val())>=0){
                //$(this).attr("class","result-selected");
                $(this).attr("disabled","true");
            }else{
                $(this).removeAttr("disabled");
            }
        });
    }

    function showInput(obj){
        var value = $(obj).val();
        if(value != 0 && value != 7  && value != 8){

            $(obj).prev().prev().css("color","red");
            bootbox.confirm("<textarea style='width: 550px' placeholder='请输入原因' id='hole_sample_remark'/>", function(result) {
                if(result) {
                    $(obj).next().val($("#hole_sample_remark").val());
                };
            });
        }else{
            $(obj).prev().prev().css("color","");
        }

    }
    //判断下拉框是否包
    function isExistOption(obj,value) {
        var isExist = false;
        var count = $(obj).find('option').length;

        for(var i=0;i<count;i++)
        {
            if($(obj).get(0).options[i].value == value)
            {
                isExist = true;
                break;
            }
        }
        return isExist;
    }

    function getInputVal(statrneirong,s,endshuzi){
        var shuzi = "";
        for(var i = 0 ;i<s.toString().length;i++){
            shuzi+="9";
        }
        var z = 0;
        if(endshuzi>parseInt(shuzi)){
            z = endshuzi.toString().length - shuzi.toString().length;
        }
        var j = "";
        for(var i = 0 ;i<z;i++){
            j +="0";
        }
        return statrneirong.substring(0,statrneirong.lastIndexOf(j))+(endshuzi);
    }


    $(document).keyup(function(event){
        if(event.keyCode ==13){
            var number = $("#num").val();
            var id = "a1";
            var z = id.substr(0, 1);
            var num = parseInt(id.substr(1, id.length-1));
            var id1 = z+num;
            if( $("#"+id1).val()==""){
                $("#"+id1).focus();
                $("#"+id1).val(number);
            }else{
                while ($("#"+id1).val()!="" ){
                    if(z=="h" || z=="H"){
                        z = "a";
                        num ++;
                        if(num>12){
                            num=1;
                        }
                    }else{
                        z=  getNextWord(z);
                    }
                    id1 = z+num;
                    if(id1 == "h12"){
                        break;
                    }
                }
                $("#"+id1).focus();
                $("#"+id1).val(number);
            }
        }
    });
</script>
</html>
