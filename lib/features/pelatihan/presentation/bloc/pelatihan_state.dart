import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/pelatihan/domain/model/pelatihan_model.dart';

abstract class PelatihanState extends Equatable {
  final PelatihanModel? pelatihanModel;
  final String? success;
  const PelatihanState({this.pelatihanModel, this.success});
  @override
  List<Object?> get props => [this.pelatihanModel];
}

class InitialPelatihanState extends PelatihanState {
  const InitialPelatihanState();
}

class SuccessCreatePelatihan extends PelatihanState {
  final String success;
  const SuccessCreatePelatihan(this.success) : super(success: success);
}

class LoadingPelatihanState extends PelatihanState {
  const LoadingPelatihanState();
}

class SuccessGetListPelatihan extends PelatihanState {
  final List<PelatihanModel> listPelatihan;

  SuccessGetListPelatihan(this.listPelatihan);
}

class LoadingRequestJoinPelatihan extends PelatihanState {
  const LoadingRequestJoinPelatihan();
}

class SuccessRequestJoinPelatihan extends PelatihanState {
  final String successMessage;

  SuccessRequestJoinPelatihan(this.successMessage);
}

class LoadingDetailPelatihan extends PelatihanState {
  const LoadingDetailPelatihan();
}

class SuccessDetailPelatihan extends PelatihanState {
  final PelatihanModel pelatihan;

  SuccessDetailPelatihan(this.pelatihan) : super(pelatihanModel: pelatihan);
}

class LoadingUpdateStatusMember extends PelatihanState {
  const LoadingUpdateStatusMember();
}

class SuccessUpdateStatusMember extends PelatihanState {
  final String successMessage;

  SuccessUpdateStatusMember(this.successMessage);
}
