import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../data/models/specializations_response_model.dart';
import '../../../logic/home_cubit.dart';
import '../../../logic/home_state.dart';
import '../doctors_list/doctors_shimmer_loading.dart';
import 'speciality_list_view.dart';
import 'speciality_shimmer_loading.dart';

class SpecializationsBlocBuilder extends StatelessWidget {
  const SpecializationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is SpecializationsLoading ||
          current is SpecializationsSuccess ||
          current is SpecializationsError,
      builder: (context, state) {
        return state.maybeWhen(
          specializationsLoading: () => setupLoading(),
          specializationsSuccess: (specializationsDataList) {
            return setupSuccess(specializationsDataList);
          },
          specializationsError: (errorHandler) => setupError(),
          orElse: () => setupError(),
        );
      },
    );
  }

  Widget setupError() => Text(
        "expired, Click see all",
        style: TextStyle(
          color: Colors.red,
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
        ),
      );

  /// shimmer loading for specializations and doctors
  Widget setupLoading() {
    return Expanded(
      child: Column(
        children: [
          const SpecialityShimmerLoading(),
          verticalSpace(8),
          const DoctorsShimmerLoading(),
        ],
      ),
    );
  }

  SpecialityListView setupSuccess(
    List<SpecializationsData?>? specializationsDataList,
  ) {
    return SpecialityListView(
      specializationDataList: specializationsDataList,
    );
  }
}
