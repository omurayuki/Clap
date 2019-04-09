import UIKit

class TimeLineHorizontalController: HorizontalSnappingController {
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(TimeLineCell.self, forCellWithReuseIdentifier: String(describing: TimeLineCell.self))
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension TimeLineHorizontalController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 32
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: TimeLineCell.self), for: indexPath) as? TimeLineCell else { return UICollectionViewCell() }
        return cell
    }
}

extension TimeLineHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return .init(width: view.frame.width - 48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: 0)
    }
}
