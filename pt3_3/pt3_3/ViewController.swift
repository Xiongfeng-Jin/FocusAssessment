//
//  ViewController.swift
//  pt3_3
//
//  Created by Jin on 9/4/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let circleImage = UIImage(named: "image")?.circleMask

    @IBOutlet weak var imageView1: UIImageView!{
        didSet{
            imageView1.image = circleImage
        }
    }
    @IBOutlet weak var imageView2: UIImageView!{
        didSet{
            imageView2.image = UIImage(named: "image")
            imageView2.layer.cornerRadius = 5
            imageView2.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imageView3: UIImageView!{
        didSet{
            imageView3.image = circleImage
        }
    }
    
    @IBOutlet weak var imageView4: UIImageView!{
        didSet{
            imageView4.image = circleImage
        }
    }
    
    @IBOutlet weak var imageView5: UIImageView!{
        didSet{
            imageView5.image = circleImage
        }
    }
    
    @IBOutlet weak var imageView6: UIImageView!{
        didSet{
            imageView6.image = UIImage(named: "image")
            imageView6.layer.cornerRadius = 5
            imageView6.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imageView7: UIImageView!{
        didSet{
            imageView7.image = circleImage
        }
    }

    
    @IBOutlet weak var imageView8: UIImageView!
        {
        didSet{
            imageView8.image = circleImage
        }
    }

    
    @IBOutlet weak var imageView9: UIImageView!{
        didSet{
            imageView9.image = circleImage
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIImageView(image: UIImage(named: "head")))
        navigationItem.leftBarButtonItems?.append(UIBarButtonItem(customView: UIImageView(image: UIImage(named: "search"))))
        
        let tempView = UIImageView(image: UIImage(named: "white")?.circleMask)
        let label = UILabel()
        label.text = String(4)
        label.frame = CGRect(x:tempView.bounds.midX-5, y: tempView.bounds.midY-10, width: 10, height: 10)
        label.frame.size = label.intrinsicContentSize
        label.textColor = UIColor.lightGray
        tempView.addSubview(label)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tempView)

        
        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(customView: UIImageView(image: UIImage(named: "chat"))))
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
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
