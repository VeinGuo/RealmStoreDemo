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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        saveTestObjects()
    }
    
    @IBAction func onLoad(_ sender: UIButton) {
        loadTestObjects()
    }
    
    @IBAction func onFilter(_ sender: UIButton) {
        filterObjects()
    }
    
    func loadTestObjects() {
        do {
            let realm =  try Realm()
            let objects: Results<TestObject> = realm.objects(TestObject.self)
            print(objects)
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
            print(realm.configuration.fileURL ?? "")
        } catch {
            print(error)
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
        print(filterObjects)
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
}


