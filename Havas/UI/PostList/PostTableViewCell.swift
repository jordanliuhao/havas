//
//  PostTableViewCell.swift
//  Havas
//
//  Created by Jordan Liu on 2021-04-10.
//

import UIKit
import Kingfisher

class PostTableViewCell: UITableViewCell {
    var ups: String? {
        didSet {
            upsLabel.text = ups
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var thumb: PostItem.Image? {
        didSet {
            if let thumb = thumb {
                thumbImageView.kf.setImage(with: URL(string: thumb.url))
                thumbHeight.constant = CGFloat(Int(thumbImageView.bounds.width) * thumb.height / thumb.width)
            } else {
                thumbImageView.image = nil
                thumbHeight.constant = 0
            }
        }
    }
    
    var comment: String? {
        didSet {
            commentLabel.text = comment
        }
    }
    
    @IBOutlet weak var thumbHeight: NSLayoutConstraint!
    @IBOutlet weak var upsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
