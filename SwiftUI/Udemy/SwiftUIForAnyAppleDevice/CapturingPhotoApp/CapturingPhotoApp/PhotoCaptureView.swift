//
//  PhotoCaptureView.swift
//  CapturingPhotoApp
//
//  Created by 김광수 on 2021/12/04.
//

import Foundation
import SwiftUI

struct PhotoCaptureView: View {
    
    @Binding var showImagePicker: Bool
    @Binding var image: Image?
    
    var body: some View {
        ImagePicker(isShown: $showImagePicker, image: $image)
    }
    
}
