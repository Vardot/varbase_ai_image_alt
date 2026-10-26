@varbase-ai-image-alt @ai @recipes @local @development
Feature: Varbase AI Recipe - AI Image Alt - Adding an image with AI help
  As a content editor
  I want AI to write the alt text, a description and tags for the images I add
  So that every image is accessible and findable without extra work

  Scenario Outline: Check the "<user>" user gets Generate with AI for the alt text
    Given I am a logged in user with the "<user>" user
     When I go to "/media/add/image"
     Then I should see "AI description and tags"
     When I attach the file "house.jpg" to the "Add a new file" field
      And I wait max of 30 seconds
      And I click allow the image AI this time
     Then I see visible generate with ai button

    Examples:
      | user           |
      | Content editor |
      | Content admin  |
      | SEO admin      |
      | Site admin     |

  Scenario: Verify Generate with AI writes the alt text
    CI has no real RAG or vector database hosting: it uses only what the pipeline has and the free amazee.ai
    trial from Drupal CMS AI (thanks to amazee.ai). A short answer comes back within 10 seconds.
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
      And I attach the file "house.jpg" to the "Add a new file" field
      And I wait max of 30 seconds
      And I click allow the image AI this time
      And I click generate with ai button
      And I wait for 10 seconds for AJAX to finish
     Then the field "Alternative text" should not be empty

  Scenario: Verify the description and tags are written by AI when the image is saved without them
    Given I am a logged in user with the "Content editor" user
     When I go to "/media/add/image"
      And I fill in "Name" with "Red house beside a tree"
      And I attach the file "house.jpg" to the "Add a new file" field
      And I wait max of 30 seconds
     Then I see visible alternative text field
     When I fill in "Alternative text" with "A red house beside a tree"
      And I click the "Save" button
      And I go to "/admin/content/media"
      And I open the "Edit" link in the "Red house beside a tree" row
     Then the field "Image description" should not be empty
