//
//  SplashView.swift
//  GroceriesApp
//
//  Created by Nikolay Dinkov on 9.02.25.
//

import SwiftUI

struct SplashView: View {

    var body: some View {
        VStack {
            Image("Dog")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 416)
                .padding([.trailing, .leading], 20)
        }
    }
}
