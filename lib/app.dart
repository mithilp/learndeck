import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sample/loading.dart';

class App extends StatefulWidget {
  final Auth0? auth0;
  const App({this.auth0, final Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  UserProfile? _user;

  late Auth0 auth0;

  @override
  void initState() {
    super.initState();
    auth0 = widget.auth0 ??
        Auth0(dotenv.env['AUTH0_DOMAIN']!, dotenv.env['AUTH0_CLIENT_ID']!);
  }

  Future<void> login() async {
    try {
      var credentials = await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .login();

      setState(() {
        _user = credentials.user;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await auth0
          .webAuthentication(scheme: dotenv.env['AUTH0_CUSTOM_SCHEME'])
          .logout();
      setState(() {
        _user = null;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
        home: Loading(user: _user),
    );
  }
}
