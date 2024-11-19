import 'package:bloc/bloc.dart';

import '../../../../core/utils/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/asociados_model.dart';
import '../../domain/asociados_usecase.dart';

//usa los archivos que tienen part of asociados a este archivo
part 'asociados_event.dart';
part 'asociados_state.dart';

class AsociadosBloc extends Bloc<AsociadosEvent, AsociadosState> {
  final GetAsociadosUseCase? getAsociadosUseCase;
  final GetAsociadosConLlaveDispUseCase? getAsociadosConLlaveDispUseCase;
  final GetAsociadosConLlavePresUseCase? getAsociadosConLlavePresUseCase;
  final CreateAsociadoUseCase? createAsociadoUseCase;
  final GetAsociadoByNumUseCase? getAsociadoByNumUseCase;
  final UpdateAsociadoUseCase? updateAsociadoUseCase;
  final DeleteAsociadoUseCase? deleteAsociadoUseCase;
  AsociadosBloc({
    this.getAsociadosUseCase,
    this.getAsociadosConLlaveDispUseCase,
    this.getAsociadosConLlavePresUseCase,
    this.createAsociadoUseCase,
    this.getAsociadoByNumUseCase,
    this.updateAsociadoUseCase,
    this.deleteAsociadoUseCase,
  }) : super(AsociadosLoading()) {
    on<GetAsociadosEvent>(_getAsociados);
    on<GetAsociadosConLlaveDispEvent>(_getAsociadosConLlaveDisponible);
    on<GetAsociadosConLlavePresEvent>(_getAsociadosConLlavePrestada);
    on<AddAsociadoEvent>(_createAsociado);
    on<GetAsociadoByNumEvent>(_getAsociadoByNum);
    on<UpdateAsociadoEvent>(_updateAsociado);
    on<DeleteAsociadoEvent>(_deleteAsociado);
  }

  Future<void> _getAsociados(GetAsociadosEvent event, Emitter<AsociadosState> emit) async {
    if (event.loading) {
      emit(AsociadosLoading());
    }
    if (getAsociadosUseCase != null) {
      final result = await getAsociadosUseCase!.call(NoParams());
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosLoaded(r)));
    } else {
      emit(AsociadosError('GetAsociadosUseCase was not provided'));
    }
  }

  Future<void> _getAsociadosConLlaveDisponible(
      GetAsociadosConLlaveDispEvent event, Emitter<AsociadosState> emit) async {
    if (event.loading) {
      emit(AsociadosLoading());
    }
    if (getAsociadosConLlaveDispUseCase != null) {
      final result = await getAsociadosConLlaveDispUseCase!.call(NoParams());
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosConLlaveLoaded(r)));
    } else {
      emit(AsociadosError('GetAsociadosConLlaveDispUseCase was not provided'));
    }
  }

  Future<void> _getAsociadosConLlavePrestada(GetAsociadosConLlavePresEvent event, Emitter<AsociadosState> emit) async {
    if (event.loading) {
      emit(AsociadosLoading());
    }
    if (getAsociadosConLlavePresUseCase != null) {
      final result = await getAsociadosConLlavePresUseCase!.call(NoParams());
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosConLlaveLoaded(r)));
    } else {
      emit(AsociadosError('GetAsociadosConLlavePresUseCase was not provided'));
    }
  }

  Future<void> _getAsociadoByNum(GetAsociadoByNumEvent event, Emitter<AsociadosState> emit) async {
    if (event.loading) {
      emit(AsociadosLoading());
    }
    if (getAsociadoByNumUseCase != null) {
      final result = await getAsociadoByNumUseCase!.call(event.numAsociado);
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadoConLlaveLoaded(r)));
    } else {
      emit(AsociadosError('GetAsociadoByNumUseCase was not provided'));
    }
  }

  Future<void> _createAsociado(AddAsociadoEvent event, Emitter<AsociadosState> emit) async {
    if (createAsociadoUseCase != null) {
      if (event.loading) {
        emit(AsociadosLoading());
      }
      final result = await createAsociadoUseCase!.call(event.asociado);
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosCreated(r)));
    } else {
      emit(AsociadosError('CreateAsociadoUseCase was not provided'));
    }
  }

  Future<void> _updateAsociado(UpdateAsociadoEvent event, Emitter<AsociadosState> emit) async {
    if (updateAsociadoUseCase != null) {
      if (event.loading) {
        emit(AsociadosLoading());
      }
      final result = await updateAsociadoUseCase!.call(event.asociado);
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosUpdated(r)));
    } else {
      emit(AsociadosError('UpdateAsociadoUseCase was not provided'));
    }
  }

  Future<void> _deleteAsociado(DeleteAsociadoEvent event, Emitter<AsociadosState> emit) async {
    if (deleteAsociadoUseCase != null) {
      if (event.loading) {
        emit(AsociadosLoading());
      }
      final result = await deleteAsociadoUseCase!.call(event.asociado);
      result.fold((l) => emit(AsociadosError(l.message)), (r) => emit(AsociadosDeleted(r)));
    } else {
      emit(AsociadosError('DeleteAsociadoUseCase was not provided'));
    }
  }
}
