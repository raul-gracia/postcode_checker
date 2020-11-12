# frozen_string_literal: true

class PostcodeApiService
  include HTTParty
  base_uri 'https://postcodes.io/postcodes'

  def lookup(postcode)
    validate_postcode(postcode)
    request("/#{postcode}")
  end

  private

  def request(path)
    response = self.class.get(URI.encode(path))
    raise PostcodeService::ApiUnavailableError unless response.ok?

    response.parsed_response
  end

  def validate_postcode(postcode)
    response = request("/#{postcode}/validate")
    raise PostcodeService::InvalidPostcodeError unless response['result']
  end
end
