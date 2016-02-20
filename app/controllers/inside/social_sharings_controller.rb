class Inside::SocialSharingsController < Inside::DashboardController
  before_action :authenticate_user!
  before_action :authenticate_inside_privileges

  before_action :set_social_sharing, except: [:index, :new]

  include InsidesHelper
  include ApplicationHelper


  layout 'inside'

  # def index
  #   @images = BlogImage.all
  #   @images = @images.page params[:page]
  # end

  # def new 
  #   @image = BlogImage.new
  # end

  # def show
  # end

  # def edit

  # end

  # def create
  #    @image = BlogImage.new(blog_image_params)
  #    respond_to do |format|
  #     if @image.save 
  #       format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully created." and return}
  #       format.json { render :edit, status: :created, location: @image and return }
  #     else
  #       format.html { render :new and return }
  #       format.json { render json: @image.errors, status: :unprocessable_entity and return }
  #     end
  #   end
  # end


  # def destroy
  #   @image.destroy
  #   respond_to do |format|
  #     format.html { redirect_to inside_blog_images_path, notice: 'Photo was successfully deleted.' }
  #     format.json { head :no_content }
  #   end
  # end

  def update
    respond_to do |format|
     if @social_sharing.update_attributes(social_sharing_params)  
        format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully updated." and return}
        format.json { render :edit, status: :created, location: @image and return }
      else
        format.html { render :edit and return }
        format.json { render json: @image.errors, status: :unprocessable_entity and return }
      end
    end
  end

  private

  def set_social_sharing
    @social_sharing = SocialSharing.find(params[:id])
  end

  def social_sharing_params
        params.require(:social_sharing).permit(:id, )
  end


end
