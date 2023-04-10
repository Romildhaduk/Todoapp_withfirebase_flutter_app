import 'package:flutter/material.dart';

class listcustomwidget extends StatelessWidget {
  const listcustomwidget({Key? key,required this.discription,required this.Title}) : super(key: key);

  final String discription;
  final String Title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            discription,
            style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.white),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            Title,
            style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.white),
          ),
        ],
      ),
    );
  }
}
