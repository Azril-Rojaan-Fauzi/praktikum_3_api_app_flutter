import 'package:http/http.dart' as http;
import 'package:api_app/models/post.dart';

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var posts = postFromJson(response.body);

      return posts;
    }

    return null;
  }
}
