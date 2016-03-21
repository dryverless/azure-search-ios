//
//  MovieCell.swift
//  azure-search-basics
//
//  Created by Mark Hamilton on 3/18/16.
//  Copyright © 2016 dryverless. All rights reserved.
//

import Foundation
import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieCoverImage: UIImageView!
    
    var movie: Movie!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        layer.cornerRadius = 15.0
        
    }
    
    func configureCell(movie: Movie) {
        
        self.movie = movie
        
        self.movieTitleLabel.text = self.movie.title.capitalizedString
        //self.movieCoverImage.image = UIImage(named: "\(self..id)")
        
    }
    
}
