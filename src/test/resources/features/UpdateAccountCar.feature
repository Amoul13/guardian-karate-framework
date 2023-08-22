@Regression
Feature: update car Account

  Background: setuptest
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def accountResultId = callonce read('createAccount.feature')
    * def validToken = accountResultId.validToken
    * def AccountCreateId = accountResultId.response.id

  Scenario: Update existing Account Car
    #Create Add Car first
    Given path "api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = AccountCreateId
    And request
      """
      {
      "make": "Toyota",
      "model": "HighLander",
      "year": "2025",
      "licensePlate": "VA-162"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.make == "Toyota"
    And assert response.model == "HighLander"
    * def carId = response.id
    #Update exisiting Car Account
    Given path "api/accounts/update-account-car"
    And header Authorization = "Bearer " +validToken
    And param primaryPersonId = AccountCreateId
    And request
      """
      {
      "id": "#(carId)",
      "make": "Toyota",
      "model": "Camry",
      "year": "2025",
      "licensePlate": "VA-127"
      }
      """
    When method put
    Then status 202
    And print response
    And assert response.make == "Toyota"
    And assert response.model == "Camry"
    And assert response.licensePlate == "VA-127"
