# frozen_string_literal: true

#
# ApplicationHelper
#
module ApplicationHelper
  def domain_title_tag(text)
    if text.blank?
      'Barong'
    else
      text
    end
  end

  def domain_stylesheet_tag(url)
    stylesheet_link_tag(url) unless url.nil?
  end

  def domain_logo_tag(url)
    if url.blank?
      image_tag('logo-white.png')
    else
      image_tag(url)
    end
  end

  def domain_favicon_tag
    url = domain_asset :favicon

    if url.blank?
      return favicon_link_tag asset_path('favicon.png'), rel: 'icon', type:  'image/png'
    end

    content_tag :link, nil, rel: 'icon', href: url
  end

  def domain_html_tag(text)
    text&.html_safe
  end

  def show_level_mapping
    Level.all.map do |lvl|
      "#{lvl.key}:#{lvl.value} scope \"private\"=> account level #{lvl.id}"
    end.join("\n")
  end
  def locale_name
    I18n.locale.to_s.downcase
  end

  def body_id
    "#{controller_name}-#{action_name}"
  end

  def guide_panel_title
    @guide_panel_title || t("guides.#{i18n_controller_path}.#{action_name}.panel", default: t("guides.#{i18n_controller_path}.panel"))
  end

  def i18n_controller_path
    @i18n_controller_path ||= controller_path.gsub(/\//, '.')
  end

  def guide_intro
    @guide_intro || t("guides.#{i18n_controller_path}.#{action_name}.intro", default: t("guides.#{i18n_controller_path}.intro", default: ''))
  end
end
