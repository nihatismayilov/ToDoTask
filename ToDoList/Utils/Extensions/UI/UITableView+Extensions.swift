//
//  UITableView+Extensions.swift
//  presentation
//
//  Created by Nihad Ismayilov on 23.07.24.
//

import UIKit

extension UITableView{
    func addCell<Cell: UITableViewCell>(type: Cell.Type){
        register(type, forCellReuseIdentifier: String(describing: type))
    }
    func getCell<Cell: UITableViewCell>(type: Cell.Type) -> Cell{
        return dequeueReusableCell(withIdentifier: String(describing: type)) as! Cell
    }
}
