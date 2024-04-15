//
//  chatScrrenViewController.swift
//  geeve
//
//  Created by Dev Navadiya on 09/04/24.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import CryptoKit
class chatScrrenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var tabelview: UITableView!
    @IBOutlet weak var chatTextFIled: UITextField!
    @IBOutlet weak var chatSenderButton: UIButton!
    var nameofuser : String?
    let database = Database.database().reference()
    var reciver : String!
   var senderid : String!
    var massage : [Chat] = []
    
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


        let message = massage[indexPath.row]
         if message.senderID == senderid {
             let cell = tableView.dequeueReusableCell(withIdentifier: "SenderTableViewCell") as! SenderTableViewCell
            
             cell.configure(with: message)
             return cell
         } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "reciverTableViewCell") as! reciverTableViewCell
             cell.configure(with: message)
             return cell
         }
    }
    
  
  
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            moveToLastComment()
        }
    
    @IBAction func send_btn(_ sender: Any) {
        guard let senderID = senderid,
              let receiverID = reciver,
             
                     let message = chatTextFIled.text else {
            print("usernot found")
           
            return
            
        }
        self.tabelview.reloadData()
//        self.massage.removeAll()
        sendMesssage(senderID: senderID, receiverID: receiverID, message: message)

        self.chatTextFIled.text = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.50) {
            self.moveToLastComment()
        }
    }
    
    @IBAction func back_btn(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    func fetchMessages() {
        self.massage.removeAll()
        guard let senderID = senderid,
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

                
                self.massage.append(message)
  
            DispatchQueue.main.async {
                self.tabelview.reloadData()
            }
        }
    }

    func moveToLastComment() {
        if self.tabelview.contentSize.height > self.tabelview.frame.height {
            // First figure out how many sections there are
            let lastSectionIndex = self.tabelview!.numberOfSections - 1
            
            // Then grab the number of rows in the last section
            let lastRowIndex = self.tabelview!.numberOfRows(inSection: lastSectionIndex) - 1
            
            // Now just construct the index path
            let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
            
            // Make the last row visible
            self.tabelview?.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: true)
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
    func genratChatRoomId(senderID: String, receiverID: String) -> String {
        let sanitizedSenderID = senderID.replacingOccurrences(of: "[.#$\\[\\]]", with: "_", options: .regularExpression)
        let sanitizedReceiverID = receiverID.replacingOccurrences(of: "[.#$\\[\\]]", with: "_", options: .regularExpression)
        
        // Ensure that the chat room ID is consistently generated based on alphabetical order
        let sortedIDs = [sanitizedSenderID, sanitizedReceiverID].sorted()
        let chatRoomID = sortedIDs.joined(separator: "_")
        print(chatRoomID)
        return chatRoomID
    }
 
}


