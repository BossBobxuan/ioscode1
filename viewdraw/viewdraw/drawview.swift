//
//  drawview.swift
//  viewdraw
//
//  Created by bossxuan on 16/9/16.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import UIKit
protocol passdatadelegate : class {
    func passdata() -> Double
}
@IBDesignable
class drawview: UIView {
   /* var circlecenter: CGPoint {
     return convertPoint(center, fromView: superview)
    }
    var scale:CGFloat = 0.9 {didSet{setNeedsDisplay()}}
    var circleradius :CGFloat {
     return min(bounds.width,bounds.height) / 2 * scale
    }
    var lineWidth : CGFloat = 3 {didSet{ setNeedsDisplay()}}
    var UIcolor : UIColor = UIColor.blueColor() {didSet{ setNeedsDisplay()}}
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(arcCenter: circlecenter ,radius: circleradius ,startAngle: 0 , endAngle: CGFloat(2*M_PI)  ,clockwise :true)
        path.lineWidth = lineWidth
        UIcolor.setStroke()
        path.stroke()
        
         
    }*/
    @IBInspectable
    
    var scale: CGFloat = 0.90{didSet {self.setNeedsDisplay()}}
    @IBInspectable
    var mouthCurvature: Double = 1.0 // 1 full smile, -1 full frown
     weak var  delegate : passdatadelegate?
    private var skullRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left
        case Right
    }
    
    private func pathForCircleCenteredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat) -> UIBezierPath
    {
        let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*M_PI),
            clockwise: false
        )
        path.lineWidth = 5.0
        return path
    }
    func scale(gesture : UIPinchGestureRecognizer)  {
        if gesture.state == .Changed
        {
            scale *= gesture.scale
            gesture.scale = 1
        }
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint
    {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath
    {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        return pathForCircleCenteredAtPoint(eyeCenter, withRadius: eyeRadius)
    }
    
    private func pathForMouth() -> UIBezierPath
    {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        mouthCurvature = delegate?.passdata() ?? 1.0
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        
        return path
    }
    
    override func drawRect(rect: CGRect)
    {
        UIColor.blueColor().set()
        pathForCircleCenteredAtPoint(skullCenter, withRadius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
    }

 

}
