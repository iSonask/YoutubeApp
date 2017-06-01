//
//  MenuCell.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit
class MenuCell: BaseCell {
    
    let imageview: UIImageView = {
        let iv = UIImageView()
//        iv.image = #imageLiteral(resourceName: "home")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return iv
    }()
    override var isHighlighted: Bool{
        didSet{
            imageview.tintColor = isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    override var isSelected: Bool{
        didSet{
            imageview.tintColor = isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13)
        }
    }
    
    override func setupViews() {
        super.setupViews()
        addSubview(imageview)
        imageview.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 30, heightConstant: 30)
        
    }
   
    
}
