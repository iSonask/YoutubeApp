//
//  SettingsCell.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit

class SettingsCell: UICollectionViewCell {
    let namelabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Setting"
        return lbl
    }()
    let iconimaageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "more")
        img.contentMode = .scaleAspectFill
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews()  {
        addSubview(namelabel)
        addSubview(iconimaageView)
        
        namelabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 50, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        iconimaageView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: namelabel.leftAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 5, rightConstant: 5, widthConstant: 0, heightConstant: 0)

    }
}
