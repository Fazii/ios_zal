//
//  Product.swift
//  proj
//
//  Created by student on 10.09.2018.
//  Copyright © 2018 student. All rights reserved.
//

import Foundation
import RealmSwift

class Product: Object {
    @objc dynamic var userId:Int = 0
    @objc dynamic var id:Int = 0
    @objc dynamic var title:String = ""
    @objc dynamic var completed:Bool = false
    }
