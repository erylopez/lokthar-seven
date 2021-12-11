class AddListedToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :listed, :boolean, default: true
  end
end
