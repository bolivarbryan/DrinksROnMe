import Foundation

enum Language: String {
    case invitedUsers = "invitedUsers"
    case notInvitedUsers = "notInvitedUsers"
    case appName = "appName"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}
