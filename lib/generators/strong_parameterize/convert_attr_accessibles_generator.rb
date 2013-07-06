module StrongParameterize
  module Generators
    class ConvertAttrAccessiblesGenerator < ::Rails::Generators::NamedBase
      desc 'convert attr_accessible to strong_parameters'
      source_root File.expand_path("../../templates", __FILE__)

      STATUS_PADDING = 25

      ATTR_ACCESSIBLE_WORD_MATCHER = /\battr_accessible\b/
      ATTR_ACCESSIBLE_LINE_MATCHER = /^(\s+)attr_accessible\s*(?:(?::\w+),\s*)*:\w+\s*$\n/

      SHOW_POSSIBLE_LINES_COUNT = 3

      TEMPLATE_PATH = 'strong_parameter.rb.erb'.freeze

      def tasks
        return unless setup!

        discard_attr_accessibles!
        add_strong_parameters!
      end

      private
      def setup!
        StrongParameterize.generator_setup!
        check_class_definitions!
      end

      def check_class_definitions!
        case
        when model_class.nil?
          status :skip, :blue, "#{model_path} (model is missing)"
        when ! model_class.ancestors.include?(::ActiveRecord::Base)
          status :skip, :blue, "#{class_name} (model is not a subclass of ActiveRecord::Base)"
        when permitted_attributes.nil?
          status :skip, :blue, "#{class_name} (attr_accessible is not found in the model)" 
        else
          return true
        end
        false
      end

      def discard_attr_accessibles!
        if model_content =~ ATTR_ACCESSIBLE_WORD_MATCHER
          status :discard_attr_accessibles, :green, model_path
          if model_content =~ ATTR_ACCESSIBLE_LINE_MATCHER
            gsub_file model_path, ATTR_ACCESSIBLE_LINE_MATCHER, '', verbose: false
          else
            status :impossibility, :red, "#{model_path} (you need rewrite manually below lines)"
            show_model_possible_lines
          end
        else
          status :skip, :blue, "#{class_name} (attr_accessible is not found in the model)" 
        end
      end

      def add_strong_parameters!
        return unless controller_exists?

        template = find_in_source_paths(TEMPLATE_PATH)
        status :strong_parameter, :green, controller_path
        insert_into_file(controller_path, before: /^end\b/, verbose: false) do
          ERB.new(::File.read(template), nil, '-').result(binding)
        end
      end

      def model_path
        "app/models/#{file_path}.rb"
      end

      def model_pathname
        Rails.root.join(model_path)
      end

      def model_exists?
        model_pathname.file? && model_class
      end

      def model_content
        model_pathname.read
      end

      def model_class
        class_name.constantize rescue nil
      end

      def controller_path
        ["app/controllers", class_path, "#{plural_name}_controller.rb"].flatten.join('/')
      end

      def controller_pathname
        Rails.root.join(controller_path)
      end

      def controller_exists?
        controller_pathname.file? && controller_class
      end

      def controller_content
        controller_pathname.read
      end

      def controller_class
        "#{class_name.pluralize}Controller".constantize
      end

      def params_method_name
        "#{singular_name}_params"
      end

      def permitted_attributes
        return nil if model_class.nil?
        model_class.permitted_attributes
      end

      def status(label, label_color = :green, text = '')
        label = label.to_s.chomp.rjust(STATUS_PADDING)
        say label, [:bold, label_color], false
        say (" " * 2) + text, :white
      end

      def show_model_possible_lines
        last_matches = nil
        model_content.lines.each.with_index do |line, number|
          line.chomp!
          last_matches = if line =~ ATTR_ACCESSIBLE_WORD_MATCHER
                           number
                         elsif line.size == 0 or line =~ /^end$/
                           nil
                         end
          if last_matches && last_matches + SHOW_POSSIBLE_LINES_COUNT > number
            status '', :white, "#{number}: #{line}"
          end
        end
      end
    end
  end
end
