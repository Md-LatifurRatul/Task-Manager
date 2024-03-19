import 'package:flutter/material.dart';

class EmptyListMessageWidget extends StatelessWidget {
  const EmptyListMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Empty list item"),
    );
  }
}
