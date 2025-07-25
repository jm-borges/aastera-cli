import 'dart:async';
import 'package:app_links/app_links.dart';
import 'routes/deep_linking_routes.dart';
import '../utilities/global.dart';

AppLinks? appLinks;
StreamSubscription? linkSubscription;

void initDeepLinkListener() async {
  appLinks = AppLinks();

  linkSubscription = appLinks!.uriLinkStream.listen(
    (Uri? uri) {
      if (uri != null) {
        _handleDeepLink(uri);
      }
    },
    onError: (err) {
      printOnDebug("Erro ao processar o deep link: $err");
    },
  );
}

void _handleDeepLink(Uri uri) {
  if (deepLinkingRoutes[uri.host] != null) {
    deepLinkingRoutes[uri.host]!(uri);
  }
}
