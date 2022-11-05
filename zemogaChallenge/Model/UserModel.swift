import Foundation

struct UserModel: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: AddressModel
    let phone, website: String
    let company: CompanyModel
}
