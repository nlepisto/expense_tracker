class ExpensesController < ApplicationController
  before_filter :authenticate_user!

  def index
    #call the model with updated sort & pagination code
    @expenses = Expense.list(current_user.id, params, 'id')
  end

  def show
    @expense = Expense.find_by_id_and_user_id(params[:id], current_user.id) || not_found
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find_by_id_and_user_id(params[:id], current_user.id) || not_found
  end

  def create
    @expense = Expense.new(params[:expense].merge(:user_id => current_user.id))

    if @expense.save
      redirect_to @expense, notice: "expense created successfully"
    else
      flash[:error] = @expense.errors.full_messages
      render action: "new", error: @expense.errors.full_messages
    end
  end

  def update
    @expense = Expense.find_by_id_and_user_id(params[:id], current_user.id) || not_found

    if @expense.update_attributes(params[:expense])
      redirect_to @expense, notice: "expense updated successfully"
    else
      flash[:error] = @expense.errors.full_messages
      render action: "edit", error: @expense.errors.full_messages
    end
  end

  def destroy
    expense = Expense.find_by_id_and_user_id(params[:id], current_user.id) || not_found
    expense.destroy
    redirect_to expenses_path
  end
end
