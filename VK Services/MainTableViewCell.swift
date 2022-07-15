//
//  UITableViewCell.swift
//  VK Test
//
//  Created by Ilya Vladimirovich on 14.07.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var imageView1 = UIImageView()
    var mainLabel = UILabel()
    var descriptionLabel = UILabel()
    var chevronImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupCellUI()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if isHighlighted {
            self.contentView.backgroundColor = .white.withAlphaComponent(0.2)
        } else {
            self.contentView.backgroundColor = .clear
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView1.image = nil
        mainLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func setupCellUI() {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
                
        contentView.addSubview(imageView1)
        
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            imageView1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView1.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
            imageView1.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75)
        
        ])
        
        mainLabel.numberOfLines = 1
        mainLabel.font = UIFont(name: "Helvetica Neue Regular", size: 20)
        mainLabel.textColor = .white
        mainLabel.textAlignment = .left
        mainLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        
            mainLabel.leadingAnchor.constraint(equalTo: imageView1.trailingAnchor,
                                               constant: contentView.frame.width * 0.05),
            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: contentView.frame.height * 0.3),
            mainLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width * 0.1)
        ])
        
        descriptionLabel.numberOfLines = 3
        descriptionLabel.font = UIFont(name: "Helvetica Neue Light", size: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .left
        descriptionLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            descriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor,
                                               constant: contentView.frame.height * 0.05),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -contentView.frame.height * 0.08)
            
        ])
        
        chevronImageView.image = UIImage(named: "Vector")?.withTintColor(.gray)
        chevronImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(chevronImageView)
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.13),
            chevronImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.13),
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -contentView.frame.width * 0.05)

        ])

                
    }
    
}
