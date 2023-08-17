@Random
Feature: End to End Test

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateNewToken.feature')
    And print result
    * def validNewToken = result.response.token

  #create New Account
  Scenario: Create New Account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validNewToken
    * def generateData = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateData.getEmail()
    And request
      """
      {
       "email": "#(autoEmail)",
       "firstName": "Sarah",
       "lastName": "Baher",
       "title": "Mrs.",
       "gender": "FEMALE",
       "maritalStatus": "MARRIED",
       "employmentStatus": "Software Engineer",
       "dateOfBirth": "1991-10-20",
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    #add account phone to created Account
    Given path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + validNewToken
    And param primaryPersonId = response.id
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoPhoneNum = generateDataObject.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(autoPhoneNum)",
      "phoneExtension": "",
      "phoneTime": "Evening",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == autoPhoneNum
    #add account Address to created Account
    Given path "/api/accounts/add-account-address"
    And header Authorization = " Bearer " + validNewToken
    And param primaryPersonId = response.id
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "6060 Main st",
      "city": "Alexandria",
      "state": "Virginia",
      "postalCode": "22302",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "6060 Main st"
    #add car to created Account
    Given path "/api/accounts/add-account-car"
    And header Authorization = " Bearer " + validNewToken
    And param primaryPersonId = response.id
    And request
      """
      {
      "make": "Ford",
      "model": "Escape",
      "year": "2024",
      "licensePlate": "VM234"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.make == "Ford"
    #delete created Account
    Given path "/api/accounts/delete-account"
    And header Authorization = " Bearer " + validNewToken
    And param primaryPersonId = response.id
    And method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"