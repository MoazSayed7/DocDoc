import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/extensions.dart';
import '../../../core/networking/api_error_handler.dart';
import '../data/models/specializations_response_model.dart';
import '../data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  List<SpecializationsData?>? specializationsList = [];

  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getDoctorsList({required int? specializationId}) {
    List<Doctors?>? doctorsList =
        getDoctorsListBySpecializationId(specializationId: specializationId!);
    if (!doctorsList!.isNullOrEmpty()) {
      emit(HomeState.doctorsSuccess(doctorsList));
    } else {
      emit(HomeState.doctorsError(ErrorHandler.handle('No doctors found')));
    }
  }

  /// returns the list of doctors for the given specialization id
  List<Doctors?>? getDoctorsListBySpecializationId(
      {required int specializationId}) {
    return specializationsList!
        .firstWhere(
          (specialization) => specialization!.id == specializationId,
        )
        ?.doctorsList;
  }

  void getSpecializations() async {
    emit(const HomeState.specializationsLoading());
    final response = await _homeRepo.getSpecialization();
    try {
      response.when(
        success: (specializationResponseModel) {
          specializationsList =
              specializationResponseModel.specializationDataList ?? [];
          // getting the doctors list for the first specialization by default
          getDoctorsList(specializationId: specializationsList!.first?.id);
          emit(HomeState.specializationsSuccess(specializationsList));
        },
        failure: (error) {
          emit(HomeState.specializationsError(error));
        },
      );
    } catch (error) {
      emit(HomeState.specializationsError(ErrorHandler.handle(error)));
    }
  }
}
