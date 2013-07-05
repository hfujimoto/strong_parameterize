module StrongParamations
  module Generators
    class ConvertAttrAccessiblesGenerator < ::Rails::Generators::NamedBase
      desc 'convert attr_accessible to strong_parameters'
      source_root File.expand_path("../../templates", __FILE__)

      STATUS_LABELS = {
        discard_attr_accessibles: 'discard_attr_accessibles',
                strong_parameter: '        strong_parameter',
                            skip: '                    skip',
      }.freeze

      def tasks
        return unless setup!

        discard_attr_accessibles!
        add_strong_parameters!
      end

      private
      def setup!
        StrongParamations.generator_setup!
        check_class_definitions!
      end

      def check_class_definitions!
        case
        when model_class.nil?
          say_status status(:skip), "#{model_path} (model is missing)"
        when ! model_class.ancestors.include?(::ActiveRecord::Base)
          say_status status(:skip), "#{class_name} (model is not a subclass of ActiveRecord::Base)"
        when permitted_attributes.nil?
          say_status status(:skip), "#{class_name} (attr_accessible is not found in model)" 
        when ! Rails.root.join(controller_path).file?
          say_status status(:skip), "#{class_name} (controller is missing)" 
        else
          return true
        end
        false
      end

      def discard_attr_accessibles!
        say_status status(:discard_attr_accessibles), model_path
        gsub_file model_path, /^(\s+)attr_accessible\b.+$\n/, '', verbose: false
      end

      TEMPLATE = 'strong_parameter.rb.erb'.freeze
      def add_strong_parameters!
        template = find_in_source_paths(TEMPLATE)
        say_status status(:strong_parameter), controller_path
        insert_into_file(controller_path, before: /^end\b/, verbose: false) do
          ERB.new(::File.read(template), nil, '-').result(binding)
        end
      end

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
        return nil if model_class.nil?
        model_class.permitted_attributes
      end

      def model_class
        class_name.constantize rescue nil
      end

      def status(key)
        STATUS_LABELS[key]
      end
    end
  end
end
