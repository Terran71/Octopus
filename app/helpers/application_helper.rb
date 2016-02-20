module ApplicationHelper

  # def title(page_title)
  #   content_for(:title) { page_title }
  # end

  def env_label
    if Rails.env.production?
      (ENV['OCT_ENV'] || '').titleize
    else
      Rails.env.titleize
    end
  end

  def blog_has_meta_properties?
    true
  end

  def blog_has_meta_properties?
    true
  end


  def standard_date(time)
    time.respond_to?(:strftime) ? time.strftime("%B %e, %Y at %I:%M %p") : ""
  end

 

  def active_page(root_path)
    # @active == active_page ? "active" : ""
    ' class="active"' if current_page?(root_path)

  end



  

  # def user_participation_redirect(response, current_user_participation)
  #   if response == "accepted"
  #    #do nothing
  #   elsif response == "denied"
  #    redirect_to no_access_path(user_id: current_user.id)
  #   elsif response == "unseen" or response == "declined" or response == "pending" or response == "maybe" 
  #    redirect_to invite_path(id: current_user_participation.id)
  #   end
  # end

  # def days_ago(date)
  #   diff = Time.now - date.to_time
  #   return date.ago if diff < 86400
  #   "#{"day".pluralize(diff.to_i / 86400)} ago"
  # end

  def days_ago_in_words(time)
    days = ((Time.now - time.to_time) / 86400.0).round
    if days > 1
      I18n.t :x_days, :count => days, :scope => :'datetime.distance_in_words'
    else
      time_ago_in_words(time)
    end
  end

  def days_ago(time)
    days = ((Time.now - time.to_time) / 86400.0).round
    if days > 1
     days
    end
  end

  


end
