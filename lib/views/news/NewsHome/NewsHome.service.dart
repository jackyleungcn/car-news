import 'package:dio/dio.dart';
import '../../../common/http/http.dart';
import './SuvNewsPcHomepage.dart';

class NewsHomeService {
  getList(page) async {
    FormData formData = new FormData.from({
      "data": {"page_id": page},
    });

    var data =
        await $http.$post("iyourcar_news_suv/suv/news/pc/homepage", formData);

    SuvNewsPcHomepage suvNewsPcHomepage = new SuvNewsPcHomepage.fromJson(data);

    return suvNewsPcHomepage;
  }
}

final $service = new NewsHomeService();
