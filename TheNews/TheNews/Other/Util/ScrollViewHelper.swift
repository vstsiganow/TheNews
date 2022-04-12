//
//  ScrollViewHelper.swift
//  TheNews
//
//  Created by vtsyganov on 24.03.2022.
//

import UIKit

class ScrollViewHelper {
    // MARK: - Properties
    enum Direction {
        case up, down
    }
    
    var previousScrollOffset: CGFloat
    
    var scrollDifference: CGFloat {
        return scrollView.contentOffset.y - previousScrollOffset
    }
    
    var moveDirection: Direction {
        return scrollDifference > 0 ? .up : .down
    }
    
    // MARK: - Private Properties
    private let scrollView: UIScrollView
    
    // MARK: - Lifecycle Methods
    init(scrollView: UIScrollView, offset: CGFloat = 0) {
        self.scrollView = scrollView
        previousScrollOffset = offset
    }
}
