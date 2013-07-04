module StrongParametersFromAccessibility
  module Generators
    module ConvertAttrAccessibles
      class AllGenerator < ::Rails::Generators::Base 
        desc 'convert attr_accessible to strong_parameters in all models and controllers'

        def setup
          StrongParametersFromAccessibility.generator_setup!
        end

        def execute
          ActiveRecord.model_names.each do |name|
            Rails::Generators.invoke('strong_parameters_from_accessibility:convert_attr_accessibles', [name])
          end
        end
      end
    end
  end
end
