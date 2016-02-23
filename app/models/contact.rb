class Contact < ActiveRecord::Base
  # belongs_to :home_address
  # belongs_to :work_address
  belongs_to :user
  has_many :guests
  has_many :list_recipients, through: :guests
  has_many :addresses, class_name: "Address", foreign_type: "Contact", foreign_key: 'owner_id', dependent: :destroy
  has_one :contact_household
  has_one :household, through: :contact_household
  belongs_to :user_editor, class_name: "User",  foreign_key: "user_id"

def self.import(file, set_list_id)
  
  # header = spreadsheet.row(1)
  # (2..spreadsheet.last_row).each do |i|
  #   row = Hash[[header, spreadsheet.row(i)].transpose]
  CSV.foreach(file.path, headers: true) do |row|
      contact_hash = row.to_hash
      # row.strip.split(",(?=([^\"]*\"[^\"]*\")*[^\"]*$)");
      c = Contact.new(first_name: ["contact_hash"]["first_name"])
      c.save!
      # c.add_contact_to_guest_list(set_list_id)
    end

end


def self.import(file, set_list_id, current_user_id, auto_add_to_list, import_source)
  

    ImportContactsJob.perform(file, set_list_id, current_user_id, import_source, auto_add_to_list, self.file_type(file))#put category
    
  end

def add_contact_to_guest_list(list_id)
  # guest = Guest.create(contact_id: self.id)
  # guest.save!
  # ListRecipient.create!(list_id: list_id, guest_id: guest.id)
  AddContactToGuestListJob.perform(self, list_id)
end

def editor
  user_editor.name 
end

def self.file_type(file)
  case File.extname(file.original_filename)
  when ".csv" then "CSV"
  when ".xls" then "XLS"
  when ".xlsx" then "XLSX"
  else raise "Unknown file type: #{file.original_filename}"
  end
end

def primary_household_address
  if household.present? && household.addresses.present?
    household.addresses.primary.first.full_address
  else
    self.primary_address
  end
end

def primary_address
    self.addresses.primary.first.full_address
end

  def default_address
    if self.addresses.present?
      if     self.addresses.primary.first.present?
            self.addresses.primary.first.full_address
      else
            self.addresses.first.full_address
      end
    end
  end

  def default_address_id
    if    self.default_address.present?
          self.default_address.id
    else
      nil
    end
  end

  def name
    first_name + " " + last_name rescue first_name + "" rescue "" + last_name rescue "User"
  end

  def is_on_list?(list)
    self.lists.where(list_id: list.id).present?
  end
  
end
