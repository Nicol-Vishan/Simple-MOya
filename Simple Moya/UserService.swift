//
//  UserService.swift
//  Simple Moya
//
//  Created by Nicol Vishan on 04/10/21.
//

import Foundation
import Moya

enum UserServices {
    case createUser(name: String)
    case readUsers
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

extension UserServices: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { return URL(string: "")!}
        return url
    }

    var path: String {
        switch self {
            case .createUser(_), .readUsers:
                return "/users"
            case .updateUser(let id,_), .deleteUser(let id):
                return "/users/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
            case .createUser(_):
                return .post

            case .readUsers:
                return .get

            case .updateUser(_, _):
                return .put

            case .deleteUser(_):
                return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
            case .deleteUser(_), .readUsers:
                return .requestPlain
            case .createUser(let name), .updateUser(_, let name):
                return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Type":"application/json"]
    }


}
