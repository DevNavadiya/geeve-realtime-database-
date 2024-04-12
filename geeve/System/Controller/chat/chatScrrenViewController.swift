//
//  chatScrrenViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class chatScrrenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var chatTextFIled: UITextField!
    @IBOutlet weak var chatSenderButton: UIButton!
    var nameofuser : String?
    let database = Database.database().reference()
    var reciver : String?
    var massage : [Chat] = []
    var reciveMassege : [Chat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.text = nameofuser ?? "void"
        self.tabelview.delegate = self
        self.tabelview.dataSource = self
        fetchMessages()
        let senderNib = UINib(nibName: "SenderTableViewCell", bundle: nil)
            tabelview.register(senderNib, forCellReuseIdentifier: "SenderTableViewCell")
        let receiverNib = UINib(nibName: "reciverTableViewCell", bundle: nil)
           tabelview.register(receiverNib, forCellReuseIdentifier: "reciverTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message: Chat
          if indexPath.section == 0 {
              // Sent messages section
              message = massage[indexPath.row]
          } else {
              // Received messages section
              message = reciveMassege[indexPath.row]
          }

        if message.senderID == Auth.auth().currentUser?.uid {
            let cell = tabelview.dequeueReusableCell(withIdentifier: "SenderTableViewCell") as! SenderTableViewCell
            cell.configure(with: message)
            return cell

        }else{
            let cell = tabelview.dequeueReusableCell(withIdentifier: "reciverTableViewCell") as! reciverTableViewCell
            cell.configure(with: message)
            return cell

        }
        
        
    }
    
  
 
    @IBAction func send_btn(_ sender: Any) {
        guard let senderID = Auth.auth().currentUser?.uid,
              let receiverID = reciver,
                     let message = chatTextFIled.text else {
            print("usernot found")
                   return
           
        }
                
        sendMesssage(senderID: senderID, receiverID: receiverID, message: message)
        self.chatTextFIled.text = ""
    }
    
    @IBAction func back_btn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    func fetchMessages() {
        guard let senderID = Auth.auth().currentUser?.uid,
              let receiverID = reciver else {
            return
        }

        let chatRoomID = genratChatRoomId(senderID: senderID, receiverID: receiverID)
        let messagesRef = database.child("Chat").child(chatRoomID)

        messagesRef.observe(.childAdded) { (snapshot : DataSnapshot) in
            guard let messageData = snapshot.value as? [String: Any],
                  let senderID = messageData["senderID"] as? String,
                  let receiverID = messageData["receiverID"] as? String,
                  let messageText = messageData["message"] as? String,
                  let timestampInterval = messageData["timestamp"] as? TimeInterval else {
                return
            }

            // Convert TimeInterval to Date
            let timestamp = Date(timeIntervalSince1970: timestampInterval)
            
            // Assuming Chat has an initializer like init(senderID:receiverID:message:timestamp:)
            let message = Chat(senderID: senderID, receiverID: receiverID, message: messageText, timestamp: timestamp)
            
            if  senderID  == senderID {
                
                self.massage.append(message)
                print(message)
            }else {
                self.reciveMassege.append(message)
                }
                self.tabelview.reloadData()
            
        }
    }

    
    func sendMesssage  (senderID : String , receiverID : String , message : String) {
        let chatroomId = genratChatRoomId(senderID: senderID, receiverID: receiverID)
        let massegref = database.child("Chat").child(chatroomId).childByAutoId()
        let massegdata : [String : Any] = [
            "senderID": senderID,
            "receiverID": receiverID,
            "message": message,
            "timestamp": ServerValue.timestamp()
        ]
        massegref.setValue(massegdata) { error, _ in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
            } else {
                print("Message sent successfully")
            }
        }
    }
    func genratChatRoomId (senderID : String , receiverID : String) -> String {
        let sanitizedSenderID = senderID.replacingOccurrences(of: "[.#$\\[\\]]", with: "_", options: .regularExpression)
           let sanitizedReceiverID = receiverID.replacingOccurrences(of: "[.#$\\[\\]]", with: "_", options: .regularExpression)
           return sanitizedSenderID < sanitizedReceiverID ? "\(sanitizedSenderID)_\(sanitizedReceiverID)" : "\(sanitizedReceiverID)_\(sanitizedSenderID)"
    }
//    func fetchMessages() {
//            // Replace "chatRoomID" with the actual chat room ID
//            let chatRoomID = "your_chat_room_id"
//            let messagesRef = Database.database().reference().child("Chat").child(chatRoomID)
//            
//        messagesRef.observe(.childAdded) { snapshot in
//                if let messageData = snapshot.value as? [String: Any] {
//                    // Assuming you have a Message model
//                    if let message = Chat(snapshot: messageData) {
//                        self.messages.append(message)
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
}
