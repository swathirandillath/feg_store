import 'package:feg_store/bloc/bloc/app_blocs.dart';
import 'package:feg_store/bloc/bloc/app_state.dart';
import 'package:feg_store/service/api_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/bloc/app_event.dart';

class Plans extends StatefulWidget {
  final String token;

  const Plans(
    this.token, {
    Key? key,
  }) : super(key: key);

  @override
  State<Plans> createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  final PlanBloc _planBloc = PlanBloc(PlansRepo());

  @override
  void initState() {
    _planBloc.add(LoadPlanEvent(widget.token));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: BlocConsumer<PlanBloc, PlanState>(
                builder: (context, state) {
                  if (state is PlanLoadingState) {
                    print("PlanLoadingState");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PlanLoadedState) {
                    print("PlanLoadedState");
                    return Column(
                      children: const [Text("This is planList")],
                    );
                  } else if (state is PlanErrorState) {
                    return const Text("Error");
                  }
                  return Container();
                },
                listener: (context, state) {})));
  }
}
