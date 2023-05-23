import 'package:flutter/material.dart';
import 'package:parkin/resources/color_maneger.dart';
import 'package:parkin/resources/constant_maneger.dart';
import 'package:parkin/resources/responsive.dart';
import 'package:parkin/resources/strings_maneger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../shared/component/app_background.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({Key? key, required this.txt, required this.type})
      : super(key: key);
  final String txt;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.primary,
        body: AppBackground(
          customWidget: ListView(
            children: [
              if (type == "Terms")
                Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              SizedBox(
                height: responsive.sHeight(context) * .2,
              ),
              if (type == "about")
                Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              responsive.sizedBoxH10,
              if (type == "contactUs")
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () async {
                          final Uri url = Uri(
                            scheme: 'mailto',
                            path: 'paarrk.in@gmail.com',
                            query:
                                'subject=hi this is subject &body=hi this is body', //add subject and body here
                          );
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                        child: const Text(AppStrings.email))),
              responsive.sizedBoxH10,
              if (type == "contactUs")
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              "https://wa.me/${AppConstant.constPhoneNumber}?text=Hi this is parkin app",
                            ),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                        child: const Text(AppStrings.whatsApp))),
              responsive.sizedBoxH10,
              if (type == "contactUs")
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              "https://twitter.com/PaarrkIn",
                            ),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                        child: const Text(AppStrings.twitter))),
              responsive.sizedBoxH10,
              if (type == "help")
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                              "https://wa.me/${AppConstant.constPhoneNumber}?text=Hi this is parkin app",
                            ),
                            mode: LaunchMode.externalNonBrowserApplication,
                          );
                        },
                        child: const Text(AppStrings.support))),
              responsive.sizedBoxH10,
              if (type == "help")
                SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MenuItem(type: "about", txt: """  
How to reserve?
                                   



Where can you find us? 





What areas are we covering ? 
                                    """)));
                        },
                        child: const Text(AppStrings.fAQs))),
            ],
          ),
        ));
  }
}
