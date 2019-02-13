import Foundation

protocol InvitesListViewModelDelegate {
    func usersDidFetch()
}

class InvitesListViewModel {

    var users: [User] = [] {
        didSet {
            invitedUsers = users.filter({
                return self.haversineDinstance(la1: currentRegion.latitude,
                                               lo1: currentRegion.longitude,
                                               la2: $0.lat,
                                               lo2: $0.long)/1000 < 100
            })
                .sorted { (user1, user2) -> Bool in
                    user1.userID < user2.userID
            }

            notInvitedUsers = users.filter { !invitedUsers.contains($0) }

        }
    }

    let currentRegion: Coordinate = Coordinate(latitude: 53.339428,
                                               longitude:  -6.257664)

    fileprivate var invitedUsers: [User] = []
    fileprivate var notInvitedUsers: [User] = []

    var groupedUsers: [[User]] {
        return [invitedUsers, notInvitedUsers]
    }

    var delegate: InvitesListViewModelDelegate? = nil

    func listUsersInRegion(place: Coordinate) -> [User] {
        return users.filter({
            return self.haversineDinstance(la1: place.latitude,
                                           lo1: place.longitude,
                                           la2: $0.lat,
                                           lo2: $0.long)/1000 < 100
        })
            .sorted { (user1, user2) -> Bool in
                user1.userID < user2.userID
        }
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

    func haversineDinstance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {

        let haversin = { (angle: Double) -> Double in
            return (1 - cos(angle))/2
        }

        let ahaversin = { (angle: Double) -> Double in
            return 2*asin(sqrt(angle))
        }

        let dToR = { (angle: Double) -> Double in
            return (angle / 360) * 2 * .pi
        }

        let lat1 = dToR(la1)
        let lon1 = dToR(lo1)
        let lat2 = dToR(la2)
        let lon2 = dToR(lo2)

        return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))/2
    }
}
