import 'package:flutter/material.dart';

class TopNavigationBar extends StatefulWidget {
  final String title;
  final List rotulos;
  final Function onTap;

  const TopNavigationBar(
      {super.key,
      required this.title,
      required this.rotulos,
      required this.onTap});

  @override
  _TopNavigationBarState createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: getChildren(),
    );
  }

  List<Widget> getChildren() {
    List<Widget> children = <Widget>[];
    widget.rotulos.asMap().forEach((index, element) {
      children.add(
        TextButton(
          onPressed: () {
            widget.onTap(index, element);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: 20,
            height: 20,
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
            child: Center(
              child: Text(
                element.toString(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    });
    return children;
  }
}
