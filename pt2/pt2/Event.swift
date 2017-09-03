//
//  Event.swift
//  pt2
//
//  Created by Jin on 9/2/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

protocol EventDataDelegate {
    func eventAdded(event:Event)
    func eventChanged(event:Event)
    //func eventRemoved(event:Event)
}

class Event {
    var name:String?{
        didSet{
            if name != nil, !key.isEmpty{
                Event.ref?.child("Events").child(key).child("name").setValue(name!)
            }
        }
    }
    var image:UIImage?{
        didSet{
            if image != nil, !key.isEmpty, imageURL == nil {
                let data = UIImageJPEGRepresentation(image!, 1)
                Event.storageRef?.child("Events").child(key).child("image.jpg").putData(data!, metadata: nil, completion: { (metaData, error) in
                    if metaData != nil {
                        self.imageURL = metaData?.downloadURL()
                    }
                })
            }
        }
    }
    var price:Double?{
        didSet{
            if price != nil, !key.isEmpty {
                Event.ref?.child("Events").child(key).child("price").setValue(price!)
            }
        }
    }
    var address:String?{
        didSet{
            if address != nil, !key.isEmpty {
                Event.ref?.child("Events").child(key).child("address").setValue(address!)
            }
        }
    }
    var date:Date?{
        didSet{
            if date != nil, !key.isEmpty {
                Event.ref?.child("Events").child(key).child("date").setValue(dateToString())
            }
        }
    }
    
    private var imageURL:URL?{
        didSet{
            if imageURL != nil{
                if key.isEmpty{
                    DispatchQueue.global().async { [weak weakSelf = self] in
                        if let data = try? Data(contentsOf:(weakSelf?.imageURL!)!){
                            DispatchQueue.main.async { [weak weakSelf = self] in
                                weakSelf?.image = UIImage(data: data)
                                weakSelf?.imageURL = nil
                                Event.delegate?.eventChanged(event: self)
                            }
                        }
                    }
                }
                else {
                    Event.ref?.child("Events").child(key).child("imageURL").setValue(String(describing: imageURL!))
                    imageURL = nil
                }
            }
        }
    }
    
    lazy private var key:String = {
        return Event.ref?.child("Events").childByAutoId().key
    }()!
    
    func isValidEvent() -> Bool{
        return !key.isEmpty
    }
    
    func removeFromDataBase(){
        Event.ref?.child("Events").child(key).removeValue()
        Event.storageRef?.child("Events").child(key).child("image.jpg").delete(completion: { (error) in
            if error != nil{
                print(error!)
            }
        })
    }
    
    func dateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: date!)
    }
    
    private func stringToDate(string:String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.local
        return formatter.date(from: string)!
    }
    
    static func ==(lhs: Event, rhs: Event) -> Bool {
        return lhs.key == rhs.key
    }
    
    static var delegate:EventDataDelegate?{
        didSet{
            ref?.child("Events").observe(.childAdded, with: { (snapshot) in
                delegate?.eventAdded(event:createEvent(from: snapshot))
            })
            /*ref?.child("Events").observe(.childChanged, with: { (snapshot) in
                delegate?.eventChanged(event: createEvent(from: snapshot))
            })
            ref?.child("Events").observe(.childRemoved, with: { (snapshot) in
                delegate?.eventRemoved(event: createEvent(from: snapshot))
            })*/
        }
    }
    
    private static var ref:DatabaseReference? = {
        return Database.database().reference()
    }()
    
    private static var storageRef:StorageReference? = {
        return Storage.storage().reference()
    }()
    
    private static func createEvent(from snapshot:DataSnapshot) -> Event{
        let e = Event()
        e.key = ""
        if let dict = snapshot.value as? [String: AnyObject]{
            e.name = dict["name"] as? String
            e.address = dict["address"] as? String
            e.price = dict["price"] as? Double
            if let urlString = dict["imageURL"] as? String{
                e.imageURL = URL(string: urlString)
            }
            if let dateString = dict["date"] as? String{
                e.date = e.stringToDate(string: dateString)
            }
            e.key = snapshot.key
            //print(snapshot)
        }
        return e
    }
    
    
}
