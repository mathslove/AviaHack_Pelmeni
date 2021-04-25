import FirebaseAuth
import SwiftyJSON

protocol DetailUserPresenterProtocol {
    func getMetric(forUser: String)
}

final class DetailUserPresenter: DetailUserPresenterProtocol {
    
    // MARK: - Dependencies
    weak var viewController: DetailUserViewController?
    
    // MARK: - Methods
    func getMetric(forUser uid: String) {
        print("uiduid", uid)
        DatabaseManager
            .firestore
            .collection(DatabasePaths.users)
            .document(uid)
            .getDocument { (snapshot, error) in
                let json = JSON(snapshot!.data())
                print(json)
                self.viewController?.user = VacansUser(firstname: json["firstname"].stringValue,
                                                  lastname: json["lastname"].stringValue,
                                                  middle: json["middle"].stringValue,
                                                  hardskill_res: json["hardskill_res"].intValue,
                                                  education_res: json["education_res"].intValue,
                                                  experience_res: json["experience_res"].intValue,
                                                  softskill_res: json["softskill_res"].intValue,
                                                  tags_res: json["tags_res"].intValue,
                                                  total_res: json["total_res"].intValue)
                self.viewController?.notify()
            }
    }
}
