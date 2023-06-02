import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:pro/screens/Home.dart';
import 'package:pro/screens/Login_error_page.dart';
import 'package:pro/screens/Profile.dart';
import 'package:pro/task/model/task_model.dart';
import 'package:pro/task/view/edit_task_screen.dart';
import 'package:pro/task/view/tabs_screen.dart';
import 'package:pro/user/model/user_model.dart';
import 'package:pro/user/view/emplooye/emplooye.dart';
import 'package:pro/user/view/emplooye/employe_list.dart';

import 'auth/view/auth/Login_page.dart';
import 'auth/view/auth/signup.dart';
import 'farm/farm_model/farm_model.dart';
import 'farm/view/add_item.dart';
import 'farm/view/edit_item.dart';
import 'farm/view/inventory_list.dart';
import 'farm/view/item_detail.dart';
import 'herd/model/herd_model.dart';
import 'herd/view/add_form.dart';
import 'herd/view/edit_form.dart';
import 'herd/view/herd_details.dart';
import 'herd/view/herd_list.dart';

class Routes_page extends StatelessWidget {
  Routes_page({super.key});
  final gorouter = GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => SignupPage(),
      ),
      GoRoute(
        path: "/editprofil",
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: "/emplooyes",
        builder: (context, state) => EmplooyeListScreen(
          userr: state.extra as User,
        ),
      ),
      GoRoute(
        path: "/herdlist",
        builder: (context, state) => HerdList(
          user: state.error as User,
        ),
      ),
      GoRoute(
        path: "/addherd",
        builder: (context, state) => const AddHerd(),
      ),
      GoRoute(
        path: "/herddetails",
        builder: (context, state) => HerdDetails(herd: state.extra as Herd),
      ),
      GoRoute(
        path: "/editherd",
        builder: (context, state) => EditHerd(herd: state.extra as Herd),
      ),
      GoRoute(
        path: "/error",
        builder: (context, state) => const LoginErrorpage(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => HomePage(),
      ),
      GoRoute(
        path: "/inventory",
        builder: (context, state) => InventoryListScreen(
          user: state.error as User,
        ),
      ),
      GoRoute(
        path: "/tasklist",
        builder: (context, state) => TabsScreen(
          user: state.error as User,
        ),
      ),
      GoRoute(
        path: "/itemdetail",
        builder: (context, state) => ItemDetailScreen(
          item: state.extra as Farm,
        ),
      ),
      GoRoute(
        path: "/addemplooye",
        builder: (context, state) => EmplooyeRegistor(),
      ),
      GoRoute(
        path: "/edititem",
        builder: (context, state) => EditItemScreen(
          item: state.extra as Farm,
        ),
      ),
      GoRoute(
        path: "/edittask",
        builder: (context, state) => EditTaskScreen(
          oldTask: state.extra as Task,
        ),
      ),
      GoRoute(
        path: "/additem",
        builder: (context, state) => AddItemScreen(),
      ),
    ],
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: gorouter.routerDelegate,
      routeInformationParser: gorouter.routeInformationParser,
      routeInformationProvider: gorouter.routeInformationProvider,
    );
  }
}
