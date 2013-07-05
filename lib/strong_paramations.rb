require 'strong_paramations/version'
require 'strong_paramations/active_record'
require 'strong_paramations/active_record/replacement'
require 'strong_paramations/action_controller'

module StrongParamations
  def self.generator_setup!
    unless @already_setup
      ::ActiveRecord::Base.extend(ActiveRecord::Replacement)
    end
    @already_setup = true
  end
end
