import Foundation
import Moya

enum IntercomAPIService {
    case customers
}

extension IntercomAPIService: TargetType {

    var baseURL: URL { return URL(string: "https://s3.amazonaws.com/intercom-take-home-test/")! }

    var path: String {
        switch self {
        case .customers:
            return "customers.txt"
        }
    }

    var method: Moya.Method {
        switch self {
        case .customers:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .customers:
            return .requestPlain
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return [:]
    }
}
