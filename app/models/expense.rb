class Expense < ActiveRecord::Base
  validates_presence_of :amount, :category
  validates_numericality_of :amount

  belongs_to :user
end
