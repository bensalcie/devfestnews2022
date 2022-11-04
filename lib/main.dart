import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

// A
import 'package:path_provider/path_provider.dart';

import 'feature/presentation/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devfest News 2022',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(title: 'Devfest News 2022'),
    );
  }
}
