import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trait_lens/firebase_options.dart';

import 'core/di/di.dart';
import 'trait_lens_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: 'https://iheitgacckotzfdtqybc.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImloZWl0Z2FjY2tvdHpmZHRxeWJjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2NzQzMzcsImV4cCI6MjA1NTI1MDMzN30.PCBIfZR-ZjLLeguaUuAJfqZOn238Gc8Rd7YwI8cSZc4',
  );
  runApp(const TraitLensApp());
}
