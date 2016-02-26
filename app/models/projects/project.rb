class Project < ActiveRecord::Base
  include ProjectsHelper


  def self.types
    [
      MealDeliveryProject.types,
      PartyProject.types,
      ].flatten
  end




  belongs_to :user

  has_many :participants, dependent: :destroy
  has_many :honored_guests, dependent: :destroy

  has_many :participant_roles, through: :participants
  has_many :addresses, class_name: "Address", foreign_type: "Project", foreign_key: 'owner_id', dependent: :destroy

  has_many :project_dates, dependent: :destroy
  has_many :events,  through: :project_dates

  has_many :project_restrictions, dependent: :delete_all
  has_many :restrictions,  through: :project_restrictions
  has_many :lists, dependent: :destroy
  has_many :guest_lists,  through: :lists
  has_many :guests,  through: :guest_lists

  has_one :organizer_participant, class_name: "Participant",  foreign_key: "organizer_participant_id", dependent: :destroy
  # has_many :recipients, class_name: "RecipientParticipantRole",  foreign_key: "project_id", dependent: :destroy

  belongs_to :editor, class_name: "User",  foreign_key: "editor_user_id"
  enum status: [:draft, :active, :archived]
  #STI Requires Type
  validates :type, presence:  {message: "Please enter a Kind of project."}


 # accepts_nested_attributes_for :events, allow_destroy: true
  accepts_nested_attributes_for :participants, allow_destroy: true, reject_if: proc { |a| a["email"].blank? }
  accepts_nested_attributes_for :addresses, allow_destroy: true,   reject_if: proc { |a| a["address_1"].blank? }
  accepts_nested_attributes_for :project_dates, allow_destroy: true
  accepts_nested_attributes_for :events, allow_destroy: true, reject_if: proc { |a| a["project_date_id"].blank? }
  accepts_nested_attributes_for :participant_roles, allow_destroy: true, reject_if: proc { |a| a["participant_id"].blank? }
  accepts_nested_attributes_for :honored_guests, allow_destroy: true, reject_if: proc { |a| a["name"].blank? }

 accepts_nested_attributes_for :lists, allow_destroy: true
  accepts_nested_attributes_for :guest_lists, allow_destroy: true
 accepts_nested_attributes_for :guests, allow_destroy: true

 # accepts_nested_attributes_for :milestones, allow_destroy: true
 # accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: :all_blank
 # accepts_nested_attributes_for :guest_tables, allow_destroy: true, reject_if: :all_blank
 # accepts_nested_attributes_for :project_meals, allow_destroy: true, reject_if: :all_blank



  # scope :organized_by, lambda { |user|
  #   joins(:organizer_participant).where(organizer_participant: { user_id: user.id })
  # }


def proj_env
  '???'
end

def subcategory_name
  '???'
end

def category
  '???'
end

def subcategory_roles
   # [
   #  ['Organizer', '1'],
   #  ['Recipient', '2'],
   #  ['Organzier/Recipient', '3'],
   #  ['Co-Organizer', '4'],

   # ]
end

def self.subcategory_roles
    [
      "Organizer", "Recipient", "Organzier/Recipient"
     
      
    ]
  end

def is_meal_delivery?
  false
end

def is_party?
  false
end

def is_wedding?
  false
end

def is_baby_related?
  false
end

def is_wedding_related?
   false
end

def code
  0
end

def rank
  nil
end

def icon_name
  'default'
end

def current_user_roles(user_id)
   self.project.participants.where(user_id: user_id)
end


#placeholder text
def question_1
  'Desmond & Molly Jones'
end

def question_2
  'Desmond & Molly had a beautiful baby boy. This...'
end

def kind_project_path
  root_path
end

def self.new_project
  self.new
