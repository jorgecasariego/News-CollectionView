//
//  Publishers.swift
//  PrettyApple
//
//  Created by Duc Tran on 7/21/15.
//  Copyright © 2015 Developer Inspirus. All rights reserved.
//

import UIKit

class Publishers
{
    private var publishers = [Publisher]()
    private var immutablePublishers = [Publisher]()
    private var sections = [String]()
    
    // MARK: - Public
    
    var numberOfPublishers: Int {
        return publishers.count
    }
    
    var numberOfSections: Int {
        return sections.count
    }
    
    init()
    {
        publishers = createPublishers()
        immutablePublishers = publishers
        sections = ["Paraguay", "Deportes", "Politica", "Viajes", "Tecnologia", "Internacional", "Cultura", "Celebridades"]
    }
    
    func deleteItemsAtIndexPaths(indexPaths: [NSIndexPath])
    {
        var indexes = [Int]()
        for indexPath in indexPaths {
            indexes.append(absoluteIndexForIndexPath(indexPath))
        }
        var newPublishers = [Publisher]()
        for (index, publisher) in publishers.enumerate() {
            if !indexes.contains(index) {
                newPublishers.append(publisher)
            }
        }
        publishers = newPublishers
    }
    
    func movePublisherFromIndexPath(indexPath: NSIndexPath, toIndexPath newIndexPath: NSIndexPath) {
        if indexPath != newIndexPath {
            let index = absoluteIndexForIndexPath(indexPath)
            let publisher = publishers[index]
            publisher.section = sections[newIndexPath.section]
            let newIndex = absoluteIndexForIndexPath(newIndexPath)
            publishers.removeAtIndex(index)
            publishers.insert(publisher, atIndex: newIndex)
        }
    }
    
    func indexPathForNewRandomPublisher() -> NSIndexPath
    {
        let index = Int(arc4random_uniform(UInt32(immutablePublishers.count)))
        let publisherToCopy = immutablePublishers[index]
        let newPublisher = Publisher(copies: publisherToCopy)
        publishers.append(newPublisher)
        publishers.sortInPlace { $0.section < $1.section }
        return indexPathForPublisher(newPublisher)
    }
    
    func indexPathForPublisher(publisher: Publisher) -> NSIndexPath
    {
        let section = sections.indexOf(publisher.section)
        var item = 0
        for (index, currentPublisher) in publishersForSection(section!).enumerate() {
            if currentPublisher === publisher {
                item = index
                break
            }
        }
        return NSIndexPath(forItem: item, inSection: section!)
    }
    
    func numberOfPublishersInSection(index: Int) -> Int {
        let publishers = publishersForSection(index)
        return publishers.count
    }
    
    func publisherForItemAtIndexPath(indexPath: NSIndexPath) -> Publisher? {
        if indexPath.section > 0 {
            let publishers = publishersForSection(indexPath.section)
            return publishers[indexPath.item]
        } else {
            return publishers[indexPath.item]
        }
    }
    
    func titleForSectionAtIndexPath(indexPath: NSIndexPath) -> String?
    {
        if indexPath.section < sections.count {
            return sections[indexPath.section]
        }
        return nil
    }
    
    // MARK: - Private
    
    private func createPublishers() -> [Publisher]
    {
        var newPublishers = [Publisher]()
        newPublishers += Paraguay.publishers()
        newPublishers += Deportes.publishers()
        newPublishers += Politics.publishers()
        newPublishers += Travel.publishers()
        newPublishers += Technology.publishers()
        newPublishers += Celebridades.publishers()
        newPublishers += Internacional.publishers()
        newPublishers += Cultura.publishers()
        return newPublishers
    }
    
    private func absoluteIndexForIndexPath(indexPath: NSIndexPath) -> Int
    {
        var index = 0
        for i in 0..<indexPath.section {
            index += numberOfPublishersInSection(i)
        }
        index += indexPath.item
        return index
    }
    
    private func publishersForSection(index: Int) -> [Publisher] {
        let section = sections[index]
        let publishersInSection = publishers.filter {
            (publisher: Publisher) -> Bool in return publisher.section == section
        }
        return publishersInSection
    }
}

class Paraguay
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "ABC Color", url: "http://www.abc.com.py", image: UIImage(named: "abc")!, section: "Paraguay"))
        publishers.append(Publisher(title: "Ultima Hora", url: "http://www.ultimahora.com", image: UIImage(named: "ultimahora")!, section: "Paraguay"))
        publishers.append(Publisher(title: "La Nación", url: "http://www.lanacion.com.py", image: UIImage(named: "lanacion")!, section: "Paraguay"))
        publishers.append(Publisher(title: "Hoy", url: "http://www.hoy.com.py", image: UIImage(named: "hoy")!, section: "Paraguay"))
        publishers.append(Publisher(title: "Extra", url: "http://www.extra.com.py", image: UIImage(named: "extra")!, section: "Paraguay"))
        publishers.append(Publisher(title: "Cronica", url: "http://www.cronica.com.py", image: UIImage(named: "cronica")!, section: "Paraguay"))
        
        return publishers
    }
}

class Deportes
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "Olé", url: "http://www.ole.com.ar", image: UIImage(named: "ole")!, section: "Deportes"))
        publishers.append(Publisher(title: "D10", url: "http://d10.paraguay.com", image: UIImage(named: "d10")!, section: "Deportes"))
        publishers.append(Publisher(title: "Marca", url: "http://www.marca.com", image: UIImage(named: "marca")!, section: "Deportes"))
        publishers.append(Publisher(title: "Tigo sports", url: "http://www.tigosports.com.py", image: UIImage(named: "tigosports")!, section: "Deportes"))
         publishers.append(Publisher(title: "El Grafico", url: "http://www.elgrafico.com.ar", image: UIImage(named: "elgrafico")!, section: "Deportes"))
        return publishers
    }
}


