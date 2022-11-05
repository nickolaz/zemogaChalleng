import Foundation

struct FavoritePostModel : Codable,Hashable {
    var userId : Int
    var id : Int
    var title : String
    var body : String
    var isFavorite : Bool
}
