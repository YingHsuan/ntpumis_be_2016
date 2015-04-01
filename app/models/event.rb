class Event < ActiveRecord::Base
  before_save :default_values

  def default_values
    self.id =  SecureRandom.uuid
  end
end