class Politics
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "The Atlantic", url: "http://www.theatlantic.com", image: UIImage(named: "The Atlantic")!, section: "Politica"))
        publishers.append(Publisher(title: "The Hill", url: "http://thehill.com", image: UIImage(named: "The Hill")!, section: "Politica"))
        publishers.append(Publisher(title: "Daily Intelligencer", url: "http://nymag.com/daily/intelligencer/", image: UIImage(named: "Daily Intelligencer")!, section: "Politica"))
        publishers.append(Publisher(title: "Vanity Fair", url: "http://recode.net", image: UIImage(named: "Vanity Fair")!, section: "Politica"))
        publishers.append(Publisher(title: "The Huffington Post", url: "http://www.huffingtonpost.com", image: UIImage(named: "The Huffington Post")!, section: "Politica"))
        return publishers
    }
}

class Travel
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "AFAR", url: "http://www.afar.com", image: UIImage(named: "AFAR")!, section: "Viajes"))
        publishers.append(Publisher(title: "Men’s Journal", url: "http://www.mensjournal.com", image: UIImage(named: "Men’s Journal")!, section: "Viajes"))
        publishers.append(Publisher(title: "Wallpaper", url: "http://www.wallpaper.com", image: UIImage(named: "Wallpaper")!, section: "Viajes"))
        publishers.append(Publisher(title: "Sunset", url: "http://www.sunset.com", image: UIImage(named: "Sunset")!, section: "Viajes"))
        publishers.append(Publisher(title: "Traveler", url: "http://www.traveler.es", image: UIImage(named: "traveler")!, section: "Viajes"))
        return publishers
    }
}

class Technology
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "TED", url: "https://www.ted.com", image: UIImage(named: "TED")!, section: "Tecnologia"))
        publishers.append(Publisher(title: "WIRED", url: "http://www.wired.com", image: UIImage(named: "WIRED")!, section: "Tecnologia"))
        publishers.append(Publisher(title: "Re/code", url: "http://recode.net", image: UIImage(named: "Recode")!, section: "Tecnologia"))
        publishers.append(Publisher(title: "Daring Fireball", url: "http://daringfireball.net", image: UIImage(named: "Daring Fireball")!, section: "Tecnologia"))
        publishers.append(Publisher(title: "MIT Technology Review", url: "http://www.technologyreview.es/?lang=es", image: UIImage(named: "MIT Technology Review")!, section: "Tecnologia"))
        return publishers
    }
}

class Celebridades
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "People", url: "http://www.peopleenespanol.com", image: UIImage(named: "people")!, section: "Celebridades"))
        publishers.append(Publisher(title: "US", url: "http://www.usmagazine.com/celebrity-news", image: UIImage(named: "us")!, section: "Celebridades"))
        publishers.append(Publisher(title: "OK! Magazine", url: "http://radaronline.com", image: UIImage(named: "ok")!, section: "Celebridades"))
        publishers.append(Publisher(title: "Hello", url: "http://www.hellomagazine.com", image: UIImage(named: "hello")!, section: "Celebridades"))
        publishers.append(Publisher(title: "Hola", url: "http://www.hola.com", image: UIImage(named: "hola")!, section: "Celebridades"))
        
        return publishers
    }
}

class Internacional
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "VEJA", url: "http://veja.abril.com.br", image: UIImage(named: "veja")!, section: "Internacional"))
        publishers.append(Publisher(title: "The New York Times", url: "http://www.nytimes.com", image: UIImage(named: "The New York Times")!, section: "Internacional"))
        publishers.append(Publisher(title: "TIME", url: "http://time.com", image: UIImage(named: "TIME")!, section: "Internacional"))
        publishers.append(Publisher(title: "Quartz", url: "http://qz.com", image: UIImage(named: "Quartz")!, section: "Internacional"))
        publishers.append(Publisher(title: "The New Yorker", url: "http://www.newyorker.com", image: UIImage(named: "newyorker")!, section: "Internacional"))
        
        return publishers
    }
}

class Cultura
{
    class func publishers() -> [Publisher]
    {
        var publishers = [Publisher]()
        publishers.append(Publisher(title: "Smithsonian", url: "http://www.smithsonianmag.com/?no-ist", image: UIImage(named: "Smithsonian")!, section: "Cultura"))
        publishers.append(Publisher(title: "WIRED", url: "http://www.wired.com", image: UIImage(named: "WIRED")!, section: "Cultura"))
        publishers.append(Publisher(title: "Rolling Stone", url: "http://www.rollingstone.com", image: UIImage(named: "rollingstone")!, section: "Cultura"))
        publishers.append(Publisher(title: "Rolling Stone Español", url: "http://www.rollingstone.com.ar", image: UIImage(named: "rollingstonespanish")!, section: "Cultura"))
        publishers.append(Publisher(title: "Vanity Fair", url: "http://www.vanityfair.com", image: UIImage(named: "vanityfair")!, section: "Cultura"))
        publishers.append(Publisher(title: "Vanity Fair España", url: "http://www.revistavanityfair.es", image: UIImage(named: "revistavanityfair")!, section: "Cultura"))
        publishers.append(Publisher(title: "Esquire", url: "http://www.esquire.com", image: UIImage(named: "esquire")!, section: "Cultura"))
        publishers.append(Publisher(title: "National Lampoon", url: "http://nationallampoon.com", image: UIImage(named: "nationallampoon")!, section: "Cultura"))
        
        return publishers
    }
}















