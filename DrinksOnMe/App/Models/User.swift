import Foundation

class User: Codable, Equatable {

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userID == rhs.userID
    }


    let latitude: String
    let userID: Int
    let name: String
    let longitude: String

    var lat: Double {
        return Double(latitude) ?? 0
    }

    var long: Double {
        return Double(longitude) ?? 0
    }

    var detailedName: String {
        return "\(name)  \(userID)"
    }

    var compactedCoordinate: String {
        return "(\(latitude), \(longitude))"
    }

    enum CodingKeys: String, CodingKey {
        case latitude
        case userID = "user_id"
        case name, longitude
    }
}
