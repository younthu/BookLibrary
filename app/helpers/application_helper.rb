module ApplicationHelper
  def borrowed_books_count
    Book.checked_out_books.count
  end

  def users_with_books_count
    User.with_books.count
  end

  def all_users
    User.all
  end

  def total_book_count
    Book.count
  end

  def total_user_count
    User.count
  end

  def human_boolean(boolean)
    boolean ? 'Yes' : 'No'
  end
end
