import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './firebase_options.dart';
import '../Pages/product_list.dart';
import '../Provider/product_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductsProvider()..loadProducts(),
      child: const PracticeProvider(),
    ),
  );
}

class PracticeProvider extends StatelessWidget {
  const PracticeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProviderProList(),
    );
  }
}