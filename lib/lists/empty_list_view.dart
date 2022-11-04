import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyList extends StatefulWidget {
  const EmptyList({
    super.key,
  });
  @override
  EmptyListState createState() => EmptyListState();
}

class EmptyListState extends State<EmptyList> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              SvgPicture.asset(
                'assets/todolist_background.svg',
              ),
              SvgPicture.asset(
                'assets/todolist.svg',
              ),
            ],
          ),
          const Text(
            'На данный\nмомент задачи\nотсутствуют',
            style: TextStyle(
              color: Color(0xFF400063),
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
