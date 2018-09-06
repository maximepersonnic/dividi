module ItemsHelper
  def card_background_image_path(item)
    if item.photo.present?
      cl_image_tag item.photo, alt: "#{item.name}", class: "image-item"
    else
      image_tag("fallback/default-picture.png")
    end
  end

  def url_image(item)
    if item.photo.present?
      item.photo
    else
      ""
    end
  end
end
