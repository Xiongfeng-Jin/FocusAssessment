//
//  IconView.swift
//  pt3
//
//  Created by Jin on 9/3/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit
@IBDesignable
class IconView: UIView {
    @IBInspectable
    var image:UIImage?{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var color:UIColor = UIColor.green{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var lineWidth:CGFloat = 1.0{
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable
    var relativity:CGFloat = 7
    @IBInspectable
    var topRightCircleRadius:CGFloat = 5
    
    private var topRightCorner:CGPoint{
        let top = bounds.size.height / relativity
        let right = bounds.maxX - bounds.maxX / relativity
        return CGPoint(x: right, y: top)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        color.set()
        if image != nil {
            image?.draw(in: bounds)
        }
        pathForCircleCenteredAtPoint(midPoint: topRightCorner, withRadius: topRightCircleRadius).fill()
        UIColor.white.set()
        pathForCircleCenteredAtPoint(midPoint: topRightCorner, withRadius: topRightCircleRadius+1).stroke()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentMode = .redraw
        frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 70, height: 70))
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint, withRadius radius:CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }

}
