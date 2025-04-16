import 'dart:async';

import 'package:artifex/features/prompt/repos/prompt_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptEvent>((event, emit) {
    

    });
   on<PromptEnteredEvent>(promptEnteredEvent);
   on<PromptInitialEvent>(promptInitialEvent);
   
  }
   FutureOr<void>promptEnteredEvent(PromptEnteredEvent event,Emitter<PromptState> emit) 
   async {
         emit(PromptGeneratingImageLoadState());
         Uint8List? bytes = await PromptRepo.genreateImage(event.prompt);
         if(bytes != null)
         {
          emit(PromptGeneratingImageSuccessState(uint8list: bytes));
         }
         else {
          emit(PromptGeneratingImageErrorState());
         }
    }
     FutureOr<void>promptInitialEvent(PromptInitialEvent event,Emitter<PromptState> emit) 
    async {
      ByteData data = await rootBundle.load('assets/image.jpg');
       Uint8List bytes = data.buffer.asUint8List();
      emit(PromptGeneratingImageSuccessState( uint8list: bytes));

     }

}
