//
//  User.swift
//  ObjectMapperSample
//
//  Created by Hirohisa Kawasaki on 4/28/15.
//  Copyright (c) 2015 Hirohisa Kawasaki. All rights reserved.
//

import Foundation
import ObjectMapper


class MappedUser: Mappable {

    var publicRepos: Int!
    var reposURL : String!

    required init?(_ map: Map) {
        mapping(map)
    }

    // Mappable
    func mapping(map: Map) {
        publicRepos     <- map["public_repos"]
        reposURL        <- map["repos_url"]
    }
}

class User {

    let publicRepos: Int
    let reposURL : String

    init(user: MappedUser) {

        publicRepos = user.publicRepos
        reposURL = user.reposURL
    }
}