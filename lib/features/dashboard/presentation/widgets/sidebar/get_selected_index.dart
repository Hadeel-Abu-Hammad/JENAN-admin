import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jenan_admin/core/constants/routes/app_routes.dart';

int getSelectedIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.path;
  final index = appRoutes.indexOf(location);
  return index >= 0 ? index : 0;
}