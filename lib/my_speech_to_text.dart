import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart'as stts;

class MySpeechToText extends StatefulWidget {
  const MySpeechToText({Key? key}) : super(key: key);

  @override
  State<MySpeechToText> createState() => _MySpeechToTextState();
}

class _MySpeechToTextState extends State<MySpeechToText> {
   var speechToText = stts.SpeechToText();
  bool isListening = false;
  String text = "press the button for speaking";
  Future<void> listen() async{
    if(isListening!){
      bool availabel = await speechToText.initialize(
        onStatus:(status)=>print("$status"),
        onError: (errorNotification)=>print("$errorNotification"),

      );
if(availabel){
  setState(() {
    isListening = true;
  });
}
speechToText .listen(
  onResult: (result)=>
      setState(() {
        text=result.recognizedWords;
      } ));

    }else{
      setState(() {
        isListening = false;
      });
      speechToText.stop();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    speechToText = stts.SpeechToText();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text(text),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: AvatarGlow(
        repeat: isListening,
        endRadius: 80,
        glowColor: Colors.blue,

        child: FloatingActionButton(
          tooltip: "speak",
          highlightElevation: 100,
          onPressed: ()  {
          listen();
          },
          child: Icon(isListening? Icons.mic:Icons.mic_none),
        ),
      ),
    );
  }
}
