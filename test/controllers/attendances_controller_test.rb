require 'test_helper'

class AttendancesControllerTest < ActionController::TestCase
  setup do
    sign_in admins(:one)
    sign_in coordinators(:one)
    sign_in reg_desks(:one)
    @attendance = attendances(:one)
    @update = {
      team_id: 8000,
      event_id: 100,
      round: 15,
      status: "present"
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:attendances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create attendance" do
    assert_difference('Attendance.count') do
      post :create, attendance: @update
    end

    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should show attendance" do
    get :show, id: @attendance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @attendance
    assert_response :success
  end

  test "should update attendance" do
    patch :update, id: @attendance, attendance: @update
    assert_redirected_to attendance_path(assigns(:attendance))
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete :destroy, id: @attendance
    end

    assert_redirected_to attendances_path
  end
end
