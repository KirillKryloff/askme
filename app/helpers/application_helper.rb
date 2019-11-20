module ApplicationHelper

  def declension(number, one, few, many)
    if (11..14).include?(number % 100)
      return many
    end

    remainder = number % 10
    if (remainder == 1)
      return one
    end

    if (remainder >= 2 && remainder <= 4)
      return few
    end

    if (remainder >= 5 && remainder <= 9 || remainder == 0)
      return many
    end
  end

  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end
end
