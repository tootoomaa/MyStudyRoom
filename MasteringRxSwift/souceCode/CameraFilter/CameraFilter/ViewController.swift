//
//  ViewController.swift
//  CameraFilter
//
//  Created by 김광수 on 2020/10/13.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
  // MARK: - Properties
  let disposeBag = DisposeBag()

  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var applyFilterButton: UIButton!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let navC = segue.destination as? UINavigationController,
          let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("sefue Destination is not found") }
    
    photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
      
      DispatchQueue.main.async {
        self?.updateUI(with: photo)
      }

    }).disposed(by: disposeBag)
  }
  
  @IBAction func applyFilterButtonPressed() {
    
    guard let sourceImage = self.photoImageView.image else { return }
    
//    FilterService().applyFilter(to: sourceImage) { filterImage in
//      DispatchQueue.main.async {
//        self.photoImageView.image = filterImage
//      }
//    }
    
    FilterService().applyFiler(to: sourceImage)
      .subscribe(onNext: { filteredImage in
        
        DispatchQueue.main.async {
          self.photoImageView.image = filteredImage
        }
        
      }).disposed(by: disposeBag)
    
    
  }
  
  private func updateUI(with image: UIImage) {
    self.photoImageView.image = image
    self.applyFilterButton.isHidden = false
  }
}

