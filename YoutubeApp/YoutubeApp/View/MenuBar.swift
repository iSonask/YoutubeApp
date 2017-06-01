//
//  MenuBar.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit

class MenuBar: UIView ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    let CellID = "CellID"
    var homeVC: HomeController?
    
    lazy var collectionView: UICollectionView = {
        
        
        
//        let screenSize = UIScreen.main.bounds
//        let screenWidth = screenSize.width
//        let screenHeight = screenSize.height
//        
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
//        layout.itemSize = CGSize(width: screenWidth/4, height: screenWidth/4)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0

        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 187, green: 0, blue: 0)
        
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let imageNames = ["home","trending","subscribe","user"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.rgb(red: 187, green: 0, blue: 0)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: CellID)
        addSubview(collectionView)
        collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        let selectedIndexpath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexpath, animated: true, scrollPosition: .bottom)
        setupHorizontalBar()
    }
    var horizontalbarLeftAnchorConstraint: NSLayoutConstraint?
    func setupHorizontalBar(){
        let horizontalBarview = UIView()
        horizontalBarview.translatesAutoresizingMaskIntoConstraints = false
        horizontalBarview.backgroundColor = UIColor(white: 0.9, alpha: 1)
        addSubview(horizontalBarview)
        horizontalbarLeftAnchorConstraint = horizontalBarview.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalbarLeftAnchorConstraint?.isActive = true
        horizontalBarview.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/4).isActive = true
        horizontalBarview.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellID, for: indexPath) as! MenuCell
        cell.imageview.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        _ = CGFloat(indexPath.item) * frame.width / 4
//        horizontalbarLeftAnchorConstraint?.constant = x
        homeVC?.scrolltomenuIndex(menuindex: indexPath.item)
//        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//            self.layoutIfNeeded()
//        }, completion: nil)
    }
}

