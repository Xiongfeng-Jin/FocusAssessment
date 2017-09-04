//
//  CustomTableViewCell.swift
//  pt3
//
//  Created by Jin on 9/3/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {


    @IBOutlet weak var iconImage: IconView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var indicationButton: UIButton!{
        didSet{
            indicationButton.setTitle("2", for: .normal)
            indicationButton.setTitleColor(UIColor.white, for: .normal)
            indicationButton.setBackgroundImage(UIImage(named:"blue")?.circleMask, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
