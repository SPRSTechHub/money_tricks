// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_tricks/utils/api.dart';
import 'package:money_tricks/utils/colors.dart';
import 'package:money_tricks/utils/themes.dart';
import 'package:money_tricks/widgets/TopbarWithSearch.dart';
import 'dart:math' as math;

import 'package:money_tricks/widgets/postcards.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  final String apiUrl = 'https://blog.goldenfatafat.in/mapi/getPosts';
  late Future<List<dynamic>> futurePost;

  @override
  void initState() {
    futurePost = fetchPost(apiUrl);
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: TopbarWithSearchWidget(title: 'Money Tricks'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: futurePost,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  return PostCards(child: snapshot.data[index]);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
