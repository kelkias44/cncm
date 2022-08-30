import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class AssociationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    //   BlocProvider(
    //   create: (BuildContext context) => AssociationBloc()..add(InitEvent()),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<AssociationBloc>(context);

    return Container();
  }
}

