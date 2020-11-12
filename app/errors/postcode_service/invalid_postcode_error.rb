module PostcodeService
  class InvalidPostcodeError < StandardError
    def initialize(msg = "The provided postcode is not valid")
      super(msg)
    end
  end
end
