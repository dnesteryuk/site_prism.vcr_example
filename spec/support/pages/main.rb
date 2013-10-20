class MainPage < SitePrism::Page
  set_url '/'

  element :nickname_field,    '#nickname'
  element :loading_indicator, '#loading_indicator'

  element_with_vcr \
    :submit_btn,
    '#get_info' do
      home_path '~/'

      path '~/', ['info', 'repositories']

      waiter &:wait_until_loading_indicator_invisible
    end

  element :info_container,  '#info'
end