//
//  ViewController.swift
//  ClonePinterest
//
//  Created by Phan Minh Thang on 8/31/20.
//  Copyright © 2020 Phan Minh Thang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGSize {
        let image = UIImage(named: "Image\(indexPath.row+1)")
        return image!.size
    }
    
    
    let arrName = ["Charizard", "Alakazam", "Pikachu", "Alakazam", "Dragon Knight", "Storm Spirit", "Earth Shaker", "Phantom Lancer", "Messi"]
    let spacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        cell.imgImage.image = UIImage(named: "Image\(indexPath.row+1)")
        cell.layer.cornerRadius = 15
        cell.lblName.text = arrName[indexPath.row]
        return cell
    }
    
    let edge: CGFloat = 10.0

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: edge, bottom: 0, right: edge)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
//  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfColumns: CGFloat = 2
//        let width = collectionView.frame.size.width
//        let xInsets: CGFloat = 10
//        let cellSpacing: CGFloat = 5
//        let image = UIImage(named: "Image\(indexPath.row+1)")
//        let hight = image?.size.height
//        return CGSize(width: (width/numberOfColumns) - (xInsets+cellSpacing), height: hight!)
//        }
        
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
    }
    
    func setupCollectionViewItemSize() {
        let customLayout = Layout()
        customLayout.delegate = self
        collectionView.collectionViewLayout = customLayout
        
    }
        

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionViewItemSize()
//        collListImage.delegate = self
//        collListImage.dataSource = self
//        collListImage.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        // Do any additional setup after loading the view.
    }


}

