//
//  MessageViewController.swift
//  CircleShop
//
//  Created by Yu Jiang on 11/8/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class MessageViewController: JSQMessagesViewController {
    var conversation: Conversation!
    var messages: [Message] = []
    var outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    var incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.collectionViewLayout.springinessEnabled = true
        self.senderId = User.currentUser().objectId
        self.senderDisplayName = User.currentUser().name
        
        self.conversation.getMessages { (messages, error) -> Void in
            if error == nil {
                self.messages = messages
                self.collectionView.reloadData()
            }
        }
        
        self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
        self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = self.messages[indexPath.item]
        
        if message.senderId() == self.senderId {
            return self.outgoingBubble;
        }
        
        return self.incomingBubble;
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let msg = Message()
        
        msg.conversation = self.conversation
        msg.sender = User.currentUser()
        msg.receiver = self.conversation.getOtherUser()
        msg.content = text
        
        msg.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.messages.append(msg)
                self.finishSendingMessage()
            }
        }
    }
}

