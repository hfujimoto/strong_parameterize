require 'strong_paramation/version'
require 'strong_paramation/active_record'
require 'strong_paramation/active_record/replacement'
require 'strong_paramation/action_controller'

module StrongParamation
  def self.generator_setup!
    unless @already_setup
      ::ActiveRecord::Base.extend(ActiveRecord::Replacement)
    end
    @already_setup = true
  end
end
