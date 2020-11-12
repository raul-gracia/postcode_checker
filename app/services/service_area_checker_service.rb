class ServiceAreaCheckerService
  ALLOWED_AREAS = %w{Southwark Lambeth}
  ALLOWED_POSTCODES = %w{SH241AA SH241AB}

  def initialize(postcode)
    @postcode = postcode
  end

  def allowed?
    return true if member_of_allowed_postcodes?
    lsoa = PostcodeApiService.new.lookup(@postcode).dig("result", "lsoa")
    ALLOWED_AREAS.any? { |area| lsoa.start_with?(area) }
  end

  private

  def member_of_allowed_postcodes?
    ALLOWED_POSTCODES.include?(sanitize(@postcode))
  end

  def sanitize(postcode)
    postcode.strip.remove("/n").remove(" ").upcase
  end
end
