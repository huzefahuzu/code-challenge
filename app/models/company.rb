class Company < ApplicationRecord
  has_rich_text :description

  validates :brand_color, format: {
    with: /#(?:[0-9a-fA-F]{3}){1,2}/i
  }, if: -> { brand_color.present? }

  validates :email, format: {
    with:    /\A[^@\s]+@getmainstreet.com/,
    message: 'The email should be a valid email with getmainstreet domain.'
  }, if: -> { email.present? }

  validates :zip_code, format: {
    with:    /[0-9]{5}/,
    message: 'The zip code should consist of 5 digits.'
  }

  after_save :set_city_state

  def set_city_state
    information = ZipCodes.identify(zip_code)
    return if information.blank?

    update_columns(city: information[:city], state: information[:state_name])
  end
end
