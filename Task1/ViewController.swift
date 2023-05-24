import UIKit

final class ViewController: UIViewController {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let side: CGFloat = 36.0
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(
            image: .init(
                systemName: "person.crop.circle.fill",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: side, weight: .regular, scale: .medium)
            )
        )
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        navigationItem.title = "Avatar"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if let navigationBar = navigationController?.navigationBar,
               let navigationBarLargeTitleViewClass = NSClassFromString("_UINavigationBarLargeTitleView"),
               let navigationBarLargeTitleView = navigationBar.subviews.first(where: { $0.isKind(of: navigationBarLargeTitleViewClass.self) }),
               imageView.superview == nil {
                imageView
                    .addToView(navigationBarLargeTitleView)
                    .addConstraints(bottom: 10, trailing: 12)
                    .addSize(width: side, height: side)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = view.bounds.size
        scrollView.contentSize.height *= 2
    }
}
