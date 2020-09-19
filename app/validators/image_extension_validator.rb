require('set')

class ImageExtensionValidator < ActiveModel::Validator
  def validate(record)
    extensions = Set.new(['image/jpeg', 'image/jpg', 'image/png'])
    if record.image.attached? && !extensions.include?(record.image.content_type)
      record.errors[:image].push('を添付してください')
    end
  end
end