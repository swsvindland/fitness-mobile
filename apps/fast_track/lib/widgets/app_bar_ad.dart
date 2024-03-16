import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AppBarAd extends StatefulWidget {
  const AppBarAd({super.key});

  @override
  State<AppBarAd> createState() => _AppBarAdState();
}

class _AppBarAdState extends State<AppBarAd> {
  // late BannerAd? _bannerAd;
  // bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();

  //   _bannerAd = BannerAd(
  //     adUnitId: AdHelper.bannerAdUnitId,
  //     request: const AdRequest(),
  //     size: const AdSize(width: 300, height: 50),
  //     listener: BannerAdListener(
  //       onAdLoaded: (_) {
  //         setState(() {
  //           _isBannerAdReady = true;
  //         });
  //       },
  //       onAdFailedToLoad: (ad, err) {
  //         _isBannerAdReady = false;
  //         ad.dispose();
  //       },
  //     ),
  //   );
  //
  //   _bannerAd?.load();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //
  //   _bannerAd?.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // if (_bannerAd == null || !_isBannerAdReady) {
      return Text(AppLocalizations.of(context)!.bpTrack);
    // }

    // return SizedBox(
    //     width: 300,
    //     height: 50,
    //     child: AdWidget(ad: _bannerAd!),
    // );
  }
}
