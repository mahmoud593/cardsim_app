import 'package:flutter/material.dart';

class ViewTransicationImage extends StatelessWidget {
  const ViewTransicationImage({super.key,required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صورة اثبات الدفع'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Image(
          height:  MediaQuery.of(context).size.height*0.5,
          width: double.infinity,
          fit: BoxFit.contain,
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
