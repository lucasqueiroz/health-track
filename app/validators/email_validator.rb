class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  def validate_each(record, attribute, value)
    format = options[:format] || EMAIL_REGEX
    invalidate(record, attribute) unless value =~ format
  end

  private

  def invalidate(record, attribute)
    record.errors.add(attribute, options[:message] || 'is not a valid email')
  end
end