import 'package:web/web.dart' as web;

class SeoService {
  SeoService._();

  static void updateMeta({required String title, required String description}) {
    try {
      // 1. Tarayıcı sekme başlığını (Title) günceller
      web.document.title = title;

      // 2. Meta Description etiketini günceller
      final metas = web.document.getElementsByTagName('meta');
      bool found = false;
      
      for (int i = 0; i < metas.length; i++) {
        final meta = metas.item(i) as web.HTMLMetaElement;
        if (meta.name == 'description') {
          meta.content = description;
          found = true;
          break;
        }
      }
      
      // Eğer yoksa (fallback) yeni bir meta description oluşturur
      if (!found) {
        final newMeta = web.HTMLMetaElement()
          ..name = 'description'
          ..content = description;
        web.document.head?.append(newMeta);
      }
    } catch (e) {
      // Platform web değilse hata vermemesi için sessizce yutuyoruz
    }
  }
}