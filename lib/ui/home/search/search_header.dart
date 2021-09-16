import 'package:flutter/material.dart';

import '../../../utils/strings/app_strings.dart';

class SearchHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.menu, color: Colors.white),
            ),
            onTap: () async {
              //_scaffoldKey.currentState!.openEndDrawer();
            },
          ),
          Flexible(child: Container()),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(AppStrings.appIcon, height: 22, width: 22),
            ),
            onTap: () async {
              //_scaffoldKey.currentState!.openDrawer();
            },
          ),
          Text(
            AppStrings.appName,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.w700),
          ),
          Flexible(child: Container()),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(Icons.notifications, color: Colors.white),
            ),
            onTap: () async {
              /*final List? selected = await showSearch(
                context: context,
                delegate: SearchDelegater(context, searchList),
              );*/
            },
          ),
        ],
      ),
    );
  }
  }