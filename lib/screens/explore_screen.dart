import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore', style: Theme.of(context).textTheme.headlineSmall),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'Explore Page',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
