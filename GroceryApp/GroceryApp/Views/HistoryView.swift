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
        VStack{
            List(viewModel.lists.sorted(by: { $0.date > $1.date }), id: \.id) { list in
                HStack {
                    Image(systemName: "list.clipboard.fill")
                        .foregroundColor(.primary)

                    Text("Shopping list: \(list.date, formatter: viewModel.dateFormatter)")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)

                }
                .onTapGesture { _ in
                    viewModel.toDetail(list)
                }

            }
        }.task {
            await viewModel.fetchHistoryLists()
        }
    }
}
