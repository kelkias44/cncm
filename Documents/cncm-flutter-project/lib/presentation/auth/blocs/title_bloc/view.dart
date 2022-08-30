import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class TitlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    //   BlocProvider(
    //   create: (BuildContext context) => TitleBloc()..add(InitEvent()),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<TitleBloc>(context);

    return Container();
  }
}

