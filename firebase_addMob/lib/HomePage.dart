import 'dart:async';

import 'package:firebase_addMob/NextPage.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo();
  int _coins = 0;
  final _nativeAdController = NativeAdmobController();
  static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";
  bool isShowbanner = false;

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        targetingInfo: targetingInfo,
        adUnitId: InterstitialAd.testAdUnitId,
        listener: (MobileAdEvent event) {
          print('interstitial eventudjbfjdfbdjbbdbfbfdbdfbbb: $event');
        });
  }

  BannerAd createBannerAdd() {
    return BannerAd(
        targetingInfo: targetingInfo,
        adUnitId: "ca-app-pub-3321577093093604/7902605162",
        size: AdSize.leaderboard,
        listener: (MobileAdEvent event) {
          print('Bnner Event nklsklnfsdkndsfndfsng: $event');
        });
  }

  @override
  void initState() {
    // FirebaseAdMob.instance
    //     .initialize(appId: FirebaseAdMob.testAppId);
    // _bannerAd = createBannerAdd()..load();
    // _bannerAd.show();
    _interstitialAd = createInterstitialAd()..load();

    RewardedVideoAd.instance.load(
        adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () async {
      RewardedVideoAd.instance.show();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                _bannerAd ??= createBannerAdd();
                _bannerAd..load();
                _bannerAd?.dispose();
                _bannerAd = null;
                await _interstitialAd?.show();
                await Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NextPage()));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(8),
                height: 200,
                color: Colors.white,
                child: NativeAdmob(
                  adUnitID: _adUnitID,
                  controller: _nativeAdController,
                  numberAds: 10,
                  type: NativeAdmobType.full,
                  loading: Center(child: CircularProgressIndicator()),
                  error: Text('failed to load'),
                )),
            RaisedButton(
                child: isShowbanner == false
                    ? Text("Show banner")
                    : Text('Remove banner'),
                onPressed: () {
                  setState(() {
                    if (isShowbanner == false) {
                      _bannerAd ??= createBannerAdd();
                      _bannerAd
                        ..load()
                        ..show();
                      isShowbanner = true;
                    } else {
                      _bannerAd?.dispose();
                      _bannerAd = null;
                      isShowbanner = false;
                    }
                  });
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Refresh Ads"),
        onPressed: () {
          _nativeAdController.reloadAd(forceRefresh: true);
        },
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }
}
