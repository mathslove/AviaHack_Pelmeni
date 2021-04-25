//
//  User.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import Foundation

struct User {
    var name: String?
    var surname: String?
    var middlename: String?
    var type: String?
    var hrcvs = [HRCV]()
    var wcvs = [WCV]()
}

struct VacansUser {
    var firstname: String?
    var lastname: String?
    var middle: String?
    var hardskill_res: Int?
    var education_res: Int?
    var experience_res: Int?
    var softskill_res: Int?
    var tags_res: Int?
    var total_res: Int?
}

struct HRCV {
    var name: String?
    var title: String?
    var city: String?
    var occupation: Int?
    var weekend: Int?
    var salary: Int?
    var responsibilities = [String]()
    var requirements: Requirements?
}

struct Requirements {
    var vital = [String]()
    var extra = [String]()
    var tags = [String]()
}

struct WCV {
    var name: String?
    var title: String?
    var city: String?
    var occupation: Int?
    var weekend: Int?
    var salary: Int?
    var education = [Education]()
    var experience = [Experience]()
    var skills = [String]()
    var additionalInfo = [String]()
    var tags = [String]()
}

struct Education {
    var name: String?
    var startDate: Int?
    var endDate: Int?
    var degree: String?
    var specialization: String?
    var certified: Bool?
}

struct Experience {
    var name: String?
    var startDate: Int?
    var endDate: Int?
    var description: String?
    var recommendation: Bool?
}
