//
//  LocalbaseManager.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

final class LocalbaseManager {
    
    // MARK: - Worker
    static var firstname = BehaviorRelay<String?>(value: nil)
    static var secondname = BehaviorRelay<String?>(value: nil)
    static var thirdname = BehaviorRelay<String?>(value: nil)
    static var relocate = BehaviorRelay<Bool?>(value: nil)
    static var graph = BehaviorRelay<(occupation: Int, weekend: Int)?>(value: nil)
    static var salary = BehaviorRelay<Int?>(value: nil)
    static var target = BehaviorRelay<String?>(value: nil)
    static var education = BehaviorRelay<[String]?>(value: nil)
    static var skills = BehaviorRelay<[String]>(value: [])
    static var extra = BehaviorRelay<String?>(value: nil)
    static var tags = BehaviorRelay<[String]?>(value: nil)
}
