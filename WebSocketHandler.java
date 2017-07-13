package com.wuchanglin.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/websocket/handler")
public class WebSocketHandler {
	
	private static List<Session> allSession = Collections.synchronizedList(new ArrayList<Session>());
	
	public static void sendDataToAllSession(String data){
		System.err.println(data);
		for (Session session : allSession) {
			session.getAsyncRemote().sendText(data);
		}
	}
	
	@OnOpen
	public void onOpen(Session session){
		System.out.println("\n==== WebSocketHandler onOpen, session id: " + session.getId());
		allSession.add(session);
	}
	
	@OnClose
	public void onClsoe(Session session){
		System.out.println("\n==== WebSocketHandler onClose, session id: " + session.getId());
		allSession.remove(session);
	}
	@OnError
	public void onError(Throwable throwable){
		System.out.println("\n==== WebSocketHandler onError, throwable: " + throwable);
	}
	@OnMessage
	public void onMessage(String message){
		System.out.println("\n==== WebSocketHandler onMessage, message: " + message); 
	
	}
	
}
