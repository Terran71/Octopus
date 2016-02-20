module ProjectsHelper

  def default_country
    return Country.find_by(name: "United States").id
  end

  def parsing_roles(participant_role)
    # participant_role = participant_role
    if participant_role == 1
       'OrganizerParticipantRole'
     elsif participant_role == 2
      'RecipientOrganizerParticipantRole'
    elsif participant_role == 3
      'RecipientParticipantRole'
    elsif participant_role == 4
      'HelperParticipantRole'
    else
      'HelperParticipantRole'
    end
  end

  def project_code_to_type(code)
    case code ? code.to_i : nil
      when 1
        "NewBabyMealDeliveryProject"
      when 2
        "WeddingPartyProject"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def participant_title_code_to_title(code)
    case code ? code.to_i : nil
      when 1
        "Bride"
      when 2
        "Groom"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def project_type_to_code(type)
    case type ? type.to_s : nil
      when "NewBabyMealDeliveryProject"
           1
      # when 2

      #   "WeddingPartyProject"
      # when 3
      #   "NewBabyMealDeliveryProject"

      # when 4
      #   "NewBabyMealDeliveryProject"

      # when 5
      #   "MealDeliveryProject"
      # when 6
    end
  end

  def max_visits_menu
   [
    ['No Maximimum', '1000'],
    ['1', '1'],
    ['2', '2'],
    ['3', '3'],
    ['4', '4'],
    ['5', '5']
  ]
end

def date_formatter

  if params[:project][:prep_start_datetime].present?
    params[:project][:prep_start_datetime] = Date.strptime(params[:project][:prep_start_datetime], '%m/%d/%Y')
  end
  if params[:project][:prep_end_datetime].present?
    params[:project][:prep_end_datetime] = Date.strptime(params[:project][:prep_end_datetime], '%m/%d/%Y')
  end
end  

def set_to_active(project)
  if project.draft? or project.archived?
    project.status = "active"
    project.save 
  end
end

def project_categories
 Project.subclasses
end

def meal_delivery_kinds
  MealDeliveryProject.subclasses
end

def setup(source, project)
  case source ? source.to_s : nil
    when "restrictions"
      project_add_restrictions_path(id: project.id)
    when "verify dates"
      project_available_dates_path(id: project.id)
    when "show project"
      project_path(id: project.id)
    when "new project"
      project_add_restrictions_path(id: project.id)
    else
      project_path(id: project.id)
    end
end



end