import 'package:flutter/material.dart';
import 'package:chatview/chatview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickChat Example',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<ConversationMessage> messages = [
    ConversationMessage(name: 'Thanh Tuyền', text: 'hello', time: '10:30 am'),
    ConversationMessage(name: 'Yến Nhi', text: 'hi', time: '9:00 am'),
    ConversationMessage(name: 'Hiền Thục', text: 'da', time: 'Mon'),
    ConversationMessage(name: 'Mom', text: 'love you', time: 'Sun'),
    ConversationMessage(name: 'Dad', text: 'Hi', time: 'Sun'),
    ConversationMessage(name: 'Nhật Huy', text: 'How are you', time: 'Sat'),
    ConversationMessage(name: 'Mẫn Nghi', text: 'Hello', time: 'Sat'),
  ];

  List<Story> stories = [
    Story(name: 'Thanh Tuyền', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Yến Nhi', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Hiền Thục', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Mom', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Dad', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Nhật Huy', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
    Story(name: 'Mẫn Nghi', imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375_1280.png'),
  ];

  void _updateUserName(String oldName, String newName) {
    setState(() {
      for (var message in messages) {
        if (message.name == oldName) {
          message.name = newName;
        }
      }
      for (var story in stories) {
        if (story.name == oldName) {
          story.name = newName;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QuickChat'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Column(
        children: [
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
          StoryList(stories: stories),
          Expanded(child: ConversationList(messages: messages, onUpdateUserName: _updateUserName)),
        ],
      ),
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

class StoryList extends StatelessWidget {
  final List<Story> stories;

  const StoryList({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(story.imageUrl),
                ),
                SizedBox(height: 5),
                Text(story.name),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ConversationList extends StatelessWidget {
  final List<ConversationMessage> messages;
  final void Function(String oldName, String newName) onUpdateUserName;

  const ConversationList({Key? key, required this.messages, required this.onUpdateUserName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatDetailScreen(
                        userName: message.name,
                        onUpdateUserName: onUpdateUserName,
                      ),
                    ),
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
  final void Function(String oldName, String newName) onUpdateUserName;

  ChatDetailScreen({required this.userName, required this.onUpdateUserName});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  List<Message> messages = [
    Message(message: 'Hello', createdAt: DateTime.now(), sentBy: '2'),
    Message(message: 'Hi pro', createdAt: DateTime.now(), sentBy: '1'),
    Message(message: 'Hahaha! How are you!', createdAt: DateTime.now(), sentBy: '2'),
    Message(message: 'I am fine thanks', createdAt: DateTime.now(), sentBy: '1'),
    Message(message: 'ok', createdAt: DateTime.now(), sentBy: '2'),
  ];

  late final ChatController chatController;
  late String userName;

  @override
  void initState() {
    super.initState();
    userName = widget.userName;
    chatController = ChatController(
      initialMessageList: messages,
      scrollController: ScrollController(),
      currentUser: ChatUser(id: '1', name: 'You'),
      otherUsers: [ChatUser(id: '2', name: userName)],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final newName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNameScreen(
                    currentName: userName,
                    onNameChanged: (newName) {
                      setState(() {
                        userName = newName;
                      });
                      widget.onUpdateUserName(widget.userName, newName);
                    },
                  ),
                ),
              );
            },
          ),
        ],
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
          textFieldBackgroundColor: Colors.grey,
          allowRecordingVoice: false,
          enableCameraImagePicker: true,
          enableGalleryImagePicker: true,
        ),
        chatViewState: ChatViewState.hasMessages,
      ),
    );
  }
}

class ChangeNameScreen extends StatefulWidget {
  final String currentName;
  final ValueChanged<String> onNameChanged;

  ChangeNameScreen({required this.currentName, required this.onNameChanged});

  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đổi tên'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Tên mới',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.onNameChanged(_nameController.text);
                Navigator.pop(context);
              },
              child: Text('Lưu'),
            ),
          ],
        ),
      ),
    );
  }
}

class ConversationMessage {
  String name;
  final String text;
  final String time;

  ConversationMessage({
    required this.name,
    required this.text,
    required this.time,
  });
}

class Story {
  String name;
  final String imageUrl;

  Story({
    required this.name,
    required this.imageUrl,
  });
}