import 'package:bloc/bloc.dart';

import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/exportar_usecase.dart';

part 'exportar_event.dart';
part 'exportar_state.dart';

class ExportarBloc extends Bloc<ExportarEvent, ExportarState> {
  final ExportarYBorrarUseCase? exportarYBorrarUseCase;
  final ExportarUseCase? exportarUseCase;
  ExportarBloc({this.exportarUseCase, this.exportarYBorrarUseCase})
      : super(ExportarInitial()){
    on<ExportarDataEvent>(_exportar);
    on<ExportarDataYBorrarEvent>(_exportarYBorrar);
      }

  Future<void> _exportar(ExportarDataEvent event, Emitter<ExportarState> emit) async {
    if (event.loading) {
      emit(ExportarLoading());
    }
    if (exportarUseCase != null) {
      final result = await exportarUseCase!.call(NoParams());
      result.fold((l) => emit(ExportarError(l.message)), (r) => emit(ExportarSuccess(r.message)));
    } else {
      emit(ExportarError('ExportarUseCase was not provided'));
    }
  }

  Future<void> _exportarYBorrar(ExportarDataYBorrarEvent event, Emitter<ExportarState> emit) async {
    if (event.loading) {
      emit(ExportarLoading());
    }
    if (exportarYBorrarUseCase != null) {
      final result = await exportarYBorrarUseCase!.call(NoParams());
      result.fold((l) => emit(ExportarError(l.message)), (r) => emit(ExportarSuccess(r.message)));
    } else {
      emit(ExportarError('ExportarYBorrarUseCase was not provided'));
    }
  }
}
