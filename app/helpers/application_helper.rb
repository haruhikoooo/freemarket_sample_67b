module ApplicationHelper

  def get_thumbnail(good)
    good.images.first.image
  end

end
