class RecipientOrganizerParticipantRole < RecipientParticipantRole


  def kind
    'Recipient/Organizer'
  end
  
  def icon_name
    'recipient_organizer'
  end



  def can_organize?
   true
  end

  def is_recipient?
    true
  end

  def rank
    1
  end
  
  def code
    2
  end

  after_create :add_honored_guest

  def add_honored_guest
    if self.participant.honored_guest.blank?
      HonoredGuest.create!(project_id: self.participant.project_id, passive: false, name: self.participant.name,
                            email: self.participant.email)
    end
  end

  private

end
