//
//  HistoryView.swift
//  GroceryApp
//
//  Created by Zlatina Lilova on 20.02.25.
//
import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        HStack {
            LazyVStack{
                List(viewModel.lists) { list in
                    HStack {
                        Image(systemName: "list.clipboard.fill")
                            .foregroundColor(.primary)
                        
                        Text("Shopping list: \(list)")
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
                    )
                    .onTapGesture { _ in
                        viewModel.toDetail(list)
                    }
                    
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCategories()
            }
        }
    }
}
