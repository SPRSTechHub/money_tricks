// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:money_tricks/screens/single_post.dart';

import '../utils/style.dart';

class PostCards extends StatelessWidget {
  final child;
  const PostCards({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      width: MediaQuery.of(context).size.width,
      height: 260,
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsetsDirectional.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostScreen(
                        titleTag: child['post_title'],
                        postCode: child['post_code'],
                        shareTag: child['post_share'] ?? '0',
                        imgTag: child['post_img'] + child['id'],
                        img: child['post_img']),
                  ),
                );
              },
              child: Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: child['post_img'] + child['id'],
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      child['post_img'],
                      width: MediaQuery.of(context).size.width,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 2, 0, 1),
              child: Text(
                child['post_title'],
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: StyleText.card_title_text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.alarm,
                        color: Colors.black87,
                        size: 18,
                      ),
                      Text(
                        child['post_date'] ?? 'just now',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.heart_1,
                        color: Colors.black87,
                        size: 18,
                      ),
                      Text(
                        child['post_likes'] ?? '...',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.eye,
                        color: Colors.black87,
                        size: 20,
                      ),
                      Text(
                        child['post_likes'] ?? '...',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        LineariconsFree.bullhorn,
                        color: Colors.black87,
                        size: 18,
                      ),
                      Text(
                        child['post_share'] ?? '...',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Inter',
                            fontSize: 14,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////
/*
// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:money_tricks/screens/single_post.dart';

class PostCards extends StatelessWidget {
  final child;
  const PostCards({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 32, 32),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Hero(
        tag: child['post_img'] + child['id'],
        child: Container(
          height: 210,
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.6), BlendMode.softLight),
              image: NetworkImage(child['post_img']),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostScreen(
                              titleTag: child['post_title'],
                              text: child['post_code'],
                              likeTag: child['post_likes'] ?? '0',
                              imgTag: child['post_img'] + child['id'],
                              img: child['post_img']),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4, 2, 4, 0),
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 10, 0, 0),
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundImage:
                                      NetworkImage(child['post_img']),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              child: Text(
                                child['post_title'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 22,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                child['post_desc'].length > 50
                                    ? child['post_desc'].substring(0, 50) +
                                        '...'
                                    : child['post_desc'],
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.black54,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 2, 4),
                          child: lowerBox(
                              child['post_likes'] ?? '100',
                              child['post_likes'] ?? '100',
                              child['post_share'] ?? '100'))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  lowerBox(String s, String t, String u) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Watch button clicked!');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Typicons.heart,
                  size: 28,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$s\n Likes',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Watch button clicked!');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Typicons.stopwatch,
                  size: 28,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$t\n Viewed',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              print('Watch button clicked!');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Typicons.loop_outline,
                  size: 28,
                  color: Colors.white70,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  '$u\n Shares',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inter',
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}


*/