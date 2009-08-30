# The default acts_as_taggable_on_steroids model uses id for param.
# Use the name instead for prettier URLs

class Tag < ActiveRecord::Base
  def to_param
    name
  end
end
