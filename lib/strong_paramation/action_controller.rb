module StrongParamation
  module ActionController
    def self.controllers
      controller_sources.each {|source| require source }
      ::ActionController.subclasses
    end

    CONTROLLER_SOURCES_PATH = 'app/controllers/**/*_controller.rb'.freeze
    def self.controller_sources
      Dir.glob Rails.root.join(CONTROLLER_SOURCES_PATH)
    end
  end
end
