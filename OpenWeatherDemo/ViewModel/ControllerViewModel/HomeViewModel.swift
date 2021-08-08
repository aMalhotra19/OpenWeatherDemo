//
//  HomeViewModel.swift
//  OpenWeatherDemo
//
//  Created by Anju Malhotra on 8/5/21.
//

import Foundation
import MapKit

protocol RowDisplayable {
    var title: String { get set }
    var rowType: RowType { get }
}
enum RowType: Int, CaseIterable {
    case defaultCell
    case bookmark
}
class HomeViewModel {
    var annotations: [MKAnnotation]
    
    init(annotations: [MKAnnotation] = BookmarkManager.shared.annotations) {
        self.annotations = annotations
    }
    
    var bookmarkCellViewModel: [BookmarkCellViewModel] = []
    
    func configureBookmarkCellViewModel() {
        bookmarkCellViewModel.removeAll()
        for annotation in annotations {
            guard let title = annotation.title else { return }
            let lat = String(annotation.coordinate.latitude)
            let lon = String(annotation.coordinate.longitude)
            let cellViewModel = BookmarkCellViewModel(title: title ?? "", lat: lat, lon: lon)
            bookmarkCellViewModel.append(cellViewModel)
        }
    }
    
    var defaultCellViewModel: DefaultCellViewModel {
        return DefaultCellViewModel(title: "You have not registered any bookmarks. Please add by selecting +")
    }
    
    func numberOfSection() -> Int {
        return RowType.allCases.count
    }
    
    func numberOfRow(for section: Int) -> Int {
        let sectionType = RowType.init(rawValue: section)
        switch sectionType {
        case .bookmark:
            return annotations.count
        case .defaultCell:
            return annotations.count > 0 ? 0 : 1
        case .none:
            return 0
        }
    }
    
    func getViewModel(for indexpath: IndexPath) -> RowDisplayable? {
        let cellType = RowType.init(rawValue: indexpath.section)
        switch cellType {
        case .bookmark:
            return bookmarkCellViewModel[indexpath.row]
        case .defaultCell:
            return defaultCellViewModel
        case .none:
            return nil
        }
    }
}
