class AddResultinfoToresults < ActiveRecord::Migration
  def change
 	add_column :results, :result_info, :string
  end
end
