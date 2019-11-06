module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/assets/images
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
end
