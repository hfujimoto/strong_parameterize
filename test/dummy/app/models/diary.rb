class Diary < ActiveRecord::Base
  attr_accessible *%w[title content].map(&:to_sym)
end
