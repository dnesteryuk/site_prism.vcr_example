require 'spec_helper'

feature 'Application' do
  before do
    @main_page = MainPage.new
    @main_page.load
  end

  context 'when there is a requested user' do
    before do
      @main_page.nickname_field.set 'dnesteryuk'
      @main_page.submit_btn.click_and_apply_vcr
    end

    it 'displays user\' info' do
      expect(@main_page.info_container).to have_content('Dmitriy Nesteryuk')
      expect(@main_page.info_container).to have_content('Zaporizhzhia, Ukraine')
    end

    context 'when there are repositories' do
      it 'displays repositories of an user' do
        expect(@main_page.info_container).to have_content('dnesteryuk/site_prism.vcr')
        expect(@main_page.info_container).to have_content('dnesteryuk/site_prism.vcr_example')
      end
    end

    context 'when there are not repositories' do
      before do
        @main_page.submit_btn.click_and_apply_vcr do
          exchange '~/repositories', '~/no_repositories'
        end
      end

      it 'displays a message about empty repositories' do
        expect(@main_page.info_container).to have_content('This user has no repositories')
      end
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
      expect(@main_page.info_container).to have_content('Error: Sorry, but the requested user is not found')
    end
  end
end