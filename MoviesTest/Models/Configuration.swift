//
//  Configuration.swift
//  MoviesTest
//
//  Created by Aleksandr Poliakov on 29.09.2022.
//

import Foundation

struct Configuration: Codable {
    struct Images: Codable {
        enum CodingKeys: String, CodingKey {
            case baseUrl = "base_url"
            case secureBaseUrl = "secure_base_url"
            case backdropSizes = "backdrop_sizes"
            case logoSizes = "logo_sizes"
            case posterSizes = "poster_sizes"
            case profileSizes = "profile_sizes"
            case stillSizes = "still_sizes"
        }
        
        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<Configuration.Images.CodingKeys> = try decoder.container(keyedBy: Configuration.Images.CodingKeys.self)
            self.baseUrl = try container.decodeIfPresent(String.self, forKey: Configuration.Images.CodingKeys.baseUrl)
            self.secureBaseUrl = try container.decodeIfPresent(String.self, forKey: Configuration.Images.CodingKeys.secureBaseUrl)
            self.backdropSizes = try container.decodeIfPresent([String].self, forKey: Configuration.Images.CodingKeys.backdropSizes)
            self.logoSizes = try container.decodeIfPresent([String].self, forKey: Configuration.Images.CodingKeys.logoSizes)
            self.posterSizes = try container.decodeIfPresent([String].self, forKey: Configuration.Images.CodingKeys.posterSizes)
            self.profileSizes = try container.decodeIfPresent([String].self, forKey: Configuration.Images.CodingKeys.profileSizes)
            self.stillSizes = try container.decodeIfPresent([String].self, forKey: Configuration.Images.CodingKeys.stillSizes)
        }
        
        let baseUrl: String?
        let secureBaseUrl: String?
        let backdropSizes: [String]?
        let logoSizes: [String]?
        let posterSizes: [String]?
        let profileSizes: [String]?
        let stillSizes: [String]?
    }
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.images = try container.decodeIfPresent(Configuration.Images.self, forKey: .images)
        self.changeKeys = try container.decodeIfPresent([String].self, forKey: .changeKeys)
    }
    
    let images: Images?
    let changeKeys: [String]?
}
