class BlogPostOriginal < BlogPost
   has_many :versions, class_name: "BlogPostVersion",  foreign_key: "original_post_id"
  has_many :meta_properties, class_name: "MetaProperty", foreign_type: "BlogPostLive", foreign_key: 'owner_id', dependent: :destroy



 # after_create :set_meta_information

 # def set_meta_information
 #  page_information = PageInformation.create!(owner_type:"BlogPostLive", owner_id: self.id, editor_user_id: editor_user_id )
 #  page_information.make_default_properties
 # end

end
