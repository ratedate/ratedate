module ApplicationHelper

  def ref_link
    ref = 'https://ico.ratedate.net/?ref='+current_ico_user.id.to_s
    ref.html_safe
  end
  def meta_tags
    tags = '<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">'
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
  def locale_link(is_mobile)
    tr = '<span class="trigger-left">EN</span><span class="trigger-right">RU</span>'
    html_class = 'btn-link trigger'
    if is_mobile
      html_class += ' mobile'
    end
    if I18n.locale==:ru
      link_to({locale: :en}, html_options= {class: html_class+" active"}) do
        tr.html_safe
      end
    else
      link_to({locale: :ru}, html_options={class: html_class}) do
        tr.html_safe
      end
    end
  end
  def wp_link(html_class)
    if I18n.locale==:ru
      link_to "White Paper", "/assets/white_paper_ru_4_0.pdf", {class: html_class, target: "_blank"}
    else
      link_to "White Paper", "/assets/white_paper_en_4_0.pdf", {class: html_class, target: "_blank"}
    end
  end

  # helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def online_status(user)
    content_tag :span, '',
                class: "user-#{user.id} online-status #{'online' if user.online?}"
  end

  def user_avatar
    if current_user.profile.present?
      if current_user.profile.avatar.small_avatar.file.present?
        image_tag current_user.profile.avatar.url(:small_avatar), class: 'rounded-circle', id: 'signed-user'
      else
        image_tag "small_avatar_placeholder.png", class: 'rounded-circle', id: 'signed-user'
      end
    else
      image_tag "small_avatar_placeholder.png", class: 'rounded-circle', id: 'signed-user'
    end
  end

  def etz_raised
    '7109.9000'
  end
end
