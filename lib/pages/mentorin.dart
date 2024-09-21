import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';
import 'package:syllout_v3/bloc/chat_bloc.dart';
import 'package:syllout_v3/models/chat_message_model.dart';

class AiMentor extends StatefulWidget {
  const AiMentor({super.key, required this.text});
  final String text;

  @override
  State<AiMentor> createState() => _AiMentorState();
}

class _AiMentorState extends State<AiMentor> with SingleTickerProviderStateMixin {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: widget.text));
    _tabController = TabController(length: 3, vsync: this); // Initialize TabController
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController when the widget is disposed
    chatBloc.close(); // Close the chatBloc when the widget is disposed
    super.dispose();
  }

  // Chat Page
  Widget _buildChatPage() {
    return BlocConsumer<ChatBloc, ChatState>(
      bloc: chatBloc,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case ChatSuccessState:
            List<ChatMessageModel> messages = (state as ChatSuccessState).messages;
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  "assets/chat_bg.jpg",
                  fit: BoxFit.cover,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 100,
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SyllOut",
                            style: TextStyle(
                              fontFamily: 'SixtyFour',
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: messages.isEmpty ? messages.length : messages.length - 1,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  messages[index + 1].role == "user" ? "User" : "Syllout",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: messages[index + 1].role == "user"
                                        ? Colors.amber
                                        : Color.fromARGB(255, 23, 192, 207),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                MarkdownBody(
                                  data: messages[index + 1].parts.first.text,
                                  styleSheet: MarkdownStyleSheet(
                                    p: TextStyle(color: Colors.white),
                                    strong: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    if (chatBloc.generating)
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Lottie.asset('assets/loader.json'),
                          ),
                          const SizedBox(width: 20),
                          Text("Loading..."),
                        ],
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(color: Colors.black),
                              cursorColor: Theme.of(context).primaryColor,
                              maxLines: 6,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                fillColor: Colors.white,
                                hintText: "Ask your Doubts",
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {
                              if (textEditingController.text.isNotEmpty) {
                                String text = textEditingController.text;
                                textEditingController.clear();
                                chatBloc.add(ChatGenerateNewTextMessageEvent(inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 32,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).primaryColor,
                                child: Center(
                                  child: Icon(Icons.send, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );

          default:
            return SizedBox();
        }
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Ai Mentor",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      
      ),
      body: 
          _buildChatPage(),
        
      
    );
  }
}
