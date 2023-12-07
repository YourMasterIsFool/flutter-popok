import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';
import 'package:pos_flutter/features/pelatihan/presentation/bloc/pelatihan_state.dart';

import '../../domain/sevice/pelatihan_service.dart';

class PelatihanBloc extends Cubit<PelatihanState> {
  PelatihanService pelatihanService = PelatihanService();
  PelatihanBloc() : super(const InitialPelatihanState());

  Future<void> createPelatihan(PelatihanModel schema) async {
    emit(LoadingPelatihanState());
    var response = await pelatihanService.createPelatihanService(schema);

    response?.fold((l) {
      getListPelatihan();
      emit(SuccessCreatePelatihan('Successfully created donasi'));
    }, (r) => print(r));
  }

  void getListPelatihan({Map<String, dynamic>? params}) async {
    emit(LoadingPelatihanState());
    var response =
        await pelatihanService.getListPelatihanService(params: params);

    print('get list donasi response' + response.toString());
    response?.fold((l) => emit(SuccessGetListPelatihan(l)), (r) => print(r));
  }

  Future<void> requestJoinPelatihan(int id) async {
    emit(LoadingRequestJoinPelatihan());

    var response = await pelatihanService.requestJoinPelatihan(id);

    response?.fold((l) {
      getDetailPelatihan(id);
      emit(SuccessRequestJoinPelatihan(
          "Berhasil request pelatihan, menuggu approve dari admin"));
    }, (r) {
      print(r.response.toString());
    });
  }

  Future<void> getDetailPelatihan(int id) async {
    emit(LoadingDetailPelatihan());

    var response = await pelatihanService.detailPelatihanService(id);

    response?.fold((l) {
      emit(SuccessDetailPelatihan(l));
    }, (r) {
      print(r.response.toString());
    });
  }

  Future<void> updateStatusPelatihanMember(
      {required int id, required int acc}) async {
    emit(LoadingUpdateStatusMember());

    var response =
        await pelatihanService.updateStatusMemberPelatihan(acc: acc, id: id);

    response?.fold((l) {
      emit(SuccessUpdateStatusMember("Berhasil update status memberp"));
      // getDetailPelatihan(id);
    }, (r) {
      print(r.response.toString());
    });
  }
}
