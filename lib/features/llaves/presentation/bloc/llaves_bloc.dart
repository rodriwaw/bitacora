import 'package:bloc/bloc.dart';

import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/llaves_usecase.dart';
import '../../domain/llaves_model.dart';
import '../../../../core/utils/api_response.dart';

part 'llaves_event.dart';
part 'llaves_state.dart';

class LlavesBloc extends Bloc<LlavesEvent, LlavesState> {
  final GetLlavesUseCase? getLlavesUseCase;
  final CreateLlaveUseCase? createLlaveUseCase;
  // final GetLlaveUseCase? getLlaveUseCase;
  final UpdateLlaveUseCase? updateLlaveUseCase;
  final DeleteLlaveUseCase? deleteLlaveUseCase;

  LlavesBloc({
    this.getLlavesUseCase,
    this.createLlaveUseCase,
    //  this.getLlaveUseCase,
    this.updateLlaveUseCase,
    this.deleteLlaveUseCase,
  }) : super(LlavesInitial()) {
    on<GetLlavesEvent>(_getLlaves);
    on<AddLlaveEvent>(_createLlave);
    on<UpdateLlaveEvent>(_updateLlave);
    on<DeleteLlaveEvent>(_deleteLlave);
  }

  Future<void> _getLlaves(GetLlavesEvent event, Emitter<LlavesState> emit) async {
    if (event.loading) {
      emit(LlavesLoading());
    }
    if (getLlavesUseCase != null) {
      final result = await getLlavesUseCase!.call(NoParams());
      result.fold((l) => emit(LlavesError(l.message)), (r) => emit(LlavesLoaded(r)));
    } else {
      emit(LlavesError('GetLlavesUseCase was not provided'));
    }
  }

  Future<void> _createLlave(AddLlaveEvent event, Emitter<LlavesState> emit) async {
    if (createLlaveUseCase != null) {
      if (event.loading) {
        emit(LlavesLoading());
      }
      final result = await createLlaveUseCase!.call(event.llave);
      result.fold((l) => emit(LlavesError(l.message)), (r) => emit(LlavesCreated(r)));
    } else {
      emit(LlavesError('CreateLlaveUseCase was not provided'));
    }
  }

  Future<void> _updateLlave(UpdateLlaveEvent event, Emitter<LlavesState> emit) async {
    if (updateLlaveUseCase != null) {
      if (event.loading) {
        emit(LlavesLoading());
      }
      final result = await updateLlaveUseCase!.call(event.llave);
      result.fold((l) => emit(LlavesError(l.message)), (r) => emit(LlavesUpdated(r)));
    } else {
      emit(LlavesError('UpdateLlaveUseCase was not provided'));
    }
  }

  Future<void> _deleteLlave(DeleteLlaveEvent event, Emitter<LlavesState> emit) async {
    if (deleteLlaveUseCase != null) {
      if (event.loading) {
        emit(LlavesLoading());
      }
      final result = await deleteLlaveUseCase!.call(event.llave);
      result.fold((l) => emit(LlavesError(l.message)), (r) => emit(LlavesDeleted(r)));
    } else {
      emit(LlavesError('DeleteLlaveUseCase was not provided'));
    }
  }
}
