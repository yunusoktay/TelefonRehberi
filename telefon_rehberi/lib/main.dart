import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/contacts/contacts_page.dart';
import 'screens/contacts/contacts_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ContactsViewModel())],
      child: MaterialApp(
        title: 'Telefon Rehberi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Using a light theme to match the design
          scaffoldBackgroundColor: const Color(0xFFF9F9F9),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          textTheme: GoogleFonts.mulishTextTheme(),
        ),
        home: const ContactsPage(),
      ),
    );
  }
}
