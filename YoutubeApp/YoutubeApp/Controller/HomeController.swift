//
//  ViewController.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 09/05/17.
//
//

import UIKit

class HomeController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let titles = ["Home", "Trending","Subscriptions", "Account"]
    let colors: [UIColor] = [.red , .gray , .brown , .cyan]
    let settingsLauncher = SettingsLauncher()
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeVC = self
        mb.backgroundColor = UIColor.rgb(red: 187, green: 0, blue: 0)
        return mb
    }()
    let cellID = "CellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.barTintColor = UIColor(red: 187/255, green: 0/255, blue: 0/255, alpha: 0.8)
        navigationController?.navigationBar.isTranslucent = false
        
        let titlelable = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titlelable.text = "  Home"
        titlelable.textColor = .white
        titlelable.font = UIFont.systemFont(ofSize: 18)
        navigationItem.titleView = titlelable
        
        setupMenuBar()
        setupNavBarButtons()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        if let flowlayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowlayout.scrollDirection = .horizontal
            flowlayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = .white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: Cell)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    
    
    func setupNavBarButtons(){
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "search").filled(withColor: .white), style: .done, target: self, action: #selector(searchTapped))
        let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "more").filled(withColor: .white), style: .done, target: self, action: #selector(moreTapped))
        navigationItem.rightBarButtonItems = [moreButton,searchButton]
        print("added")
    }
    
    
    func moreTapped()  {
        print("More Tapped")
        SettingsLauncher.shared.showSettings()
    }
    func searchTapped() {
        print("Search Tapped")
    }
    
    func scrolltomenuIndex(menuindex: Int)  {
        let index = IndexPath(item: menuindex, section: 0)
        collectionView?.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        setTitle(index: menuindex)
    }
    fileprivate func setTitle(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = "\(titles[index])"
        }
    }
    fileprivate func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        view.addSubview(menuBar)
        menuBar.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
    }
    let Cell = "cell"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell, for: indexPath) as! FeedCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalbarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print(targetContentOffset.pointee.x)
        let index = targetContentOffset.pointee.x / view.frame.width
        setTitle(index: Int(index))
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }

}

