//
//  model.swift
//  weibo
//
//  Created by bossxuan on 16/11/8.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import Foundation
protocol ModelDelegate {
    func modelDataChanged() -> Void
    }


class Model {
    private let parisKey = "searchkey"
    private var searches: [String] = []
    
    private let delegate : ModelDelegate
    init(delegate : ModelDelegate)
    {
        self.delegate = delegate
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let paris = userDefaults.arrayForKey(parisKey)        {
            self.searches = paris as! [String]
        }
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateSearches:", name: NSUbiquitousKeyValueStoreDidChangeExternallyNotification, object: NSUbiquitousKeyValueStore.defaultStore())
    }
    func synchronize()
    {
//        NSUbiquitousKeyValueStore.defaultStore().synchronize()
    }
    func stringAtIndex(index : Int) -> String
    {
        return searches[index]
    }
    var count : Int
        {
        return searches.count
    }
    func deleteSearchAtIndex(index : Int) -> Void {
        searches.removeAtIndex(index)
        updateUserDefaults()
    }
    func updateUserDefaults()  {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(searches, forKey: parisKey)
        userDefaults.synchronize()
    }
    func insertSearch(str : String, index : Int?)
    {
        var isequal = false
        for element in searches
        {
            if element == str
            {
                isequal = true
                break;
            }
        }
        if !isequal
        {
            if let inq = index
            {
                searches[inq] = str
                updateUserDefaults()
                delegate.modelDataChanged()
            }
            else
            {
                searches.insert(str, atIndex: 0)
                updateUserDefaults()
                delegate.modelDataChanged()
            }
        }
        
    }
    func move(oldIndex : Int, toDestinationIndex : Int) -> Void {
        let str = searches.removeAtIndex(oldIndex)
        searches.insert(str, atIndex: toDestinationIndex)
        delegate.modelDataChanged()
        updateUserDefaults()
    }
    
    
}