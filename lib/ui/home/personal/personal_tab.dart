import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import 'personal.dart';

class PersonalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KamusiCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return PersonalBody();
      },
    );
  }
}
