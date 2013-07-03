require 'test_helper'

class Vote::DisagreesControllerTest < ActionController::TestCase
  setup do
    @vote_disagree = vote_disagrees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote_disagrees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote_disagree" do
    assert_difference('Vote::Disagree.count') do
      post :create, vote_disagree: { user_id: @vote_disagree.user_id }
    end

    assert_redirected_to vote_disagree_path(assigns(:vote_disagree))
  end

  test "should show vote_disagree" do
    get :show, id: @vote_disagree
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote_disagree
    assert_response :success
  end

  test "should update vote_disagree" do
    patch :update, id: @vote_disagree, vote_disagree: { user_id: @vote_disagree.user_id }
    assert_redirected_to vote_disagree_path(assigns(:vote_disagree))
  end

  test "should destroy vote_disagree" do
    assert_difference('Vote::Disagree.count', -1) do
      delete :destroy, id: @vote_disagree
    end

    assert_redirected_to vote_disagrees_path
  end
end
