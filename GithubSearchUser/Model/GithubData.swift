//
//  GithubData.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 31, 2018

import Foundation


class GithubData : NSObject, NSCoding{

    var incompleteResults : Bool!
    var items : [GithubItem]!
    var totalCount : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        incompleteResults = dictionary["incomplete_results"] as? Bool
        totalCount = dictionary["total_count"] as? Int
        items = [GithubItem]()
        if let itemsArray = dictionary["items"] as? [[String:Any]]{
            for dic in itemsArray{
                let value = GithubItem(fromDictionary: dic)
                items.append(value)
            }
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if incompleteResults != nil{
            dictionary["incomplete_results"] = incompleteResults
        }
        if totalCount != nil{
            dictionary["total_count"] = totalCount
        }
        if items != nil{
            var dictionaryElements = [[String:Any]]()
            for itemsElement in items {
                dictionaryElements.append(itemsElement.toDictionary())
            }
            dictionary["items"] = dictionaryElements
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        incompleteResults = aDecoder.decodeObject(forKey: "incomplete_results") as? Bool
        items = aDecoder.decodeObject(forKey: "items") as? [GithubItem]
        totalCount = aDecoder.decodeObject(forKey: "total_count") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if incompleteResults != nil{
            aCoder.encode(incompleteResults, forKey: "incomplete_results")
        }
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if totalCount != nil{
            aCoder.encode(totalCount, forKey: "total_count")
        }
    }
}