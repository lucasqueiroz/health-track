class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?
    after = options[:after] || Date.new(1900, 1, 1)
    before = options[:before] || Date.today
    invalidate(record, attribute) unless value.between?(after, before)
  end

  private

  def invalidate(record, attribute)
    record.errors.add(attribute, options[:message] || 'is not a valid date')
  end
end