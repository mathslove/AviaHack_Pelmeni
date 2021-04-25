//  
//  VerificationView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit

final class VerificationView: MainView {

    //MARK: - Views
    let emailSendedLabel: UILabel = {
        let label = UILabel()
        label.text = .emailSended
        label.textAlignment = .center
        label.textColor = .blue
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
}
