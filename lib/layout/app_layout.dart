import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/home screen/cubit/cubit.dart';
import '../presentation/home screen/cubit/state.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  // var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: HomeCubit.get(context)
              .screens[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: HomeCubit.get(context).bottomItems,
            currentIndex: HomeCubit.get(context).currentIndex,
            onTap: (index) => HomeCubit.get(context).changeBottomNavBar(index),
          ),
        );
      },
    );
  }
}
