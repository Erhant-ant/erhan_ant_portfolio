import 'package:web/web.dart' as web;

void downloadCvFile() {
  final currentUrl = web.window.location.href;
  final baseUrl = currentUrl.contains('#') 
      ? currentUrl.substring(0, currentUrl.indexOf('#')) 
      : currentUrl;
      
  final assetUrl = '${baseUrl}assets/assets/documents/Erhan_Ant_CV.pdf';

  final anchor = web.HTMLAnchorElement()
    ..href = assetUrl
    ..download = 'Erhan_Ant_CV.pdf'
    ..target = '_blank'
    // GÜVENLİK GÜNCELLEMESİ: Reverse Tabnabbing atağını önler
    ..rel = 'noopener noreferrer' 
    ..style.display = 'none';

  web.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
}