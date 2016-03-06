require 'test_helper'

class ParticipantsControllerTest < ActionController::TestCase
  setup do
    @participant = participants(:one)
    sign_in admins(:one)
    sign_in reg_desks(:one)
    @update = {
      name: "ruby",
      email: "google@google.com",
      phone: "9811141623",
      college: "bvicam"
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:participants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create participant" do
    assert_difference('Participant.count') do
      post :create, participant: @update
    end

    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should show participant" do
    get :show, id: @participant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @participant
    assert_response :success
  end

  test "should update participant" do
    patch :update, id: @participant, participant: @update
    assert_redirected_to participant_path(assigns(:participant))
  end

  test "should destroy participant" do
    assert_difference('Participant.count', -1) do
      delete :destroy, id: @participant
    end

    assert_redirected_to participants_path
  end
end
