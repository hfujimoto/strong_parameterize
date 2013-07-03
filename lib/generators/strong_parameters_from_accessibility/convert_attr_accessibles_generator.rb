module StrongParametersFromAccessibility
  module Generators
    class ConvertAttrAccessiblesGenerator < ::Rails::Generators::NamedBase
      desc 'convert attr_accessible to strong_parameters'
      source_root File.expand_path("../../templates", __FILE__)

      def setup
        StrongParametersFromAccessibility.generator_setup!
      end

      def attr_attributes_comment_out
        return if permitted_attributes.nil?

        gsub_file model_path, /^(\s+)attr_accessible\b/, '\1# attr_accessible'
      end

      TEMPLATE = 'strong_parameter.rb.erb'.freeze
      def add_strong_parameters
        return if permitted_attributes.nil?

        template = find_in_source_paths(TEMPLATE)
        insert_into_file(controller_path, before: /^end\b/) do
          ERB.new(::File.read(template), nil, '-').result(binding)
        end
      end

      private
      def model_path
        "app/models/#{file_path}.rb"
      end

      def controller_path
        ["app/controllers", class_path, "#{plural_name}_controller.rb"].flatten.join('/')
      end

      def params_method_name
        "#{singular_name}_params"
      end

      def permitted_attributes
        class_name.constantize.permitted_attributes
      end
    end
  end
end
