import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theming/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../login/ui/widgets/terms_and_conditions_text.dart';
import '../logic/sign_up_cubit.dart';
import 'widgets/already_have_account_text.dart';
import 'widgets/sign_up_bloc_listener.dart';
import 'widgets/sign_up_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(24.w, 50.h, 24.w, 24.h),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyles.font24BlueBold,
                      ),
                      verticalSpace(8),
                      Text(
                        'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                        style: TextStyles.font14GrayRegular,
                      ),
                    ],
                  ),
                ),
                verticalSpace(17),
                const SignupForm(),
                verticalSpace(32),
                AppTextButton(
                  buttonText: "Create Account",
                  textStyle: TextStyles.font16WhiteSemiBold,
                  onPressed: () async {
                    await validateThenDoSignup(context);
                  },
                ),
                verticalSpace(32),
                const TermsAndConditionsText(),
                verticalSpace(24),
                const AlreadyHaveAccountText(),
                const SignupBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> validateThenDoSignup(BuildContext context) async {
    if (context.read<SignupCubit>().formKey.currentState!.validate()) {
      await context.read<SignupCubit>().emitSignupStates();
    }
  }
}
