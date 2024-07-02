import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/helpers/extensions.dart';
import '../../../../core/helpers/shared_pref_helper.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_factory.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/styles.dart';

class DoctorsSpecialitySeeAll extends StatelessWidget {
  const DoctorsSpecialitySeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Doctors Speciality',
          style: TextStyles.font18DarkBlueSemiBold,
        ),
        TextButton(
          onPressed: () async {
            try {
              Dio dio = DioFactory.getDio();
              await dio.request(
                '${ApiConstants.apiBaseUrl}${ApiConstants.logout}',
                options: Options(
                  method: 'POST',
                ),
              );
            } catch (e) {
              debugPrint(e.toString());
            } finally {
              await SharedPrefHelper.clearAllSecuredData();
              // ignore: control_flow_in_finally
              if (!context.mounted) return;
              context.pushNamedAndRemoveUntil(
                Routes.onBoardingScreen,
                predicate: (route) => false,
              );
            }
          },
          child: Text(
            'See All',
            style: TextStyles.font12BlueRegular,
          ),
        ),
      ],
    );
  }
}
