//
//  MovieCell.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 28.09.2022.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

final class MovieCell: UITableViewCell {
    @IBOutlet weak var theImageView: UIImageView!
    @IBOutlet weak var theTitleLabel: UILabel!
    @IBOutlet weak var theYearLabel: UILabel!
    
    var viewModel: MovieItemViewModel! {
        didSet {
            theImageView.sd_setImage(with: viewModel.imageURL, placeholderImage: nil, options: [.retryFailed, .highPriority])
            theTitleLabel.text = viewModel.item.title
            theYearLabel.text = viewModel.item.year
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        theImageView.image = nil
        theTitleLabel.text = nil
        theYearLabel.text = nil
    }
}
