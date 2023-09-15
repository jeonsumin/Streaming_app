//
//  SocketIOManager.swift
//  AvStreamingApp
//
//  Created by terry on 2023/06/23.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    var room: String?
    
    override init() {
        super.init()
//        guard let room = room else { return }
        socket = self.manager.socket(forNamespace: "/chat")
        print("@@@ 소켓 초기화 완료 @@@")
    }
    
    /// 소켓 연결 시도
    func establishConnection() {
        socket.connect()
        print("@@@ 소켓 연결 시도 @@@")
    }
    
    /// 소켓 연결 종료
    func closeConnection() {
        socket.disconnect()
        print("@@@ 소켓 연결 종료 @@@ ")
    }
    
    /// 바접속
    func connectToRoomWithName(name: String, room: String){
//        guard let room = room else { return }
        socket = self.manager.socket(forNamespace: room)
        socket.connect()
    }
    
    ///메시지 전송
    func sendMessage(_ name: String, message:String ){
        
    }
    
    /// 체팅 내용 업데이트

}
