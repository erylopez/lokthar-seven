class AddPublishedAtToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :published_at, :datetime
  end
end
