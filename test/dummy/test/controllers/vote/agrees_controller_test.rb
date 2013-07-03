require 'test_helper'

class Vote::AgreesControllerTest < ActionController::TestCase
  setup do
    @vote_agree = vote_agrees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vote_agrees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote_agree" do
    assert_difference('Vote::Agree.count') do
      post :create, vote_agree: { user_id: @vote_agree.user_id }
    end

    assert_redirected_to vote_agree_path(assigns(:vote_agree))
  end

  test "should show vote_agree" do
    get :show, id: @vote_agree
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vote_agree
    assert_response :success
  end

  test "should update vote_agree" do
    patch :update, id: @vote_agree, vote_agree: { user_id: @vote_agree.user_id }
    assert_redirected_to vote_agree_path(assigns(:vote_agree))
  end

  test "should destroy vote_agree" do
    assert_difference('Vote::Agree.count', -1) do
      delete :destroy, id: @vote_agree
    end

    assert_redirected_to vote_agrees_path
  end
end
