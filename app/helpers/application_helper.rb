module ApplicationHelper
  def image(size)
    image_tag('http://www.sclance.com/pngs/smiley-face-transparent-png/smiley_face_transparent_png_1258029.png',
              size: "#{size}x#{size}")
  end
end
