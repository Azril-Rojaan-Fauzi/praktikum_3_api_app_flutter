import 'package:flutter/material.dart';
import 'package:api_app/models/post.dart';
import 'package:api_app/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter API Example")),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts![index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    posts![index].body ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
