# frozen_string_literal: true

RSpec.describe 'Postcode Check Feature' do
  it 'shows successful message when the postcode is within the allowed area' do
    postcode = 'SE1 7QD'
    VCR.use_cassette(postcode) do
      visit '/'
      fill_in 'postcode', with: postcode
      click_button 'Check'
      expect(page).to have_content 'Success'
      expect(page).to have_content 'This postcode is within our service area'
    end
  end
  it 'shows successful message when the postcode in the allowed postcodes list' do
    postcode = 'SH24 1AA'
    VCR.use_cassette(postcode) do
      visit '/'
      fill_in 'postcode', with: postcode
      click_button 'Check'
      expect(page).to have_content 'Success'
      expect(page).to have_content 'This postcode is within our service area'
    end
  end

  it 'shows error message when the postcode is NOT within the allowed area' do
    postcode = 'N1 8JG'
    VCR.use_cassette(postcode) do
      visit '/'
      fill_in 'postcode', with: postcode
      click_button 'Check'
      expect(page).to have_content 'Error'
      expect(page).to have_content 'This postcode is NOT within our service area'
    end
  end
  it 'shows error message when the postcode is invalid' do
    postcode = 'SE1 SSSS'
    VCR.use_cassette(postcode) do
      visit '/'
      fill_in 'postcode', with: postcode
      click_button 'Check'
      expect(page).to have_content 'Error'
      expect(page).to have_content 'The provided postcode is not valid'
    end
  end
  it 'shows error message when the api is not available' do
    allow_any_instance_of(ServiceAreaCheckerService).to receive(:allowed?).and_raise(PostcodeService::ApiUnavailableError)

    visit '/'
    fill_in 'postcode', with: 'SE1 7RE'
    click_button 'Check'
    expect(page).to have_content 'Error'
    expect(page).to have_content 'The postcode service api is unavailable'
  end
end
