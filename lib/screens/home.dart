// ignore_for_file: file_names, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:money_tricks/utils/api.dart';
import 'package:money_tricks/utils/colors.dart';
import 'package:money_tricks/widgets/TopbarWithSearch.dart';
import 'package:money_tricks/widgets/postcards.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../utils/ad_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<dynamic>> futureCat;
  late Future<List<dynamic>> futurePost;
  final String apiUrl = 'https://blog.goldenfatafat.in/mapi/get_cats/';
  final String apiPostUrl = 'https://blog.goldenfatafat.in/mapi/getPosts';

  String _title(dynamic catagory) {
    return catagory['cat_title'];
  }

  String _catid(dynamic catagory) {
    return catagory['cat_id'];
  }

  String _catimg(dynamic catagory) {
    return catagory['cat_img'];
  }

  static const _kAdIndex = 3;
  late BannerAd _ad;
  late bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    futureCat = fetchPost(apiUrl);
    futurePost = fetchPost(apiPostUrl);
    super.initState();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          // print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: TopbarWithSearchWidget(title: 'Money Tricks'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Container(
                color: AppColors.appbarbg,
                child: FutureBuilder<List<dynamic>>(
                  future: futureCat,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
                        height: 92,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                futurePost = fetchPost(
                                    '$apiPostUrl/${_catid(snapshot.data[index])}');
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              margin: EdgeInsets.all(10),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 48,
                                      height: 48,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          'https://blog.goldenfatafat.in/uploads/catg/${_catimg(snapshot.data[index])}',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      _title(snapshot.data[index]),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.appbarbg,
                  child: FutureBuilder<List<dynamic>>(
                    future: futurePost,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount:
                              snapshot.data!.length + (_isAdLoaded ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (_isAdLoaded && index == _kAdIndex) {
                              return Container(
                                width: _ad.size.width.toDouble(),
                                height: 72.0,
                                alignment: Alignment.center,
                                child: AdWidget(ad: _ad),
                              );
                            } else {
                              final item = snapshot
                                  .data[_getDestinationItemIndex(index)];
                              return PostCards(child: item);
                            }
                          },
                        ); /*ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return PostCards(child: snapshot.data[index]);
                            });*/
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ad.dispose();
    super.dispose();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kAdIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}
