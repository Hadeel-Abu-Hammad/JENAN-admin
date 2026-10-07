import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenan_admin/core/shared/app_dialog.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/core/constants/routes/app_routes.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/core/constants/routes/app_routes_consts.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/body/sidebar.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/get_selected_index.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final sidebarExpanded = ValueNotifier<bool>(true);

  @override
  void dispose() {
    sidebarExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = getSelectedIndex(context);
    return Scaffold(
      backgroundColor: background,
      body: Row(
        children: [

          ValueListenableBuilder<bool>(
            valueListenable: sidebarExpanded,
            builder: (context, isExpanded, _) {
              return Sidebar(
                isExpanded: isExpanded,
                selectedIndex: selectedIndex,
                onToggle: () {
                  sidebarExpanded.value = !isExpanded;
                },
                onItemSelected: (index) {
                  context.go(appRoutes[index]);
                },
                onSettingsTap: () {
                  context.go(AppRoutesConsts.settings);
                },
                  onLogoutTap: () async {
                    final confirmed = await showDialog<bool>(
                      context: context,
                      builder: (context) => AppDialog(),
                    );

                    if (confirmed == true && context.mounted) {
                      context.read<AuthBloc>().add(const AuthLogoutEvent());
                      // context.go(AppRouter.splash);
                    }

                },
              );
            },
          ),

          Expanded(child: widget.child),

        ],
      ),
    );
  }
}
