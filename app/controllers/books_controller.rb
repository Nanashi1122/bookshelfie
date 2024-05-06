class BooksController < ApplicationController
  def search 
    if params[:search].nil?
      return
    elsif params[:search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    else
      url = "https://www.googleapis.com/books/v1/volumes"
      text = params[:search]
      res = Faraday.get(url, q: text, langRestrict: 'ja', printType: 'books', maxResults: 20, orderBy: 'newest')
      @google_books = JSON.parse(res.body)
    end
  end

  def create
    @book = book_params
    binding.pry
    if @book.save_with_author(authors_params[:authors])
      redirect_to books_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
    end
  end

  def index
    @books = Book.includes(:authors).all  # N+1問題を防ぐために`includes`を使用
    
  end

  private

  def book_params
    params.require(:book).permit(:title, :image_link, :info_link, :published_date, :systemid, authors: [])
  end

  def authors_params
    params.require(:book).permit(authors: [])
  end
end
