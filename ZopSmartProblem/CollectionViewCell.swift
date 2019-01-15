//
//  CollectionViewCell.swift
//  ZopSmartProblem
//
//  Created by kashee on 15/01/19.
//  Copyright © 2019 kashee. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
   
    let cardView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        return view
    }()
    let productImage:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let productNameLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "name of product"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor(red: 33/255.0, green: 73/255.0, blue: 88/255.0, alpha: 0.73)
        return label
    }()
    
    let addedItemLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5"
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor(red: 33/255.0, green: 73/255.0, blue: 88/255.0, alpha: 0.73)
        return label
    }()
    
    lazy var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var subButton:UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .purple
        button.layer.cornerRadius = 25
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowforView(button: cardView, color: .lightGray)
    }
    
    func setupView(){
        addSubview(cardView)
        cardView.addSubview(productImage)
        cardView.addSubview(productNameLabel)
        cardView.addSubview(addedItemLabel)
        cardView.addSubview(addButton)
        cardView.addSubview(subButton)
        cardView.topAnchor.constraint(equalTo: self.topAnchor,constant:5).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:5).isActive = true
        cardView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-5).isActive = true
        cardView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:-5).isActive = true
        
        productImage.topAnchor.constraint(equalTo: cardView.topAnchor,constant:5).isActive = true
        productImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5).isActive = true
        productImage.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5).isActive = true
        productImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        productNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 5).isActive = true
        productNameLabel.leadingAnchor.constraint(equalTo: productImage.leadingAnchor).isActive = true
        productNameLabel.trailingAnchor.constraint(equalTo: productImage.trailingAnchor).isActive = true
        productNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 10).isActive = true
        addButton.leadingAnchor.constraint(equalTo: productNameLabel.leadingAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 50)
        
        addedItemLabel.topAnchor.constraint(equalTo: addButton.topAnchor).isActive = true
        addedItemLabel.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 10).isActive = true
        addedItemLabel.trailingAnchor.constraint(equalTo: subButton.leadingAnchor, constant: -10).isActive = true
        addedItemLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        subButton.topAnchor.constraint(equalTo: addButton.topAnchor).isActive = true
        subButton.trailingAnchor.constraint(equalTo: productNameLabel.trailingAnchor).isActive = true
        subButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        subButton.heightAnchor.constraint(equalToConstant: 50)
        
        
//        productNameLabel.backgroundColor = .red
    }
    
    func setValues(data:CategoryDetails){
        productImage.sd_setImage(with: URL(string: data.imageUrl?[0] ?? ""), placeholderImage:UIImage(named: ""))
        productNameLabel.text = data.name
    }
    
    func shadowforView(button:UIView,color:UIColor){
        
        button.layer.shadowColor = color.cgColor
        //    button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.masksToBounds = false
        
    }
}
