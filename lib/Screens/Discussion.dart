import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:who_s_who/Modules/Message.dart';
import 'package:who_s_who/Modules/TextComposer.dart';
import 'package:who_s_who/TopBar.dart';

/// This screen is for the chat, it shows messages from the group and allow to send messages
/// Text composer is used
/// If the user decides to go back he'll quit current game


class Discussion extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _DiscussionPage();

}

class _DiscussionPage extends State<Discussion> {

  Widget ChatMessages(){
    List<String> msg = ['hey','hello', 'how r u ', 'fine', 'goodbye'];
    //TODO replace the messages with ones from data base
    return ListView.builder(
        reverse: true, //so that the msgs would show in clean way
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index){
          final Message msg = chats[index];
        final bool isMe = msg.sender.id == currentUser.id;
          return Messages(msg, isMe);
        }
        );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //onWillPop: _onBackPressed,
      //TODO uncomment when ready to disable back button
      //onWillPop: ()async => false,
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: TopBar('Discussion', [IconButton(
          onPressed: (){},
          icon: Icon(Icons.info),
          padding: EdgeInsets.only(right: 2.0),
        )]),
        body: GestureDetector(
          onTap: ()=> FocusScope.of(context).unfocus(),
          child: Column(
            children:[
              Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                  ),
                  color: Colors.white,
                ),
                width: double.infinity,
                child:  ChatMessages(),

                    ///Child N°2 the chat composor
                ),
            ),

              TextComposer(()=>(){}, (String msg)=>{
                //TODO retreive and send message to DB
                print("\n the retreived msg = "+msg),
              }),
          ],
          ),
          ),
        ),
    );

  }
}

sendMsg() {
}

class Messages extends StatelessWidget {
  final Message msg;
  final bool isMe;
  Messages(this.msg, this.isMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      margin: isMe?
      EdgeInsets.only(
        right: 3.0,
        left: 150.0,
        top: 6.0,
        bottom: 6.0,
      ):
      EdgeInsets.only(
        top: 6.0,
        bottom: 6.0,
        right: 50.0,
      ),
      //if send by me align to right otherwise align to left
      alignment: isMe?
          Alignment.centerRight:
          Alignment.centerLeft,
      decoration: BoxDecoration(
        color: isMe?
          Colors.amber:
          Colors.black12,
        borderRadius: isMe?
        BorderRadius.only(
          topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
        ):
        BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0)
        ),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          isMe?
          Text(
            msg.time,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black26,
            ),
          ):
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                msg.sender.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: 1.0,),
              Text(
                msg.time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),

            ],
          ),
          Text(
            msg.msg,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
        ),
      ],
      ),
    );
  }
}


//Dialog window
/*Future<bool> _onBackPressed() {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text('Are you sure?'),
      content: new Text('Do you want to exit an App'),
      actions: <Widget>[
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(false),
          child: Text("NO"),
        ),
        SizedBox(height: 16),
        new GestureDetector(
          onTap: () => Navigator.of(context).pop(true),
          child: Text("YES"),
        ),
      ],
    ),
  ) ??
      false;
}*/