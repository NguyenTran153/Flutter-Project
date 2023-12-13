import 'package:flutter/material.dart';
import 'package:flutter_project/utils/sized_box.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constant.dart';
import '../../../../l10n.dart';
import '../../../../models/tutor/tutor.dart';
import '../../../../models/tutor/tutor_info.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../providers/language_provider.dart';
import '../../../../services/tutor_service.dart';
import '../../../../utils/routes.dart';

class TutorSearchCardWidget extends StatefulWidget {
  const TutorSearchCardWidget({
    Key? key,
    required this.tutor,
  }) : super(key: key);

  final Tutor tutor;

  @override
  State<TutorSearchCardWidget> createState() => _TutorSearchCardWidgetState();
}

class _TutorSearchCardWidgetState extends State<TutorSearchCardWidget> {
  TutorInfo? _tutorInfo;
  late List<String> _specialties;

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

  Future<void> _getTutorInformation(AuthProvider authProvider) async {
    final String token = authProvider.token?.access?.token as String;

    final learnTopics = authProvider.learnTopics
        .where((topic) =>
            _tutorInfo?.specialties?.split(',').contains(topic.key) ?? false)
        .map((e) => e.name ?? 'null');
    final testPreparations = authProvider.testPreparations
        .where((test) =>
            _tutorInfo?.specialties?.split(',').contains(test.key) ?? false)
        .map((e) => e.name ?? 'null');
    _specialties = [...learnTopics, ...testPreparations];

    final result = await TutorService.getTutorInformationById(
      token: token,
      userId: widget.tutor.userId ?? '',
    );

    if (mounted) {
      setState(() {
        _tutorInfo = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    if (authProvider.token != null) {
      _getTutorInformation(authProvider);
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.teacherDetail,
            arguments: widget.tutor);
      },
      child: Card(
        surfaceTintColor: Theme.of(context).primaryColor,
        elevation: 3.0,
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      widget.tutor.avatar ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.error_outline_rounded,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              widget.tutor.name ??
                                  AppLocalizations(currentLocale)
                                      .translate('null')!,
                              style: Theme.of(context).textTheme.displaySmall),
                          Text(
                              countries[widget.tutor.country ??
                                      AppLocalizations(currentLocale)
                                          .translate('null')!] ??
                                  AppLocalizations(currentLocale)
                                      .translate('unknownCountry')!,
                              style: const TextStyle(fontSize: 16)),
                          widget.tutor.rating == null
                              ? Text(
                                  'No reviews yet',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                )
                              : Row(
                                  children: List<Widget>.generate(
                                    widget.tutor.rating!.round(),
                                    (index) => const Icon(Icons.star,
                                        color: Colors.amber),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (authProvider.token != null) {
                        final String accessToken =
                            authProvider.token?.access?.token as String;
                        await TutorService.addTutorToFavorite(
                          token: accessToken,
                          userId: widget.tutor.userId ?? '',
                        );
                        _getTutorInformation(authProvider);
                      }
                    },
                    icon: _tutorInfo?.isFavorite ?? false
                        ? const Icon(
                            Icons.favorite_rounded,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_rounded,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                  )
                ],
              ),
              subSizedBox,
              Wrap(
                spacing: 8,
                runSpacing: -4,
                children: List<Widget>.generate(
                  _specialties.length,
                  (index) => Chip(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    label: Text(
                      _specialties[index],
                      style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary),
                    ),
                  ),
                ),
              ),
              subSizedBox,
              Text(
                widget.tutor.language ??
                    AppLocalizations(currentLocale).translate('null')!,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
