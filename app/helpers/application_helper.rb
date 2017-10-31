module ApplicationHelper

  def ref_link
    ref = 'https://ico.ratedate.net/?ref='+current_ico_user.id.to_s
    ref.html_safe
  end
  def meta_tags
    tags = '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
    tags.html_safe
  end
  def google_analytics
    ga = "<!-- Global Site Tag (gtag.js) - Google Analytics -->
<script async src='https://www.googletagmanager.com/gtag/js?id=UA-107749703-1'></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-107749703-1');
</script>"
    ga.html_safe
  end
  def ya_metric
    ym="<!-- Yandex.Metrika counter -->
<script type=\"text/javascript\" >
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter46261626 = new Ya.Metrika({
                    id:46261626,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true,
                    webvisor:true,
                    trackHash:true
                });
            } catch(e) { }
        });

        var n = d.getElementsByTagName(\"script\")[0],
            s = d.createElement(\"script\"),
            f = function () { n.parentNode.insertBefore(s, n); };
        s.type = \"text/javascript\";
        s.async = true;
        s.src = \"https://mc.yandex.ru/metrika/watch.js\";

        if (w.opera == \"[object Opera]\") {
            d.addEventListener(\"DOMContentLoaded\", f, false);
        } else { f(); }
    })(document, window, \"yandex_metrika_callbacks\");
</script>
<noscript><div><img src=\"https://mc.yandex.ru/watch/46261626\" style=\"position:absolute; left:-9999px;\" alt=\"\" /></div></noscript>
<!-- /Yandex.Metrika counter -->"
    ym.html_safe
  end
  def locale_link
    if I18n.locale==:ru
      link_to "en", { locale: :en }, class: "nav-link"
    else
      link_to "ru", { locale: :ru }, class: "nav-link"
    end
  end
  def wp_link(html_class)
    if I18n.locale==:ru
      link_to "загрузить white paper", "/assets/white_paper_ru_1_2.pdf", {class: html_class, target: "_blank"}
    else
      link_to "download white paper", "/assets/white_paper_en_1_2.pdf", {class: html_class, target: "_blank"}
    end
  end
end
