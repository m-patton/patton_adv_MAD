//
//  Post.swift
//  p1m3
//
//  Created by Mae Patton on 5/5/17.
//  Copyright © 2017 Mae Patton. All rights reserved.
//

import Foundation
import Firebase

class Post {
    var name: String
    var post: String
    var postid: String
    
    init(newname: String, newpost: String, newid: String){
        name = newname
        post = newpost
        postid = newid
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        name = snapshotValue["name"]!
        post = snapshotValue["post"]!
        postid = snapshotValue["postid"]!
    }
    
}
