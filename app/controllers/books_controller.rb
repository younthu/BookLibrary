class BooksController < ApplicationController
  before_filter :find_book, except: [:index, :create, :new]
  before_action :authenticate_user!
  helper_method :sort_column, :sort_direction
  before_filter :authorize_admin, only: [:destroy, :update, :edit, :create, :new]


  def index
    if params[:query].present?
      books = Book.search(params[:query])
      @books = Kaminari.paginate_array(books.results).page(params[:page]).per(15)
    else
      @books = Book.page(params[:page]).per(15).order(sort_column + " " + sort_direction)
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = t('book_saved')
      redirect_to books_path
    else
      flash[:alert] = t('check_required_field')
      redirect_to new_book_path
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @book.destroy
    flash[:alert] = t('book_has_been_deleted') 
    redirect_to books_path
  end

  def update
    @book.update(book_params)
    if @book.save
      flash[:notice] = t('book_saved')
      redirect_to book_path(@book)
    else
      flash[:alert] = t('check_required_field')
      redirect_to new_book_path
    end
  end

  def check_out
    current_user.check_out(@book)
    loan = Loan.where(user: current_user, book: @book, checked_in_at: nil).last
    Nb::Contacts.log_contact(loan, 'Book check-out')
    flash[:notice] = t('you_have_checkedout_somebook', book_title: @book.title)
    redirect_to books_path
  end

  def check_out_on_behalf_of
    user = User.find(params[:book]['user_id'])
    user.check_out(@book)
    flash[:notice] = t('checkout_somebook_for_someone', book_title: @book.title, borrower_name: user.name)
    redirect_to books_path
  end

  def check_in
    current_user.check_in(@book)
    loan = Loan.where(user: current_user, book: @book).last
    Nb::Contacts.log_contact(loan, 'Book check-in')
    flash[:notice] = t('you_have_checkedin_somebook', book_title: @book.title)
    redirect_to books_path
  end

  def check_in_on_behalf_of
    @borrower.check_in(@book)
    flash[:notice] = t('thanks_for_return_boookname_for_borrowername', book_title: @book.title, borrower_name: @borrower.name)
    redirect_to books_path
  end
  private

  def find_book
    @book = Book.find(params[:id])

    #FIXME:bring AmazonBook back by request service token
    #@links = AmazonBook.search_by_isbn(@book.isbn)
    @borrower = @book.borrower
  end

  def book_params
    params.require(:book).permit(
        :title,
        :subtitle,
        :isbn,
        :author_first_name,
        :author_last_name,
        :description,
        :user_id,
        :location_id
      )
  end

  def sort_column
    Book.column_names.include?(params[:sort]) ? params[:sort] : "title"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
