class RecipientParticipantRole < ParticipantRole

  belongs_to :project, class_name: "RecipientParticipantRole",  foreign_key: "project_id"

  def self.types
    [
      RecipientParticipantRole, RecipientOrganizerParticipantRole
      
    ].flatten
  end

  def level
    1
  end

  def kind
    'Recipient'
  end
  
  def icon_name
    'recipient'
  end

  def is_recipient?
    true
  end

  def code
    4
  end


  private

    

  # private
end
