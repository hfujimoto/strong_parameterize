module StrongParamation
  module ActiveRecord
    def self.models
      model_sources.each {|source| require source }
      ::ActiveRecord::Base.subclasses
    end

    MODEL_SOURCES_PATH = 'app/models/**/*.rb'.freeze
    def self.model_sources
      Dir.glob Rails.root.join(MODEL_SOURCES_PATH)
    end

    def self.model_names
      models.collect do |model|
        model.name.underscore
      end
    end
  end
end
