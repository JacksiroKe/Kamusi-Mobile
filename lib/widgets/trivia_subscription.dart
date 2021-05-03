import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:anisi_controls/anisi_controls.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../services/app_settings.dart';
import '../utils/preferences.dart';
import '../utils/app_utils.dart';
import '../utils/colors.dart';

class TriviaSubscription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TriviaSubscriptionState();
}

enum SubscriptionModes { P3M, P6M, P1Y }

class TriviaSubscriptionState extends State<TriviaSubscription> {
  AsLoader loader = AsLoader.setUp(ColorUtils.primaryColor);
  Offerings _offerings;
  bool isSubscribed, processing;
  String subscriptionMode;

  List<String> options = [];

  SubscriptionModes _mode = SubscriptionModes.P3M;

  @override
  void initState() {
    super.initState();
    processing = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => initBuild(context));
  }

  /// Run anything that needs to be run immediately after Widget build
  void initBuild(BuildContext context) async {
    loader.showWidget();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    isSubscribed = await Preferences.isAppTriviaSubscribed();
    subscriptionMode = await Preferences.getSharedPreferenceStr(
        SharedPreferenceKeys.triviaSubscriptionMode);

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup(AppStrings.revCatKey);

    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.triviaSubscription),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context, true),
            )
          ],
        ),
        body: mainBody(),
      ),
    );
  }

  Widget mainBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          subcriptionOptions(),
          processing
              ? loader
              : RaisedButton(
                  child: Text(
                    AppStrings.subscribe.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  onPressed: subscribeAction,
                  color: Provider.of<AppSettings>(context).isDarkMode
                      ? ColorUtils.black
                      : ColorUtils.baseColor,
                ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget subcriptionOptions() {
    if (_offerings != null) {
      final offering = _offerings.current;
      if (offering != null) {
        final quarterly = offering.threeMonth;
        final biannully = offering.sixMonth;
        final yearly = offering.annual;
        if (quarterly != null && biannully != null && yearly != null) {
          String product1 = AppStrings.subscription3months +
              " - ${quarterly.product.priceString}";
          String product2 = AppStrings.subscription6months +
              " - ${biannully.product.priceString}";
          String product3 =
              AppStrings.subscription1year + " - ${yearly.product.priceString}";

          setState(() {
            processing = false;
          });
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<SubscriptionModes>(
                title: Text(product1),
                value: SubscriptionModes.P3M,
                groupValue: _mode,
                onChanged: (SubscriptionModes value) {
                  setState(() {
                    _mode = value;
                  });
                },
              ),
              RadioListTile<SubscriptionModes>(
                title: Text(product2),
                value: SubscriptionModes.P6M,
                groupValue: _mode,
                onChanged: (SubscriptionModes value) {
                  setState(() {
                    _mode = value;
                  });
                },
              ),
              RadioListTile<SubscriptionModes>(
                title: Text(product3),
                value: SubscriptionModes.P1Y,
                groupValue: _mode,
                onChanged: (SubscriptionModes value) {
                  setState(() {
                    _mode = value;
                  });
                },
              ),
              Divider(),
            ],
          );
        }
      }
    } else
      return Container();
  }

  void subscribeAction() async {
    setState(() {
      processing = true;
    });

    Package package;

    try {
      switch (_mode) {
        case SubscriptionModes.P3M:
          package = _offerings.current.threeMonth;
          await Purchases.purchasePackage(package);
          setSubscribed("P3M");
          break;

        case SubscriptionModes.P6M:
          package = _offerings.current.sixMonth;
          await Purchases.purchasePackage(package);
          setSubscribed("P6M");
          break;

        case SubscriptionModes.P1Y:
          package = _offerings.current.annual;
          await Purchases.purchasePackage(package);
          setSubscribed("PIY");
          break;
      }
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        print("User cancelled");
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        print("User not allowed to purchase");
      }
      print("Platform Error: " + e.message);
      print("Error Details: " + e.details.toString());
    }
  }

  void setSubscribed(String mode) async {
    print("User is Subscribed");
    Preferences.setAppTriviaSubscribed(true);
    Preferences.setSharedPreferenceStr(
        SharedPreferenceKeys.triviaSubscriptionMode, mode);
    Navigator.pop(context, true);
  }
}
