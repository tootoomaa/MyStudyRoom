//
//  PhotosCollectionViewController.swift
//  CameraFilter
//
//  Created by 김광수 on 2020/10/13.
//

import Foundation
import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {
  // MARK: - Properties
  private let selectedPhotoSubject = PublishSubject<UIImage>()
  var selectedPhoto: Observable<UIImage> {
    return selectedPhotoSubject.asObservable()
  }
  
  private var images = [PHAsset]()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    populatePhotos()
    
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.images.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    let selectedAsset = self.images[indexPath.item]
    PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [ weak self ] image, info in
      guard let info = info else { return }
      
      let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
      if !isDegradedImage {
        if let image = image {
          self?.selectedPhotoSubject.onNext(image)
          self?.dismiss(animated: true, completion: nil)
        }
      }
     }
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { fatalError("PhotoCollectionViewCell is not found")}
    
    let asset = self.images[indexPath.item]
    
    let manager = PHImageManager.default()
    manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
      DispatchQueue.main.async {
        cell.photoImageView.image = image
      }
    }
    
    return cell
  }
  
  private func populatePhotos() {
    PHPhotoLibrary.requestAuthorization { [ weak self ]status in
      if status == .limited || status == .authorized {
        //access photo from phot library
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        assets.enumerateObjects { (object, count, stop) in
          self?.images.append(object)
        }
        
        self?.images.reverse()
        DispatchQueue.main.async {
          self?.collectionView.reloadData()
        }
      }
    }
  }
}
