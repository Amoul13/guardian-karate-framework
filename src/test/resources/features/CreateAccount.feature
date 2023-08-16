@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"
  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling Java class in feature file. this utility will create object from Java Class.
        #define wich class want to call java class and we give it variable name and (package name and class name)  
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
      #define variable and use the first variable to call the method
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",#define variable will read by karate and put in request
      "firstName": "Ahmed",
      "lastName": "Azzam",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "SINGLE",
      "employmentStatus": "Software Developer",
      "dateOfBirth": "1990-02-27",
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
