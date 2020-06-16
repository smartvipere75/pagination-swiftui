//
//  File.swift
//  
//
//  Created by Bezhan Odinaev on 6/16/20.
//

import SwiftUI

/// List with pagination.
public struct PagingList<Content: View, Loader: View, Model: PagingListPresentable>: View {
    /// Model that conforms to PagingListPresentable.
    let model: Model
    /// View that will be shown when page is loading.
    let loader: Loader
    /// Callback that provides index and paging item for each row and returns some view.
    let content: (Int, Model.PagingItem) -> Content
    
    /// Creates a pagination list.
    public init(model: Model,
         loader: Loader,
         @ViewBuilder _ content: @escaping (Int, Model.PagingItem) -> Content) {
        self.model = model
        self.loader = loader
        self.content = content
    }
    
    public var body: some View {
        List(0..<model.pagingItems.count+(self.model.canLoadPage ? 1 : 0), id: \.self) { index in
            if index == self.model.pagingItems.count-1 {
                self.content(index,self.model.pagingItems[index])
                    .buttonStyle(PlainButtonStyle())
                    .onAppear(perform: self.model.startLoadingPage)
            } else {
                if self.model.isLoadingPage {
                    if index == self.model.pagingItems.count {
                        self.loader
                    } else {
                        self.content(index,self.model.pagingItems[index])
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    self.content(index,self.model.pagingItems[index])
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
