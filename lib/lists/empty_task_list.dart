import 'package:diary/lists/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyTaskList extends StatelessWidget {
  const EmptyTaskList({
    super.key,
  });

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
                Resources.todolistBackground,
              ),
              SvgPicture.asset(
                Resources.todolist,
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
