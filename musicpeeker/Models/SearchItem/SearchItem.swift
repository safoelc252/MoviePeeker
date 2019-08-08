//
//  SearchItem.swift
//  musicpeeker
//
//  Created by Cleofas Villarin on 08/08/2019.
//  Copyright © 2019 appetiserco. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchItem: ImmutableMappable {
    var wrapperType : String?
    var kind : String?
    var artistId : Int?
    var collectionId : Int?
    var trackId : Int?
    var artistName : String?
    var collectionName : String?
    var trackName : String?
    var collectionCensoredName : String?
    var trackCensoredName : String?
    var artistViewUrl : String?
    var collectionViewUrl : String?
    var trackViewUrl : String?
    var previewUrl : String?
    var artworkUrl30 : String?
    var artworkUrl60 : String?
    var artworkUrl100 : String?
    var collectionPrice : Double?
    var trackPrice : Double?
    var releaseDate : String?
    var collectionExplicitness : String?
    var trackExplicitness : String?
    var discCount : Int?
    var discNumber : Int?
    var trackCount : Int?
    var trackNumber : Int?
    var trackTimeMillis : Int?
    var country : String?
    var currency : String?
    var primaryGenreName : String?
    var contentAdvisoryRating : String?
    var isStreamable : Bool?

     init(map: Map) throws {
        wrapperType          = try? map.value("wrapperType")
        kind                 = try? map.value("kind")
        artistId             = try? map.value("artistId")
        collectionId         = try? map.value("collectionId")
        trackId              = try? map.value("trackId")
        artistName           = try? map.value("artistName")
        collectionName       = try? map.value("collectionName")
        trackName            = try? map.value("trackName")
        collectionCensoredName = try? map.value("collectionCensoredName")
        trackCensoredName    = try? map.value("trackCensoredName")
        artistViewUrl        = try? map.value("artistViewUrl")
        collectionViewUrl    = try? map.value("collectionViewUrl")
        trackViewUrl         = try? map.value("trackViewUrl")
        previewUrl           = try? map.value("previewUrl")
        artworkUrl30         = try? map.value("artworkUrl30")
        artworkUrl60         = try? map.value("artworkUrl60")
        artworkUrl100        = try? map.value("artworkUrl100")
        collectionPrice      = try? map.value("collectionPrice")
        trackPrice           = try? map.value("trackPrice")
        releaseDate          = try? map.value("releaseDate")
        collectionExplicitness = try? map.value("collectionExplicitness")
        trackExplicitness    = try? map.value("trackExplicitness")
        discCount            = try? map.value("discCount")
        discNumber           = try? map.value("discNumber")
        trackCount           = try? map.value("trackCount")
        trackNumber          = try? map.value("trackNumber")
        trackTimeMillis      = try? map.value("trackTimeMillis")
        country              = try? map.value("country")
        currency             = try? map.value("currency")
        primaryGenreName     = try? map.value("primaryGenreName")
        contentAdvisoryRating = try? map.value("contentAdvisoryRating")
        isStreamable         = try? map.value("isStreamable")
    }

    mutating func mapping(map: Map) {
        wrapperType          <- map["wrapperType"]
        kind                 <- map["kind"]
        artistId             <- map["artistId"]
        collectionId         <- map["collectionId"]
        trackId              <- map["trackId"]
        artistName           <- map["artistName"]
        collectionName       <- map["collectionName"]
        trackName            <- map["trackName"]
        collectionCensoredName <- map["collectionCensoredName"]
        trackCensoredName    <- map["trackCensoredName"]
        artistViewUrl        <- map["artistViewUrl"]
        collectionViewUrl    <- map["collectionViewUrl"]
        trackViewUrl         <- map["trackViewUrl"]
        previewUrl           <- map["previewUrl"]
        artworkUrl30         <- map["artworkUrl30"]
        artworkUrl60         <- map["artworkUrl60"]
        artworkUrl100        <- map["artworkUrl100"]
        collectionPrice      <- map["collectionPrice"]
        trackPrice           <- map["trackPrice"]
        releaseDate          <- map["releaseDate"]
        collectionExplicitness <- map["collectionExplicitness"]
        trackExplicitness    <- map["trackExplicitness"]
        discCount            <- map["discCount"]
        discNumber           <- map["discNumber"]
        trackCount           <- map["trackCount"]
        trackNumber          <- map["trackNumber"]
        trackTimeMillis      <- map["trackTimeMillis"]
        country              <- map["country"]
        currency             <- map["currency"]
        primaryGenreName     <- map["primaryGenreName"]
        contentAdvisoryRating <- map["contentAdvisoryRating"]
        isStreamable         <- map["isStreamable"]
    }
}
