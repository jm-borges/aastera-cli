import 'config.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> initializePackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  Config.appVersion = packageInfo.version;
  Config.buildNumber = packageInfo.buildNumber;
}
