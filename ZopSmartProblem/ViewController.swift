//
//  ViewController.swift
//  ZopSmartProblem
//
//  Created by kashee on 15/01/19.
//  Copyright © 2019 kashee. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, ServerAPIDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func API_CALLBACK_Error(errorNumber: Int, errorMessage: String, apiName: String) {
        print(errorMessage)
    }
    
    var dataArray = [CategoryDetails]()
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionCell")
        cv.backgroundColor = UIColor.clear
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromServer()
        setupCollectionView()
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionViewCell
//        cell.backgroundColor = .purple
//        cell.isUserInteractionEnabled = false
        cell.setValues(data:dataArray[indexPath.row])
        cell.addButton.tag = indexPath.row
        cell.subButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(addButtonAction), for: .touchUpInside)
        cell.subButton.addTarget(self, action: #selector(subButtonAction), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:(collectionView.frame.width-20)/2,height:270)
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    @objc func addButtonAction(sender:UIButton){
        let indexPat = IndexPath(item: sender.tag, section: 0)
        let cell = collectionView.cellForItem(at: indexPat) as! CollectionViewCell
        var count = Int(cell.addedItemLabel.text!)
        
        cell.addedItemLabel.text = "\(count! + 1)"
    }
    
    @objc func subButtonAction(sender:UIButton){
        let indexPat = IndexPath(item: sender.tag, section: 0)
        let cell = collectionView.cellForItem(at: indexPat) as! CollectionViewCell
        var count = Int(cell.addedItemLabel.text!)
        cell.addedItemLabel.text = "\(count! - 1)"
    }
    
    func fetchDataFromServer(){
        let param = ["":""]
        ServerInterface.sharedInstance.API_Request(params: param as [String : AnyObject], delegate: self , apiName: "home", needErrorAlert: false)
        
    }
    
    
    // call back respone
    func API_CALLBACK_POST_Data(result: NSDictionary){
        if let dictionary = result.value(forKey: "data") as? NSDictionary{
            if  let pages = dictionary["page"] as? NSDictionary{
                if let layoutArray = pages["layouts"] as? NSArray {
                    for array in layoutArray{
                        if let dic = array as? NSDictionary{
                            if dic["name"] as! String == "ProductCollection"{
                                if let valeDic = dic["value"] as? NSDictionary{
                                    if let collectionDic = valeDic["collection"] as? NSDictionary{
                                        if let productArray = collectionDic["product"] as? NSArray{
                                             print(productArray[1])
                                            for product in productArray{
                                               
                                                if let prdtl = product as? NSDictionary{
                                                   let data = CategoryDetails()
                                                    data.initDic(result: prdtl)
                                                    dataArray.append(data)
                                                    
                                                }
                                            }
                                            collectionView.reloadData()
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        
        }else{
            return
        }
        
    }

}

