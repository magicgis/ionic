<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><sitemesh:title default="花生金服 hsbank360.com-更优质、更安全、更便捷、更有诚意的互联网金融P2P平台"/></title>
		<meta name="keywords" content="花生金服|网络理财|个人理财|投资理财|P2P理财|互联网金融|债权转让|理财计划|贷款|房产贷款|汽车贷款|个人贷款|无抵押贷款|个人无抵押贷款">
		<meta name="description" content="花生金服(www.hsbank360.com) - 更优质、更安全、更便捷、更有诚意的互联网金融平台。花生金服有严格的风险控制,对接优选项目,第三方资金托管,保障资金安全。">
		<%@include file="/WEB-INF/views/include/head_for_front.jsp" %>
		<link href="${ctxStatic}/modules/front/css/util/util.css?${version }" rel="stylesheet"/>
		<link href="${ctxStatic}/modules/front/css/layouts/my_account.css?${version }" rel="stylesheet"/>
		<script>
			var sign = function() {
				$.getJSON("${ctxFront}/customer/integral/sign", function(data) {
					if(data.success) {
						var coin=new Coin();
						sign = function(){};
						$("#sign").html("+" + data.signCoins);
						$.jBox.tip('签到成功', 'success');
						window.setTimeout(function() {
							$("#sign").html("已签到");
							$("#sign").removeClass("sign").addClass("signed");
						}, 2000);
					}else {
						$.jBox.error("签到失败：" + data.message,"提示");
					}
				});
			}
			var SHAKE_THRESHOLD = 400;
			var last_update = 0;
			var index=0;
			var x = y = z = last_x = last_y = last_z = 0;
			var w_curTime=0;
			function init() {
				if (window.DeviceMotionEvent) {
					window.addEventListener('devicemotion', deviceMotionHandler, false);
				} else {
					//$.jBox.alert('not support mobile event');
				}
			}
			function deviceMotionHandler(eventData) {
				var acceleration = eventData.accelerationIncludingGravity;
				var curTime = new Date().getTime();
				if ((curTime - last_update) > 100) {
					var diffTime = curTime - last_update;
					last_update = curTime;
					x = acceleration.x;
					y = acceleration.y;
					z = acceleration.z;
					var speed = Math.abs(x + y + z - last_x - last_y - last_z) / diffTime * 10000;
					var delta=Math.abs(x + y + z - last_x - last_y - last_z);
					if (speed > SHAKE_THRESHOLD) {
						if((curTime-w_curTime)>2000){
							w_curTime!=0 && new Coin({density:Math.round(delta)});
							w_curTime=curTime;
						}
					}
					last_x = x;
					last_y = y;
					last_z = z;
				}
			}
			$(function(){
				init();
			});
		</script>
		<sitemesh:head/>
	</head>
	<body>
		<c:if test="${need_third_account_tip && not empty p2p:getPrincipal() && p2p:getCustomerAccount().hasOpenThirdAccount != '1'}">
			<div id="third_account_tip">
				<div class="div_width_980 text-center">
					<img src="${ctxStatic}/modules/front/images/util/!.png">
					<span>&nbsp;&nbsp;&nbsp;您需要先开通第三方托管账户，才能开启您的【花生金服】安全投资之旅&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
					<a class="btn" target="_blank" href="${ctxFront }/customer/thirdAccount/open">立即开通</a>
				</div>
			</div>
		</c:if>
		<div class="div_bg_001" style="overflow:hidden; margin:0 auto;">
			<div id="div_header_top" class="div_width_1080">
				<div class="div_left"><img id="logo" class="logo" src="${ctxStatic}/modules/front/images/util/logo.png"/></div>
                <div class="div_right">
                    <ul class="top_menu">
                        <li class="client">
                        	<!--<div class="popup width272" style=" width:272px; margin-left:-136px">-->
                        	<div class="popup width272" style=" width:144px; margin-left:-72px">
                            	<div class="popup_arrow"></div>
                                <div class="popup_content">
                                	<p><img src="${ctxStatic}/modules/front/images/util/img_app_tdc.png"><span>扫一扫下载<br>花生金服客户端</span></p>
                            	</div>
                            </div>
                        	<i class="icon_phone"></i>
                            <a href="${ctxFront }/downloadApp">手机客户端</a>
                        </li>
                        
                        
                        <li class="line"></li>
                        <li class="follow">关注：</li>
                        <li class="follow ml0">
                          <div class="popup" style=" width:144px; left:50%; margin-left:-72px">
                              <div class="popup_arrow"></div>
                              <div class="popup_content">
                                  <p><img src="${ctxStatic}/modules/front/images/util/img_tdc.png"><span>扫一扫关注<br>花生金服微信</span></p>
                            </div>
                            </div>
                        	<a href="javascript:;" class="icon_wechat"></a>
                        </li>
                        
                        <li class="follow">
                        	<div class="popup" style=" width:144px; left:50%; margin-left:-72px">
                            	<div class="popup_arrow"></div>
                                <div class="popup_content">
                                    <p>点击关注花生金服微博<a href="http://weibo.com/hsbank360" target="_blank" class="btn_text_gold"><br>@花生金服</a></p>
                              </div>
                            </div>
                        	<a href="http://weibo.com/hsbank360" target="_blank" class="icon_weibo"></a>
                        </li>
                        <li class="line"></li>
                        <li class="help"><a href="${ctxFront}/xszy">新手指引</a></li>
                        <li class="line"></li>
                        <li class="help"><i class="icon_hot"></i><a href="${ctxFront}/help/wytz_xsbd">帮助中心</a></li>
                        <li class="line"></li>
	              		<li class="help"><i class="icon_new"></i><a href="${ctxFront}/integralMall/index">花生乐园</a></li>
						<li class="line"></li>
                        <c:choose>
						<c:when test="${not empty p2p:getPrincipal()}">
							<li class="logged" ><a
								href="${ctxFront}/customer/summary" class="btn_text_black mr10 username"> 
								   <c:choose>
										<c:when
											test="${empty p2p:getCustomerAccount().nickname }">
						       				${p2p:abbrev(p2p:getCustomerAccount().accountName,8) }
						       			</c:when>
										<c:otherwise>
						       				${p2p:abbrev(p2p:getCustomerAccount().nickname,8) }
						       			</c:otherwise>
									</c:choose>
							</a> <a href="javascript:;" class="btn_text_black mr10" style="display: none;">消息<span class="info_tip">9</span></a>
							<c:choose>
								<c:when test="${p2p:customerCanSign() }">
							<a href="javascript:void(0);" id="sign" onclick="sign()" class="sign mr10">签到</a>
								</c:when>
								<c:otherwise>
                            <a id="sign" href="javascript:;" class="signed mr10">已签到</a>
								</c:otherwise>
							</c:choose>
							<a href="${ctxFront}/logout" class="btn_text_black logout">退出</a></li>
						</c:when>
						<c:otherwise>
							<li class="login_register" style="display: inline-block"><a
								href="${ctxFront}/login" class="btn_text_gold mr10">立即登录</a><a
								href="${ctxFront}/register" class="btn_text_gold">马上注册</a></li>
						</c:otherwise>
					</c:choose>
                    </ul>
                    <div class="service_hotline">服务热线：400-969-6599 (工作日9:00~18:00)</div>
                </div>
			</div>
			<!-- 主菜单 -->
			<div id="div_main_menu" class="div_width_1080">
				<ul id="menu_bar">
					<li class="${menu == 'wytz'? 'selected wytz_selected' : 'wytz'}"><a href="${ctxFront}/wytz"></a></li>
					<li class="${menu == 'wyrz'? 'selected wyrz_selected' : 'wyrz'}"><a href="${ctxFront}/willloan/willloan"></a></li>
					<li class="${menu == 'zxhd'? 'selected zxhd_selected' : 'zxhd'}"><a href="${ctxFront}/zxhd"></a></li>
					<!-- <li class="${menu == 'xszy'? 'selected xszy_selected' : 'xszy'}"><a href="${ctxFront}/xszq"></a></li> -->
					<li class="${menu == 'gywm'? 'selected gywm_selected' : 'gywm'}"><a href="${ctxFront}/gywm/index"></a></li>
					<li class="${menu == 'wdzh'? 'selected wdzh_selected' : 'wdzh'}"><a href="${ctxFront}/customer/summary"></a></li>
                </ul>
                <div class="clearfix"></div>
			</div>
			<div id="juanzhou">
				<div class="juanzhou_top"></div>
				<div class="juanzhou_middle">
					<div class="nav_row">
						<div class="left">${nav}</div>
						<div class="right">上次登录：<fmt:formatDate value="${customerAccount.lastLoginDt }" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;&nbsp;</div>
					</div>
					<div id="content">
						<div class="left">
							<div class="top"></div>
							<div class="${one_menu == 'zhzl'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/customer/summary">
									<span class="zhzl"></span>
									<span class="span_text">账户总览</span>
								</a>
							</div>
							<div id="one_menu_zjgl" class="${one_menu == 'zjgl'? 'one_menu_selected' : 'one_menu'}">
								<span class="zjgl"></span>
								<span class="span_text">资金管理</span>
							</div>
							<div id="one_menu_sub_list_zjgl" class="two_menu_list ${one_menu == 'zjgl'? 'show' : 'hide'}">
								<div class="${(one_menu == 'zjgl' && two_menu == 'jyjl')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/capital/record">&nbsp;&nbsp;&nbsp;交易记录</a>
								</div>
								<div class="${(one_menu == 'zjgl' && two_menu == 'cz')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/capital/recharge">&nbsp;&nbsp;&nbsp;充值&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
								</div>
								<div class="${(one_menu == 'zjgl' && two_menu == 'tx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/capital/withdraw">&nbsp;&nbsp;&nbsp;提现&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
								</div>
							</div>
							<div id="one_menu_tzgl" class="${one_menu == 'tzgl'? 'one_menu_selected' : 'one_menu'}">
								<span class="tzgl"></span>
								<span class="span_text">投资管理</span>
							</div>
							<div id="one_menu_sub_list_tzgl" class="two_menu_list ${one_menu == 'tzgl'? 'show' : 'hide'}">
								<div class="${(one_menu == 'tzgl' && two_menu == 'tztj')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/investment/tongji">&nbsp;&nbsp;&nbsp;投资统计</a>
								</div>
								<div class="${(one_menu == 'tzgl' && two_menu == 'wdhhs')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/currentAccount/myCurrentPeanut">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我的活花生</a>
								</div>
								<div class="${(one_menu == 'tzgl' && two_menu == 'tzxm')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/investment/project_cyz">&nbsp;&nbsp;&nbsp;我的债权</a>
								</div>
								<div class="${(one_menu == 'tzgl' && two_menu == 'skmx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/investment/detailUnReceiveMoney">&nbsp;&nbsp;&nbsp;收款明细</a>
								</div>
					
							</div>
							<div id="one_menu_rzgl" class="${one_menu == 'rzgl'? 'one_menu_selected' : 'one_menu'}">
								<span class="rzgl"></span>
								<span class="span_text">融资管理</span>
							</div>
							<div id="one_menu_sub_list_rzgl" class="two_menu_list ${one_menu == 'rzgl'? 'show' : 'hide'}">
								<div class="${(one_menu == 'rzgl' && two_menu == 'jktj')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/loan/tongji">&nbsp;&nbsp;&nbsp;融资统计</a>
								</div>
								<div class="${(one_menu == 'rzgl' && two_menu == 'wdjk')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/loan/myFundingProject">&nbsp;&nbsp;&nbsp;我的融资</a>
								</div>
								<div class="${(one_menu == 'rzgl' && two_menu == 'jksqcx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/loan/applyForQuery">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;融资申请查询</a>
								</div>
							</div>
							<div id="one_menu_zhgl" class="${one_menu == 'zhgl'? 'one_menu_selected' : 'one_menu'}">
								<span class="zhgl"></span>
								<span class="span_text">账户管理</span>
							</div>
							<div id="one_menu_sub_list_zhgl" class="two_menu_list ${one_menu == 'zhgl'? 'show' : 'hide'}">
								<div class="${(one_menu == 'zhgl' && two_menu == 'grjcxx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/account/baseInfo">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;个人基础信息</a>
								</div>
								<div class="${(one_menu == 'zhgl' && two_menu == 'xgmm')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/account/safeCenter">&nbsp;&nbsp;&nbsp;安全中心</a>
								</div>
								<div class="${(one_menu == 'zhgl' && two_menu == 'ghtx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/account/change_avatar">&nbsp;&nbsp;&nbsp;更换头像</a>
								</div>
								<div class="${(one_menu == 'zhgl' && two_menu == 'rzxx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/account/authInfo">&nbsp;&nbsp;&nbsp;认证信息</a>
								</div>
								<div class="${(one_menu == 'zhgl' && two_menu == 'yhkgl')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/account/bankCard">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;银行卡管理</a>
								</div>
							</div>
							<div class="${one_menu == 'wdxx'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/customer/message/myMessage">
									<span class="wdxx"></span>
									<span class="span_text">我的消息</span>
								</a>
							</div>
							<div class="${one_menu == 'wdyhj'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/customer/ticket/my">
									<span class="wdyhj"></span>
									<span class="span_text">我的现金券</span>
								</a>
							</div>
							<div class="${one_menu == 'wdtxe'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/customer/withdrawTicket">
									<span class="wdyhj"></span>
									<span class="span_text">我的提现券</span>
								</a>
							</div>
							<div id="one_menu_wdjf"  class="${one_menu == 'wdjf'? 'one_menu_selected' : 'one_menu'}">
								<span class="wdjf"></span>
								<span class="span_text">我的花生豆</span>
							</div>
							<div id="one_menu_sub_list_wdjf" class="two_menu_list ${one_menu == 'wdjf'? 'show' : 'hide'}">
								<div class="${(one_menu == 'wdjf' && two_menu == 'jfgk')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/integral/summary">&nbsp;&nbsp;&nbsp;花生豆概况</a>
								</div>
								<div class="${(one_menu == 'wdjf' && two_menu == 'szmx')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/integral/detail">&nbsp;&nbsp;&nbsp;收支明细</a>
								</div>
								<!-- <div class="${(one_menu == 'wdjf' && two_menu == 'syjf')? 'two_menu_selected' : 'two_menu'}">
									<a href="${ctxFront}/customer/integral/use">&nbsp;&nbsp;&nbsp;花生乐园</a>
								</div> -->
							</div>
							<div class="${one_menu == 'yqhy'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/customer/inviteFriends/myFriends">
									<span class="yqhy"></span>
									<span class="span_text">邀请好友</span>
								</a>
							</div>
							<!-- <div class="${one_menu == 'wdxx'? 'one_menu_selected' : 'one_menu'}">
								<a href="${ctxFront}/wdzh/wdxx">
									<span class="wdxx"></span>
									<span class="span_text">我的消息</span>
								</a>
							</div> -->
							<div class="bottom"></div>
						</div>
						<div class="right">
							<sitemesh:body/>
						</div>
					</div>
				</div>
				<div class="juanzhou_bottom"></div>
			</div>
		</div>
		<%@include file="/WEB-INF/views/modules/front/layouts/util/footer.jsp" %>
		<script type="text/javascript">
    		$(document).ready(function() {
    			$(document).on('click', '#one_menu_zjgl', function() {
					$('#one_menu_sub_list_zjgl').toggle();
				});
				
				$(document).on('click', '#one_menu_tzgl', function() {
					$('#one_menu_sub_list_tzgl').toggle();
				});
				
				$(document).on('click', '#one_menu_rzgl', function() {
					$('#one_menu_sub_list_rzgl').toggle();
				});
				
				$(document).on('click', '#one_menu_zhgl', function() {
					$('#one_menu_sub_list_zhgl').toggle();
				});
				
				$(document).on('click', '#one_menu_wdjf', function() {
					$('#one_menu_sub_list_wdjf').toggle();
				});
			});
		</script>
	</body>
</html>