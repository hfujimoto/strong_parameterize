require 'strong_parameterize/version'
require 'strong_parameterize/active_record'
require 'strong_parameterize/active_record/replacement'
require 'strong_parameterize/action_controller'

module StrongParameterize
  def self.generator_setup!
    unless @already_setup
      ::ActiveRecord::Base.extend(ActiveRecord::Replacement)
    end
    @already_setup = true
  end
end
