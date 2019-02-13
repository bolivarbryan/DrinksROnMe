import Foundation

struct User: Codable {

    let userID: Int
    let name: String
    var latitude: String
    var longitude: String

    /// Setting 0.0 as default value in case latitude or longitude are over or below the valid range
    var lat: Double {
        guard
            let value = Double(latitude),
            value >= -90,
            value <= 90
            else { return 0 }
        return value
    }

    var long: Double {
        guard
            let value = Double(longitude),
            value >= -180,
            value <= 180
            else {
                assertionFailure("Invalid input for new value")
                return 0
        }
        return value
    }

    var detailedName: String {
        return "(\(userID)) \(name)"
    }

    var compactedCoordinate: String {
        return "(\(latitude), \(longitude))"
    }

    var userLocation: Coordinate {
        return Coordinate(latitude: lat, longitude: long)
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case userID = "user_id"
        case name, longitude
    }

    init(userID: Int, name: String, latitude: String, longitude: String) {
        self.userID = userID
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userID == rhs.userID
    }
}

extension User: Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        return lhs.userID <= rhs.userID
    }

}
