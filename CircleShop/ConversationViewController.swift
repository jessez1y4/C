import UIKit

class ConversationViewController: UITableViewController {
    
    var conversations: [Conversation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        User.currentUser().getConversations { (conversations, error) -> Void in
            if error == nil {
                self.conversations = conversations
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conversations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ConversationCell") as ConversationCell
        cell.textLabel.text = self.conversations[indexPath.row].getOtherUser().name
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let conv = self.conversations[indexPath.row]
        
        self.performSegueWithIdentifier("show_messages", sender: conv)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show_messages" {
            let mvc = segue.destinationViewController as MessageViewController
            mvc.conversation = sender as Conversation
        }
    }
    
    @IBAction func menuClicked(sender: AnyObject) {
        self.slidingViewController().anchorTopViewToRightAnimated(true)
    }
}
