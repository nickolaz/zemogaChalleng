import SwiftUI

struct PostView: View {
    @State var post : FavoritePostModel
    @EnvironmentObject var allPost : PostViewModel
    
    func deleteItem(){
        if let index = allPost.favorites.firstIndex(where: { fav in
            fav.id == post.id
        }) {
            allPost.favorites.remove(at: index)
        }
        if let index = allPost.favoritePosts.firstIndex(where: { fav in
            fav.id == post.id
        }) {
            allPost.favoritePosts.remove(at: index)
        }
    }
    
    var body: some View {
        NavigationLink(destination: PostDetailView(post: $post), label: {
            HStack{
                Text(post.title)
                    .font(.body)
                Spacer()
                if post.isFavorite {
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                }
            }.swipeActions {
                Button(role: .destructive, action: deleteItem) {
                    Label("Delete", systemImage: "trash")
                }
            }
        })
    }
}

struct PostView_Previews: PreviewProvider {
    @State static var post : FavoritePostModel = FavoritePostModel(userId: 1, id: 1, title: "Example Post", body: "This is a example post",isFavorite: false)
    static var previews: some View {
        PostView(post: post)
    }
}
