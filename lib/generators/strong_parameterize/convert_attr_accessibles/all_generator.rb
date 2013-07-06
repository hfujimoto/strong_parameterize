module StrongParameterize
  module Generators
    module ConvertAttrAccessibles
      class AllGenerator < ::Rails::Generators::Base 
        desc 'convert attr_accessible to strong_parameters in all models and controllers'

        def setup
          StrongParameterize.generator_setup!
        end

        def execute
          ActiveRecord.model_names.each do |name|
            Rails::Generators.invoke('strong_parameterize:convert_attr_accessibles', [name])
          end
        end
      end
    end
  end
end
