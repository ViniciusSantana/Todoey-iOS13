//
//  ItemManager.swift
//  Todoey
//
//  Created by Vinicius Santana on 29/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol ItemManager {
    func getItems() -> [Item]?
    func getItem(at index: Int) -> Item
    func addItem(_ item:Item)
    func update(_ item: Item, at index: Int)
    
}
