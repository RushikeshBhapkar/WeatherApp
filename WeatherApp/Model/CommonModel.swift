//
//  CommonModel.swift
//  Autosearch
//
//  Created by Rushikesh on 03/12/2019.
//  Copyright © 2019 Rushikesh. All rights reserved.
//

import Foundation
/*
 class LocationRepresentation {
 var totalResults: Int?
 var home: String?
 var office: String?
 }
 
 //TODO : Update
 class EmbeddedResource {
 var isSourceAnArray: Bool?
 var name: String?
 }
 
 class Category {
 var id: String?
 var name: String?
 }
 class Position {
 var lat: Double?
 var lon: Double?
 }
 class Region {
 var id: String?
 var name: String?
 }
 
 class CuriesLink {
 var name: String?
 var href: String?
 }
 */

/*
// MARK: - LocationRepresentation
class LocationRepresentation {
    var totalResults: Int?
    var _links: Links?
    var locations: [Location]?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        
        let temp = dict["totalResults"] 
        
        if let data = dict["totalResults"] as? Int {
            self.totalResults = data
        }
        
        if let data = dict["_links"] as? [String:AnyObject] {
            self._links = Links.build(data)
        }
        
        if let locationArray = dict["_embedded"] as? [[String:AnyObject]] {
            
            var locations = Array<Location>()
            for location in locationArray {
                locations.append(Location.build(location))
            }
            
            self.locations = locations
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> LocationRepresentation {
        let locationRepresentation = LocationRepresentation()
        locationRepresentation.loadFromDictionary(dict)
        return locationRepresentation
    }
}

// MARK: - Location
class Location {
    var category: Category?
    var id: String?
    var name: String?
    var position: Position?
    var elevation: Int?
    var timeZone, urlPath: String?
    var country, region, subregion: Category?
    var _links: LocationLinks?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["name"] as? String {
            self.name = data
        }
        if let data = dict["elevation"] as? Int {
            self.elevation = data
        }
        if let data = dict["timeZone"] as? String {
            self.timeZone = data
        }
        if let data = dict["urlPath"] as? String {
            self.urlPath = data
        }
        
        if let data = dict["country"] as? [String:AnyObject] {
            self.country = Category.build(data)
        }
        
        if let data = dict["region"] as? [String:AnyObject] {
            self.region = Category.build(data)
        }
        
        if let data = dict["subregion"] as? [String:AnyObject] {
            self.subregion = Category.build(data)
        }
        
        if let data = dict["_links"] as? [String:AnyObject] {
            self._links = LocationLinks.build(data)
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> Location {
        let location = Location()
        location.loadFromDictionary(dict)
        return location
    }
    
}

// MARK: - Embedded
class Embedded {
    var location: [Location]?
    
}

// MARK: - Category
class Category {
    var id:String?
    var name: String?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["id"] as? String {
            self.id = data
        }
        if let data = dict["name"] as? String {
            self.name = data
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> Category {
        let category = Category()
        category.loadFromDictionary(dict)
        return category
    }
}

// MARK: - LocationLinks
class LocationLinks {
    var linksSelf, celestialevents, forecast, mapfeature: SelfElement?
    var notifications, extremeforecasts: SelfElement?
    var observations: [SelfElement]?
    var airqualityforecast: SelfElement?
    var now: SelfElement?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["self"] as? [String: AnyObject] {
            self.linksSelf = SelfElement.build(data)
        }
        if let data = dict["celestialevents"] as? [String: AnyObject] {
            self.celestialevents = SelfElement.build(data)
        }
        if let data = dict["forecast"] as? [String: AnyObject] {
            self.forecast = SelfElement.build(data)
        }
        if let data = dict["mapfeature"] as? [String: AnyObject] {
            self.mapfeature = SelfElement.build(data)
        }
        if let data = dict["notifications"] as? [String: AnyObject] {
            self.notifications = SelfElement.build(data)
        }
        if let data = dict["extremeforecasts"] as? [String: AnyObject] {
            self.extremeforecasts = SelfElement.build(data)
        }
        if let data = dict["airqualityforecast"] as? [String: AnyObject] {
            self.airqualityforecast = SelfElement.build(data)
        }
        
        //TODO : observations
    }
    
    class func build(_ dict: [String: AnyObject]) -> LocationLinks {
        let locationLinks = LocationLinks()
        locationLinks.loadFromDictionary(dict)
        return locationLinks
    }
}

// MARK: - Position
class Position {
    var lat, lon: Double?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["lat"] as? Double {
            self.lat = data
        }
        if let data = dict["lon"] as? Double {
            self.lon = data
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> Position {
        let position = Position()
        position.loadFromDictionary(dict)
        return position
    }
}

// MARK: - Links
class Links {
    var linksSelf: SelfElement?
    var page, search: Page?
    var location: [SelfElement]?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["href"] as? [String:AnyObject] {
            self.linksSelf = SelfElement.build(data)
        }
        if let data = dict["page"] as? [String:AnyObject] {
            self.page = Page.build(data)
        }
        if let data = dict["search"] as? [String:AnyObject] {
            self.search = Page.build(data)
        }
        
        if let locationArray = dict["location"] as? [[String:AnyObject]] {
            var locations = Array<SelfElement>()
            
            for location in locationArray {
                locations.append(SelfElement.build(location))
            }
            self.location = locations
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> Links {
        let links = Links()
        links.loadFromDictionary(dict)
        return links
    }
}
// MARK: - SelfElement
class SelfElement {
    var href: String?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["href"] as? String {
            self.href = data
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> SelfElement {
        let selfElement = SelfElement()
        selfElement.loadFromDictionary(dict)
        return selfElement
    }
}

// MARK: - Page
class Page {
    var href: String?
    var templated: Bool?
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
        if let data = dict["href"] as? String {
            self.href = data
        }
        if let data = dict["templated"] as? Bool {
            self.templated = data
        }
    }
    
    class func build(_ dict: [String: AnyObject]) -> Page {
        let page = Page()
        page.loadFromDictionary(dict)
        return page
    }
}
*/
