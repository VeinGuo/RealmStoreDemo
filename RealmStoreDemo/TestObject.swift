//
//  TestObject.swift
//  Store
//
//  Created by Vein on 2017/10/25.
//  Copyright © 2017年 Vein. All rights reserved.
//

import Foundation
import RealmSwift

class TestObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var gender = ""
    // 默认 为nil
    let stature = RealmOptional<Int>()

    // 设置主键
    override static func primaryKey() -> String? {
        return "id"
    }
}
