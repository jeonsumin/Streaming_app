//
//  RoomListCell.swift
//  AvStreamingApp
//
//  Created by terry on 2023/09/14.
//

import UIKit
class RoomListCell: UICollectionViewCell {
    
    let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "room"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
