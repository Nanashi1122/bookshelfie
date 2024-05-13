class BooksController < ApplicationController
  def search
    query_parts = []
    query_parts << "intitle:#{URI.encode_www_form_component(params[:title])}" if params[:title].present?
    query_parts << "inauthor:#{URI.encode_www_form_component(params[:author])}" if params[:author].present?
    query_parts << "isbn:#{URI.encode_www_form_component(params[:isbn])}" if params[:isbn].present?

    if query_parts.empty?
      flash.now[:danger] = '検索条件を少なくとも一つ入力してください'
      return
    end
  
    query_string = query_parts.join('+')
    url = "https://www.googleapis.com/books/v1/volumes?q=#{query_string}&langRestrict=ja&printType=books&maxResults=20&orderBy=newest"
    Rails.logger.info "Requesting URL: #{url}"
    res = Faraday.get(url)
    @google_books = JSON.parse(res.body)
  end

  def create
    @book = Book.new(book_params)
    if @book.save_with_author(authors_params)
      redirect_to books_path, notice: '本を登録しました'
    else
      flash.now[:alert] = 'Error creating book.'
      render :new
    end
  end

  def index
    @books = Book.includes(:authors).all  # N+1問題を防ぐために`includes`を使用
  end

  private

  def book_params
    params.require(:book).permit(:title, :authors, :list_price, :publisher, :image_link, :info_link, :published_date, :info_link, :systemid)
  end

  def authors_params
    params.require(:book).fetch(:authors, []).map(&:to_s)
  end
end
