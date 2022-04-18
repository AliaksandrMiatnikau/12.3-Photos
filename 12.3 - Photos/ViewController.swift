

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    private let imageArray = [
        UIImage(named: "ic_twitter"),
        UIImage(named: "ic_snapchat"),
        UIImage(named: "ic_facebook"),
        UIImage(named: "ic_whatsup"),
        UIImage(named: "ic_youtube")
    ]
    
    private var imageViewArray = [UIImageView]()
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = imageArray[index]
        
        
        
        let leftSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(leftMove))
        leftSwipeRecognizer.direction = .left
        self.view.addGestureRecognizer(leftSwipeRecognizer)
        
        let rightSwipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(rightMove))
        rightSwipeRecognizer.direction = .right
        self.view.addGestureRecognizer(rightSwipeRecognizer)    }
    
    
    
    @objc func leftMove() {
        showPreviousImage()
    }
    
    @objc func rightMove() {
        showNextImage()
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: CGRect(
            x: self.view.frame.size.width,
            y: self.view.frame.size.height / 2 - self.view.frame.size.width / 2,
            width: self.view.frame.size.width,
            height: self.view.frame.size.width)
        )
        self.view.addSubview(imageView)
        return imageView
    }
    
    private func showNextImage() {
        let imageView = createImageView()
        if index < imageArray.count - 1 {
            index += 1
        } else {
            index = 0
        }
        imageView.image = imageArray[index]
        animateImageView(imageView)
        imageViewArray.append(imageView)
    }
    
    private func animateImageView(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.3) {
            imageView.frame.origin.x -= self.view.frame.width
        }
    }
    
    private func showPreviousImage() {
        if index > 0 {
            index -= 1
        } else {
            index = imageArray.count - 1
        }
        checkCountImageViewArray()
    }
    private func checkCountImageViewArray() {
        if imageViewArray.count > 0 {
            let imageView = imageViewArray[imageViewArray.count - 1]
            imageViewArray.removeLast()
            animateImageView(imageView)
        } else {
            let imageView = createImageView()
            imageView.frame.origin.x -= self.view.frame.size.width
            imageView.image = self.imageView.image
            self.imageView.image = imageArray[index]
            animateImageView(imageView)
        }
    }
}
