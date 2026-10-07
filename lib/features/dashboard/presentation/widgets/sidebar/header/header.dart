import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jenan_admin/features/auth/bloc/auth_bloc.dart';
import 'package:jenan_admin/core/constants/colors/app_colors.dart';
import 'package:jenan_admin/core/constants/sidebar/sidebar_width.dart';
import 'package:jenan_admin/features/dashboard/presentation/widgets/sidebar/header/avatar.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.isExpanded,
    required this.onToggle
  });

  final bool isExpanded;
  final VoidCallback onToggle;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final admin = state is AuthAuthenticated ? state.adminUser : null;
          return AnimatedContainer(
            duration: animationDuration,
            curve: Curves.easeInOut,
            height: 80,
            padding: EdgeInsets.symmetric(
              horizontal: isExpanded ? 16 : 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [

                Avatar(photoUrl: admin?.photo, onToggle: onToggle,),

                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Flexible(
                                child: Container(
                                  width: 95,
                                  child: Text(
                                    admin?.name ?? "مسؤول",
                                    style: const TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 2),

                              Flexible(
                                child: Container(
                                  width: 118,
                                  child: Text(
                                    textDirection: TextDirection.ltr,
                                    admin?.email ?? "admin@jenan.com",
                                    style: TextStyle(
                                      color: white.withOpacity(0.5),
                                      fontSize: 11,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      );
    }
}
