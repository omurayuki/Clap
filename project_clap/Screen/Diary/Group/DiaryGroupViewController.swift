import Foundation
import UIKit
import RxSwift
import RxCocoa

class DiaryGroupViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var timelineBtnCenter: CGPoint = CGPoint(x: 340, y: 595)
    private var memberAddingBtnCenter: CGPoint = CGPoint(x: 240, y: 694)
    private var isSelected = false
    
    private lazy var menuBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle(R.string.locarizable.eventAddTitle(), for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var memberAddingBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle("＊", for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var timelineBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppResources.ColorResources.deepBlueColor
        button.setTitle("＠", for: .normal)
        button.titleLabel?.font = DisplayCalendarResources.Font.eventAddBtnFont
        button.layer.cornerRadius = DisplayCalendarResources.View.eventAddBtnCornerLayerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var viewTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        return gesture
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.addGestureRecognizer(viewTapGesture)
        setupViewModel()
        saveBtnPosition()
        moveMenuBtnPosition()
        hiddenBtn()
    }
}

extension DiaryGroupViewController {
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        navigationItem.title = R.string.locarizable.group()
        view.addSubview(menuBtn)
        menuBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        menuBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(memberAddingBtn)
        memberAddingBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        memberAddingBtn.rightAnchor.constraint(equalTo: menuBtn.leftAnchor, constant: -50).isActive = true
        memberAddingBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        memberAddingBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(timelineBtn)
        timelineBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        timelineBtn.bottomAnchor.constraint(equalTo: menuBtn.topAnchor, constant: -50).isActive = true
        timelineBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        timelineBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupViewModel() {
        menuBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.menuBtn.bounce(completion: {
                    self?.selectedTargetMenu()
                })
            }).disposed(by: disposeBag)
        
        memberAddingBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.memberAddingBtn.bounce(completion: {
                    self?.selectedTargetMenu()
                })
            }).disposed(by: disposeBag)
        
        timelineBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.timelineBtn.bounce(completion: {
                    self?.selectedTargetMenu()
                    guard let `self` = self?.navigationController else { return }
                    `self`.pushViewController(TimelineViewController(), animated: true)
                })
            }).disposed(by: disposeBag)
        
        viewTapGesture.rx.event
            .bind(onNext: { [weak self] _ in
                UIView.animate(withDuration: 0.5) {
                    self?.moveMenuBtnPosition()
                    self?.hiddenBtn()
                }
            }).disposed(by: disposeBag)
    }
    
    private func selectedTargetMenu() {
        if isSelected {
            UIView.animate(withDuration: 0.5) {
                self.moveMenuBtnPosition()
                self.hiddenBtn()
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.moveBtnPosition()
                self.showBtn()
            }
        }
        isSelected = !isSelected
    }
    
    private func showBtn() {
        memberAddingBtn.alpha = 1
        timelineBtn.alpha = 1
    }
    
    private func hiddenBtn() {
        memberAddingBtn.alpha = 0
        timelineBtn.alpha = 0
    }
    
    private func saveBtnPosition() {
    }
    
    private func moveBtnPosition() {
        memberAddingBtn.center = memberAddingBtnCenter
        timelineBtn.center = timelineBtnCenter
    }
    
    private func moveMenuBtnPosition() {
        memberAddingBtn.center = menuBtn.center
        timelineBtn.center = menuBtn.center
    }
}
