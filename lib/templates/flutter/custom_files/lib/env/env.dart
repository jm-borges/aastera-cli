import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'APP_MODE', obfuscate: true)
  static final String appMode = _Env.appMode;

  @EnviedField(varName: 'PROD_BASE_API_URL', obfuscate: true)
  static final String prodBaseApiUrl = _Env.prodBaseApiUrl;

  @EnviedField(varName: 'DEV_BASE_API_URL', obfuscate: true)
  static final String devBaseApiUrl = _Env.devBaseApiUrl;

  @EnviedField(varName: 'PROD_STORAGE_URL', obfuscate: true)
  static final String prodStorageUrl = _Env.prodStorageUrl;

  @EnviedField(varName: 'DEV_STORAGE_URL', obfuscate: true)
  static final String devStorageUrl = _Env.devStorageUrl;

  @EnviedField(varName: 'PROD_URL', obfuscate: true)
  static final String prodUrl = _Env.prodUrl;

  @EnviedField(varName: 'DEV_URL', obfuscate: true)
  static final String devUrl = _Env.devUrl;

  @EnviedField(varName: 'PROD_WEBSOCKET_URL', obfuscate: true)
  static final String prodWebsocketUrl = _Env.prodWebsocketUrl;

  @EnviedField(varName: 'DEV_WEBSOCKET_URL', obfuscate: true)
  static final String devWebsocketUrl = _Env.devWebsocketUrl;

  @EnviedField(varName: 'WEBSOCKET_AUTH_TOKEN', obfuscate: true)
  static final String websocketAuthToken = _Env.websocketAuthToken;

  @EnviedField(varName: 'BUGSNAG_API_KEY', obfuscate: true)
  static final String bugsnagApiKey = _Env.bugsnagApiKey;

  @EnviedField(varName: 'VIACEP_API_URL', obfuscate: true)
  static final String viacepApiUrl = _Env.viacepApiUrl;

  @EnviedField(varName: 'APP_TITLE', obfuscate: true)
  static final String appTitle = _Env.appTitle;

  @EnviedField(varName: 'PLAY_STORE_URL', obfuscate: true)
  static final String playStoreUrl = _Env.playStoreUrl;

  @EnviedField(varName: 'APP_STORE_URL', obfuscate: true)
  static final String appStoreUrl = _Env.appStoreUrl;
}
