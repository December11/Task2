//
//  ItemHeaderTableView.swift
//  Task2
//
//  Created by Alla Shkolnik on 20.07.2022.
//

import UIKit

final class ItemHeaderTableView: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let height = 250.0
    }
    
    private let coverImageView = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(coverImageView)
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Constants.height)
        }
    }
    
    func configure(imageString: String) {
        let url = URL(string: imageString)
        coverImageView.kf.setImage(with: url)
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
    }
}
