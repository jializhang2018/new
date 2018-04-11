# Heroku Cheat Sheet

Heroku.com is a "platform as a service" that simplifies the task of
deploying web application code to the cloud, so that your users can visit
your application in a secure, hosted environment.  

Heroku was first imagined as a Rails deployment service, but now supports many major
frameworks.

### Prerequisites and Concepts

* This guide assumes you already have a GitHub repository for your Rails application, and you know how to
commit changes and push commits to GitHub.
* You must first sign up for a Heroku.com account and install the "Heroku CLI": https://devcenter.heroku.com/articles/heroku-cli.  Windows users, make sure you open your `bash` prompt and follow the "Ubuntu/Debian" instructions, not the Windows instructions.
* The Free account level puts your application "to sleep" if it has no traffic for 30 minutes.  The next request will "wake it up" which can take 5-10 seconds.


### Deployment Cheat Sheet


**Step 1: Edit Your Gemfile**

This step may have already been done for you if you're using code from class,
but it's good to be familiar with this procedure so you can deploy any Rails application.

_[WARNING: Do not run `bundle install` until the Step 2]_

We can use SQLite in our development and test environments, but not in production.  
Good choices for the production environment are MySQL, Postgresql, SQL Server, Oracle, and DB/2.  

Heroku only supports Postgresql. Therefore we need to configure our Gemfile like this:

``` ruby

group :development, :test do
  gem 'sqlite3'
  # ... other gems
end

group :production do
  gem 'pg', '0.20'
  # ... other gems
end
```

**Step 2: Bundle without Production gems**

You do not need to install the actual production gems on your computer; and the pg gem in particular can be
troublesome.  However, we still need to perform gem dependency resolution and update your Gemfile.lock
file appropriately:

`bundle install --without production`

**Step 3: Commit and Push Your Latest Changes**

```
git add -A
git commit -m "Prepare for deployment"
git push
```

**Step 4: Create a Heroku application under your account**

You can use the Heroku website to create a new "Heroku app" under your account.

Alternatively, if you prefer to use the command line, you can create a new "application" under your Heroku account like this:

`heroku create [subdomain]`

You can leave the subdomain blank, in which case Heroku will generate a random one for you.


**Step 5: Deploy (push) your code to your Heroku git repository**

Using your Heroku dashboard, click on the Deploy tab and scroll to the bottom to manually deploy your code from GitHub.

Alternatively, if you used the CLI in Step 4, you can manually deploy from the command line:

`git push heroku master`

Of course, this assumes you remember to commit your code changes first, otherwise the push will have no effect.


**Step 6: Run your Rails tasks**

Use `heroku run` to remotely execute any Rails task.

```
heroku run rails db:seed
```

**Step 7: Navigate to Your App**

Use `heroku open` or just put the URL into your browser.


**HOW TO: View Your Server Log**

`heroku logs` or `heroku logs --tail`

**HOW TO: Open a Remote Console**

`heroku run rails console`
