import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mpassessment/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// GET-IT INITIALISATION
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const Index()),
  );
}
