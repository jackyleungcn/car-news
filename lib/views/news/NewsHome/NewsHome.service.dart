import '../../../common/http/http.dart';

import './SuvNewsPcHomepage.dart';
import './SuvPagesV2MainModel.dart';
import './SuvListArticleTag.dart';

class NewsHomeService {
  getList({tagId = "-1", score = "-1"}) async {
    // var data = await $http
    //     .$post("iyourcar_news_suv/suv/news/pc/homepage", {"page_id": page});

    // SuvNewsPcHomepage suvNewsPcHomepage = new SuvNewsPcHomepage.fromJson(data);

    // return suvNewsPcHomepage;

    Object postObj = { "tag_id": tagId, "_score": score };
    var data = await $http.$post("/iyourcar_news_suv/suv/pages/v2/main", postObj);

    SuvPagesV2MainModel suvPagesV2MainModel = new SuvPagesV2MainModel.fromJson(data);

    return suvPagesV2MainModel;
  }

  getChannel() async {
    var data = await $http.$post("iyourcar_news_suv/suv/list/article_tag", {});

    SuvListArticleTag suvListArticleTag = new SuvListArticleTag.fromJson(data);

    return suvListArticleTag;
  }
}

final $service = new NewsHomeService();
