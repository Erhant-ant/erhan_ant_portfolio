import 'package:flutter/material.dart';
import '../../widgets/layout/app_scaffold.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const AppScaffold(body: Center(child: Text('404')));
}
