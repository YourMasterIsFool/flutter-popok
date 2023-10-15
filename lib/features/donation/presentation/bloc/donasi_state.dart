import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/donation/model/donasi_model.dart';

abstract class DonasiState extends Equatable {
  final DonasiModel? donasiModel;
  final String? success;
  const DonasiState({this.donasiModel, this.success});
  @override
  List<Object?> get props => [this.donasiModel];
}

class InitialDonasiState extends DonasiState {
  const InitialDonasiState();
}

class SuccessCreateDonasi extends DonasiState {
  final String success;
  const SuccessCreateDonasi(this.success) : super(success: success);
}

class LoadingDonasiState extends DonasiState {
  const LoadingDonasiState();
}

class LoadingCreateDonasi extends DonasiState {
  const LoadingCreateDonasi();
}

class SuccessGetListDonasi extends DonasiState {
  final List<DonasiModel> listDonasi;

  SuccessGetListDonasi(this.listDonasi);
}

class LoadingGetDetailDonasi extends DonasiState {
  const LoadingGetDetailDonasi();
}

class SuccessGetDetailDonasi extends DonasiState {
  final DonasiModel donasi;

  SuccessGetDetailDonasi(this.donasi) : super(donasiModel: donasi);
}

class LoadingUpdateStatus extends DonasiState {
  const LoadingUpdateStatus();
}

class SuccessUpdateStatus extends DonasiState {
  // final DonasiModel donasi;

  SuccessUpdateStatus();
}
