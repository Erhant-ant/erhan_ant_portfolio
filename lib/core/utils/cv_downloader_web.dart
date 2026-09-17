import 'package:web/web.dart' as web;

void downloadCvFile() {
  final anchor = web.HTMLAnchorElement()
    ..href = 'assets/assets/documents/Erhan_Ant_CV.pdf'
    ..download = 'Erhan_Ant_CV.pdf';

  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}
