import 'package:flutter/material.dart';

import '../imagens/images_atoms.dart';

class MessageStatusProduct extends StatelessWidget {
  MessageStatusProduct({required this.image, required this.label});

  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageLogin(
                context: context,
                image: image),
            Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
