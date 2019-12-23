class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|
      t.references :user, foreign_key: true, index: true
      t.string :keyword

      t.timestamps
    end
  end
end
