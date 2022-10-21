import 'package:flutter/cupertino.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'PAGE NOT FOUND',
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
