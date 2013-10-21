require 'spec_helper'

feature 'Application' do
  before do
    @main_page = MainPage.new
    @main_page.load
  end

  context 'when there is a requested user' do
    before do
      @main_page.nickname_field.set 'nestd'
      @main_page.submit_btn.click_and_apply_vcr
    end

    it 'displays user\' info' do
      @main_page.info_container.should have_content('Dmitriy Nesteryuk')
      @main_page.info_container.should have_content('Zaporizhzhia, Ukraine')
    end

    it 'displays repositories of an user' do
      @main_page.info_container.should have_content('nestd/site_prism.vcr')
      @main_page.info_container.should have_content('nestd/site_prism.vcr_example')
    end
  end

  context 'when there is not a requested user' do
    before do
      @main_page.nickname_field.set 'rewwwwwwwww'
      @main_page.submit_btn.click_and_apply_vcr do
        fixtures ['~/no_user']
      end
    end

    it 'displays a message about no user' do
      @main_page.info_container.should have_content('Error: Sorry, but the requested user is not found')
    end
  end
end