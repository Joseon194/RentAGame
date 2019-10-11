class WelcomeController < ApplicationController

    #Checks if logged_in already, redirects to users home if so
       def home
           already_logged_in?
       end
   end
   