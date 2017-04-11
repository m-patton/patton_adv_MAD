//
//  Quote.swift
//  lab6
//
//  Created by Mae Patton on 4/10/17.
//  Copyright © 2017 atlas. All rights reserved.
//

import Foundation
import Firebase


class Quote {
    var name: String
    var quote: String
    
    init(newname: String, newquote: String){
        name = newname
        quote = newquote
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: String]
        name = snapshotValue["name"]!
        quote = snapshotValue["quote"]!
    }
}
