import 'package:provider/provider.dart';
import 'package:simple_app/providers/all_providers.dart';
import 'package:simple_app/providers/auth_providers.dart';

var providers = [
  ChangeNotifierProvider<AuthProviders>(create: ((context) => AuthProviders())),
  ChangeNotifierProvider<AllProviders>(create: ((context) => AllProviders())),
];
