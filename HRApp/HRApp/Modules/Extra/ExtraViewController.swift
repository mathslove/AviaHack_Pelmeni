//  
//  ExtraViewController.swift
//  HRApp
//
//  Created by Даниил Храповицкий on 24.04.2021.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

final class ExtraViewController: ViewController<ExtraView> {

    private let bag = DisposeBag()
    
    let workerTable: [ExtraField] = [
        .textField(placeholder: .firstname),
        .textField(placeholder: .secondname),
        .textField(placeholder: .thirdname),
        .switcher(title: .relocate),
        .multiple(title: .graph,
                  data: [
                    .timeFull,
                    .timeLe,
                    .timeMo,
                    .timeEq,
                    .timeSm,
                    .timeIn,
                    .timeFr
                  ]),
        .number(placeholder: .salary),
        .textView(placeholder: .objective),
        .expanded(data: .education,
                  first: ["1", "2", "3", "4", "5", "6"],
                  second: [Int](1950...2021).map { "\($0)" },
                  third: [Int](1950...2021).map { "\($0)" }),
        .many(title: .skills, placeholder: .skill, buttonTitle: .addSkill),
        .textView(placeholder: .addInfo),
        .tag
    ]
    
    let requiredForWorker = [0, 1, 3, 4, 5, 6, 7, 8, 9]
    
    let hrTable: [ExtraField] = [
        
    ]
    
    //MARK: - Properties
    let binder: ExtraBinderProtocol
    let filler: ExtraFillerProtocol
    let presenter: ExtraPresenterProtocol
    let router: ExtraRouterProtocol
    
    let type: ExtraScreenType
    
    //MARK: - Initializer
    init(binder: ExtraBinderProtocol,
         filler: ExtraFillerProtocol,
         presenter: ExtraPresenterProtocol,
         router: ExtraRouterProtocol,
         type: ExtraScreenType) {
        self.type = type
        self.binder = binder
        self.filler = filler
        self.presenter = presenter
        self.router = router
        super.init()
        mainView.tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("appear")
        filler.fill()
        binder.bind()
        handleTap()
        
        title = .extraInformation
        
        navigationItem.rightBarButtonItem = mainView.doneButton
        navigationController?.navigationBar.rx.tapGesture().bind { _ in
            self.mainView.endEditing(true)
        }.disposed(by: bag)
    }
    
    private func handleTap() {
        mainView.aloeStackView.setTapHandler(forRow: mainView.avatar) { (view) in
            let camera = UIAlertAction(title: .takePhoto, style: .default) { _ in
                let pickerViewController = UIImagePickerController()
                pickerViewController.sourceType = .camera
                pickerViewController.cameraDevice = .rear
                pickerViewController.delegate = self
                pickerViewController.allowsEditing = true
                AlertManager.shared.show(viewController: pickerViewController)
            }
            camera.setValue(UIImage(systemName: "camera"), forKey: "image")
            let library = UIAlertAction(title: .library, style: .default) { _ in
                let pickerViewController = UIImagePickerController()
                pickerViewController.sourceType = .photoLibrary
                pickerViewController.delegate = self
                pickerViewController.allowsEditing = true
                AlertManager.shared.show(viewController: pickerViewController)
            }
            library.setValue(UIImage(systemName: "photo.on.rectangle.angled"), forKey: "image")
            let cancel = UIAlertAction(title: .cancel, style: .cancel)
            AlertManager.shared.showBottomSheet(title: nil, actions: [camera, library, cancel])
        }
    }
}

