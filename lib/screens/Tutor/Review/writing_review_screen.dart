import 'package:flutter/material.dart';
import 'package:flutter_project/providers/auth_provider.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../l10n/l10n.dart';
import '../../../providers/language_provider.dart';
import '../../../services/tutor_service.dart';
import '../../../services/user_service.dart';

class WritingReviewScreen extends StatefulWidget {
  const WritingReviewScreen({Key? key, required this.bookingId})
      : super(key: key);

  final String? bookingId;

  @override
  State<WritingReviewScreen> createState() => _WritingReviewScreenState();
}

class _WritingReviewScreenState extends State<WritingReviewScreen> {
  int rate = 5;
  final TextEditingController _textEditingController = TextEditingController();

  late Locale currentLocale;

  @override
  void initState() {
    super.initState();

    currentLocale = context.read<LanguageProvider>().currentLocale;
    context.read<LanguageProvider>().addListener(() {
      setState(() {
        currentLocale = context.read<LanguageProvider>().currentLocale;
      });
    });
  }

  Future<void> _writeReview(AuthProvider authProvider, String content) async {
    try {
      final String token = authProvider.token?.access?.token as String;
      final result = await UserService.getUserInformation(token);

      await TutorService.writeReviewForTutor(
        token: token,
        bookingId: widget.bookingId ?? '',
        userId: result?.id ?? '',
        rate: rate,
        content: content,
      );
      // Show a success dialog
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations(currentLocale).translate('success')!),
          content:
              Text(AppLocalizations(currentLocale).translate('reviewSent')!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // Navigate back after the success dialog is dismissed
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      Navigator.pop(context);
      print(e.toString());
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations(currentLocale).translate('error')!),
          content: Text(
            AppLocalizations(currentLocale).translate('reviewSent')!),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          AppLocalizations(currentLocale).translate('review')!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations(currentLocale).translate('rating')!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            subSizedBox,
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(
                  5,
                  (index) => InkWell(
                    onTap: () {
                      setState(() {
                        rate = index + 1;
                      });
                    },
                    child: Icon(
                      Icons.star,
                      color: index < rate ? Colors.amber : Colors.grey,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
            sizedBox,
            sizedBox,
            Text(
              AppLocalizations(currentLocale).translate('description')!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            subSizedBox,
            TextField(
              controller: _textEditingController,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            sizedBox,
            sizedBox,
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () async {
                  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                  String content = _textEditingController.text;
                  await _writeReview(authProvider, content);                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations(currentLocale).translate('send')!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).primaryColor),
                    ),
                    sizedBox,
                    Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                      size: 24,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
