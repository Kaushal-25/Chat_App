import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';


class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.black54,
      child: InkWell( onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>Chat_Screen()));
      },
        child: ListTile(
          leading:

          ClipRRect(
            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height*.03),
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.height*.055,
              height: MediaQuery.of(context).size.height*.055,
              imageUrl: widget.user.image,
              errorWidget: (context, url, error) =>   CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
          ),
          title: Text(widget.user.name,style: TextStyle(color: Colors.white),),
          subtitle: Text(widget.user.about,style: TextStyle(color: Colors.white),maxLines: 1,),
          trailing:  Container(
            height: MediaQuery.of(context).size.height*.012,
            width: MediaQuery.of(context).size.width*.025,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20)
            ),
          ),
          // Text("12:25",style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
