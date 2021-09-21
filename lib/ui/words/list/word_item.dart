import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cubit/cubit.dart';
import '../../../../cubit/states.dart';
import '../../../../data/models/models.dart';
import 'word.dart';

class WordItem extends StatelessWidget {
  final String heroTag;
  final Word word;
  final bool showTimeline;

  WordItem(this.heroTag, this.word, this.showTimeline);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KamusiCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return WordItemBody(heroTag, word, showTimeline);
      },
    );
  }
}
