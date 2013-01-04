require 'test_helper'

class RunsControllerTest < ActionController::TestCase
  setup do
    @run = runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create run" do
    assert_difference('Run.count') do
      post :create, run: { next_due: @run.next_due, notes: @run.notes, sell_date: @run.sell_date, sell_price: @run.sell_price, ship: @run.ship, ship_number: @run.ship_number, start_date: @run.start_date, status: @run.status }
    end

    assert_redirected_to run_path(assigns(:run))
  end

  test "should show run" do
    get :show, id: @run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @run
    assert_response :success
  end

  test "should update run" do
    put :update, id: @run, run: { next_due: @run.next_due, notes: @run.notes, sell_date: @run.sell_date, sell_price: @run.sell_price, ship: @run.ship, ship_number: @run.ship_number, start_date: @run.start_date, status: @run.status }
    assert_redirected_to run_path(assigns(:run))
  end

  test "should destroy run" do
    assert_difference('Run.count', -1) do
      delete :destroy, id: @run
    end

    assert_redirected_to runs_path
  end
end
