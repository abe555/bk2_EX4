class BooksController < ApplicationController
  before_action :authenticate_user!

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    @user = current_user
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      flash[:notice] = "error!"
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if current_user == @user
      @book = Book.find(params[:id])
    else
      flash[:notice] = "error!"
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      flash[:notice] = "error!"
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
