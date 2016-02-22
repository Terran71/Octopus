class Address < ActiveRecord::Base
  belongs_to :us_state
  belongs_to :country
 

  belongs_to :project, class_name: "Project", foreign_type: "Project", foreign_key: 'owner_id'
  belongs_to :user, class_name: "User", foreign_type: "User", foreign_key: 'owner_id'
  belongs_to :contact, class_name: "Contact", foreign_type: "Contact", foreign_key: 'owner_id'
  belongs_to :household, class_name: "household", foreign_type: "household", foreign_key: 'owner_id'

  # validates :address_id, uniqueness: {scope: project_id, scope: primary, message: "Looks like you've entered this one already."}
  # validates :address_id, uniqueness: {message: "not unique" }, 
  #   if: 'foundation_label.present?'

  scope :primary, -> { where(primary: true)}


  def is_complete?
    if self.address_1.present? && self.city.present? && self.us_state_id.present? && self.postal_code.present? && self.country_id.present?
      true
    else
      false
    end
  end

  def state_or_province_code
    if us_state_id
      us_state.code
    else
      'unknown'
    end
  end

  def in_usa
    true unless self.country_id != 236
  end
  

  def full_address
    "#{self.address_1} #{self.address_2} #{self.city} #{self.state_or_province_code} #{self.postal_code}"
  end

  def google_maps_link
    "http://maps.google.com/?q= #{self.full_address}"
  end

end


