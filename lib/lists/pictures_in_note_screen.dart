import 'dart:math';

import 'package:flutter/material.dart';

class PicturesInNoteScreen extends StatelessWidget {
  const PicturesInNoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Material(
                color: Colors.deepOrange,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 100,
                    width: 60,
                    child: Transform.rotate(
                      angle: pi / 2,
                      child: const Icon(
                        Icons.attach_file,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
