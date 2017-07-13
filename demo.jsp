<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8">
<title>信息发送页面</title>
</head>
<body>
	<h2>WebSocket</h2>
	<h3>发布新通知</h3>
	<form action="<%= application.getContextPath()%>/manage/messagesend" method="post">
	<p>请输入：<input type="text" name="message"></p>
	<p><input type="submit" value="发送">${tip} </p>
	</form>
	<h3>收到的消息</h3>
	<ul class="msg"></ul>
	<script type="text/javascript" src="<%= application.getContextPath()%>/js/jquery-1.12.4.js"></script>
	<script type="text/javascript">
		$(function(){
			/* 创建与服务器的连接，并让服务器保持会话 */
			var ws = new WebSocket("ws://192.168.10.204:8080/<%=application.getContextPath() %>/websocket/handler");
			
			ws.onopen = function(event) {			
				putDebug("websocket open ocurr");
			}
			
			ws.onmessage = function(event) {
				putDebug("websocket message ocurr data: " + event.data);
			}

			ws.onclose = function(event) {			
				putDebug("websocket close ocurr");
			}
			
			ws.onerror = function(event){
				putDebug("websocket error ocurr");
			}
			
			window.onbeforeunload = function() {
				ws.close(); //关闭websocket连接
			}
			
		})	
		
		function putDebug(msg) {
			$(".msg").append("<li>" + msg + "</li>");
		}
	</script>
</body>
</html>
