//
//  PriceListCell.swift
//  Bitcoin History
//
//  Created by Vitaliy Ampilogov on 6/9/19.
//  Copyright © 2019 Vitaliy Ampilogov. All rights reserved.
//

import UIKit

class PriceListCell: UITableViewCell {
    
    func configure(with model: PriceModel) {
        textLabel?.text = model.title
        detailTextLabel?.text = model.value
    }
}
