class AddStartDateToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :start_date, :date
  end
end
