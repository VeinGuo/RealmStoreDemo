//
//  ViewController.swift
//  RealmStoreDemo
//
//  Created by Vein on 2017/10/25.
//  Copyright © 2017年 Vein. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var logTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatDataBase("testDB")
    }
    
    func creatDataBase(_ name: String) {
        let path = dataBasePath()
        let filePath = path + "/\(name).realm"
        var config = Realm.Configuration()
        config.fileURL = URL(fileURLWithPath: filePath)
        config.schemaVersion = 0
        // 将这个配置应用到默认的 Realm 数据库当中
        Realm.Configuration.defaultConfiguration = config
    }
    
    // MARK: 数据迁移
    func localMigrations() {
        var defaultConfiguration = Realm.Configuration.defaultConfiguration
        defaultConfiguration.schemaVersion = 1
        defaultConfiguration.migrationBlock = { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: TestObject.className()) { oldObject, newObject in
                    // 将ID主键进行修改，每一位都增加 1
                    let id = oldObject!["id"] as! Int
                    newObject!["id"] = id + 1
                }
            }
            // 修改类名
            //                if oldSchemaVersion < UInt64(1.1) {
            //                    migration.renameProperty(onType: TestObject.className(), from: "name", to: "rename")
            //                }
        }
        Realm.Configuration.defaultConfiguration = defaultConfiguration
    }
    
    func dataBasePath() -> String {
        let ducumentPath = NSHomeDirectory() + "/Documents"
        return ducumentPath
    }
    
    func loadTestObjects() {
        do {
            let realm =  try Realm()
            let objects: Results<TestObject> = realm.objects(TestObject.self)
            printLog(objects.description)
        } catch {
            print(error)
        }
    }
    
    func saveTestObjects() {
        
        do {
            let realm =  try Realm()
            try realm.write {
                for object in testObjects() {
                    realm.add(object, update: true)
                }
            }
            printLog(realm.configuration.fileURL?.absoluteString ?? "")
        } catch {
            printLog(error.localizedDescription)
        }
    }
    
    func deleteAllTestObejcts() {
        let realm =  try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func filterObjects() {
        let realm =  try! Realm()
        print(realm.configuration.fileURL ?? "")
        
        let stature = 170
        let objects: Results<TestObject> = realm.objects(TestObject.self)
        let filterObjects = objects.filter("stature > \(stature)")
        printLog(filterObjects.description)
    }
    
    func testObjects() -> [TestObject] {
        let testObjet0 = TestObject(value: ["name": "Test0",
                                            "gender": "Female",
                                            "stature": 155,
                                            "id": 0])
        let testObjet1 = TestObject(value: ["name": "Test1",
                                            "gender": "Male",
                                            "stature": 165,
                                            "id": 1])
        let testObjet2 = TestObject(value: ["name": "Test2",
                                            "gender": "Female",
                                            "stature": 165,
                                            "id": 2])
        let testObjet3 = TestObject(value: ["name": "Test3",
                                            "gender": "Male",
                                            "stature": 181,
                                            "id": 3])
        let testObjet4 = TestObject(value: ["name": "Test4",
                                            "gender": "Male",
                                            "stature": 175,
                                            "id": 4])
        return [testObjet0, testObjet1,
                testObjet2, testObjet3,
                testObjet4]
    }
    
    func printLog(_ log: String) {
        logTextView.text = log
        print(log)
        print(Realm.Configuration.defaultConfiguration.fileURL ?? "")
    }
}

// MARK: Event
extension ViewController {
    @IBAction func onSave(_ sender: UIButton) {
        saveTestObjects()
    }
    
    @IBAction func onLoad(_ sender: UIButton) {
        loadTestObjects()
    }
    
    @IBAction func onFilter(_ sender: UIButton) {
        filterObjects()
    }
    
    @IBAction func onLocalMigrations(_ sender: UIButton) {
        localMigrations()
    }
    
}

