class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  protect_from_forgery
  before_action :authenticate_user!

  def index
    @items = Item.all
    @collections = current_user.collections
    if params[:query].present?
      @items = Item.search_by_name("#{params[:query]}")
    end
  end

  def show
  end

  def new
    @item = Item.new
  end

  # POST /collections/:collection_id/items
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :new
    end

  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :price, :photo, :collection_id)
  end

end
