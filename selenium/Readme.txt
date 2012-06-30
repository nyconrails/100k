                    ---Initial SetUp for Selenium-----
1. Requires Selenium IDE as an Add-On

2. Selenium Flow Control as an Add-On

3. Requires 3 javascripts plugins==> sideflow.js, user-extensions.js.includeCommand4IDE, datadriven.js
   As a reference, documentation on this url 'http://maryannmp.wordpress.com/2011/02/23/data-driven-  testing-with-selenium-rc-   html-tests/' can be referred.

4. Download above 3 plugins.

5. For above js plugins to get initialized:
        a. Selenium IDE -> Select Options from Menu bar -> Options.. -> General tab.
        b. Under Selenium Core Extensions, browse for plugin location in the order of:
                /path/to/sideflow.js, /path/to/user-extensions.js.includeCommand4IDE, /path/to/datadriven.js
        c. Select Ok.

6. Restart Selenium IDE.

                   ---100K Test Suite---
1. All the tests Scripts and Suites are present in a single folder named '100K_Suite'

2. This Suites covers basic functionality of 100K app.

3. To run Test Suite for Active Admin, suite named 'active_admin_testSuite' creates all tests data required to perform testing like creating Org_Admins, Organizations and Regular_Users under these created Organizations.

4. To run Test Suite for Client interface like OrgAdmin, suite named 'orgAdmin_testSuite' performs basic functions for Org_Admin like viewing and editing Organizations' data, manipulates his/her account_settings, creating regular_users, etc

5. To run Test Suite for whole 100K app, suite named as '100K_TestSuite' covers above both test suites on a whole.

6. Creation of all test data loads from XML file. These files also exists in these folder. To load these files in all scripts, update the location of these Suite folder in file named '100K_Suite/load_env_url.xml'

7. In '100K_Suite/load_env_url.xml', by setting 'custom_url' attribute, suite can be executed in any environment.

8. For logging in Active Admin interface, suite uses default login_email & password which is present in 'super_user_login.xml'. One can change these credentials as per their requirement.

9. Env and test suite specific variables are stored in XML files - (TODO - write details on various variables used)

