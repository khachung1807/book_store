class BooksController < ApplicationController
  before_action :search_book, only: [:index]
  def index
    @categories = Category.order :category_name
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = "Them sach thanh cong"
      redirect_to root_url
    else
      flash[:danger] = "Khong the tao sach"
      render :new
    end
  end

  def show
    @book = Book.find params[:id]
  end

  private

  def search_book
    @book = if params[:query].present?
              Book.search(params[:query]).paginate page: params[:page],
                per_page: Settings.per_page_search
            elsif params[:check] == "1" && params[:query].present? == false
              Category.find(params[:category_id]).books.paginate page: params[:page],
                per_page: Settings.per_page_search
            else
              Book.all.paginate page: params[:page],
                per_page: Settings.per_page
            end
    return if @book
    flash[:danger] = t("not_found")
    redirect_to root_path
  end

  def book_params
    params.require(:book).permit :category_id, :name, :author, :quantity,
      :price, :description
  end
end
