import 'package:flutter/material.dart';
import 'package:myapp/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://tlzmqzkpbleygqraccyd.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRsem1xemtwYmxleWdxcmFjY3lkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEzMTQyOTAsImV4cCI6MjA0Njg5MDI5MH0.rjN4rc-aEkc_u53IDaRH8kKTHdT9n3A-wnsTXBxyYg0");
  runApp(const App());
}
