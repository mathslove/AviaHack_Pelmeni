//  
//  TagsView.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import WSTagsField

final class TagsView: MainView {

    //MARK: - Views
    let tagsField: WSTagsField = {
        let tagsField = WSTagsField()
        tagsField.cornerRadius = 20
        tagsField.spaceBetweenLines = 20
        tagsField.spaceBetweenTags = 12
        tagsField.font = .preferredFont(forTextStyle: .headline)
        tagsField.textColor = .blue
        tagsField.borderWidth = 0.5
        tagsField.borderColor = .lightGray
        
        tagsField.layoutMargins = UIEdgeInsets(top: 11, left: 15, bottom: 11, right: 32)
        tagsField.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)

        tagsField.placeholder = ""
        tagsField.placeholderAlwaysVisible = true
        tagsField.textField.returnKeyType = .continue
        tagsField.delimiter = ""
        return tagsField
    }()
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = .tags
        label.font = .systemFont(ofSize: 15)
        label.textColor = .blue
        return label
    }()
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    let saveButton = Button(title: .save, titleColor: .white, backgroundColor: .blue)
    let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
}
