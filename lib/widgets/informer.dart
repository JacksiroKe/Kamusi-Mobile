import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Informer extends StatelessWidget {
  final int type;
  String? text;
  Color? color;
  Color? containerColor;
  Color? backgroundColor;
  double? borderRadius;

  Informer(this.type, this.text, this.color, this.containerColor,
      this.backgroundColor, this.borderRadius);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: color!),
        boxShadow: [BoxShadow(blurRadius: 5)],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: getCenterContent(context),
      ),
    );
  }

  Widget getCenterContent(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: type > 1
                ? Icon(type == 2 ? Icons.thumb_up : Icons.warning,
                    color: color, size: 50)
                : getCircularProgress(),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 150,
            child: Text(
              text!,
              style: TextStyle(color: color, fontSize: 18),
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }

  Widget getCircularProgress() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
    );
  }
}
