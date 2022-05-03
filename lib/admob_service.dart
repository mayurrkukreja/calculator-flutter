import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// const String testDevice = '';
const int maxFailedLoadAttempts = 3;

class AdmobService {
  static BannerAd? _bannerAd;

  static BannerAd? get bannerAd => _bannerAd;
  static String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-5933115352151657/3027904230'
      : 'ca-app-pub-3940256099942544/2934735716';

  static initialize() {
    if (MobileAds.instance == null) {
      print("Initialize:AdMob");
      MobileAds.instance.initialize();
    }
  }

  static BannerAd createBannerAd() {
    BannerAd ad = new BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad Loaded'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Ad failed to Load: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('Ad Opened'),
        onAdClosed: (Ad ad) => print('Ad closed'),
      ),
    );
    return ad;
  }

  static void showBannerAd() {
    if (_bannerAd != null) {
      return;
    }
    _bannerAd = createBannerAd();
    _bannerAd?.load();
  }

  void disposeAds() {
    print("disposeAds");
    if (_bannerAd != null) {
      _bannerAd?.dispose();
    }
  }
}
