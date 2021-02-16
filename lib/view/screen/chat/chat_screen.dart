import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sixvalley_ui_kit/data/model/response/chat_model.dart';
import 'package:sixvalley_ui_kit/data/model/response/seller_model.dart';
import 'package:sixvalley_ui_kit/provider/chat_provider.dart';
import 'package:sixvalley_ui_kit/utill/color_resources.dart';
import 'package:sixvalley_ui_kit/utill/custom_themes.dart';
import 'package:sixvalley_ui_kit/utill/dimensions.dart';
import 'package:sixvalley_ui_kit/view/basewidget/custom_app_bar.dart';
import 'package:sixvalley_ui_kit/view/screen/chat/widget/message_bubble.dart';
import 'package:sixvalley_ui_kit/view/screen/seller/seller_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  final SellerModel seller;
  ChatScreen({@required this.seller});

  final ImagePicker picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    if(isFirstTime) {
      Provider.of<ChatProvider>(context, listen: false).initChatList(seller.id);
      isFirstTime = false;
    }

    return Scaffold(
      backgroundColor: ColorResources.ICON_BG,
      body: Column(children: [

        CustomAppBar(title: seller.fName+' '+seller.lName),

        // Chats
        Expanded(child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Provider.of<ChatProvider>(context).hasData ? Provider.of<ChatProvider>(context).chatList.length != 0 ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: Provider.of<ChatProvider>(context).chatList.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              List<ChatModel> chats = Provider.of<ChatProvider>(context).chatList.reversed.toList();
              return MessageBubble(chat: chats[index], onProfileTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SellerScreen(seller: seller)));
              });
            },
          ) : ChatShimmer() : SizedBox.shrink(),
        )),

        // Bottom TextField
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Provider.of<ChatProvider>(context).imageFile != null ? Padding(
              padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Image.file(Provider.of<ChatProvider>(context).imageFile, height: 70, width: 70, fit: BoxFit.cover),
                  Positioned(
                    top: -2, right: -2,
                    child: InkWell(
                      onTap: () => Provider.of<ChatProvider>(context, listen: false).removeImage(_controller.text),
                      child: Icon(Icons.cancel, color: ColorResources.WHITE),
                    ),
                  ),
                ],
              ),
            ) : SizedBox.shrink(),

            SizedBox(
              height: 70,
              child: Card(
                color: ColorResources.WHITE,
                shadowColor: Colors.grey[200],
                elevation: 2,
                margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                  child: Row(children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: titilliumRegular,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          hintStyle: titilliumRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
                          border: InputBorder.none,
                        ),
                        onChanged: (String newText) {
                          if(newText.isNotEmpty && !Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                            Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                          }else if(newText.isEmpty && Provider.of<ChatProvider>(context, listen: false).isSendButtonActive) {
                            Provider.of<ChatProvider>(context, listen: false).toggleSendButtonActivity();
                          }
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        final PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          Provider.of<ChatProvider>(context, listen: false).setImage(File(pickedFile.path));
                        } else {
                          print('No image selected.');
                        }
                      },
                      child: Icon(Icons.image, color: ColorResources.HINT_TEXT_COLOR, size: Dimensions.ICON_SIZE_DEFAULT),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL, horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: VerticalDivider(width: 2, color: ColorResources.CHAT_ICON_COLOR),
                    ),
                    InkWell(
                      onTap: () {
                        if(Provider.of<ChatProvider>(context, listen: false).isSendButtonActive){
                          Provider.of<ChatProvider>(context, listen: false).sendMessage(_controller.text);
                          _controller.text = '';
                        }
                      },
                      child: Icon(
                        Icons.send,
                        color: Provider.of<ChatProvider>(context).isSendButtonActive ? ColorResources.COLOR_PRIMARY : ColorResources.HINT_TEXT_COLOR,
                        size: Dimensions.ICON_SIZE_DEFAULT,
                      ),
                    ),
                  ]),
                ),
              ),
            ),

          ],
        ),
      ]),
    );
  }
}

class ChatShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      shrinkWrap: true,
      reverse: true,
      itemBuilder: (context, index) {

        bool isMe = index%2 == 0;
        return Shimmer.fromColors(
          baseColor: isMe ? Colors.grey[300] : ColorResources.IMAGE_BG,
          highlightColor: isMe ? Colors.grey[100] : ColorResources.IMAGE_BG.withOpacity(0.9),
          enabled: Provider.of<ChatProvider>(context).chatList.length == 0,
          child: Row(
            mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              isMe ? SizedBox.shrink() : InkWell(child: CircleAvatar(child: Icon(Icons.person))),
              Expanded(
                child: Container(
                  margin: isMe ?  EdgeInsets.fromLTRB(50, 5, 10, 5) : EdgeInsets.fromLTRB(10, 5, 50, 5),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: isMe ? Radius.circular(10) : Radius.circular(0),
                        bottomRight: isMe ? Radius.circular(0) : Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: isMe ? ColorResources.IMAGE_BG : ColorResources.WHITE
                  ),
                  child: Container(height: 20),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

