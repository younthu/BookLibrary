class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :book_title
      t.string :book_isbn
      t.belongs_to :user
    end
  end
end
