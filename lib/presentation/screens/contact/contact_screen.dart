import 'package:flutter/material.dart';
import '../../widgets/layout/app_scaffold.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AppScaffold(body: Center(child: Text('Contact')));
}