end
  


  # We always want to load our ratings information
  # default_scope { includes(:rating) }


  # Convenience methods to find out if we're current
  # TODO: This is copied and pasted from Role

  def current_as_of?(date)
    if end_date && end_date > date
      true
    elsif end_date.blank?
      true
    else
      true
    end
  end

  def ended_as_of?(date)
    !current_as_of?(date)
  end

  def current?
    !self.is_archived?
  end

  def ended?
    !current?
  end

  # def has_active_flags?
  #   flags.any?{|f|f.active?}
  # end

  def full_title
    "???"
  end

  def short_title
    "short title"
  end

  def is_archived?
    if self.status == "archived"
      true
    else
      false
    end
  end

  def is_new?
    if self.id.blank?
      true
    end
  end

  def is_draft?
    self.status == "draft"
  end

  def has_prep_dates?
    if self.prep_start_datetime.present? && self.prep_end_datetime.present? 
      true
    end
  end

  def has_complete_address?
    if self.addresses.primary.first.present? && self.addresses.primary.first.is_complete?
      true
    else
      false
    end
  end

  def project_recipients
    self.participant_roles.accepted.find_all{|r| r.kind_of?(RecipientParticipantRole) or r.kind_of?(RecipientOrganizerParticipantRole)}
    # participant_roles = recipient_roles.collect(&:participant)
    # participant_roles.collect(&:user)
  end

  def project_organizers
    self.participant_roles.accepted.find_all{|r| r.can_organize? == true}
  end

  # def project_recipients_group(length)
  #   if length == 'short'
  #     project_recipients.each.map{ |r| r.first_name }.join(" & ")
  #   else
  #     project_recipients.each.map{ |r| r.name }.join(" & ")
  #   end
  # end

  # def project_organizers_group(length)
  #   if length == 'short'
  #     project_organizers.each.map{ |r| r.first_name }.join(" & ")
  #   else
  #     project_organizers.each.map{ |r| r.name }.join(" & ")
  #   end
  # end

  def project_helpers
    all_helpers = self.participant_roles.find_all{|r| r.kind_of?(HelperParticipantRole)}
    all_helpers.collect(&:participant).uniq
  end

  def has_recipients?
     self.participant_roles.any?{|r| r.kind_of?(RecipientParticipantRole)}
  end

  def has_helpers?
    self.participant_roles.any?{|r| r.kind_of?(HelperParticipantRole)}
  end

  def create_organizer(participant_role_type, current_user)
    participant = Participant.create!(email: current_user.email, project_id: self.id, status: "accepted")
    self.organizer_participant_id = participant.id
    self.save
    ParticipantRole.create!(type: participant_role_type, project_id: self.id,  
                            participant_id: participant.id, start_date: Date.today, 
                            grantor_participant_id:  participant.id, editor_participant_id: participant.id )
  end

  # def create_organizer(participant_role)
  #   participant = Participant.find(self.participants.first.id)
  #   self.organizer_participant_id = participant.id
  #   parsed_role = parsing_roles(participant_role)
  #   ParticipantRole.create!(type: parsed_role, project_id: self.id, 
  #                           participant_id: participant.id, start_date: Date.today, 
  #                           grantor_participant_id:  participant.id, editor_participant_id: participant.id )
  # end

  def prep_times
    if prep_start_datetime.present? & prep_end_datetime.present?
      "#{prep_start_datetime.strftime("%D")} - #{prep_end_datetime.strftime("%D")}"
    elsif prep_start_datetime.present? & prep_end_datetime.blank?

    "#{prep_start_datetime.strftime("%D")} - End TBD"

    elsif prep_start_datetime.blank? & prep_end_datetime.present?
      "Start TBD - #{prep_end_datetime.strftime("%D")}"
    else
      "TBD"
    end

  end



  def primary_address
    self.addresses.primary.first
  end

  def default_address
    if     self.addresses.primary.first.present?
          self.addresses.primary.first
    else
          self.addresses.first
    end
  end

  def default_address_id
    if    self.default_address.present?
          self.default_address.id
    else
      nil
    end
  end

  def has_diet_restrictions_or_favorites?
    if self.has_allergy_restrictions? or self.has_diet_restrictions? or self.notes.present?
      true
    end
  end

  def has_allergy_restrictions?
    self.allergy_restrictions.present?
  end

  def has_diet_restrictions?
    self.diet_restrictions.present?
  end

  def allergy_restrictions
    self.restrictions.allergy
  end

  def diet_restrictions
    self.restrictions.diet
  end
  
  
  before_save :init_data
  after_update :add_dates
  # after_create :create_organizer

  def edit_date_range_dates(current_participation_id)
    dates_in_date_range = self.event_dates
    if dates_in_date_range.present?
      dates_in_date_range.each do |date|
        self.project_dates.where('schedule_date < ? OR schedule_date > ?',  self.prep_start_datetime, self.prep_end_datetime).destroy_all
        self.project_dates.where(schedule_date: date, project_id: self.id).first_or_create
      end
    else
      dates_in_date_range.each do |new_date|
        self.project_dates.create!(schedule_date: new_date, editor_participant_id: current_participation_id)
      end  
    end
  end

  def event_dates
    if self.prep_start_datetime.present? &&  self.prep_end_datetime.present?
      (self.prep_start_datetime.to_date .. self.prep_end_datetime.to_date)  
    end    
  end

  
  private

  def add_dates
    if self.is_meal_delivery?
      if event_dates.present?
        event_dates.each do |event_date|
          self.project_dates.create!(schedule_date: event_date, editor_participant_id:  self.organizer_participant_id)
        end
      end
    end
  end

def init_data
  self.time_start ||= '09:00:00' if new_record?
  self.time_end ||= '16:00:00' if new_record?
end


  

  # private
end
