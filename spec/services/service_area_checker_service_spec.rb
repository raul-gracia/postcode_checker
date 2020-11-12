# frozen_string_literal: true

RSpec.describe ServiceAreaCheckerService do
  describe '#allowed?' do
    it 'returns true when the given postcode is within the allowed postcodes list' do
      postcode = 'SH24 1AA'

      service = ServiceAreaCheckerService.new(postcode)
      expect(service).to be_allowed
    end

    it 'returns true when the given postcode is within the allowed area' do
      postcode = 'SE1 7QD'
      service = ServiceAreaCheckerService.new(postcode)
      VCR.use_cassette(postcode) do
        expect(service).to be_allowed
      end
    end

    it 'raises and exception when the given postcode is NOT within the allowed area' do
      postcode = 'SE3 4TA'
      service = ServiceAreaCheckerService.new(postcode)
      VCR.use_cassette(postcode) do
        expect { service.allowed? }.to raise_exception(PostcodeService::InvalidPostcodeError)
      end
    end
  end
end
