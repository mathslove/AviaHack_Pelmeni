//
//  DatabaseManager.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import FirebaseFirestore
import FirebaseAuth
import RxFirebaseFirestore
import RxSwift
import SwiftyJSON

final class DatabaseManager {
    
    // MARK: - Properties
    static let firestore = Firestore.firestore()
    static var user = User()
    static var hasListener = false
    
    static var subscribers = [DatabaseManagerProtocol]()
    
    private static let bag = DisposeBag()
    
    // MARK: - Methods
    class func startListen() {
        guard let uid = Auth.auth().currentUser?.uid else {
            print("провалился")
            try! Auth.auth().signOut()
            return
        }
        
        firestore
            .collection(DatabasePaths.users)
            .document(uid)
            .rx
            .listen()
            .subscribe { (snapshot) in
                if let data = snapshot.data() {
                    let json = JSON(data)
                    print(json)
                    user.name = json[DatabasePaths.name].stringValue
                    user.surname = json[DatabasePaths.surname].stringValue
                    user.middlename = json[DatabasePaths.middlename].stringValue
                    
                    user.type = json[DatabasePaths.type].stringValue
                    let jsonCV = JSON(parseJSON: json[DatabasePaths.cv].stringValue)
                    
                    if user.type == "HR" {
                        user.hrcvs = jsonToHRCVs(json: jsonCV)
                    } else {
//                        user.wcvs = jsonToWCV(json: jsonCV)
                    }
                    
                    notify()
                }
            } onError: { (error) in
                print("error", error.localizedDescription)
            }.disposed(by: bag)
    }
    
    class func update(data: [String: Any]) {
        guard let uid = Auth.auth().currentUser?.uid else {
            try! Auth.auth().signOut()
            return
        }
        firestore
            .collection(DatabasePaths.users)
            .document(uid)
            .setData(data, merge: true)
    }
    
    class func deleteUser() {
        print("delete")
        if Auth.auth().currentUser != nil {          }
            Auth.auth().currentUser?.delete { (error) in
                if let error = error {
                    AlertManager.shared.showNotification(title: error.localizedDescription, actions: [UIAlertAction(title: "OK", style: .default, handler: nil)])
                }
                print("userDeleted")
        }
    }
    
    class func notify() {
        subscribers.forEach { subscriber in
            subscriber.notified()
        }
    }
    
    class func jsonToHRCVs(json: JSON) -> [HRCV] {
        json.arrayValue.map { (jsonCV) in
            var hrcv = HRCV()
            hrcv.name = jsonCV[DatabasePaths.name].stringValue
            hrcv.title = jsonCV[DatabasePaths.title].stringValue
            hrcv.city = jsonCV[DatabasePaths.city].stringValue
            hrcv.occupation = jsonCV[DatabasePaths.occupation].intValue
            hrcv.weekend = jsonCV[DatabasePaths.weekend].intValue
            hrcv.salary = jsonCV[DatabasePaths.salary].intValue
            hrcv.responsibilities = jsonCV[DatabasePaths.responsibilities].arrayValue.map { $0.stringValue }
            hrcv.requirements?.vital = jsonCV[DatabasePaths.requirements][DatabasePaths.vital].arrayValue.map { $0.stringValue }
            hrcv.requirements?.extra = jsonCV[DatabasePaths.requirements][DatabasePaths.extra].arrayValue.map { $0.stringValue }
            hrcv.requirements?.tags = jsonCV[DatabasePaths.requirements][DatabasePaths.tags].arrayValue.map { $0.stringValue }
            
            return hrcv
        }
    }
    
    class func jsonToWCV(json: JSON) -> WCV {
        let jsonCV = JSON(parseJSON: json[DatabasePaths.cv].stringValue)
//        print(JSON(parseJSON: jsonCV))
        return WCV(name: jsonCV[DatabasePaths.name].stringValue,
            title: jsonCV[DatabasePaths.title].stringValue,
            city: jsonCV[DatabasePaths.city].stringValue,
            occupation: jsonCV[DatabasePaths.occupation].intValue,
            weekend: jsonCV[DatabasePaths.weekend].intValue,
            salary: jsonCV[DatabasePaths.salary].intValue,
            education: jsonCV[DatabasePaths.education].arrayValue.map { (json) -> Education in
                Education(name: json[DatabasePaths.name].stringValue,
                          startDate: json[DatabasePaths.startDate].intValue,
                          endDate: json[DatabasePaths.endDate].intValue,
                          degree: json[DatabasePaths.degree].stringValue,
                          specialization: json[DatabasePaths.specialization].stringValue,
                          certified: json[DatabasePaths.certified].boolValue)
            },
            experience: jsonCV[DatabasePaths.experience].arrayValue.map { (json) -> Experience in
                Experience(name: json[DatabasePaths.name].stringValue,
                           startDate: json[DatabasePaths.startDate].intValue,
                           endDate: json[DatabasePaths.endDate].intValue,
                           description: json[DatabasePaths.description].stringValue,
                           recommendation: json[DatabasePaths.recommendation].boolValue)
            },
            skills: jsonCV[DatabasePaths.skills].arrayValue.map { $0.stringValue },
            additionalInfo: jsonCV[DatabasePaths.additionalInfo].arrayValue.map { $0.stringValue },
            tags: jsonCV[DatabasePaths.tags].arrayValue.map { $0.stringValue })
        
    }
}

protocol DatabaseManagerProtocol {
    func notified()
}
