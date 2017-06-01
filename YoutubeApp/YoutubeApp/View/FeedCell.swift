//
//  FeedCell.swift
//  YoutubeApp
//
//  Created by FARHAN IT SOLUTION on 10/05/17.
//
//

import UIKit

class FeedCell: BaseCell ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    var videos: [Video]?
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data,response,error) in
            if error != nil{
                print(error!)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                print(json)
                self.videos = [Video]()
                for dict in json as! [[String: AnyObject]]{
                    print(dict["title"]!)
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.image = dict["thumbnail_image_name"] as? String
                    self.videos?.append(video)
                }
                self.collectionView.reloadData()
            }catch let jsonerror{
                print(jsonerror)
            }
        }).resume()
    }
    
    var cellid = "cellid"
    
    override func setupViews() {
        super.setupViews()
        backgroundColor = .brown
        addSubview(collectionView)
        collectionView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        collectionView.register(videoCell.self, forCellWithReuseIdentifier: cellid)
        fetchVideos()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! videoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 20) * 9 / 16
        return CGSize(width: frame.width, height: height + 75)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
    
    
    
    
}

