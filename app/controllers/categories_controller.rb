class CategoriesController < ApplicationController
  before_filter :signed_in_user

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to @category
    else
      render action: "new"
    end
  end

  # PUT /categories/1
  def update
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      redirect_to @category
    else
      render action: "edit"
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
  end
end
