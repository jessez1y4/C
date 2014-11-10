//
//  MessageViewController.swift
//  CircleShop
//
//  Created by Yu Jiang on 11/8/14.
//  Copyright (c) 2014 yue zheng. All rights reserved.
//

import UIKit

class MessageViewController: JSQMessagesViewController {
    var messages: [Message] = []
    var outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    var incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.senderId = User.currentUser().objectId
        self.senderDisplayName = User.currentUser().name
        
        let q = User.query()
        q.getFirstObjectInBackgroundWithBlock { (otherUser, err) -> Void in
            let msg = Message()
            let u = otherUser as User
            msg.sender = User.currentUser()
            msg.receiver = otherUser as User
            msg.content = "this is a message"
            let msg2 = Message()
            msg2.sender = u
            msg2.receiver = User.currentUser()
            msg2.content = "this is a message"
            self.messages = [msg,msg2]
            self.title = u.name
            self.collectionView.reloadData()
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
}

