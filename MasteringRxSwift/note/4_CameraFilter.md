# CameraFilter

- 사진을 불러와 필터를 적용하는 앱으로 해당앱에서 RxSwift가 사용되는 방식을 확인해본다.



## 구현 화면

- 사용자가 사진을 선택하면 이전 화면의 ImageView에 보여지고, ApplyFilter버튼을 통해서 필터를 적용하게 됨

![camerafilter_play](../image/camerafilter_play.gif)

## 구현 코드

- 위 화면에서 실제로 RxSwift가 사용되는 부분은 사용자가 사진 리스트( collectionView)에서 사진을 선택했을때 해당 사진을 이전화면의 UIImageView에 보여주는 부분이다,

### ViewController 

- **Prepare**

  - ```swift
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else { fatalError("sefue Destination is not found") }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in  // subscribe!
          DispatchQueue.main.async {
            self?.updateUI(with: photo)
          }
        }).disposed(by: disposeBag)
      }
    ```

  - phtotosCVC ( CollevtionVC )에 있는 옵져버블을 Subscibe하고 있음

  - selectedPhoto 는 `Observable<UIImage>` 

- **Button Action**

  - ```swift
     @IBAction func applyFilterButtonPressed() {
        guard let sourceImage = self.photoImageView.image else { return }
        
    //    //RxSwift가 아닌 일반적인 completion 방식
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
    ```

### CollectionViewController 

- **프로퍼티 부분**

  - ```swift
      private let selectedPhotoSubject = PublishSubject<UIImage>()
      var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
      }
    ```

- **didSelectItemAt 부분**

  - ```swift
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAsset = self.images[indexPath.item]
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [ weak self ] image, info in
          guard let info = info else { return }
          
          let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
          if !isDegradedImage {
            if let image = image {
              self?.selectedPhotoSubject.onNext(image)				// subject로 image 전달
              self?.dismiss(animated: true, completion: nil)
            }
          }
         }
      }
    ```

### Filter Service 부분

- ```swift
  // Observable
  func applyFiler(to inputImage: UIImage) -> Observable<UIImage> {
      return Observable<UIImage>.create { observer in
        
        self.applyFilter(to: inputImage) { filteredImage in
          observer.onNext(filteredImage)
        }
        
        return Disposables.create()
      }
    }
    
  	// completion 방식
    private func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage)->())) {
      
      let filter = CIFilter(name: "CICMYKHalftone")!
      filter.setValue(5.0, forKey: kCIInputWidthKey)
      
      if let sourceImage = CIImage(image: inputImage) {
  
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            
          let processedImage = UIImage(cgImage: cgimg, scale: inputImage.scale, orientation: inputImage.imageOrientation)
          
          completion(processedImage)
        }
      }
    }
  ```