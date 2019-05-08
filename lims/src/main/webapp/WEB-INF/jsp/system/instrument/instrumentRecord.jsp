<%@ page language="java" contentType="text/html; charset=UTF-8"
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
    <!-- jsp文件头和头部 -->
    <%@ include file="../index/top.jsp"%>
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
                        <form action="instrument/recordList.do" method="post" name="userForm" id="userForm">
                            <table style="margin-top:20px;margin-bottom: 10px">
                                <tr>
                                    <td>
                                        <div class="nav-search">
									        <span class="input-icon">
										    <input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" value="${pd.keywords}" name="keywords" placeholder="请输入仪器型号" />
										    <i class="ace-icon fa fa-search nav-search-icon"></i>
									        </span>
                                        </div>
                                    </td>
                                    <%--<c:if test="${QX.cha == 1 }">--%>
                                        <td style="vertical-align:top;padding-left:10px;"><a class="btn btn-light btn-xs" onclick="searchs();" style="margin-left: 10px" title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
                                   <%-- </c:if>--%>
                                </tr>
                            </table>

                            <!-- 检索  -->

                            <table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
                                <thead>
                                <tr>
                                    <th class="center" style="width:50px;">序号</th>
                                    <th class="center">仪器型号</th>
                                    <th class="center">使用者</th>
                                    <th class="center">使用时间</th>
                                    <th class="center">操作</th>
                                </tr>
                                </thead>

                                <tbody>

                                <!-- 开始循环 -->
                                <c:choose>
                                    <c:when test="${not empty list}">
                                        <c:if test="${QX.cha == 1 }">
                                            <c:forEach items="${list}" var="list" varStatus="vs">

                                                <tr>
                                                    <td class='center' style="width: 30px;">${page.showCount*(page.currentPage-1)+vs.index+1}</td>
                                                    <td class="center">${list.instrument.INSTRUMENT_TYPE }</td>
                                                    <td class="center">${list.user.NAME }</td>
                                                    <td class="center">
                                                        <fmt:formatDate value="${list.INSTRUMENT_TIME }" pattern="yyyy年MM月dd日 "/><%--hh时mm分ss秒--%>
                                                    </td>
                                                    <td class="center">
                                                       <%-- <c:if test="${QX.edits != 1 && QX.dels != 1 }">
                                                            <span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="ace-icon fa fa-lock" title="无权限"></i></span>
                                                        </c:if>--%>
                                                        <div class="hidden-sm hidden-xs btn-group">
                                                            <%--<c:if test="${QX.edits == 1 }">--%>
                                                                <a class="btn btn-xs btn-success" title="编辑" onclick="editUser('${list.ID}');">
                                                                    <i class="ace-icon fa fa-pencil-square-o bigger-120" title="编辑"></i>
                                                                </a>
                                                            <%--</c:if>--%>
                                                            <%--<c:if test="${QX.dels == 1 }">--%>
                                                                <a class="btn btn-xs btn-danger" onclick="delUser('${list.ID}');">
                                                                    <i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
                                                                </a>
                                                            <%--</c:if>--%>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                        <%--<c:if test="${QX.cha == 0 }">
                                            <tr>
                                                <td colspan="10" class="center">您无权查看</td>
                                            </tr>
                                        </c:if>--%>
                                    </c:when>
                                    <c:otherwise>
                                        <tr class="main_info">
                                            <td colspan="10" class="center">没有相关数据</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                                </tbody>
                            </table>
                            <input type="hidden" id="Id"/>
                            <div class="page-header position-relative">
                                <table style="width:100%;">
                                    <tr>
                                        <td style="vertical-align:top;">
                                            <%--<c:if test="${QX.adds == 1 }">--%>
                                                <a class="btn btn-mini btn-success" onclick="add();">新增</a>
                                            <%--</c:if>--%>
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
<%@ include file="../index/foot.jsp"%>
<!-- 删除时确认窗口 -->
<script src="static/ace/js/bootbox.js"></script>
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
    $(top.hangge());

    //检索
    function searchs(){
        top.jzts();
        $("#userForm").submit();
    }

    //删除
    function delUser(ID){
        bootbox.confirm("确定要删除本条记录吗?", function(result) {
            if (result){
                top.jzts();
                var url = "<%=basePath%>instrument/delRecord.do?ID="+ID;
                $.get(url,function(data){
                    nextPage(${page.currentPage});
                });
            }
        });
    }

    //新增
    function add(){
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="新增";
        diag.URL = '<%=basePath%>instrument/goAddRecord.do';
        diag.Width = 469;
        diag.Height = 369;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                if('${page.currentPage}' == '0'){
                    top.jzts();
                    setTimeout("self.location=self.location",100);
                }else{
                    nextPage(${page.currentPage});
                }
            }
            diag.close();
        };
        diag.show();
    }

    //修改
    function editUser(id){
        $("#Id").val(id);
        top.jzts();
        var diag = new top.Dialog();
        diag.Drag=true;
        diag.Title ="编辑";
        diag.URL = '<%=basePath%>instrument/goEditRecord.do?ID='+id;
        diag.Width = 469;
        diag.Height = 369;
        diag.CancelEvent = function(){ //关闭事件
            if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
                nextPage(${page.currentPage});
            }
            diag.close();
        };
        diag.show();
    }

    $(function() {
        //日期框
        $('.date-picker').datepicker({autoclose: true,todayHighlight: true});

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

        //复选框全选控制
        var active_class = 'active';
        $('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
            var th_checked = this.checked;//checkbox inside "TH" table header
            $(this).closest('table').find('tbody > tr').each(function(){
                var row = this;
                if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
                else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
            });
        });
    });
</script>
</html>
