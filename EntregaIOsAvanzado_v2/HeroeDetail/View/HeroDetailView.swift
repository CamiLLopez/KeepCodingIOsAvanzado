//
//  HeroDetailView.swift
//  EntregaIOsAvanzado_v2
//
//  Created by Camila Laura Lopez on 26/2/23.
//

import UIKit

class HeroDetailView: UIView {
    
    let nameLabel = {
        
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel = {
        
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    var photoImageView = {
        
        var imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        
        
        backgroundColor = .white
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        
        addSubview(photoImageView)
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: photoImageView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor,constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 350),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func configure(_ model: HeroModel){
        
        self.nameLabel.text = model.name
        self.descriptionLabel.text = model.description
        self.photoImageView.kf.setImage(with: URL(string: model.photo))
    }
}
