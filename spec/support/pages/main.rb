class MainPage < SitePrism::Page
  set_url '/'

  element :nickname_field,    '#nickname' # input field for entering user's login
  element :loading_indicator, '#loading_indicator' # loading indicator to be shown while performing AJAX request

  # submit button sending a request to the app
  element_with_vcr \
    :submit_btn,
    '#get_info' do
      home_path 'user' # specifies home path to cassettes

      path '~/', [
        'info',        # cassette to stub user's info
        'repositories' # cassette to stub repositories list of an user
      ]

      waiter &:wait_until_loading_indicator_invisible # waiter which keeps test execution until expectation is met
    end

  element :info_container, '#info' # container which is used for rendering user's info
end