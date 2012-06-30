1) "100K_suite.rb" is the master script for the entire test suite.

2) All configs related to this test suite is mentioned under "config.xml" file

3) Few things/tools you would need before executing this entire suite is
   a) Selenium web server

4) Open terminal and start selenium server using following command:
Run -> java -jar /path/to/your/selenium/server/jar/file/selenium-server.jar

5) Open another terminal and start the execution of selenium test suite using following command:
Run -> ruby /your/rails/app/path/test/unit/selenium/org_admin_suite.rb

NOTE:
a) After executing ruby command to run test suite, 2 browser instances will be opened. Please do not close these instances.

b) To find what tests has been executed, check the log on terminal where ruby command was executed. It will prompt these result as follows:
    Loaded suite org_admin_suite
    Started
    .
    Finished in 130.742842 seconds.

    1 tests, 46 assertions, 0 failures, 0 errors, 0 skips

    Test run options: --seed 54047

