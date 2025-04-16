import 'package:artifex/features/prompt/bloc/prompt_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePromptScreen extends StatefulWidget {
  const CreatePromptScreen({super.key});

  @override
  State<CreatePromptScreen> createState() => _CreatePromptScreenState();
}

class _CreatePromptScreenState extends State<CreatePromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
  promptBloc.add(PromptInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Artifex Image Generator🚀",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {
        },
        builder: (context, state) {
          switch(state.runtimeType){
          case PromptGeneratingImageLoadState:
          return Center(child: CircularProgressIndicator(),);
          case PromptGeneratingImageErrorState:
          return Center(child: Text("Something Went Wrong!"),);
          case PromptGeneratingImageSuccessState:
          final successState = state as PromptGeneratingImageSuccessState;
          return Container(
            child: Column(
              children: [
                Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    
                    image: DecorationImage(
                      
                      fit: BoxFit.cover,
                      image: MemoryImage(successState.uint8list)),
                  ),
                )),
                Container(
                  height: 180,
                  padding: EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Enter your Prompt✨",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              cursorColor: Colors.deepPurple,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: Colors.deepPurple),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                fillColor: Color(0xff919191),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                              onPressed: () {
                                if(controller.text.isNotEmpty)
                                {
                                  promptBloc.add(PromptEnteredEvent(prompt: controller.text));
                                }
                              }, icon: Icon(Icons.send_rounded,color: Colors.deepPurple
                              ,size: 40,)),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
          default:
          return SizedBox();
          }
        },
      ),
    );
  }
}
