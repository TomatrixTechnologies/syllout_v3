import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syllout_v3/bloc/chat_bloc.dart';
import 'package:syllout_v3/models/chat_message_model.dart';
import 'package:syllout_v3/pages/course_creater.dart';
import 'package:syllout_v3/pages/mentorin.dart';

class CareerMentorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color to match the theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this with an actual AI spectrum or human-like avatar image
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/ai_avatar.png'), // Path to your avatar image
            ),
            SizedBox(height: 20),
            Text(
              'Your AI Mentor',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              'Career Guidance and Advice',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey[400]),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => CustomDialog(),
                          );
                        }, // Action for the floating button (e.g., starting a chat or interaction)
        
        child: Icon(Icons.chat, color: Colors.white),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

class CustomDialog extends StatefulWidget {

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
   final ChatBloc chatBloc = ChatBloc();
final TextEditingController _InterestsandHobbies = TextEditingController();
final TextEditingController _StrengthsandSkills = TextEditingController();
final TextEditingController _CareerGoals = TextEditingController();
final TextEditingController _EducationBackground = TextEditingController();
final TextEditingController _PreferredWorkEnvironment = TextEditingController();
final TextEditingController _ValuesandMotivations = TextEditingController();
  @override
  void dispose() {
_InterestsandHobbies.dispose();
_StrengthsandSkills.dispose();
_CareerGoals.dispose();
_EducationBackground.dispose();
_PreferredWorkEnvironment.dispose();
_ValuesandMotivations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return  BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccessState:
              List<ChatMessageModel> messages =
                  (state as ChatSuccessState).messages;
              return  AlertDialog(
      title: Text('Create a Course',
        style: TextStyle(color: Colors.black)),
      content: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Interests and Hobbies:'),
             SizedBox(height: 10),
            TextField(
              controller: _InterestsandHobbies,
              decoration: InputDecoration(hintText: 'title'),

            ),
            SizedBox(height: 10),
            Text('Strengths and Skills:'),
             SizedBox(height: 10),
            TextField(
              controller: _StrengthsandSkills,

              decoration: InputDecoration(hintText: 'Technology'),
            ),
            SizedBox(height: 10),
            Text('Career Goals:'),
             SizedBox(height: 10),

            TextField(
              controller: _CareerGoals,

              decoration: InputDecoration(hintText: '16 to 30'),
            ),

            
            SizedBox(height: 10),
            Text('Education Background:'),
             SizedBox(height: 10),

            TextField(
              controller: _EducationBackground,

              decoration: InputDecoration(hintText: '16 to 30'),
            ),

            
            SizedBox(height: 10),
            Text('Preferred Work Environment:'),
             SizedBox(height: 10),

            TextField(
              controller: _PreferredWorkEnvironment,

              decoration: InputDecoration(hintText: '16 to 30'),
            ),

            
            SizedBox(height: 10),
            Text('Values and Motivations:'),
             SizedBox(height: 10),

            TextField(
              controller: _ValuesandMotivations,

              decoration: InputDecoration(hintText: '16 to 30'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // String text ="Create a detailed course outline for a new course titled "+_answer1Controller.text.toString()+" that focuses on "+_answer2Controller.text.toString()+" for "+_answer3Controller.text.toString()+" students. Include the following: Learning Objectives: Clearly state the skills, knowledge, and abilities that students will gain by completing this course. Course Structure: Divide the course into modules, each focusing on a specific topic or theme. For each module, outline: Module Title Learning Outcomes Sub-Topics Content Ideas: Provide a list of content ideas for each module, including: Text-Based Content (explanations, concepts, examples) Visuals (images, infographics, charts) Interactive Elements (quizzes, simulations, games) Real-World Examples (case studies, current events) Activity Ideas: Suggest specific activities or projects that students can engage in to reinforce their learning. Assessment Methods: Outline how you will evaluate student learning, including the types of assessments (quizzes, projects, presentations) and their purpose. Additional Resources: List any external resources (websites, articles, videos) that might be helpful for students to explore. ";

  String text = "Hello! I need your assistance in guiding me towards their ideal career path. Here is the my informations:"+

 "Interests and Hobbies:"+_InterestsandHobbies.text.toString() +
"Strengths and Skills:"+_StrengthsandSkills.text.toString() +
"Career Goals:"+_CareerGoals.text.toString() +
"Education Background:"+ _EducationBackground.text.toString() +
"Preferred Work Environment:"+_PreferredWorkEnvironment.text.toString() +
"Values and Motivations:"+ _ValuesandMotivations.text.toString() +

"Using this information, please provide guidance on potential career paths that align with the student's profile. Suggest relevant educational courses, possible job roles, and any additional resources or steps they should consider to achieve their career goals.";
          
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AiMentor(text: text,)),
            );
          },
          child: Text('Next'),
        ),
      ],
    );
    default:
              return SizedBox();
          }});  }}