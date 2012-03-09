class Expense < ActiveRecord::Base
  validates_presence_of :amount, :category, :user_id
  validates_numericality_of :amount
  validates_associated :user

  belongs_to :user

  # new method to sort & paginate the expense list
  def self.list(user_id, params, sort)
        paginate :per_page => 5,
                 :page => params[:page],
                 :conditions => ['user_id = ?', user_id],
                 :order => "#{(params[:c] || sort.to_s).gsub(/[\s;'\"]/,'')} #{params[:d] == 'down' ? 'DESC' : 'ASC'}"
  end

end
