class BooksController < ApplicationController
    before_action :authenticate_user!, except: [:top]
    
	def index
		@books = Book.all
		@book = Book.new
		@user = User.find(current_user.id)
    end

    def show
    	@post = Book.find(params[:id])
    	@book = Book.new
    	@user = User.find(@post.user.id)
    end

    def create
        @book = Book.new(book_params)
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
    	@book = Book.find(params[:id])
        if @book.user_id != current_user.id
           redirect_to books_path
        end
    end

    def update
    	@book = Book.find(params[:id])
    	if @book.update(book_params)
           flash[:notice] = "Book was successfully update."
    	   redirect_to book_path(@book.id)
        else
           render :edit
        end
    end

    def destroy
    	book = Book.find(params[:id])
    	book.destroy
        flash[:delete] = "Book was successfully destroyed."
    	redirect_to books_path
    end


    private
    def book_params
  	    params.require(:book).permit(:title, :opinion, :name, :introduction)
    end

end
