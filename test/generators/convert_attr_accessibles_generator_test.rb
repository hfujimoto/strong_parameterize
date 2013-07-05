require 'test_helper'

require "generators/strong_paramations/convert_attr_accessibles_generator"

class ConvertAttrAccessiblesTest < Rails::Generators::TestCase
  tests StrongParamations::Generators::ConvertAttrAccessiblesGenerator
  destination File.expand_path("../../tmp", __FILE__)

  module AttrAccessibleDeprecating
    def attr_accessible(*)
      raise AttrAccessibleCalledError
    end
  end

  setup do
    prepare_destination
    FileUtils.cp_r Dir.glob('test/dummy/*'), destination_root
    load "#{destination_root}/config/application.rb"
  end

  test "comment out attr_accessor for simple model" do
    run_generator %w(user)
    assert_file "app/models/user.rb", /# attr_accessible/
  end

  test "comment out attr_accessor for namespaced model" do
    run_generator %w(vote/agree)
    assert_file "app/models/vote/agree.rb", /# attr_accessible\b/
  end

  test "insert strong parameters module into controller for simple model" do
    run_generator %w(user)
    assert_file "app/controllers/users_controller.rb", /\bmodule StrongParameters\b/
    assert_file "app/controllers/users_controller.rb", /\bdef user_params\b/
  end

  test "insert strong parameters module into controller for namespaced model" do
    run_generator %w(vote/agree)
    assert_file "app/controllers/vote/agrees_controller.rb", /\bmodule StrongParameters\b/
    assert_file "app/controllers/vote/agrees_controller.rb", /\bdef vote_agree_params\b/
  end

  test "skip for unbalanced model" do
    run_generator %w(role)
    assert_file "app/models/role.rb", /^\s+attr_accessible\b/
  end

  test "skip for unbalanced controller" do
    run_generator %w(dashboard)
    assert_file "app/controllers/dashboard_controller.rb" do |controller|
      assert_no_match /\b module StrongParameters\b/, controller
    end
  end

  test "StrongParameters module including for simple controller" do
    run_generator %w(user)
    load "#{destination_root}/app/controllers/users_controller.rb"
    assert UsersController.include?(UsersController::StrongParameters)
  end

  test "attr_accessible no longer call for simple model" do
    User.send(:extend, AttrAccessibleDeprecating)

    assert_raises(AttrAccessibleCalledError) do
      load "#{destination_root}/app/models/user.rb"
    end

    run_generator %w(user)

    assert_nothing_raised do
      load "#{destination_root}/app/models/user.rb"
    end
  end
end
