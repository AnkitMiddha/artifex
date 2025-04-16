part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}


class PromptGeneratingImageLoadState extends PromptState {}

class PromptGeneratingImageSuccessState extends PromptState {

final Uint8List uint8list;

  PromptGeneratingImageSuccessState({ required this.uint8list });
}
class PromptGeneratingImageErrorState extends PromptState {}


