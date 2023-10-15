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
