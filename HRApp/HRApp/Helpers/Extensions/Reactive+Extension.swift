//
//  Reactive+Extension.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import Foundation
import RxSwift
import RxCocoa
import WSTagsField

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(_ element: Element.Element) {
        accept(value + [element])
    }
    
    func replace(_ element: Element.Element, at index: Element.Index) {
        var value = self.value
        if value[safe: index] != nil {
            value.remove(at: index)
            value.insert(element, at: index)
            accept(value)
        }
    }
}

extension Reactive where Base: TagsEmitter {
    var tagsNumber: ControlProperty<Int> {
        return base.rx
            .controlProperty(editingEvents: .valueChanged,
                             getter: { (emitter: TagsEmitter) in
                                return emitter.tagsNumber
                             }, setter: { (emitter: TagsEmitter, newValue) in
                                emitter.tagsNumber = newValue
                             })
    }
}

