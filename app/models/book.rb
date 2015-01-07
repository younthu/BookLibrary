class Book < ActiveRecord::Base
  validates :title, :isbn, presence: true
  belongs_to :user
  has_many :loans
  has_many :borrowers, class_name: "Loan", foreign_key: :book_id

  def author_name
    name = [author_first_name, author_last_name].map(&:to_s).join(" ").strip
    name.empty? ? "No author name given" : name
  end

  def owner
    User.find(self.user_id)
  end

  def change_owner(user=nil)
    return unless user
    self.user = user
    save
  end

end
