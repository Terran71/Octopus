class KindsController < DashboardController
  before_action :store_location
  before_action :authenticate_user!
  before_action :set_project, except: [:new, :index]
  before_action :set_nested_project, except: [ :index]
  before_action :set_current_user_participation, except: [ :index]
  before_action :set_project_details, except: [:new, :index, :create, :destroy, :update]
  
  respond_to :html

  def index
    @kinds = Kind.all
  end

 

  private
    # Use callbacks to share common setup or constraints between actions.
  
    # Never trust parameters from the scary internet, only allow the white list through.
  def kind_params
   
    
  end
end
