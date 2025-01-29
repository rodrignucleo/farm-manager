import 'package:farm_manager/pages/homepage/homepage.dart';
import 'package:farm_manager/pages/login/login.dart';
import 'package:farm_manager/pages/menu_pages/machine/machinepage.dart';
import 'package:farm_manager/service/authservice.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
    required SidebarXController controller,
  }) : _controller = controller;

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TAppTheme.appTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: TAppTheme.appTheme.canvasColor,
        textStyle: TextStyle(
            color: TAppTheme.appTheme.primaryColorLight.withOpacity(0.7)),
        selectedTextStyle:
            TextStyle(color: TAppTheme.appTheme.primaryColorLight),
        hoverTextStyle: TextStyle(
          color: TAppTheme.appTheme.canvasColor,
          fontWeight: FontWeight.w500,
        ),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: TAppTheme.appTheme.primaryColorLight),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: TAppTheme.appTheme.primaryColorLight),
          boxShadow: [
            BoxShadow(
              color: TAppTheme.appTheme.canvasColor.withOpacity(0.24),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: TAppTheme.appTheme.primaryColorLight,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: TAppTheme.appTheme.primaryColorLight,
          size: 20,
        ),
      ),
      extendedTheme: SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: TAppTheme.appTheme.scaffoldBackgroundColor,
        ),
      ),
      footerItems: [
        SidebarXItem(
          icon: Icons.exit_to_app,
          label: 'Loggout',
          onTap: () async {
            AuthService authService = AuthService();
            await authService.signOut(context);
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LoginPage(),
                ),
              );
            }
          },
        ),
      ],
      items: [
        SidebarXItem(
          icon: Icons.home,
          label: 'Home',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
        ),
        SidebarXItem(
          icon: Icons.person_2,
          label: 'Perfil',
          onTap: () {
            debugPrint('Perfil');
          },
        ),
        SidebarXItem(
          icon: Icons.minor_crash,
          label: 'Máquinas',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MachinePage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
