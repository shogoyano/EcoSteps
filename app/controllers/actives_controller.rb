class ActivesController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]
    
    def index
      @actives = Active.all
      search = params[:search]
      @actives = Active.joins(:user).where("about LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%") if search.present?
    
      if params[:tag_ids]
        @actives = []
        params[:tag_ids].each do |key, value|      
          @actives += Tag.find_by(name: key).actives if value == "1"
        end
        @actives.uniq!

        @actives = Kaminari.paginate_array(@actives).page(params[:page]).per(12)
      end
    
      if params[:tag]
        Tag.create(name: params[:tag])
      end

      @actives = @actives.page(params[:page]).per(6)

    end
    
    def new
        @active = Active.new
      end
    
    def create
      active = Active.new(active_params)

      active.user_id = current_user.id

      if active.save!
        redirect_to :action => "index"
      else
        redirect_to :action => "new"
      end
    end
    
    def show
      @active = Active.find(params[:id])
      @comments = @active.comments
      @comment = Comment.new
    end

    def edit
        @active = Active.find(params[:id])
    end

    def update
      active = Active.find(params[:id])
      if active.update(active_params)
        redirect_to :action => "show", :id => active.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy
      active = Active.find(params[:id])
      active.destroy
      redirect_to action: :index
    end

  private
    def active_params
      params.require(:active).permit(:title, :about, :image, tag_ids: [])
    end


end
