class Inside::UsersController < Inside::DashboardController
  include InsidesHelper
  include ApplicationHelper

  # before_action :authenticate_user!
  # before_action :authenticate_inside_privileges

  before_action :set_social_share, except: [:index, :new]




  layout 'inside'



  def index
    @users = User.all.order(created_at: :desc)
  end

 

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

  # def update
  #   respond_to do |format|
  #    if @social_share.update_attributes(social_share_params)  
  #       format.html {redirect_to inside_blog_image_path(id: @image.id), notice: "Photo was successfully updated." and return}
  #       format.json { render :edit, status: :created, location: @image and return }
  #     else
  #       format.html { render :edit and return }
  #       format.json { render json: @image.errors, status: :unprocessable_entity and return }
  #     end
  #   end
  # end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # def social_share_params
  #       params.require(:social_sharing).permit(:id, )
  # end


end
