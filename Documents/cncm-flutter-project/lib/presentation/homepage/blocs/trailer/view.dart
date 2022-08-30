import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class TrailerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
    //   BlocProvider(
    //   create: (BuildContext context) => TrailerBloc()..add(InitEvent()),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<TrailerBloc>(context);

    return Container();
  }
}

