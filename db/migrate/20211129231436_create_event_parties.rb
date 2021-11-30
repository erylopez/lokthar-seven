class CreateEventParties < ActiveRecord::Migration[7.0]
  def change
    create_table :event_parties do |t|
      t.references :event, null: false, foreign_key: true
      t.jsonb :members
      t.jsonb :party_format
      t.string :title

      t.timestamps
    end
  end
end
