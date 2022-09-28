//
//  AutosizableListSectionController.swift
//  ILSS
//
//  Created by Antol Peshkov on 26/01/2018.
//  Copyright © 2018 madbrains. All rights reserved.
//

import IGListKit

class AutosizableListSectionController<Cell: UICollectionViewCell>: ListSectionController {
    
    var sizingCell: Cell?
    
    override func sizeForItem(at index: Int) -> CGSize {
        if sizingCell == nil {
            guard let cell = Bundle.main.loadNibNamed(nibName(), owner: self, options: nil)?.first as? Cell else {
                fatalError()
            }
            sizingCell = cell
        }
        
        guard let sizingCell = sizingCell else {
            fatalError()
        }
        
        configure(cell: sizingCell)
        
        sizingCell.bounds = CGRect(origin: CGPoint(x: 0, y: 0), size: collectionContext!.containerSize)
        sizingCell.setNeedsLayout()
        sizingCell.layoutIfNeeded()
        let height = sizingCell.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        return CGSize(width: collectionContext!.containerSize.width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext!.dequeueReusableCell(withNibName: nibName(), bundle: Bundle.main, for: self, at: index) as? Cell else {
            fatalError()
        }
        configure(cell: cell)
        return cell
    }
    
    func configure(cell: Cell) {
        fatalError("Should be overrided")
    }
    
    func nibName() -> String {
        fatalError("Should be overrided")
    }
}
