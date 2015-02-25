Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "test-drive"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version  |
      |--job      |
      |--file     |
      |--log-level|

    And the banner should document that this app's arguments are:
      |jenkins_url|which_is_required|
      |user       |which_is_required|
      |api_key    |which_is_required|