//
//  ProfileTableViewCell.swift
//  MorpheusTechTask
//
//  Created by Jack Bridges on 06/10/2020.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileDistanceLabel: UILabel!
    @IBOutlet weak var profileContactButton: UIButton!
    @IBOutlet weak var profileStarStackView: UIStackView!
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var colouredBackgroundSegmentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.colouredBackgroundSegmentView.backgroundColor = Constants.Colours.backgroundGrayColor
        self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.height / 2
        self.numberOfReviewsLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.numberOfReviewsLabel.textColor = .gray
        self.profileDistanceLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        self.profileDistanceLabel.textColor = .gray
        
        self.profileContactButton.backgroundColor = Constants.Colours.blueColor
        self.profileContactButton.setTitleColor(.white, for: .normal)
        self.profileContactButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.profileContactButton.layer.cornerRadius = 4
    }
    
    func showStars(rating: Int) {
        if rating == 1 {
            self.firstStarImageView.image = UIImage(imageLiteralResourceName: "star")
            self.secondStarImageView.image = UIImage(imageLiteralResourceName: "outlineStar")
            self.thirdStarImageView.image = UIImage(imageLiteralResourceName: "outlineStar")
        } else if rating == 2 {
            self.firstStarImageView.image = UIImage(imageLiteralResourceName: "star")
            self.secondStarImageView.image = UIImage(imageLiteralResourceName: "star")
            self.thirdStarImageView.image = UIImage(imageLiteralResourceName: "outlineStar")
        } else if rating == 3 {
            self.firstStarImageView.image = UIImage(imageLiteralResourceName: "star")
            self.secondStarImageView.image = UIImage(imageLiteralResourceName: "star")
            self.thirdStarImageView.image = UIImage(imageLiteralResourceName: "star")
        }
    }
    
    func showFormattedDistance(distance: String) -> String {
        let distanceSplit = distance.split(separator: "m")
        if let distanceFigure = distanceSplit.first {
            var distanceFormat = "{DISTANCE} miles away"
            distanceFormat = distanceFormat.replacingOccurrences(of: "{DISTANCE}", with: String(distanceFigure))
            return distanceFormat
        }
        return ""
    }
    
    deinit {
        self.profileImageView.image = nil
        self.firstStarImageView.image = nil
        self.secondStarImageView.image = nil
        self.thirdStarImageView.image = nil
    }
}
