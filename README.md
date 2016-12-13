# README

This project is based on Implementation Interview Script found [here](https://www.evernote.com/shard/s556/sh/acac3844-a75b-49ec-a068-cde6ab6eccac/d1c75528c33e7e2d). Thanks you for your time and consideration.

A live version of this project can be found [here](https://implementation-interview.herokuapp.com/).

## Setup
1. Clone the repository:

  `git clone https://github.com/PlanetEfficacy/implementation_interview.git`

2. Change directories into the project directory

  `cd implementation_interview`

3. Bundle project gems

  `bundle`

4. Create a project database

  `rake db:create`

5. Run pending migrations

  `rake db:migrate`

6. Populate database

  `rake db:seed`

7. Run test suite from the project root

  `rspec`

8. Launch development version

  `rails s`

  Open browser to localhost:3000 or your default port

## Further explanation of tasks

The tasks are copy and pasted from the Implementation Interview Script. I have added notes as bullet points under each numbered task.

1. This requires Postgres (9.4+) & Rails(4.2+), so if you don't already have both installed, please install them.
  * Rails v 5.0.0.1
  * PG v 9.5.4.1
2. Surf over to https://datahub.io/dataset/street-cafes-licences-in-leeds, and upload the data there into a table called street_cafes in Postgres (remove the headers and name them yourself).
  * See "db/seeds.rb" lines 1 - 12 for script used to upload data from csv.
  * See "seed_data/street_cafes_15_16.csv" for csv data.
3. Task: Add a varchar column to the table called 'category'.
  * See migration file: "db/migrate/20161211173639_add_category_to_shop.rb"
4. Create a view with the following columns[provide the view SQL]

        post_code: The Post Code
        total_places: The number of places in that Post Code
        total_chairs: The total number of chairs in that Post Code
        chairs_pct: Out of all the chairs at all the Post Codes, what percentage does this Post Code represent (should sum to 100% in the whole view)
        place_with_max_chairs: The name of the place with the most chairs in that Post Code
        max_chairs: The number of chairs at the place_with_max_chairs

    * For view, visit "https://implementation-interview.herokuapp.com/chairs"
    * Implementation of database queries can be found in "app/services/shop_analyzer.rb"
    * In SQL I would do the following:

          postal code: 'LS1 5BN'
          total places: SELECT COUNT(id) AS total_places FROM shops WHERE post_code='LS1 5BN';
          total chairs: SELECT SUM(chairs) AS total_chairs FROM shops WHERE post_code='LS1 5BN';
          chairs pct: SELECT SUM(chairs * 100.0 / (SELECT SUM(chairs) FROM shops)) AS total_chairs FROM shops WHERE post_code='LS1 5BN';
          place_with_max_chairs: SELECT name FROM shops WHERE post_code='LS1 5BN' AND chairs=(SELECT MAX(chairs) FROM shops WHERE post_code='LS1 5BN');
          max_chairs: SELECT chairs FROM shops WHERE post_code='LS1 5BN' AND chairs=(SELECT MAX(chairs) FROM shops WHERE post_code='LS1 5BN');


5. Write a Rails script to categorize the cafes and write the result to the category according to the rules:[provide the script]

    A) If the Post Code is of the LS1 prefix type:
        # of chairs less than 10: category = 'ls1 small'
        # of chairs greater than or equal to 10, less than 100: category = 'ls1 medium'
        # of chairs greater than or equal to 100: category = 'ls1 large'

    B) If the Post Code is of the LS2 prefix type:
        # of chairs below the 50th percentile for ls2: category = 'ls2 small'
        # of chairs above the 50th percentile for ls2: category = 'ls2 large'

    C) For Post Code is something else:
        category = 'other'

    * See "db/seeds.rb" lines 21 - 26 for script used to categorize shops.
    * See "app/services/categorizer.rb" for implementation of categorization rules.

6. Write a custom view to aggregate the categories [provide view SQL AND the results of this view]

      category: The category column

      total_places: The number of places in that category

      total_chairs: The total chairs in that category

    * For view, visit "https://implementation-interview.herokuapp.com/categories"
    * Implementation of database queries can be found in "app/services/category_analyzer.rb"
    * In SQL I would do the following:

          category: 'ls1 medium'
          total places: SELECT COUNT(id) AS total_places FROM shops WHERE category='ls1 medium';
          total chairs: SELECT SUM(chairs) AS total_chairs FROM shops WHERE category='ls1 medium';

7. Write a script in rails to:
        a) For street_cafes categorized as small, write a script that exports their data to a csv and deletes the records
        b) For street cafes categorized as medium or large, write a script that concatenates the category name to the beginning of the name and writes it back to the name column

    * Run export from "https://implementation-interview.herokuapp.com/" by clicking "Export Small Shops"
    * See "db/seeds.rb" lines 35 - 40 for script used to categorize shops. These lines are currently commented out. To run, uncomment lines 35 - 40 and run `rake db:seed`
    * See "app/services/categorizer.rb" for implementation of renaming rules.
