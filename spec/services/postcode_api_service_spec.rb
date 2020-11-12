# frozen_string_literal: true

RSpec.describe PostcodeApiService do
  describe '#lookup' do
    it 'raises an exception for invalid postcodes' do
      postcode = 'SE1 SSSS'
      data = { 'status' => 200, 'result' => false }
      response = double(:response)
      expect(response).to receive(:ok?).and_return(true)
      allow(response).to receive(:parsed_response).and_return(data)
      expect(PostcodeApiService).to receive(:get).with('/SE1%20SSSS/validate').and_return(response)

      expect { subject.lookup(postcode) }.to raise_error(PostcodeService::InvalidPostcodeError)
    end

    it 'raises an exception when api is not available' do
      response = double(:response)
      expect(response).to receive(:ok?).and_return(false)
      expect(PostcodeApiService).to receive(:get).with('/SE1%207QD/validate').and_return(response)

      expect { subject.lookup('SE1 7QD') }.to raise_error(PostcodeService::ApiUnavailableError)
    end

    it 'returns a hash with the results from the api call' do
      postcode = 'SE1 7QD'
      data = { 'status' => 200, 'result' => { 'postcode' => postcode } }
      response = double(:response)
      allow(response).to receive(:ok?).and_return(true)
      allow(response).to receive(:parsed_response).and_return(data)
      allow(PostcodeApiService).to receive(:get).with('/SE1%207QD/validate').and_return(response)
      allow(PostcodeApiService).to receive(:get).with('/SE1%207QD').and_return(response)

      expect(subject.lookup(postcode)).to eq data
    end
  end
end
