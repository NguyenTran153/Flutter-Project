import 'package:flutter/material.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../models/messenger/message.dart';
import '../../../providers/language_provider.dart';
import '../../../services/messenger_service.dart';

class MessengerScreen extends StatefulWidget {
  final String tutorId;
  const MessengerScreen({super.key, required this.tutorId});

  @override
  State<MessengerScreen> createState() => _MessengerScreenState();
}

class _MessengerScreenState extends State<MessengerScreen> {
  late List<MessageRow> messages = [];
  late TextEditingController messageController;
  late Locale currentLocale;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }

  Future<void> loadMessages(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;
    try {
      final messageData = await MessengerService.loadMessages(
        token: token,
        userId: widget.tutorId,
        page: 1,
        perPage: 25,
        startTime: 1704094786536,
      );
      setState(() {
        messages = messageData.rows ?? [];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    loadMessages(authProvider);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          AppLocalizations(currentLocale).translate('messenger')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.isRead == true
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: message.isRead == true ? Colors.blue : Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message.content ?? '',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    String messageContent = messageController.text;
                    // Create a temporary fake message
                    MessageRow fakeMessage = MessageRow(
                      content: messageContent,
                      isRead: true,
                      createdAt: DateTime.now().toIso8601String(), // Set the timestamp
                      fromInfo: FromInfo(id: 'fakeSenderId', name: 'Fake Sender'),
                      toInfo: ToInfo(id: 'fakeRecipientId', name: 'Fake Recipient'),
                    );

                    try {
                      setState(() {
                        messages.insert(0, fakeMessage);
                      });
                    } catch (e) {
                      print(e);
                    }

                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
