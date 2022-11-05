import SwiftUI

struct CommentsView: View {
    @EnvironmentObject var allPost : PostViewModel
    
    var body: some View {
        Text("Comments:")
            .font(.title2)
            .foregroundColor(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
        ScrollView{
            ForEach(allPost.comments, id: \.self){
                comment in
                VStack(alignment: .leading, spacing: 5){
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .top)
                        VStack(alignment: .leading, spacing: 5){
                            HStack{
                                Text("Name:").foregroundColor(.blue).bold()
                                Text(comment.name)
                            }
                            HStack{
                                Text("email:").foregroundColor(.blue).bold()
                                Text(comment.email)
                            }
                        }
                    }
                    Text(comment.body)
                    Divider()
                }
            }
        }.frame(height: 300, alignment: .center)
    }
}

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
