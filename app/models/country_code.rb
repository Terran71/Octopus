class CountryCode

  def find_code(country_name)
    return unless user

    case country_name
    when "US"
      "US"
    when "USA"
      "US"
    when "United States"
      "US"
    when "America"
      "US"
    when "IN"
      "IN"
    when "India"
      "IN"
    
    end
  end
end
