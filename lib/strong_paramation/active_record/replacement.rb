module StrongParamation
  module ActiveRecord
    module Replacement
      def attr_accessible(*args)
        @permitted_attributes ||= []
        @permitted_attributes += args
      end

      def permitted_attributes
        return nil if @permitted_attributes.nil?
        @permitted_attributes.dup.freeze
      end
    end
  end
end
