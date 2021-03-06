Medication Blood Pressure Logger is a Sinatra Application that I made for my phase 2 project for Flatiron School's Software Engineering Bootcamp Program. This application allows a User to create an account, which then allows them to log both blood pressure readings and medications. When logging medications, the user can also choose to add an associated physician and/or pharmacy to each medication.

Requirements

This project requires Ruby and RubyGems.

Setup

These are the steps to get the application up and running:

Step 1. Installation

Clone this repository into your developer environment, then install the required Ruby Gems by running the following commands in your terminal:

git clone https://github.com/grantba/medication_blood_pressure_logger_sinatra_app.git
cd medication_blood_pressure_logger_sinatra_app
bundle install

Step 2. Create the database

In order to create the database to store your information, you will need to run the following command in your terminal:

rake db:migrate

Step 3.Usage

This application uses 'shotgun' to run a local server. In order to use the application, run the following command in your terminal:

shotgun

With the server running, open up your favorite web browser and navigate to the following URL:

http://localhost:9393

Now, you can sign up for an account on the main page. This application uses bcrypt which allows you to create a secure user password. Once your account is created, you're all set to log your own medication and blood pressure readings to help you keep track of this important information. 

Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/grantba/medication_blood_pressure_logger_sinatra_app. For major changes, please open an issue first to discuss what you would like to change.

License

This Sinatra project is available as open source under the terms of the MIT License 
(see LICENSE.md file).

Check out my blog post

Here is the link where you can read about my experience developing this application on my blog post.

https://grant-blaire.medium.com/understanding-mvcs-restful-routes-and-crud-actions-in-a-sinatra-application-57d87283a035

Video Walkthrough

Here is the link to a video walkthrough of this application.

https://youtu.be/kYq8o_llnuw 

