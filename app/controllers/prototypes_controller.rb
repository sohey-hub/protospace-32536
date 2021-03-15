class PrototypesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    if Prototype.create(prototype_params)
      redirect_to root_path
    else
      @prototypes = @prototype
      render :prototype
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    unless user_signed_in? && current_user.id == @prototype.user
      redirect_to root_path
    else
      @prototype = Prototype.find(params[:id])
    end
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path method: :get
   else 
      render :prototype
   end
  end

   def destroy
     prototype = Prototype.find(params[:id])
     prototype.destroy
     redirect_to root_path
   end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end

