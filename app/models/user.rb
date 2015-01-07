class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books_owned, class_name: "Book", foreign_key: :user_id
  has_many :loans
  has_many :books_borrowed, class_name: "Loan", foreign_key: :user_id
  
  def make_admin
    update(admin: true)
  end

  def remove_admin
    update(admin: false)
  end

  def send_signup_email
    UserNotifier.send_signup_email(self).deliver
  end

  def send_overdue_email
    UserNotifier.send_overdue_email(self).deliver
  end

  def name
    name = [first_name, last_name].map(&:to_s).join(" ").strip
    name.empty? ? "No name" : name
  end
end
