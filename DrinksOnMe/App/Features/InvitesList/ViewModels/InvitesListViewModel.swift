import Foundation
import CoreLocation

protocol InvitesListViewModelDelegate {
    func usersDidFetch()
}

class InvitesListViewModel {

    private let maxDistanceInKilometers: Double = 100
    private let currentRegion: Coordinate = Coordinate(latitude: 53.339428, longitude:  -6.257664)
    private var invitedUsers: [User] = []
    private var notInvitedUsers: [User] = []
    var delegate: InvitesListViewModelDelegate? = nil

    var users: [User] = [] {
        didSet {
            invitedUsers = users.filter({ user in
                let distanceInMeters = self.distance(from: currentRegion, to: user.userLocation)
                return distanceInMeters/1000 < maxDistanceInKilometers
            })
            .sorted()

            notInvitedUsers = users.filter { !invitedUsers.contains($0) }
        }
    }

    var groupedUsers: [[User]] {
        return [invitedUsers, notInvitedUsers]
    }

    func fetchUsers() {
        let usersEndpoint: String = "https://s3.amazonaws.com/intercom-take-home-test/customers.txt"
        let url = URL(string: usersEndpoint)
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                print(error ?? "Unknown error")
                return
            }

            let contents = String(data: data, encoding: .utf8)
            var result = String(contents!.replacingOccurrences(of: "\n", with: ","))
            result = "[" + result + "]"
            let x = result.data(using: .utf8)

            do {
                let users = try JSONDecoder().decode([User].self, from: x!)
                self.users = users
                self.delegate?.usersDidFetch()
            } catch {
                print(error.localizedDescription)
            }

            }
            .resume()
    }

    func distance(from coordinate1: Coordinate, to coordinate2: Coordinate) -> Double {
        let location1 = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
        let location2 = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
        print(location1.coordinate, location2.coordinate, location1.distance(from: location2))
        return location1.distance(from: location2)
    }
}
