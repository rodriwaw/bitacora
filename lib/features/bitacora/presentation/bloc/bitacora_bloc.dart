import 'package:bloc/bloc.dart';

import '../../../../core/utils/api_response.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../../domain/bitacora_model.dart';
import '../../domain/bitacora_usecase.dart';

part 'bitacora_event.dart';
part 'bitacora_state.dart';


class BitacoraBloc extends Bloc<BitacoraEvent, BitacoraState>{
  final GetBitacoraUseCase? getBitacoraUseCase;
  final CreateBitacoraUseCase? createBitacoraUseCase;
  final DeleteBitacoraUseCase? deleteBitacoraUseCase;

  BitacoraBloc({
    this.getBitacoraUseCase,
    this.createBitacoraUseCase,
    this.deleteBitacoraUseCase,
  }) : super(BitacoraInitial()){
    on<GetBitacoraEvent>(_getBitacora);
    on<AddBitacoraEvent>(_createBitacora);
    on<DeleteBitacoraEvent>(_deleteBitacora);
  }

  Future<void> _getBitacora(GetBitacoraEvent event, Emitter<BitacoraState> emit) async {
    if(event.loading){
      emit(BitacoraLoading());
    }
    if(getBitacoraUseCase != null){
      final result = await getBitacoraUseCase!.call(NoParams());
      result.fold((l) => emit(BitacoraError(l.message)), (r) => emit(BitacoraLoaded(r)));
    }else{
      emit(BitacoraError('GetBitacoraUseCase was not provided'));
    }
  }

  Future<void> _createBitacora(AddBitacoraEvent event, Emitter<BitacoraState> emit) async {
    if(createBitacoraUseCase != null){
      if(event.loading){
        emit(BitacoraLoading());
      }
      final result = await createBitacoraUseCase!.call(event.bitacora);
      result.fold((l) => emit(BitacoraError(l.message)), (r) => emit(BitacoraCreated(r)));
    }else{
      emit(BitacoraError('CreateBitacoraUseCase was not provided'));
    }
  }

  Future<void> _deleteBitacora(DeleteBitacoraEvent event, Emitter<BitacoraState> emit) async {
    if(deleteBitacoraUseCase != null){
      if(event.loading){
        emit(BitacoraLoading());
      }
      final result = await deleteBitacoraUseCase!.call(event.bitacora);
      result.fold((l) => emit(BitacoraError(l.message)), (r) => emit(BitacoraDeleted(r)));
    }else{
      emit(BitacoraError('DeleteBitacoraUseCase was not provided'));
    }
  }
}