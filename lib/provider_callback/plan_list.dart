import 'package:flutter/material.dart';
import 'package:gtpl/provider/plan_list.dart';
import 'package:provider/provider.dart';

class PlanListCallback {
  final BuildContext context;

  PlanListCallback(this.context);

  PlanListProvider get notListner =>
      Provider.of<PlanListProvider>(context, listen: false);
  PlanListProvider get listner =>
      Provider.of<PlanListProvider>(context, listen: true);
}
