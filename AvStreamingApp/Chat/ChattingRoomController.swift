//
//  PlayerController.swift
//  AvStreamingApp
//
//  Created by deepvisions on 2023/06/26.
//

import UIKit
import SocketIO
class ChattingRoomController: UITableViewController {
    var chat = [ChatType]()
    var room: String?
    var socket: SocketIOClient!
    
    let messageField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderWidth = 1
    
        return textfield
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height:80)
        
        
        let submitButton = UIButton(type: .system)
        submitButton.setTitle("전송", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(tappedSubmitButton), for: .touchUpInside)
        
        containerView.addSubview(submitButton)
        containerView.addSubview(messageField)
        messageField.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        messageField.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        messageField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 12).isActive = true
        messageField.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor).isActive = true
        messageField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        submitButton.topAnchor.constraint(equalTo: containerView.topAnchor,constant: 12).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: messageField.trailingAnchor,constant: 12).isActive = true
        submitButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    
        submitButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        let lineSeperator = UIView()
        lineSeperator.backgroundColor = .systemGray4
        containerView.addSubview(lineSeperator)
        
//        lineSeperator.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBotton: 0, paddingRight: 0, width: 0, height: 0.5)
    
        return containerView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
            tableView.keyboardDismissMode = .interactive
        
        
        SocketIOManager.shared.manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!,config: [.log(true), .compress])
        
        socket = SocketIOManager.shared.manager.socket(forNamespace: "/")
        
        socket.connect()
        
        
     
    }
    override var inputAccessoryView: UIView? {
        return containerView
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let roomNum = room else { return }
        socket.emit("join_room",roomNum)
        socket.on("receive_message") { arr, ack in
            var dictionary = [String:Any]()
            dictionary["data"] = (arr[0] as? [String:Any])?["data"]
            
            guard let user = (dictionary["data"] as? [String:Any])?["user"],
                  let msg = (dictionary["data"] as? [String:Any])?["msg"],
                  let room = (dictionary["data"] as? [String:Any])?["room"] else { return }
            
            self.chat.append(ChatType(name: user as! String, msg: msg as! String, room: room as! String))
            self.tableView.reloadData()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        socket.emit("disconnection")
        socket.disconnect()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = "1"
        let chatValue = chat[indexPath.row]
        cell.textLabel?.text = "\(chatValue.name): \(chatValue.msg)"
        
        return cell
    }
    
    @objc func tappedSubmitButton(){
        guard let sendMsg = messageField.text,
              let roomNum = room
        else { return }
    
        let socketData = [
            "msg": sendMsg,
            "room": roomNum,
            "user": "tttt"
        ] as [String: Any]
    
        socket.emit("send_message",socketData)
        messageField.text = ""
    }
}
