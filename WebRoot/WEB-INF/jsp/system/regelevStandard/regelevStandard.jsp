﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
	<head>
	<base href="<%=basePath%>">
	<!-- jsp文件头和头部 -->
	<%@ include file="../../system/admin/top.jsp"%> 
 <!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 图片插件 -->
    <link href="static/js/fancybox/jquery.fancybox.css" rel="stylesheet">
    <!-- Check Box -->
    <link href="static/js/iCheck/custom.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="static/js/sweetalert2/sweetalert2.css" rel="stylesheet">
	<title>${pd.SYSNAME}</title>
</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div id="AddRegelevStandard" class="animated fadeIn"></div>
        <div id="EditElevatorStandard" class="animated fadeIn"></div>
        <div id="ViewProduct" class="animated fadeIn"></div>
	        <div class="row">
	            <div class="col-sm-12">
	                <div class="ibox float-e-margins">
	                    <div class="ibox-content">
	                    <div id="top",name="top"></div>
	                        <form role="form" class="form-inline" action="regelevStandard/regelevStandardList.do" method="post" name="regelevStandardForm" id="regelevStandardForm">
	                            <div class="form-group ">
	                                <input type="text" name="elevator_standard_name" value="${elevator_standard_name}" placeholder="这里输入名称" class="form-control">
	                                <select  class="form-control" name="elevator_speed_id" id="elevator_speed_id" title="速度参数">
	                               			<option value="">请选择速度参数</option>
	                                        <c:forEach items="${elevatorSpeedList }" var="elevatorSpeed">
	                                        	<option value="${elevatorSpeed.elevator_speed_id }" ${elevatorSpeed.elevator_speed_id eq elevator_speed_id ? 'selected':'' } >${elevatorSpeed.elevator_speed_name }</option>
											</c:forEach>
									</select>
									<select  class="form-control" name="elevator_weight_id" id="elevator_weight_id" title="重量参数">
	                               			<option value="">请选择重量参数</option>
	                                        <c:forEach items="${elevatorWeightList }" var="elevatorWeight">
	                                        	<option value="${elevatorWeight.elevator_weight_id }" ${elevatorWeight.elevator_weight_id eq elevator_weight_id ? 'selected':'' } >${elevatorWeight.elevator_weight_name }</option>
											</c:forEach>
									</select>
	                            </div>
	                           
	                            <div class="form-group">
	                                 <button type="submit" class="btn  btn-primary " style="margin-bottom:0px"><i style="font-size:18px;" class="fa fa-search"></i></button>
	                            </div>
	                            <button class="btn  btn-success" title="刷新" type="button" style="float:right" onclick="refreshCurrentTab();">刷新</button>
	                        </form>
	                            <div class="row">
	                            </br>
	                             </div>
	                        <div class="table-responsive" >
	                            <table class="table table-striped table-bordered table-hover">
	                                <thead>
	                                    <tr>
	                                   		<th style="width:2%;"><input type="checkbox" name="zcheckbox" id="zcheckbox" class="i-checks" ></th>
	                                        <th style="width:5%;">序号</th>
	                                        <th style="width:20%;">名称</th>
	                                        <th style="width:10%;">速度(m/s)</th>
	                                        <th style="width:10%;">承重(KG)</th>
	                                        <th style="width:10%;">层站门</th>
	                                        <th style="width:20%;">价格</th>
	                                        <th style="width:20%;">操作</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                <!-- 开始循环 -->	
									<c:choose>
										<c:when test="${not empty regelevStandardList}">
											<c:if test="${QX.cha == 1 }">
												<c:forEach items="${regelevStandardList}" var="var" varStatus="vs">
													<tr id="${var.autoid }">
														<td><input type="checkbox"  class="i-checks" name='ids' id='ids' value="${var.ID}"></td>
														<td>${vs.index+1}</td>
														<td>
															${var.NAME}
														</td>
														<td>
															${var.SD}
														</td>
														<td>
															${var.ZZ}
														</td>
														<td>
															${var.C}
															/
															${var.Z}
															/
															${var.M}
														</td>
														<td>${var.PRICE }</td>
														
														<td>
																<c:if test="${QX.edit != 1 && QX.del != 1 }">
																	<span class="label label-large label-grey arrowed-in-right arrowed-in"><i class="icon-lock" title="无权限">无权限</i></span>
																</c:if>
																<c:if test="${QX.edit == 1 }">
																	<button class="btn  btn-primary btn-sm" title="编辑" type="button"onclick="edit('${var.elevator_standard_id }');">编辑</button>
																</c:if>
																<c:if test="${QX.del == 1 }">
																	<button class="btn  btn-danger btn-sm" title="删除" type="button" onclick="del('${var.elevator_standard_id }','${var.elevator_standard_name }');">删除</button>
																</c:if>
															
														</td>
														
													</tr>
												</c:forEach>
												</c:if>
												<c:if test="${QX.cha == 0 }">
													<tr>
														<td colspan="100" class="center">您无权查看</td>
													</tr>
												</c:if>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
                                </tbody>
	                            </table>
								<div class="col-lg-12" style="padding-left:0px;padding-right:0px">
									<c:if test="${QX.add == 1 }">
										<button class="btn  btn-primary" title="新增" type="button" onclick="add();">新增</button>
									</c:if>
									<c:if test="${QX.del == 1 }">
										<button class="btn  btn-danger" title="批量删除" type="button" onclick="makeAll();">批量删除</button>						
									</c:if>
								</div>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    <!--返回顶部开始-->
        <div id="back-to-top">
            <a class="btn btn-warning btn-back-to-top" href="javascript: setWindowScrollTop (this,document.getElementById('top').offsetTop);">
                <i class="fa fa-chevron-up"></i>
            </a>
        </div>
        <!--返回顶部结束-->
	<!-- Fancy box -->
    <script src="static/js/fancybox/jquery.fancybox.js"></script>
	<!-- iCheck -->
    <script src="static/js/iCheck/icheck.min.js"></script>
    <!-- Sweet alert -->
    <script src="static/js/sweetalert2/sweetalert2.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
			//loading end
			parent.layer.closeAll('loading');
        	/* checkbox */
            $('.i-checks').iCheck({
                checkboxClass: 'icheckbox_square-green',
                radioClass: 'iradio_square-green',
            });
        	/* 图片 */
            $('.fancybox').fancybox({
                openEffect: 'none',
                closeEffect: 'none'
            });
        });
        /* checkbox全选 */
        $("#zcheckbox").on('ifChecked', function(event){
        	
        	$('input').iCheck('check');
      	});
        /* checkbox取消全选 */
        $("#zcheckbox").on('ifUnchecked', function(event){
        	
        	$('input').iCheck('uncheck');
      	});
        
      	//刷新iframe
        function refreshCurrentTab() {
      	/* 	alert("refresh");
      		alert("src=>"+window.location); */
        	window.location.reload();
        }
		//检索
		function search(){
			$("#Form").submit();
		}
		//新增
		function add(){
			$("#AddRegelevStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "新增电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>regelevStandard/goAddRegelevStandard.do',
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		
		//删除
		function del(elevator_standard_id,elevator_standard_name){
                swal({
                        title: "您确定要删除["+elevator_standard_name+"]吗？",
                        text: "删除后将无法恢复，请谨慎操作！",
                        type: "warning",
                        showCancelButton: true,
                        confirmButtonColor: "#DD6B55",
                        confirmButtonText: "删除",
                        cancelButtonText: "取消",
                        closeOnConfirm: false,
                        closeOnCancel: false
                    }).then(function (isConfirm) {
                        if (isConfirm) {
                        	var url = "<%=basePath%>elevatorStandard/delElevatorStandard.do?elevator_standard_id="+elevator_standard_id+"&guid="+new Date().getTime();
            				$.get(url,function(data){
            					if(data=='success'){
            						swal({   
            				        	title: "删除成功！",
            				        	text: "您已经成功删除了这条信息。",
            				        	type: "success",  
            				        	}).then(function(){
            									refreshCurrentTab();
            							});
            					}else{
            						swal("删除失败", "您的删除操作失败了！", "error");
            					}
            				});
                        } else {
                            swal("已取消", "您取消了删除操作！", "error");
                        }
                    });
		}
		
		//查看 
		function viewAgent(agent_id){
			$("#ViewAgent").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "查看详情",
		        actions: ["Close"],
		        content: '<%=basePath%>sysAgent/toView.do?agent_id='+agent_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").center().open();
		}
		//修改
		function edit(elevator_standard_id){
			$("#EditElevatorStandard").kendoWindow({
		        width: "1200px",
		        height: "700px",
		        title: "编辑电梯标准价格",
		        actions: ["Close"],
		        content: '<%=basePath%>elevatorStandard/goEditElevatorStandard.do?elevator_standard_id='+elevator_standard_id,
		        modal : true,
				visible : false,
				resizable : true
		    }).data("kendoWindow").maximize().open();
		}
		//批量操作
		function makeAll(){
			var str = '';
			for(var i=0;i < document.getElementsByName('ids').length;i++){
			  if(document.getElementsByName('ids')[i].checked){
			  	if(str=='') str += document.getElementsByName('ids')[i].value;
			  	else str += ',' + document.getElementsByName('ids')[i].value;
			  }
			}
			if(str==''){
				swal({
	                title: "您未选择任何数据",
	                text: "请选择你需要操作的数据！",
	                type: "error",
	                showCancelButton: false,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "OK",
	                closeOnConfirm: true,
	                timer:1500
	            });
			}else{
				swal({
	                title: "您确定要删除选中的数据吗？",
	                text: "删除后将无法恢复，请谨慎操作！",
	                type: "warning",
	                showCancelButton: true,
	                confirmButtonColor: "#DD6B55",
	                confirmButtonText: "删除",
	                cancelButtonText: "取消",
	                closeOnConfirm: false,
	                closeOnCancel: false
	            }).then(function (isConfirm) {
	                if (isConfirm) {
	                	$.ajax({
							type: "POST",
							url: '<%=basePath%>elevatorStandard/elevatorStandardDeleteAll.do',
					    	data: {DATA_IDS:str},
							dataType:'json',
							cache: false,
							success: function(data){
								$.each(data.list, function(i, list){
									if(list.msg=='ok'){
										swal({   
		        				        	title: "删除成功！",
		        				        	text: "您已经成功删除了这条信息。",
		        				        	type: "success",  
		        				        	 }).then(function(){   
	        				        		 	refreshCurrentTab(); 
	        				        	 	});
			    					}else{
			    						swal("删除失败", "您的删除操作失败了！", "error");
			    					}
							 	});
								
							}
						});
	                } else {
	                    swal("已取消", "您取消了删除操作！", "error");
	                }
	            });
				
				
				
				
				
				
				
			}
		}
		
		//导出到Excel
		function toExcel(){
			$.post("<%=basePath%>elevatorStandard/toExcel.do");
		}

		//选择导入文件
		function inputFile(){
			
			$("#provinceImportFile").click();
			
		}

		//导入Excel
		function importExcel(e){
			
			
			
	    	var filePath = $(e).val();
	    	console.log(filePath);
	    	var suffix = filePath.substring(filePath.lastIndexOf(".")).toLowerCase();
	    	var fileType = ".xls|.xlsx|";
	    	if(filePath == null || filePath == ""){
	            return false;
	        }
	        if(fileType.indexOf(suffix+"|")==-1){
	            var ErrMsg = "该文件类型不允许上传。请上传 "+fileType+" 类型的文件，当前文件类型为"+suffix; 
	            $(e).val("");
	            alert(ErrMsg);
	            return false;
	        }
	        var data = new FormData();
	    	data.append("file", $(e)[0].files[0]);
	    	console.log($(e)[0].files[0]);
	    	$.ajax({
	            url:"<%=basePath%>elevatorStandard/importExcel.do?type="+type,
	            type:"POST",
	            data:data,
	            cache: false,
	            processData:false,
	            contentType:false,
	            success:function(result){
	                if(result){
	                	alert("上传成功");
	                }else{
	                    alert(result.errorMsg);
	                }
	            }
	        });
		}
		 
		/* 下载数据模板
		2017-06-13 Stone
		*/
		function downFile() {
			var url="uploadFiles/file/DataModel/GeneralElevator/电梯标准.xls";
			window.open("customer/DataModel?url=" + url,"_blank");
		}
		
		
		/* back to top */
		function setWindowScrollTop(win, topHeight){
		    if(win.document.documentElement){
		        win.document.documentElement.scrollTop = topHeight;
		    }
		    if(win.document.body){
		        win.document.body.scrollTop = topHeight;
		    }
		}
		</script>
</body>
</html>


