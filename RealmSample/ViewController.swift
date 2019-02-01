import UIKit
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func createAction(_ sender: Any) {
        let realm = try! Realm()
        
        let tgt = TargetData()
        tgt.name = "あいうえお"
        tgt.age  = 19
        tgt.sec  = "FALE"
        
        let tgt1 = TargetData()
        tgt1.name = "かきくけこ"
        tgt1.age  = 19
        tgt1.sec  = "FALE"
        
        let tgt2 = TargetData()
        tgt2.name = "さしすせそ"
        tgt2.age  = 30
        tgt2.sec  = "FALE"
        
        let tgt3 = TargetData()
        tgt3.name = "たちつてと"
        tgt3.age  = 55
        tgt3.sec  = "MALE"
        
        try! realm.write() {
            realm.add(tgt)
            realm.add(tgt1)
            realm.add(tgt2)
            realm.add(tgt3)
        }
    }
    @IBAction func addBtnAction(_ sender: Any) {
        let realm = try! Realm()
        
        let tgt = TargetData()
        tgt.name = "田中"
        tgt.age  = 23
        tgt.sec  = "MALE"
        
        try! realm.write() {
            realm.add(tgt)
        }
    }
    @IBAction func readAction(_ sender: Any) {
        let realm = try! Realm()
        
        print("=====レコードを全件取得=====")
        print(realm.objects(TargetData.self))
        
        print("=====ageカラムが20以上のレコードを全件取得=====")
        print(realm.objects(TargetData.self).filter("age >= 20"))
        
        print("=====secカラムが 'MALE' の文字列と一致するレコードを全件取得=====")
        print(realm.objects(TargetData.self).filter("sec like 'MALE'"))
        
        print("=====nameカラムに '田中' の文字列を含むレコードを全件取得=====")
        print(realm.objects(TargetData.self).filter("name contains '田中'"))
        
        print("=====データあれこれ=====")
        let aaa = realm.objects(TargetData.self)
        for bbb in aaa {
            print(bbb.name)
        }
    }
    @IBAction func updateAction(_ sender: Any) {
        let realm = try! Realm()
        
        /* 一番最初のnameを '田中' に変更 */
        let firstPerson = realm.objects(TargetData.self).first
        try! realm.write() {
            firstPerson?.name = "田中"
        }
        
        /* 'あいうえお' を '田中' に変更 */
        let aiueo = realm.objects(TargetData.self).filter("name like 'あいうえお'")
        aiueo.forEach { aiueo in
            try! realm.write() {
                aiueo.name = "田中"
            }
        }
        
    }
    @IBAction func deleteAction(_ sender: Any) {
        let realm = try! Realm()
        
        /* 一番最初のオブジェクトを削除 */
        if let firstPerson = realm.objects(TargetData.self).first {
            try! realm.write() {
                realm.delete(firstPerson)
            }
        }
        
        /* 取得した田中を全件削除する場合 */
        let tanakas = realm.objects(TargetData.self).filter("name like '田中'")
        
        tanakas.forEach { tanaka in
            try! realm.write() {
                realm.delete(tanaka)
            }
        }
    }
    
}

