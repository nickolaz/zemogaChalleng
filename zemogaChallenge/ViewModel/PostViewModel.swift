import Foundation

class PostViewModel : ObservableObject {
    @Published var favoritePosts : [FavoritePostModel] = [] 
    @Published var user: UserModel? = nil
    @Published var comments: [CommentsModel] = []
    @Published var favorites : [FavoritePostModel] = []
    var userDefaults = UserDefaults()
    
    init(){
        self.getPosts()
    }
    
    func getPosts(){
        ApiService.getAllPost { result in
            switch result {
                case let .success(post):
                    post.forEach({ post in
                        self.favoritePosts.append(FavoritePostModel(userId: post.userId, id: post.id, title: post.title, body: post.body, isFavorite: false))
                    })
                    self.userDefaults.set(try! JSONEncoder().encode(self.favoritePosts), forKey: "posts")
                case let .failure(error):
                    print("ERROR: \(error)")
                    if self.userDefaults.object(forKey: "posts") != nil {
                        self.favoritePosts =  try! JSONDecoder().decode([FavoritePostModel].self, from: self.userDefaults.object(forKey: "posts") as! Data )
                    }
            }
        }
    }
    
    func getUserInfo(userId: Int){
        ApiService.getUserInfo(userId: userId) { result in
            switch result {
                case let .success(user):
                    self.user = user
                    self.userDefaults.set(try! JSONEncoder().encode(user), forKey: "user")
                case let .failure(error):
                    print("ERROR: \(error)")
                    if self.userDefaults.object(forKey: "user") != nil {
                        self.user =  try! JSONDecoder().decode(UserModel.self, from: self.userDefaults.object(forKey: "user") as! Data )
                    }
            }
        }
    }
    
    func getCommentInfo(postId: Int){
        ApiService.getComments(postId: postId) { result in
            switch result {
                case let .success(comments):
                    self.comments = comments
                    self.userDefaults.set(try! JSONEncoder().encode(comments), forKey: "comments")
                case let .failure(error):
                    print("ERROR: \(error)")
                    if self.userDefaults.object(forKey: "comments") != nil {
                        self.comments =  try! JSONDecoder().decode([CommentsModel].self, from: self.userDefaults.object(forKey: "comments") as! Data )
                    }
            }
        }
    }
    
    func addFavorites(post: FavoritePostModel){
        self.favorites.append(post)
        userDefaults.set(try! JSONEncoder().encode(self.favorites), forKey: "favorites")
    }
    
    func removeFavorite(post: FavoritePostModel){
        if let index = self.favorites.firstIndex(where: { fav in
            fav.id == post.id
        }) {
            self.favorites.remove(at: index)
            userDefaults.set(try! JSONEncoder().encode(self.favorites), forKey: "favorites")
        } else {
            print("Element not is favorite")
        }
    }
}