extension ExtraViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .hr: return hrTable.count
        case .worker: return workerTable.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
        case .worker:
            switch workerTable[indexPath.row] {
            case .textField(let placeholder):
                let cell = RegistrationTableViewCellWithtextField()
                cell.fill()
                cell.textField.placeholder = placeholder
                cell.textField.autocorrectionType = .no
                cell.selectionStyle = .none
                
                if indexPath.row == 0 {
                    cell.textField.rx.text.orEmpty.bind { text in
                        LocalbaseManager.firstname.accept(text)
                    }.disposed(by: bag)
                } else if indexPath.row == 1 {
                    cell.textField.rx.text.orEmpty.bind { text in
                        LocalbaseManager.secondname.accept(text)
                    }.disposed(by: bag)
                } else if indexPath.row == 2 {
                    cell.textField.rx.text.orEmpty.bind { text in
                        LocalbaseManager.thirdname.accept(text)
                    }.disposed(by: bag)
                }
                
                return cell
                
            case .switcher(let title):
                let cell = ExtraCellWithSwitcher()
                cell.fill()
                cell.textLabel?.text = title
                cell.selectionStyle = .none
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                
                cell.behaviorRelay.bind { isOn in
                    LocalbaseManager.relocate.accept(isOn)
                }.disposed(by: bag)
                
                return cell
                
            case .multiple(let title, let data):
                let cell = ExtraCellWithArrayOfStrings(style: .value1, reuseIdentifier: nil)
                cell.data.append(title)
                cell.data1 = data
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.text = title
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                if let oc = LocalbaseManager.graph.value?.occupation, let we = LocalbaseManager.graph.value?.weekend {
                    cell.detailTextLabel?.text = "\(oc)/\(we)"
                }
                return cell
                
            case .number(let placeholder):
                let cell = RegistrationTableViewCellWithtextField()
                cell.fill()
                cell.textField.placeholder = placeholder
                cell.textField.autocorrectionType = .no
                cell.textField.autocapitalizationType = .none
                cell.textField.keyboardType = .decimalPad
                cell.selectionStyle = .none
                
                cell.textField.rx.text.orEmpty.bind { text in
                    LocalbaseManager.salary.accept(Int(text))
                }.disposed(by: bag)
                
                return cell
                
            case .textView(let placeholder):
                let cell = ExtraCellWithArrayOfStrings(style: .value1, reuseIdentifier: nil)
                cell.data.append(placeholder)
                cell.textLabel?.text = placeholder
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                
                if placeholder == .objective && LocalbaseManager.target.value != nil {
                    cell.detailTextLabel?.text = "Готово"
                } else if placeholder == .extraInformation && LocalbaseManager.extra.value != nil {
                    cell.detailTextLabel?.text = "Готово"
                }
                
                
                return cell
                
            case .expanded(let data, let first, let second, let third):
                let cell = ExtraCellWithArrayOfStrings(style: .value1, reuseIdentifier: nil)
                cell.data.append(data)
                cell.data1 = first
                cell.data2 = second
                cell.data3 = third
                cell.textLabel?.text = data
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                return cell
                
            case .many(let title, let placeholder, let buttonTitle):
                let cell = ExtraCellWithArrayOfStrings(style: .value1, reuseIdentifier: nil)
                cell.data.append(title)
                cell.data1.append(placeholder)
                cell.data2.append(buttonTitle)
                cell.textLabel?.text = title
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                return cell
                
            case .tag:
                let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
                if let tags = LocalbaseManager.tags.value?.count {
                    cell.detailTextLabel?.text = "\(tags)"
                }
                cell.textLabel?.text = .tags
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.textColor = .blue
                cell.textLabel?.font = .preferredFont(forTextStyle: .headline)
                return cell
            }
            
        case .hr:
            switch indexPath.row {
            default: break
            }
        }
        
        return UITableViewCell()
    }
}

extension ExtraViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.editedImage] as? UIImage {
            mainView.avatar.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

enum ExtraField {
    case textField(placeholder: String)
    case tag  // Кнопка
    case switcher(title: String)
    case multiple(title: String, data: [String]) // Кнопка
    case number(placeholder: String)
    case textView(placeholder: String) // Кнопка
    case expanded(data: String, first: [String], second: [String], third: [String]) // Кнопка
    case many(title: String, placeholder: String, buttonTitle: String) // Кнопка скиллы
}

extension ExtraViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("123")
        mainView.tableView.reloadData()
    }
}
