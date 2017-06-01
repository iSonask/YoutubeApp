//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    func setupViews()  {
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class videoCell: BaseCell {
    
    let thumnaiImageVIew: UIImageView = {
        let img = UIImageView()
//        img.image = #imageLiteral(resourceName: "stronger")
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let userprofileimageView: UIImageView = {
        let img = UIImageView()
        img.image = #imageLiteral(resourceName: "kanyewest")
        img.clipsToBounds = true
        img.layer.cornerRadius = 22.5
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Kanye West - Stronger"
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 14)
        return lbl
    }()
    let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Work it hard makes it better Do it Faster makes us Stronger"
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 10)
        return lbl
    }()
    
    var video: Video? {
        didSet{
            titleLabel.text = video?.title
            subtitleLabel.text = video?.subtitle
            setupThumbnailImage()
//            thumnaiImageVIew.image = UIImage(named: (video?.image)!)
        }
    }
    func setupThumbnailImage(){
        if let thumbnailimageURL = video?.image{
            print(thumbnailimageURL)
            URLSession.shared.dataTask(with: URL(string: thumbnailimageURL)!, completionHandler: {(data,response,error) in
                if error != nil{
                    print(error!)
                    return
                }
                DispatchQueue.main.async {
                    self.thumnaiImageVIew.image = UIImage(data: data!)
                }
                
            }).resume()
        }
    }
    override func setupViews()  {
        
        addSubview(thumnaiImageVIew)
        addSubview(userprofileimageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        
        thumnaiImageVIew.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 65, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        userprofileimageView.anchor(thumnaiImageVIew.bottomAnchor, left: thumnaiImageVIew.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 45, heightConstant: 45)
        titleLabel.anchor(userprofileimageView.topAnchor, left: userprofileimageView.rightAnchor, bottom: nil, right: thumnaiImageVIew.rightAnchor, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 20)
        subtitleLabel.anchor(titleLabel.bottomAnchor, left: userprofileimageView.rightAnchor, bottom: userprofileimageView.bottomAnchor, right: thumnaiImageVIew.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        contentView.drawBottomBorder(width: 0.5, color: .lightGray, attributes: ["":""])
    }
    }
