import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class DepartmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    //   BlocProvider(
    //   create: (BuildContext context) => DepartmentBloc()..add(InitEvent()),
    //   child: Builder(builder: (context) => _buildPage(context)),
    // );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<DepartmentBloc>(context);

    return Container();
  }
}

