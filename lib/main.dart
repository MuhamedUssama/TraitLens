import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trait_lens/firebase_options.dart';

import 'core/di/di.dart';
import 'trait_lens_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TraitLensApp());
}
