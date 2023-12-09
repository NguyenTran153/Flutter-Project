import "package:flutter/material.dart";
import "package:flutter_project/screens/Homepage/TutorCard/tutor_card_widget.dart";
import "package:provider/provider.dart";

import "../../l10n.dart";
import "../../models/tutor/tutor.dart";
import "../../models/tutor/tutor_info.dart";
import "../../providers/auth_provider.dart";
import "../../providers/language_provider.dart";
import "../../services/tutor_service.dart";
import "../../services/user_service.dart";

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({Key? key}) : super(key: key);

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  List<Tutor> _tutors = [];
  final List<TutorInfo> _information = [];
  bool _isLoading = true;

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

  Future<void> _getRecommendedTutors(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;

    final topics = await UserService.getLearningTopic(token);
    final tests = await UserService.getTestPreparation(token);
    authProvider.setLearnTopic(topics);
    authProvider.setTestPreparation(tests);

    _tutors = await TutorService.getListTutorWithPagination(
      page: 1,
      perPage: 10,
      token: token,
    );

    _tutors.sort((a, b) {
      if (a.rating == null || b.rating == null) {
        return 0;
      }
      return a.rating!.compareTo(b.rating!);
    });

    for (var tutor in _tutors) {
      final info = await TutorService.getTutorInformationById(
        token: token,
        userId: tutor.userId!,
      );
      _information.add(info);
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    if (_isLoading && authProvider.token != null) {
      _getRecommendedTutors(authProvider);
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              AppLocalizations(currentLocale).translate('recommendTutor')!,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _tutors.length,
                  itemBuilder: (context, index) {
                    return TutorCardWidget(tutor: _tutors[index]);
                  },
                )
        ],
      ),
    );
  }
}
