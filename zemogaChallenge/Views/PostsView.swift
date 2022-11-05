import SwiftUI

struct PostsView: View {
    @ObservedObject var allPost = PostViewModel() 
    @State var posts : [FavoritePostModel] = []
    
    private var filteredContacts: [Binding<FavoritePostModel>] {
        let postBindingsArr = $allPost.favoritePosts.map {$post in return $post}
        let postWithOuthFav = postBindingsArr.filter { post in
            !allPost.favorites.contains(where: { fav in
                fav.id == post.wrappedValue.id
            })
        }
        var postFavBindingsArr = $allPost.favorites.map {$post in return $post}
        postFavBindingsArr.append(contentsOf: postWithOuthFav)
        return postFavBindingsArr
    }
    
    func refresh() {
        allPost.getPosts()
    }
    
    func removeAll() {
        allPost.favoritePosts.removeAll()
    }
    
    var body: some View {
        NavigationStack{
            List(filteredContacts,id: \.self.wrappedValue.id){
                $post in
                PostView(post: post)
            }.toolbar {
                Button(action: removeAll) {
                    Label("Delete", systemImage: "trash")
                }
            }.refreshable(action: refresh)
            .navigationTitle("Posts")
        }.environmentObject(allPost)
    }
}

struct PostsView_Previews: PreviewProvider {
    static var previews: some View {
        PostsView()
    }
}
