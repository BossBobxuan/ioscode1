//
//  Model.swift
//  quiz
//
//  Created by bossxuan on 16/11/9.
//  Copyright © 2016年 bossxuan. All rights reserved.
//

import Foundation
protocol ModelDelegate {
    func settingsChanged()
}
class Model {
    private let regionsKey = "FlagQuizKeyRegions"
    private let guessesKey = "FlagQuizKeyGuesses"
    private var delegate : ModelDelegate! = nil
    var numberOfGuesses = 4
    private var enabledRegions = ["Afica":false,"Asia":false,"Europe":false,"North_America":true,"Oceania":false,"South_America":false]
    let numberOfQuestions = 10
    private var allCountries: [String] = []
    private var countriesInEnabledRegions: [String] = []
    init (delegate : ModelDelegate, numberOfQuestions : Int)
    {
        self.delegate = delegate
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let tempGuesses = userDefaults.integerForKey(guessesKey)
        if tempGuesses != 0
        {
            numberOfGuesses = tempGuesses
        }
        if let tempRegions = userDefaults.dictionaryForKey(regionsKey)
        {
            self.enabledRegions = tempRegions as! [String: Bool]
        }
        let paths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: nil) as [String]
        
        for path in paths
        {
            let url = NSURL(fileURLWithPath: path)
            if !url.lastPathComponent!.hasPrefix("AppIcon")
            {
                allCountries.append(url.lastPathComponent!)
            }
        }
        regionsChanged()
    }
   func regionsChanged()
   {
        countriesInEnabledRegions.removeAll()
        for filename in allCountries
        {
            let region = filename.componentsSeparatedByString("-")[0]
            if enabledRegions[region]!
            {
                countriesInEnabledRegions.append(filename)
            }
        }
   }
    var regions : [String : Bool]
        {
        return enabledRegions
    }
    var enabledRegionCountries : [String]
        {
        return countriesInEnabledRegions
    }
    func toggleRegion(name : String) -> Void {
        enabledRegions[name] = !(enabledRegions[name]!)
        NSUserDefaults.standardUserDefaults().setObject(enabledRegions as NSDictionary, forKey: regionsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
        regionsChanged()
    }
    func setNumberOfGuesses(guesses : Int) -> Void {
        numberOfGuesses = guesses
        NSUserDefaults.standardUserDefaults().setInteger(numberOfGuesses, forKey: guessesKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    func notifyDelegate()
    {
        delegate!.settingsChanged()
    }
    func newQuizCountries() -> [String]
    {
        var quizCountries : [String] = []
        var FlagCounter = 0
        while FlagCounter < numberOfQuestions
        {
            let randomIndex = Int(arc4random_uniform(UInt32(enabledRegionCountries.count)))
            let filename = enabledRegionCountries[randomIndex]
            
            if quizCountries.filter({$0 == filename}).count == 0
            {
                quizCountries.append(filename)
                FlagCounter += 1
            }
        }
        return quizCountries
    }
}

