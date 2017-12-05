TimeDoctor WorkLogs
===================

This little script is able to collect information about the time that you worked and save it in Google Sheets.

## Setting
### First step. Setting up the script.

In the root folder you will find the config_example.yml file.

Copy it, rename it in config.yml and change the values in it:

timedoctor:

* `access_token` - authentication API Token
* `company_id` - unique identifier of the company

google:

* `spreadsheet_id` - unique identifier of the spreadsheet
* `sheet_title` - the title of the sheet
* `start_date` - date from which the table begins to be populated


### Second step. Create and configure Google project.

Go to the [Developer Console](https://console.developers.google.com/apis) and create a new project

Since the sheets are stored in `Google Drive`, you need to connect the `Google Drive API` to the project.

After that, go to the `credentials` section and create a new `Service account key` of type `JSON` with the `Project Editor` role.

After that, the file with the keys will be downloaded.

Rename it to `client_secret.json` and place it in the root folter.


## Start the script

1. Install dependencies
```
$ bundle install
```

2. The script accepts the following parameters:
```
Usage: script.rb [options]
  -s, --startdate=DATE             The Start Date [YYYY-MM-DD]
  -e, --enddate=DATE               The End Date [YYYY-MM-DD]
```

3. Running:
```
bundle exec ruby bin/script.rb -s 2017-12-01 -e 2017-12-07
```

4. Enjoy!
