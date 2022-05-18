// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:money_tricks/utils/colors.dart';
import 'package:money_tricks/utils/style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/ad_helper.dart';
import 'package:money_tricks/utils/api.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class PostScreen extends StatefulWidget {
  final String postCode;
  final String imgTag;
  final String shareTag;
  final String img;
  final String titleTag;

  const PostScreen(
      {Key? key,
      required this.postCode,
      required this.imgTag,
      required this.shareTag,
      required this.img,
      required this.titleTag})
      : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pop(context);
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  // ignore: prefer_typing_uninitialized_variables
  var i;
  @override
  void initState() {
    _loadInterstitialAd();
    getDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appbg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Colors.black26,
                      ),
                    ]),
                    child: Hero(
                        tag: widget.imgTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.img,
                            height: 220.0,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_isInterstitialAdReady) {
                              _interstitialAd?.show();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 91, 235)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        /* Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 10, 0),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 80, 91, 235)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Icon(
                            Icons.bookmark_add_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                        ), */
                      ]),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                          child: Text(
                            widget.titleTag,
                            style: StyleText.post_title_text,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            _onShare(context);
                          }, //_onShareWithResult(context),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEEEEEE).withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                            ),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.share,
                                  color: Color.fromARGB(255, 202, 41, 41),
                                  size: 24,
                                ),
                                Text(widget.shareTag)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 10,
                  color: AppColors.appbarSearchbg.withOpacity(0.8),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Html(
                      data: i.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  getDetails() async {
    var code = widget.postCode;
    final response = await fetchPostById(
        'https://blog.goldenfatafat.in/mapi/SinglePost/$code');
    setState(() {
      i = response;
    });
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final imageurl = widget.img;
    final uri = Uri.parse(imageurl);
    final response = await http.get(uri);
    final bytes = response.bodyBytes;
    final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    await Share.shareFiles([path],
        text: '${widget.titleTag} See now https://sprs.store/',
        subject: 'Get it now');
  }
}


/*
class _PostScreenState extends State<PostScreen> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pop(context);
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  void initState() {
    _loadInterstitialAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.appbg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        color: Colors.black26,
                      ),
                    ]),
                    child: Hero(
                        tag: widget.imgTag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            widget.img,
                            height: 220.0,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 25, 12, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (_isInterstitialAdReady) {
                              _interstitialAd?.show();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(12, 10, 0, 0),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 80, 91, 235)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(12),
                              shape: BoxShape.rectangle,
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 12, 10, 0),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 80, 91, 235)
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Icon(
                            Icons.bookmark_add_rounded,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
                      child: Text(
                        widget.titleTag,
                        style: StyleText.post_title_text,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      //onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEEEEEE).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.heart_broken_sharp,
                              color: Color.fromARGB(255, 202, 41, 41),
                              size: 24,
                            ),
                            Text(widget.likeTag)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              height: 10,
              color: AppColors.appbarSearchbg.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore.',
                style: StyleText.post_desc_text,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore. We are leading technology solutions providing company all over the world doing over 40 years lorem ipsum dolor sit amet. We are leading technology solutions providing company all over the world doing over 40 years. Lorem ipsum dolor sit amet consetetur sadipscing elitr sed diam non umy eirmod tempor invidunt ut labore.',
                style: StyleText.post_desc_text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }
}
*/