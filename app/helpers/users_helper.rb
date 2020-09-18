module UsersHelper
  def user_image(user, width)
    if user.image.attached?
      image_tag(user.image, class: "#{width}") #w-75
    else
      image_pack_tag('media/images/default.jpg', class: "#{width}")
    end
  end

  def prefecture_options(prefectures)
    prefectures.reduce([]) do |array, prefecture|
      array.push([prefecture.name, prefecture.id])
    end
  end
end
