class InstagramsController < ApplicationController
  before_action :authenticate_user!

  def index

    if params[:search] == nil
      @instagrams= Instagram.all
    elsif params[:search] == ''
      @instagrams= Instagram.all
    else
      @instagrams = Instagram.where("body LIKE ? ",'%' + params[:search] + '%')
    end
    
  end

  def new
      @instagram = Instagram.new
  end
  
  def create
    instagram = Instagram.new(instagram_params)
    instagram.user_id = current_user.id
      if instagram.save
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
  end
  
  def show
    @instagram = Instagram.find(params[:id])

    @comments = @instagram.comments
    @comment = Comment.new

  end

  def edit
    @instagram = Instagram.find(params[:id])
  end

  def update
    instagram = Instagram.find(params[:id])
    if instagram.update(instagram_params)
      redirect_to :action => "show", :id => instagram.id
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    instagram = Instagram.find(params[:id])
    instagram.destroy
    redirect_to action: :index
  end

  private
  def instagram_params
      params.require(:instagram).permit(:body,:image)
  end

end
