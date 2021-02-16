import 'package:flutter/material.dart';
import 'package:sixvalley_ui_kit/data/model/response/chat_model.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:intl/intl.dart';

class MessageBubble extends StatelessWidget {
  final ChatModel chat;
  final Function onProfileTap;
  MessageBubble({@required this.chat, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: chat.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        chat.isMe ? SizedBox.shrink() : InkWell(onTap: onProfileTap, child: CircleAvatar(child: Icon(Icons.person))),
        Flexible(
          child: Container(
              margin: chat.isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: chat.isMe ? Radius.circular(10) : Radius.circular(0),
                  bottomRight: chat.isMe ? Radius.circular(0) : Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: chat.isMe ? ColorResources.IMAGE_BG : ColorResources.WHITE
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                !chat.isMe? Text(DateFormat('hh:mm').format(chat.dateTime), style: titilliumRegular.copyWith(
                  fontSize: 8,
                  color: ColorResources.HINT_TEXT_COLOR,
                )) : SizedBox.shrink(),
                chat.message.isNotEmpty ? Text(chat.message, style: titilliumRegular.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL)) : SizedBox.shrink(),
                chat.image != null ? Image.file(chat.image) : SizedBox.shrink(),
              ]),
          ),
        ),
      ],
    );
  }
}
