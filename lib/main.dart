import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messenger Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final List<ConversationMessage> messages = [
    ConversationMessage(name: 'Thanh Tuyền', text: 'hello', time: '10:30 am'),
    ConversationMessage(name: 'Yến Nhi', text: 'hi', time: '9:00 am'),
    ConversationMessage(name: 'Hiền Thục', text: 'da', time: 'Mon'),
    ConversationMessage(name: 'Mom', text: 'love you', time: 'Sun'),
    ConversationMessage(name: 'Dad', text: 'Hi', time: 'Sun'),
    ConversationMessage(name: 'Nhật Huy', text: 'How are you', time: 'Sat'),
    ConversationMessage(name: 'Mẫn Nghi', text: 'Hello', time: 'Sat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messenger'),
        backgroundColor: Colors.purple,
      ),
      body: ConversationList(messages: messages),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Đoạn chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Danh bạ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
      ),
    );
  }
}

class ConversationList extends StatelessWidget {
  final List<ConversationMessage> messages;

  const ConversationList({Key? key, required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatDetailScreen(userName: message.name)),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
                  ),
                  title: Text(
                    message.name,
                    style: TextStyle(fontSize: 20), // Font size here
                  ),
                  subtitle: Text(message.text),
                  trailing: Text(
                    message.time,
                    style: TextStyle(fontSize: 14), // Font size here
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String userName;

  ChatDetailScreen({required this.userName});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  List<Message> messages = [
    Message(message: 'Hello', createdAt: DateTime.now(), sentBy: '2'),
    Message(message: 'Hi pro', createdAt: DateTime.now(), sentBy: '1'),
    Message(message: 'Hahaha!How are you!', createdAt: DateTime.now(), sentBy: '2'),
    Message(message: 'I am fine thanks', createdAt: DateTime.now(), sentBy: '1'),
    Message(message: 'ok', createdAt: DateTime.now(), sentBy: '2'),
  ];

  late final ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
      initialMessageList: messages,
      scrollController: ScrollController(),
      currentUser: ChatUser(id: '1', name: 'You'),
      otherUsers: [ChatUser(id: '2', name: widget.userName)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        backgroundColor: Colors.purple,
      ),
      body: ChatView(
        chatController: chatController,
        onSendTap: (message, replyMessage, messageType) {
          chatController.addMessage(Message(
            message: message,
            createdAt: DateTime.now(),
            sentBy: '1',
          ));
        },
        sendMessageConfig: SendMessageConfiguration(
          textFieldBackgroundColor: Colors.black,
          allowRecordingVoice: false,
          enableCameraImagePicker: true,
          enableGalleryImagePicker: true,
        ),
        chatViewState: ChatViewState.hasMessages,
      ),
    );
  }
}

class ConversationMessage {
  final String name;
  final String text;
  final String time;

  ConversationMessage({
    required this.name,
    required this.text,
    required this.time,
  });
}
