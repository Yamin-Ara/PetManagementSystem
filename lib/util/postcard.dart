import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_management/providers/user_provider.dart';
import 'package:pet_management/services/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:pet_management/models/user.dart' as model;

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {}
  }

  Future<void> archivePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'isArchived': true});
    } catch (e) {}
  }

  Future<void> unarchivePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .update({'isArchived': false});
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1680521094897-7b161e2b31ee?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=415&q=80'),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ? IconButton(
                        onPressed: () {
                          showDialog(
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shrinkWrap: true,
                                    children: ['Archive', 'Delete', 'Cancel']
                                        .map(
                                          (e) => InkWell(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Text(e),
                                              ),
                                              onTap: () {
                                                switch (e) {
                                                  case 'Archive':
                                                    archivePost(widget
                                                        .snap['postId']
                                                        .toString());
                                                    break;
                                                  case 'Unarchive':
                                                    unarchivePost(widget
                                                        .snap['postId']
                                                        .toString());
                                                    break;
                                                  case 'Delete':
                                                    deletePost(widget
                                                        .snap['postId']
                                                        .toString());
                                                    break;
                                                  default:
                                                    break;
                                                }
                                                Navigator.of(context).pop();
                                              }),
                                        )
                                        .toList()),
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              widget.snap['postUrl'].toString(),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_outline,
                ),
                onPressed: () => const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '120 likes',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 8,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: widget.snap['username'].toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' ${widget.snap['description']}',
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Text(
                      'View all 20 comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                  onTap: () {},
                ),
                Container(
                  child: Text(
                    "28/04/2023",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
