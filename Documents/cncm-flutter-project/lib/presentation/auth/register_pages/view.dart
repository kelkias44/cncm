import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/register_bloc/bloc.dart';
import '../blocs/register_bloc/event.dart';
import '../blocs/register_bloc/state.dart';

// class Register_blocPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => Register_blocBloc()..add(InitEvent()),
//       child: Builder(builder: (context) => _buildPage(context)),
//     );
//   }
//
//   Widget _buildPage(BuildContext context) {
//     final bloc = BlocProvider.of<Register_blocBloc>(context);
//
//     return Container();
//   }
// }

