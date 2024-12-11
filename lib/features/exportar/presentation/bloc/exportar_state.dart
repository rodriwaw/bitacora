part of 'exportar_bloc.dart';

abstract class ExportarState {
  const ExportarState();
}

class ExportarInitial extends ExportarState {}

class ExportarLoading extends ExportarState {}

class ExportarError extends ExportarState {
  final String message;
  ExportarError(this.message);
}

class ExportarSuccess extends ExportarState {
  final String message;
  ExportarSuccess(this.message);
}

class ExportarAndDeleteSuccess extends ExportarState {
  final String message;
  ExportarAndDeleteSuccess(this.message);
}


