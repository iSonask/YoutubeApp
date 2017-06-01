//
//  View + Helper.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit

struct UIViewBorderAttributeKey {
    static let marginTop = "marginTop"
    static let marginLeft = "marginLeft"
    static let marginRight = "marginRight"
    static let marginBottom = "marginBottom"
}
extension UIImage{
    
    public func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else {
            return self
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        guard let mask = self.cgImage else {
            return self
        }
        context.clip(to: rect, mask: mask)
        context.fill(rect)
        
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIView {
    public func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    public func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterSuperview() {
        anchorCenterXToSuperview()
        anchorCenterYToSuperview()
        backgroundColor = .clear
    }
    
    
    
    
    
    
    fileprivate var topBorderTag: Int{ return 8001 }
    
    fileprivate var leftBorderTag: Int{ return 8002 }
    
    fileprivate var rightBorderTag: Int{ return 8003 }
    
    fileprivate var bottomBorderTag: Int{ return 8004 }
    
    private var defaultAttributes: [String : Any] {
        
        let attributes: [String : Any] = [
            UIViewBorderAttributeKey.marginTop : 0,
            UIViewBorderAttributeKey.marginLeft : 0,
            UIViewBorderAttributeKey.marginBottom : 0,
            UIViewBorderAttributeKey.marginRight : 0,
            ]
        
        return attributes
    }
    
    func drawTopBorder(width: Float, color: UIColor, attributes: [String : Any]){
        
        var metrics: [String : Any] = defaultAttributes
        attributes.forEach { metrics.updateValue($1, forKey: $0) }
        metrics["borderWidth"] = width
        
        let borderView = viewWithTag(topBorderTag) ?? UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = color
        self.addSubview(borderView)
        
        let views: [String : Any] = [
            "borderView" : borderView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-marginLeft-[borderView]-marginRight-|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[borderView(==borderWidth)]", options: [], metrics: metrics, views: views))
        
        layoutIfNeeded()
    }
    
    func drawLeftBorder(width: Float, color: UIColor, attributes: [String : Any]){
        
        var metrics: [String : Any] = defaultAttributes
        attributes.forEach { metrics.updateValue($1, forKey: $0) }
        metrics["borderWidth"] = width
        
        let borderView = viewWithTag(leftBorderTag) ?? UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = color
        self.addSubview(borderView)
        
        let views: [String : Any] = [
            "borderView" : borderView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[borderView(==borderWidth)]", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-marginTop-[borderView]-marginBottom-|", options: [], metrics: metrics, views: views))
        
        layoutIfNeeded()
    }
    
    func drawRightBorder(width: Float, color: UIColor, attributes: [String : Any]){
        
        var metrics: [String : Any] = defaultAttributes
        attributes.forEach { metrics.updateValue($1, forKey: $0) }
        metrics["borderWidth"] = width
        
        let borderView = viewWithTag(rightBorderTag) ?? UIView()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = color
        self.addSubview(borderView)
        
        let views: [String : Any] = [
            "borderView" : borderView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=0)-[borderView(==borderWidth)]-marginRight-|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-marginTop-[borderView]-marginBottom-|", options: [], metrics: metrics, views: views))
        
        layoutIfNeeded()
    }
    
    func drawBottomBorder(width: Float, color: UIColor, attributes: [String : Any]){
        
        var metrics: [String : Any] = defaultAttributes
        attributes.forEach { metrics.updateValue($1, forKey: $0) }
        metrics["borderWidth"] = width
        
        let borderView = viewWithTag(bottomBorderTag) ?? UIView()
        borderView.tag = bottomBorderTag
        borderView.removeFromSuperview()
        borderView.translatesAutoresizingMaskIntoConstraints = false
        borderView.backgroundColor = color
        self.addSubview(borderView)
        
        let views: [String : Any] = [
            "borderView" : borderView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-marginLeft-[borderView]-marginRight-|", options: [], metrics: metrics, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=0)-[borderView(==borderWidth)]-marginBottom-|", options: [], metrics: metrics, views: views))
        
        layoutIfNeeded()
    }
    
    func removeTopBorder(animation: Bool) {
        
        if let borderView = viewWithTag(topBorderTag) {
            if animation {
                UIView.animate(withDuration: 0.2, animations: {
                    borderView.removeFromSuperview()
                })
            }else{
                borderView.removeFromSuperview()
            }
            
        }
        
    }
    
    func removeLeftBorder(animation: Bool) {
        
        if let borderView = viewWithTag(leftBorderTag) {
            if animation {
                UIView.animate(withDuration: 0.2, animations: {
                    borderView.removeFromSuperview()
                })
            }else{
                borderView.removeFromSuperview()
            }
            
        }
        
    }
    
    func removeRightBorder(animation: Bool) {
        
        if let borderView = viewWithTag(rightBorderTag) {
            if animation {
                UIView.animate(withDuration: 0.2, animations: {
                    borderView.removeFromSuperview()
                })
            }else{
                borderView.removeFromSuperview()
            }
            
        }
        
    }
    
    func removeBottomBorder(animation: Bool) {
        
        if let borderView = viewWithTag(bottomBorderTag) {
            if animation {
                UIView.animate(withDuration: 0.2, animations: {
                    borderView.removeFromSuperview()
                })
            }else{
                borderView.removeFromSuperview()
            }
            
        }
        
    }
}
