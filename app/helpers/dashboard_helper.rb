module DashboardHelper
  def last_height_value
    last_height.nil? ? "No last height" : last_height.measurement
  end

  def last_height_date
    last_height.nil? ? "No last height" : last_height.measured_at
  end

  def last_weight_value
    last_weight.nil? ? "No last weight" : last_weight.measurement
  end

  def last_weight_date
    last_weight.nil? ? "No last weight" : last_weight.measured_at
  end

  private

  def last_height
    current_user.heights.last
  end

  def last_weight
    current_user.weights.last
  end
end