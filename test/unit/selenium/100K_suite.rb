require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

require File.join(File.dirname(__FILE__),  "create_org_admins.rb")
require File.join(File.dirname(__FILE__),  "create_organizations.rb")
require File.join(File.dirname(__FILE__),  "create_regular_users.rb")
require File.join(File.dirname(__FILE__),  "orgadmin_accessing_wholeorg.rb")
require File.join(File.dirname(__FILE__),  "orgadmin_accessing_myorg_page.rb")
require File.join(File.dirname(__FILE__),  "orgadmin_accessing_mysettings_page.rb")
require File.join(File.dirname(__FILE__),  "orgadmin_create_regularusers.rb")
require File.join(File.dirname(__FILE__),  "user_accessingorg_not_assigned_tothem.rb")