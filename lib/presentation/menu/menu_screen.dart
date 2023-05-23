import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parkin/presentation/login/cubit/cubit.dart';
import 'package:parkin/presentation/login/cubit/state.dart';
import 'package:parkin/presentation/menu/menu_item.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/routes_maneger.dart';
import 'package:parkin/resources/strings_maneger.dart';
import 'package:parkin/shared/component/app_background.dart';
import 'package:parkin/shared/component/component.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      customWidget: Column(
        children: [
          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MenuItem(
                                type: "about",
                                txt:
                                    "The \"Parkin \" app has a number of features that are intended to assist drivers find available parking spots , provide information about parking , and  Make the process easy to save time and effort")));
                  },
                  child: const Text(AppStrings.about))),
          responsive.sizedBoxH10,
          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    navigateTo(context, Routes.updateUser);
                  },
                  child: const Text(AppStrings.settings))),
          responsive.sizedBoxH10,
          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const MenuItem(type: "contactUs", txt: "")));
                  },
                  child: const Text(AppStrings.contactUs))),
          responsive.sizedBoxH10,
          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const MenuItem(type: "help", txt: "")));
                  },
                  child: const Text(AppStrings.help))),
          responsive.sizedBoxH10,
          SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MenuItem(
                                type: "Terms",
                                txt:
                                    """1. The user must verify his correct data, as he is responsible for any entry that is entered and not claiming to be another person, because this exposes the user to legal accountability

2.When the user reserves a parking twice and does not come to the reservation zone, the application will block the reservation service for the user, and he must contact us to open the reservation service again via our
 e-mail

3. The user must adhere to the reserved area and not park in an area other than the area of the user who reserved it, even if it is available


4.The user should not reserve a place for people with special needs if he does not need it
                              """)));
                  },
                  child: const Text(AppStrings.termsOfUse))),
          responsive.sizedBoxH10,
          BlocBuilder<AuthCubit, AuthState>(
            builder: (BuildContext context, state) => SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                    onPressed: () {
                      AuthCubit.get(context).logOut(context);
                    },
                    child: const Text(AppStrings.logout))),
          ),
          responsive.sizedBoxH10,
        ],
      ),
    );
  }
}
