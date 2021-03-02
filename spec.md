Specifications for the Sinatra Assessment

Specs:
 ☑ Use Sinatra to build the app
 I used sinatra, sinatra-activerecord, and sinatra-flash which I required in my gemfile.
 Required Sinatra::Base in my application controller.
 ☑ Use ActiveRecord for storing information in a database
 I used activerecord and sinatra-active record which I required in my gemfile.
 My models all require ActiveRecord::Base.
 ☑ Include more than one model class (e.g. User, Post, Category)
 I have five models in my sinatra application.
 ☑ Include at least one has_many relationship on your User model (e.g. User has_many Posts)
 My user model has 2 has_many relationships and 2 has_many through relationships.
 ☑ Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
 I have 4 models that belong to my user class based on the fact that they are unique to that specific user.
 ☑ Include user accounts with unique login attribute (username or email)
 My user has to have a name, username, and password to sign up for an account and no 2 users can have the same username.
 ☑ Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
 My user will have the ability to create, read, update, and delete all of the associated models as well as their own account. 
 ☑ Ensure that users can't modify content created by other users
 I have conditinals in all of my routes to prevent the user from altering anyone else's data but their own.
 ☑ Include user input validations
 I have the phone number fields formatted to be entered in a specific way. If not, the user will be notified. Email addresses are also validated to fit a specific format.
 ☑ BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
 I used flash messages in my application for various (error, notice, etc) messages. For example, my user can not delete any data from the database on the first attempt. They will receive a flash message first asking if they are sure they want to delete the selected object. If submitted a second time, then on the second attempt for that specific object, it will then be deleted from the database.
☑ Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code.

Confirm:
☑ You have a large number of small Git commits
☑ Your commit messages are meaningful
☑ You made the changes in a commit that relate to the commit message
☑ You don't include changes in a commit that aren't related to the commit message