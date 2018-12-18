class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  	@users = User.all
  	@book = Book.new
    @user = User.find(current_user.id)
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def create
    @book = Book.new(user_params)
    @book.user_id = current_user.id
    if @book.save
       flash[:success] = "Book was successfully created."
       redirect_to book_path(@book.id)
    else
       @books = Book.all
       @user = User.find(current_user.id)
       render :index
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:user] = "User was successfully update."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  private
  def user_params
        params.require(:user).permit(:title, :opinion, :name, :introduction, :profile_image)
  end

end
