//
//  Layout.swift
//  ClonePinterest
//
//  Created by Phan Minh Thang on 8/31/20.
//  Copyright © 2020 Phan Minh Thang. All rights reserved.
//

import UIKit
protocol LayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGSize
    
}

class Layout: UICollectionViewLayout {
     weak var delegate: LayoutDelegate!
      
      var numberOfColumns = 2
      var cellPadding: CGFloat = 3
      
       var cache = [UICollectionViewLayoutAttributes]()
      
       var contentHeight: CGFloat = 0
      
       var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
          return 0
        }
        
        return collectionView.bounds.width
      }
      
      override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
      }
      
      override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
          return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffest = [CGFloat]()
        for column in 0..<numberOfColumns {
          xOffest.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
          
          let indexPath = IndexPath(item: item, section: 0)
          
        let photoSize = delegate.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath)
          
          let cellWidth = columnWidth
        
          var cellHeight = photoSize.height * cellWidth / photoSize.width
          
          cellHeight = cellPadding * 2 + cellHeight
          
          let frame = CGRect(x: xOffest[column], y: yOffset[column], width: cellWidth, height: cellHeight)
          let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
          
          let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
          attributes.frame = insetFrame
          cache.append(attributes)
          
          contentHeight = max(contentHeight, frame.maxY)
          yOffset[column] = yOffset[column] + cellHeight
          
          if numberOfColumns > 1 {
            var isColumnChanged = false
            for index in (1..<numberOfColumns).reversed() {
              if yOffset[index] >= yOffset[index - 1] {
                column = index - 1
                isColumnChanged = true
              }
              else {
                break
              }
            }
            
            if isColumnChanged {
              continue
            }
          }
          
          column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
        
      }
      
      override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
          if attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
          }
        }
        
        return visibleLayoutAttributes
      }
      
      override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
      }
    }

    

