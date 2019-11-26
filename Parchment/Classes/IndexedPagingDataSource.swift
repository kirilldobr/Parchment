import Foundation
import UIKit

class IndexedPagingDataSource<T: PagingItem>:
PagingViewControllerInfiniteDataSource where T: Hashable & Comparable {
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, canOpenViewController: UIViewController?) -> Bool where T : PagingItem, T : Comparable, T : Hashable {
        return true
    }
    
  
  var items: [T] = []
  var viewControllerForIndex: ((Int) -> UIViewController?)?
  
  func pagingViewController<U>(
    _ pagingViewController: PagingViewController<U>,
    viewControllerForPagingItem item: U) -> UIViewController? {
    guard let index = items.firstIndex(of: item as! T) else {
        return nil
//      fatalError("pagingViewController:viewControllerForPagingItem: PagingItem does not exist")
    }
    guard let viewController = viewControllerForIndex?(index) else {
        return nil
//       fatalError("pagingViewController:viewControllerForPagingItem: No view controller exist for PagingItem")
    }
    
    return viewController
  }
  
  func pagingViewController<U>(
    _ pagingViewController: PagingViewController<U>,
    pagingItemBeforePagingItem item: U) -> U? {
    guard let index = items.firstIndex(of: item as! T) else { return nil }
    if index > 0 {
      return items[index - 1] as? U
    }
    return nil
  }
  
  func pagingViewController<U>(
    _ pagingViewController: PagingViewController<U>,
    pagingItemAfterPagingItem item: U) -> U? {
    guard let index = items.firstIndex(of: item as! T) else { return nil }
    if index < items.count - 1 {
      return items[index + 1] as? U
    }
    return nil
  }
}
