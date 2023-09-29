import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nepalsa/services/services.dart';
import 'package:nepalsa/widets/message_holder.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Services manager = Services();
  TextEditingController message = TextEditingController();
  User? curentuser;
  bool isme = true;

  void getmessage() async {
    await for (var snapshot
        in manager.firestore.collection('messages').snapshots()) {
      for (var mess in snapshot.docs) {
        print(mess.data());
      }
    }
  }

  @override
  void initState() {
    getuser();
    getmessage();

    super.initState();
  }

  void getuser() async {
    try {
      curentuser = await manager.getcurrentuser();
      print('got currentuser');
      if (curentuser != null && curentuser?.email != null) {
        print('current user: $curentuser');
        print('currentuser email:${curentuser?.email}');
      }
    } catch (e) {
      print('sorry something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Message',
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              onPressed: () async {
                await manager.logout(context);
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                width: 1 * width,
                height: 0.8 * height,
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: manager.firestore
                            .collection('messages')
                            .orderBy('timestamp')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 0.3 * height,
                                ),
                                Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Loading.... ',
                                  style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff999999),
                                    height: 18 / 12,
                                  ),
                                ),
                              ],
                            );
                          }
                          final messages = snapshot.data!.docs.reversed;
                          List<MessageHolder> messagebox = [];
                          for (var message in messages) {
                            final messagetext = (message.data()
                                as Map<String, dynamic>)['Message'] as String?;
                            final sendername = (message.data()
                                as Map<String, dynamic>)['id'] as String?;

                            if (curentuser?.email == sendername) {
                              isme = true;
                            } else {
                              isme = false;
                            }

                            final messagecontainer = MessageHolder(
                              sender: sendername.toString(),
                              message: messagetext.toString(),
                              isme: isme,
                            );
                            messagebox.add(messagecontainer);
                          }
                          return Expanded(
                            child: ListView(
                              reverse: true,
                              children: messagebox.toList(),
                            ),
                          );
                        })
                  ],
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 15),
                      child: TextField(
                        controller: message,
                        decoration: InputDecoration(
                          hintText: 'Type your message....',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 25,
                    child: IconButton(
                      onPressed: () {
                        String realmessage = message.text;
                        try {
                          manager.senddata(
                            '${curentuser?.email}',
                            realmessage,
                          );
                          message.clear();
                          print('sending  data was successfully');
                        } catch (e) {
                          print('something went wrong while sending data ');
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
