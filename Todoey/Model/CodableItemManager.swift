//
//  ItemManager.swift
//  Todoey
//
//  Created by Vinicius Santana on 29/07/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

class CodableItemManager : ItemManager{
    private let dataFilePath : URL?
    private let encoder : PropertyListEncoder
    private let decoder : PropertyListDecoder
    private var itemArray : [Item]!
    
    
    init(){
        dataFilePath =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        encoder = PropertyListEncoder()
        decoder = PropertyListDecoder()
        itemArray = self.loadItems()
    }
    
    private func loadItems() -> [Item] {
        if let encodedItems = getItemsFromFile() {
            return decodeItems(encodedItems)
        }
        
        return [Item]()
    }
    
    
    func getItems() -> [Item]? {
        itemArray
    }
    
    func getItem(at index: Int) -> Item{
        return itemArray[index]
    }
    
    private func getItemsFromFile() -> Data?{
        return try? Data(contentsOf: dataFilePath!)
    }
    
    private func decodeItems(_ data:Data) -> [Item] {
        return try! decoder.decode([Item].self, from: data)
    }
    
    
    func addItem(_ item:Item){
        itemArray.append(item)
        persistData()
    }
    
    func update(_ item: Item, at index: Int){
        itemArray[index] = item
        persistData()
    }
    
    private func persistData(){
        if let data = encodeItems(){
                writeItems(data)
            }
    }
    
    private func encodeItems() -> Data? {
        return try? encoder.encode(itemArray)
    }
    
    private func writeItems(_ data: Data){
        try? data.write(to: dataFilePath!)
    }
}
