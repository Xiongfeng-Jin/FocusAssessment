//
//  ViewController.swift
//  asd
//
//  Created by Jin on 9/3/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit
import NMessenger

class ViewController: NMessengerViewController,BubbleConfigurationProtocol {

    let messageTimestamp = MessageSentIndicator()

    private func timeSent() -> GeneralMessengerCell{
        let time = Date(timeIntervalSinceNow: 0)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeIndicator = MessageSentIndicator()
        timeIndicator.messageSentText = formatter.string(from: time)
        return timeIndicator
    }
    
    var repeatTimes = 5
    var timer:Timer?
    
    var isMasked: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messengerView.messengerNode.view.backgroundColor = UIColor(red: 0, green: 28.0/255, blue: 84.0/255, alpha: 1)
        sharedBubbleConfiguration = self
        messagePadding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        var baritem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "image")?.circleMask))
        navigationItem.rightBarButtonItems?.append(baritem)
        baritem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "arrow")))
        navigationItem.leftBarButtonItem = baritem
        
        
        
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak weakSelf = self] (timer) in
            weakSelf?.sendText("hello world", isIncomingMessage: true)
            weakSelf?.addMessageToMessenger(self.timeSent())
            weakSelf?.sendText("hello world", isIncomingMessage: false)
            if(weakSelf?.repeatTimes == 0){
                weakSelf?.timer?.invalidate()
            }
            weakSelf?.repeatTimes = (weakSelf?.repeatTimes)! - 1
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getIncomingColor() -> UIColor {
        return UIColor(red: 68.0/255, green: 193.0/255, blue: 195.0/255, alpha: 1)
    }
    
    func getOutgoingColor() -> UIColor {
        return UIColor(red: 192.0/255, green: 193.0/255, blue: 196.0/255, alpha: 1)
    }
    
    func getBubble() -> Bubble {
        return SimpleBubble()
    }
    
    func getSecondaryBubble() -> Bubble {
        return SimpleBubble()
    }

}


//from https://stackoverflow.com/questions/30044431/how-to-add-custom-imageview-in-tableview-cell-in-swift
extension UIImage {
    var circleMask: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}
