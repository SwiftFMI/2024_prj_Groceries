//
//  RoadBlockView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 19.02.25.
//
import SwiftUI

struct RoadBlockView : View {
    
    @StateObject var viewModel: RoadBlockViewModel
    
    var body : some View {
        VStack(alignment: .center, spacing: 32){
            Text("Тhis functionality is reserved only for registered users")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .padding(.top)
                .multilineTextAlignment(.center)

            
            ButtonsToAuth {
                viewModel.toLogin()
            } toRegister: {
                viewModel.toRegister()
            }

        }.padding(24)
    }
}
