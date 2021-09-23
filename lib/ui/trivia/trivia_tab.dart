import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import 'trivia.dart';

// ignore: must_be_immutable
class TriviaTab extends StatelessWidget {
  final ScrollController myScrollController = ScrollController();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KamusiCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return TriviaBody();
      },
    );
  }

}
