require 'strong_parameters_from_accessibility/version'
require 'strong_parameters_from_accessibility/active_record'
require 'strong_parameters_from_accessibility/active_record/replacement'
require 'strong_parameters_from_accessibility/action_controller'

module StrongParametersFromAccessibility
  def self.generator_setup!
    unless @already_setup
      ::ActiveRecord::Base.extend(ActiveRecord::Replacement)
    end
    @already_setup = true
  end
end
