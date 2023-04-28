import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;
  List<DocumentSnapshot> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    String keyword = _searchController.text.trim();
    if (keyword.isNotEmpty) {
      List<DocumentSnapshot> results = await searchPosts(keyword);
      setState(() {
        _searchResults = results;
      });
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  Future<List<DocumentSnapshot>> searchPosts(String keyword) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('posts')
        .where('description', isGreaterThanOrEqualTo: keyword)
        .where('description', isLessThan: keyword + 'z')
        .get();
    return querySnapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
          onChanged: (_) => _performSearch(),
        ),
        actions: [
          IconButton(
            onPressed: () => _performSearch(),
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _searchResults.isNotEmpty
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                DocumentSnapshot post = _searchResults[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to post details screen
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(post['imageUrl'].toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            post['description'],
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text('No results found.'),
            ),
    );
  }
}
