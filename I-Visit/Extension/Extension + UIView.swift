//
//  Extension + UIView.swift
//  I-Visit
//
//  Created by Suraj Bhatt on 10/12/24.
//

import UIKit
import SwiftUI

extension View {
    func showAlert(title: String, message: String, isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil) -> some View {
        self.alert(isPresented: isPresented) {
            Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text("OK"), action: {
                    onDismiss?() // Call the onDismiss closure if provided
                })
            )
        }
    }
}
