import UIKit
import RxSwift
import RxCocoa

class TimeLineViewController: BaseListController {
    
    private let disposeBag = DisposeBag()
    private var isSelected = false
    
    private lazy var ui: TimeLineUI = {
        let ui = TimeLineUIImpl()
        ui.viewController = self
        return ui
    }()
    
    private lazy var routing: TimeLineRouting = {
        let routing = TimeLineRoutingImpl2()
        routing.viewController = self
        return routing
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        ui.setup(vc: self)
        hiddenBtn()
        setupViewModel()
    }
}

extension TimeLineViewController {
    
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor(white: 0.98, alpha: 1)
        collectionView.register(TimeLineGroupCell.self, forCellWithReuseIdentifier: String(describing: TimeLineGroupCell.self))
        collectionView.register(TimeLineHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: TimeLineHeaderCell.self))
        collectionView.contentInset = .init(top: 10, left: 0, bottom: -10, right: 0)
    }
    
    private func setupViewModel() {
        ui.menuBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.menuBtn.bounce(completion: {
                    self?.selectedTargetMenu()
                })
            }).disposed(by: disposeBag)
        
        ui.memberBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.ui.memberBtn.bounce(completion: {
                    guard let this = self else { return }
                    this.selectedTargetMenu()
                    this.routing.showDiaryGroup()
                })
            }).disposed(by: disposeBag)
        
        ui.diaryBtn.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.ui.diaryBtn.bounce(completion: {
                    guard let this = self else { return }
                    this.selectedTargetMenu()
                    this.routing.showDiaryRegist()
                })
            }).disposed(by: disposeBag)
    }
    
    private func selectedTargetMenu() {
        if isSelected {
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.7,
                           options: .curveEaseOut,
                           animations: {
                self.ui.hiddenBtnPosition(vc: self)
                self.hiddenBtn()
            })
        } else {
            UIView.animate(withDuration: 0.7,
                           delay: 0,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 0.7,
                           options: .curveEaseOut,
                           animations: {
                self.ui.showBtnPosition(vc: self)
                self.showBtn()
            })
        }
        isSelected = !isSelected
    }
    
    private func showBtn() {
        ui.memberBtn.alpha = 1
        ui.diaryBtn.alpha = 1
    }
    
    private func hiddenBtn() {
        ui.memberBtn.alpha = 0
        ui.diaryBtn.alpha = 0
    }
}

extension TimeLineViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 70)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: TimeLineHeaderCell.self), for: indexPath) as? TimeLineHeaderCell else { return UICollectionReusableView() }
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeLineGroupCell.self), for: indexPath) as? TimeLineGroupCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TimeLineViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
