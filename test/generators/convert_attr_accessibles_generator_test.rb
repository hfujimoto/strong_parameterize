require 'test_helper'

require "generators/strong_paramation/convert_attr_accessibles_generator"

class ConvertAttrAccessiblesTest < Rails::Generators::TestCase
  tests StrongParamation::Generators::ConvertAttrAccessiblesGenerator
  destination File.expand_path("../../tmp", __FILE__)

  setup do
    prepare_destination
    FileUtils.cp_r Dir.glob('test/dummy/*'), destination_root

    run_generator %w(user)
    run_generator %w(vote/agree)
  end

  test "comment out attr_accessor for simple model" do
    assert_file "app/models/user.rb", /# attr_accessible/
  end

  test "comment out attr_accessor for namespaced model" do
    assert_file "app/models/vote/agree.rb", /# attr_accessible\b/
  end

  test "insert strong parameters module into controller for simple model" do
    assert_file "app/controllers/users_controller.rb", /\bmodule StrongParameters\b/
    assert_file "app/controllers/users_controller.rb", /\bdef user_params\b/
  end

  test "insert strong parameters module into controller for namespaced model" do
    assert_file "app/controllers/vote/agrees_controller.rb", /\bmodule StrongParameters\b/
    assert_file "app/controllers/vote/agrees_controller.rb", /\bdef vote_agree_params\b/
  end

end
