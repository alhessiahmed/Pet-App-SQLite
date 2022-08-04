import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp_qatar_assignment_5_local_db/preferences/shared_pref_controller.dart';
import 'package:vp_qatar_assignment_5_local_db/widgets/home_drawer/home_drawer_tile.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: const EdgeInsetsDirectional.only(
              top: 32,
              start: 24,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(165),
              ),
              color: Color(0xFFEB4747),
            ),
            child: Text(
              'Welcome ${SharedPrefController().getValueFor<String>(key: 'name')}',
              style: GoogleFonts.nunito(
                fontSize: 24,
                color: const Color(0xFFFFDEDE),
              ),
            ),
          ),
          DrawerTile(
            title: 'Control Pet Vaccines',
            onPressed: () {
              Navigator.pushNamed(context, '/all_vaccines_screen');
            },
          ),
          const Divider(
            indent: 25,
            endIndent: 25,
            color: Color(0xFFEB4747),
          ),
          DrawerTile(
            title: 'Control Pet Tools',
            onPressed: () {
              Navigator.pushNamed(context, '/all_tools_screen');
            },
          ),
          const Divider(
            indent: 25,
            endIndent: 25,
            color: Color(0xFFEB4747),
          ),
          DrawerTile(
            title: 'Logout',
            onPressed: () async => _logout(context),
          ),
        ],
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SharedPrefController().logout();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login_screen',
      (route) => false,
    );
  }
}
