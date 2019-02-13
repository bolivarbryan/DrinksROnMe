import XCTest
@testable import DrinksOnMe

class UserTests: XCTestCase {

    override func setUp() { }

    override func tearDown() { }

    func testUserEqualityMatches() {
        let firstUser = User(userID: 1,
                             name: "Bryan",
                             latitude: "0.0",
                             longitude: "0.0")

        let secondUser = firstUser

        XCTAssertEqual(firstUser, secondUser, "Users contains the same information, but could not be compared. check userID")
    }

    func testUserCoordinatesAreValid() {
        let user = User(userID: 1,
                             name: "Bryan",
                             latitude: "150.0",
                             longitude: "0.0")

        let validLatitude = (user.lat >= -90) && (user.lat <= 90)
        let validLongitude = (user.long >= -180) && (user.long <= 180)

        XCTAssertTrue(validLatitude && validLongitude, "This user's coordinates are not valid, range should be (-90: 90) for latitude and (-180: 180) for longitude. got(\(user.lat), \(user.long))")
    }

}
