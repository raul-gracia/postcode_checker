module PostcodeService
  class ApiUnavailableError < StandardError
    def initialize(msg = "The postcode service api is unavailable")
      super(msg)
    end
  end
end
