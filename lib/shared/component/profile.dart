import 'package:flutter/material.dart';
import '../../resources/color_maneger.dart';
import '../../resources/responsive.dart';
import '../../resources/value_maneger.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: ColorManager.radialGradientCard,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: Row(children: [
              Container(
                height: responsive.sHeight(context) * .06,
                width: responsive.sWidth(context) * .12,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(7),
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://firebasestorage.googleapis.com/v0/b/insulin-1b28b.appspot.com/o/menu%20list%2Fdownload.jpeg?alt=media&token=a9ec18e9-89fb-4a6c-85e0-cec16d38d79c'),
                      fit: BoxFit.fill),
                ),
              ),
              responsive.sizedBoxW10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'بيتزا مجمده متوسطة الحجم',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'العدد : 5',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(
                        width: 150,
                      ),
                      Text(
                        '15g',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        textAlign: TextAlign.right,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
