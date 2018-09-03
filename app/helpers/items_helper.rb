module ItemsHelper
  def card_background_image_path(item)
    if @item.photo.present?
      # cl_image_path(item.photo, height: 300, width: 400, crop: :fill)
      cl_image_tag @item.photo, alt: "#{@item.name}", class: "cloudinary-show"
    else
      image_tag("fallback/default-picture.png"), class: "default-picture"
    end
  end
end
