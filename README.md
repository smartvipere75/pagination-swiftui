# Pagination-SwiftUI

Pagination for SwiftUI.

### Requirements

* Xcode 11
* iOS 13

### Installation

In Xcode go to `File -> Swift Packages -> Add Package Dependency` and paste this repo url `https://github.com/smartvipere75/pagination-swiftui` then `Next -> Branch: master -> Next`  

### Usage

1. `import Pagination_SwiftUI`
2. Create `ObservableObject` and conform to `PagingListPresentable`
3. Call startLoadingPage in your view's `onAppear`

### Example

```
import SwiftUI
import Pagination_SwiftUI

class ItemsViewModel: ObservableObject, PagingListPresentable {
    typealias PagingItem = String
    
    var pagingItems: [String] = []
    // Set to the first page
    var currentPage: Int = 0
    // This must be @Published so that view can reload
    @Published var isLoadingPage: Bool = false
    var canLoadPage: Bool = true
    
    func onPageChange(_ page: Int) {
        isLoadingPage = true
        // Call API here
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // Add new items
            self.pagingItems.append(contentsOf: Array<String>(repeating: "Item", count: 20))
            // Set this to reload view
            
            // Assumming API returns empty array on page 5
            let isSuccess = self.currentPage < 5
            self.stopLoadingPage(success: isSuccess)
        }
    }
}

struct ItemsView: View {
    @ObservedObject var viewModel: ItemsViewModel = ItemsViewModel()
    
    var loader: some View {
        HStack {
            Spacer()
            Text("Loading...")
            Spacer()
        }
    }
    
    var body: some View {
        PagingList(model: viewModel, loader: loader) { index, item in
            Text("\(item) \(index)")
        }.onAppear(perform: viewModel.startLoadingPage)
    }
}

```

### Extra

Follow me on [Twitter](https://twitter.com/smartvipere75) for latest updates.
