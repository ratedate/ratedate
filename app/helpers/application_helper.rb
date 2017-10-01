module ApplicationHelper
  def meta_tags
    tags = '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
    tags.html_safe
  end
end
