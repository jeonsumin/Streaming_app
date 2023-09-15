//
//  RoomListController.swift
//  AvStreamingApp
//
//  Created by terry on 2023/09/14.
//

import UIKit

struct RoomList {
    let room: String
}
class RoomListController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    var roomList = [RoomList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        setupCurrentDate()
        
        collectionView.register(RoomListCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RoomListCell
        
        let roomList = roomList[indexPath.item]
        cell.label.text = roomList.room
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chattingController = ChattingRoomController()
        chattingController.room = roomList[indexPath.item].room
        
        navigationController?.pushViewController(chattingController, animated: true)
    }
    
    func setupCurrentDate(){
        roomList.append(RoomList(room: "1"))
        roomList.append(RoomList(room: "2"))
        roomList.append(RoomList(room: "3"))
        roomList.append(RoomList(room: "4"))
        roomList.append(RoomList(room: "5"))
        roomList.append(RoomList(room: "6"))
    }
}
