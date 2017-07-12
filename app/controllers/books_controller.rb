class BooksController < ApplicationController
  before_action :set_book, only: [:edit, :update, :destroy]

  # GET /books
  # GET /books.json
  # To be shown on search pages
  def index
    @books = Book.search(params)
    @title = params[:title]
  end

  # GET /books/1
  # GET /books/1.json
  # To be used on an individual book's page
  def show
    # param_title = params[:title].gsub('_', '').downcase
    # titles = Book.all.select(:title).select do |book|
    #   book[:title].downcase.strip.delete(' ').gsub(/[[:punct:]]/, '') == param_title
    # end
    # titles = titles.map(&:title)
    # @books = []
    # titles.each do |title|
    #   @books << Book.all.where(title: title).to_a
    # end
    # @books = @books.to_a.flatten.uniq(&:id)
    # @universities = @books.uniq { |u| u.university }
    @books = Book.search(params)
    @title = params[:title]
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    if @book.valid?
      @book.save
      redirect_to @book
    else
      render :new
    end

    # respond_to do |format|
    #   if @book.save
    #     format.html { redirect_to @book, notice: 'Book was successfully created.' }
    #     format.json { render :show, status: :created, location: @book }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @book.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update

    if @book.update(book_params)
      redirect_to @book
    else
      render :edit
    end

    # respond_to do |format|
    #   if @book.update(book_params)
    #     format.html { redirect_to @book, notice: 'Book was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @book }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @book.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

    def search
      @valid_params = {}
      params.each do |key, value|
         # @valid_params.store(key, value) unless value.empty?
         case key
         when "title"
           @valid_params[key] = value unless value.empty?
         when "condition"
           @valid_params[key] = value unless value.empty?
          when "price"
          @valid_params[key] = value unless value.empty?
          when "edition"
          @valid_params[key] = value unless value.empty?
          when "university"
          @valid_params[key] = value unless value.empty?
          when "subject"
          @valid_params[key] = value unless value.empty?
         end
      end
      @valid_params
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :edition, :condition, :price, :class, :description, :sold, :purchase_id, :user_id)
    end
end
