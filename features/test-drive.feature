Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App prints help
    When I get help for "test-drive"
    Then the exit status should be 0
    And the banner should be present
    And there should be a one line summary of what the app does
    And the banner should document that this app takes options
    And the following options should be documented:
      |--version     |
      |--job         |
      |--log-level   |
      |--server      |
      |--user        |
      |--password    |
      |--[no-]push   |
