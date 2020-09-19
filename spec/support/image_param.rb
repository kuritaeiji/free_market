module ImageParam
  def image_param
    ActionDispatch::Http::UploadedFile.new(tempfile: File.open(Rails.root.join('spec', 'images', 'sample.jpg')), content_type: 'image/jpg')
  end
end