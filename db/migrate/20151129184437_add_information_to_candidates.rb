class AddInformationToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :information, :string
  end
end
