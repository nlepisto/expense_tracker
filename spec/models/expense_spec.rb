require 'spec_helper'

describe Expense do
  describe "validations" do
    before do
      @expense = Factory(:expense)
    end

    it "is valid from the factory" do
      @expense.should be_valid
    end

    it "is not valid without amount" do
      @expense.amount = nil
      @expense.should_not be_valid
    end

    it "is not valid without category" do
      @expense.category = nil
      @expense.should_not be_valid
    end
  end
end
