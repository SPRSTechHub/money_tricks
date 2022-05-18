// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:money_tricks/utils/colors.dart';
import 'package:money_tricks/utils/style.dart';

class TopbarWithSearchWidget extends StatefulWidget {
  final String title;
  const TopbarWithSearchWidget({Key? key, required this.title})
      : super(key: key);
  @override
  State<TopbarWithSearchWidget> createState() => _TopbarWithSearchWidgetState();
}

class _TopbarWithSearchWidgetState extends State<TopbarWithSearchWidget> {
  late TextEditingController textController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22.0),
      width: MediaQuery.of(context).size.width,
      height: 60,
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),
      decoration: const BoxDecoration(
        color: AppColors.appbarbg,
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 2, 10, 2),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 0, 0, 0), blurRadius: 2.0),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage('assets/images/loggoo.png'),
                ),
              ),
            ),
            Text(
              widget.title,
              style: StyleText.post_title_text,
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white60,
                  )
                ],
                borderRadius: BorderRadius.circular(12),
                shape: BoxShape.rectangle,
              ),
              child: const Icon(
                Icons.search_outlined,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
