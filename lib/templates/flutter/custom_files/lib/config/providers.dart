import 'package:provider/provider.dart';
import '../providers/loading_indicator.dart';
import '../providers/user_provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<LoadingIndicator>(
    create: (context) => LoadingIndicator(),
  ),
  ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider()),
];
