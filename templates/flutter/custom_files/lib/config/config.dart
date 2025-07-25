import '../env/env.dart';

class Config {
  static String? appVersion;

  static String? buildNumber;

  static String? playStoreUrl = Env.playStoreUrl;
  static String? appStoreUrl = Env.appStoreUrl;

  static String appMode = Env.appMode;

  static String baseApiUrl =
      Env.appMode == 'production' || Env.appMode == 'prod'
      ? Env.prodBaseApiUrl
      : Env.devBaseApiUrl;

  static String storageUrl =
      Env.appMode == 'production' || Env.appMode == 'prod'
      ? Env.prodStorageUrl
      : Env.devStorageUrl;

  static String baseUrl = Env.appMode == 'production' || Env.appMode == 'prod'
      ? Env.prodUrl
      : Env.devUrl;

  static String websocketUrl =
      Env.appMode == 'production' || Env.appMode == 'prod'
      ? Env.prodWebsocketUrl
      : Env.devWebsocketUrl;

  static String websocketAuthToken = Env.websocketAuthToken;

  static String bugsnagApiKey = Env.bugsnagApiKey;

  static String viacepApiUrl = Env.viacepApiUrl;

  static bool appIsInProduction() {
    return appMode.toLowerCase() == 'prod' ||
        appMode.toLowerCase() == 'production';
  }

  static String appTitle = Env.appTitle;
}
