//
//  PostModel.swift
//  Assignment
//
//  Created by Perfect Aduh on 27/02/2019.
//  Copyright © 2019 PAK Consulting. All rights reserved.
//

import Foundation
import Mapper

struct Posts {
    
    var hits: [PostHits]
    
    init(hits: [PostHits]) {
        self.hits = hits
    }
}


extension Posts: Mappable {
    
    init(map: Mapper) throws {
        try hits = map.from("hits")
    }
}



struct PostHits {
    
    var createdAt: String
    var title: String
    var url: String
    
    init(createdAt: String, title: String, url: String) {
        self.createdAt = createdAt
        self.title = title
        self.url = url
    }
}

extension PostHits: Mappable {
    
    init(map: Mapper) throws {
        try createdAt = map.from("created_at")
        try title = map.from("title")
        try url = map.from("url")
    }
}

/*
 
 {
 "created_at": "2019-02-27T17:00:21.000Z",
 "title": "Ask HN: Should an engineering manager convey pressure or absorb it?",
 "url": null,
 "author": "mavsman",
 "points": 1,
 "story_text": "Curious to hear opinions from people in different roles and circumstances.",
 "comment_text": null,
 "num_comments": 1,
 "story_id": null,
 "story_title": null,
 "story_url": null,
 "parent_id": null,
 "created_at_i": 1551286821,
 "_tags": [
 "story",
 "author_mavsman",
 "story_19264623",
 "ask_hn"
 ],
 "objectID": "19264623",
 "_highlightResult": {
 "title": {
 "value": "Ask HN: Should an engineering manager convey pressure or absorb it?",
 "matchLevel": "none",
 "matchedWords": []
 },
 "author": {
 "value": "mavsman",
 "matchLevel": "none",
 "matchedWords": []
 },
 "story_text": {
 "value": "Curious to hear opinions from people in different roles and circumstances.",
 "matchLevel": "none",
 "matchedWords": []
 }
 }
 },
 */
