//
//  File.swift
//  
//
//  Created by Bezhan Odinaev on 6/16/20.
//

import Foundation

/// Pagination protocol for ObservableObject models.
public protocol PagingListPresentable: class {
    /// Type of paginated data.
    associatedtype PagingItem: Equatable
    /// A list of paginated data.
    var pagingItems: [PagingItem] { get set }
    /// Value that indicates current page.
    var currentPage: Int { get set }
    /// Boolean that indicates whether there is any page loading.
    var isLoadingPage: Bool { get set }
    /// Boolean that indicates whether pagination can load more pages.
    var canLoadPage: Bool { get set }
    /// Function that's called when new page should start loading.
    func onPageChange(_ page: Int)
}

public extension PagingListPresentable {
    /// Function to start loading page.
    func startLoadingPage() {
        if !isLoadingPage && canLoadPage {
            isLoadingPage = true
            currentPage += 1
            onPageChange(currentPage)
        }
    }
    /// Function that stops loading page. A value success indicates whether more pages can be loaded.
    func stopLoadingPage(success: Bool) {
        isLoadingPage = false
        canLoadPage = success
    }
    /// Function that resets page to the first.
    func resetPage() {
        currentPage = 1
        canLoadPage = true
        onPageChange(currentPage)
    }
    /// Function that clears paging.
    func clearPaging() {
        currentPage = 0
        canLoadPage = true
        isLoadingPage = false
    }
}
