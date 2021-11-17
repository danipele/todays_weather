class CreateLimitsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :limits do |t|
      t.string :between
      t.decimal :degrees, precision: 10, scale: 2

      t.timestamps
    end
  end
end
