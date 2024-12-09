//
//  LoaderView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import Foundation
import SwiftUI
import UIKit

struct LoaderView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
        if isLoading {
            ZStack {
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .frame(width: 100, height: 100) // Adjust the width and height as needed
                    .opacity(0.3)
                
                ProgressView("")
                    .progressViewStyle(CircularProgressViewStyle(tint: .black.opacity(0.5)))
                    .scaleEffect(2.0) // Adjust the scale factor to increase the indicator size
                    .frame(width: 80, height: 75) // Match the size of the outer circle
                    .padding(.top,25)
            }
            
            .background(Color.gray.opacity(0.5))
            .edgesIgnoringSafeArea(.all)
            .cornerRadius(10)
        }
    }
}
