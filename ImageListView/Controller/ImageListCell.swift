//
//  ImageListCell.swift
//  ImageListView
//
//  Created by Pravin.nagargoje on 03/04/22.
//

import UIKit
import Kingfisher
import SnapKit

class ImageListCell: UITableViewCell {

    var dataImageView = UIImageView()
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var cellViewModel: CellData? {
        didSet {
            titleLabel.text = cellViewModel?.cellTitle
            descriptionLabel.text = cellViewModel?.cellDescription
            dataImageView.kf.setImage(with: URL(string: cellViewModel?.cellImage ?? ""), placeholder: UIImage(named: Constants.placeHolderImage))
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dataImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        formatImageView()
        formatDescriptionLabel()
        self.setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageListCell {
    
    // Format description text
    private func formatDescriptionLabel() {
        descriptionLabel.textColor = .gray
        descriptionLabel.sizeToFit()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Format cell image
    private func formatImageView() {
        dataImageView.layer.cornerRadius = 4.0
        dataImageView.clipsToBounds = true
        dataImageView.backgroundColor = .lightGray
    }
    
    // Set cell constraints
    private func setConstrains() {
        dataImageView.snp.makeConstraints({ make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        })
        titleLabel.snp.makeConstraints({ make in
            make.top.equalTo(dataImageView.snp.top)
            make.left.equalTo(dataImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
        })
        descriptionLabel.snp.makeConstraints({ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(dataImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        })
    }
}
