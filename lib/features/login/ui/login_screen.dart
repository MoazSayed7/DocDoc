import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../logic/cubit/login_cubit.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/email_and_password.dart';
import 'widgets/login_bloc_listener.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 24.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: TextStyles.font24BlueBold,
                            ),
                            verticalSpace(8),
                            Text(
                              'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                              style: TextStyles.font14GrayRegular,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(36),
                      const EmailAndPassword(),
                      verticalSpace(32),
                      AppTextButton(
                        buttonText: "Login",
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () async {
                          await validateThenDoLogin(context);
                        },
                      ),
                      const LoginBlocListener(),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ensure minimum height
                  children: [
                    const TermsAndConditionsText(),
                    verticalSpace(24),
                    const DontHaveAccountText(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validateThenDoLogin(BuildContext context) async {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      await context.read<LoginCubit>().emitLoginStates();
    }
  }
}
