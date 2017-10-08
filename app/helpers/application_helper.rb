module ApplicationHelper
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
end
