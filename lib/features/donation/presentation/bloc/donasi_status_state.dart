import 'package:equatable/equatable.dart';
import 'package:pos_flutter/features/donation/model/donasi_status_model.dart';

abstract class DonasiStatusState extends Equatable {
  final List<DonasiStatusModel>? listStatus;

  const DonasiStatusState({this.listStatus});

  @override
  List<Object?> get props => [this.listStatus];
}

class LoadingGetDonasiStatus extends DonasiStatusState {
  const LoadingGetDonasiStatus();
}

class SuccessGetDonasiStatus extends DonasiStatusState {
  final List<DonasiStatusModel> listDonasiStatus;

  const SuccessGetDonasiStatus(this.listDonasiStatus);
}
