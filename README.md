== README {<img src="https://travis-ci.org/codealchemy/BookLibrary.svg" alt="Build Status" />}[https://travis-ci.org/codealchemy/BookLibrary] {<img src="https://codeclimate.com/github/codealchemy/BookLibrary/badges/gpa.svg" />}[https://codeclimate.com/github/codealchemy/BookLibrary] {<img src="https://codeclimate.com/github/codealchemy/BookLibrary/badges/coverage.svg" />}[https://codeclimate.com/github/codealchemy/BookLibrary/coverage]

BookLibrary is a Ruby on Rails application to manage a library of items that are checked out and in by users. 

## Application basics:

1. Ruby version: <tt>2.1.2</tt>
1. Rails version: <tt>4.1.8</tt>

## Configuration

1. Postgres Database
1. Sendgrid for ActionMailer (sendgrid gem) https://github.com/stephenb/sendgrid
1. Elasticsearch for queries (searchkick gem) https://github.com/ankane/searchkick

## Database creation - to set up the database:
1. run <tt>rake db:create</tt>
1. then <tt>rake db:migrate</tt>

## Deployment instructions
1. keep private keys in a <tt>local_env.yml</tt> file in the config directory (do not include in commits)
2. 


## Elasticsearch

In ubuntu, start elasticsearch.
`
 apt-get install openjdk-7-jre-headless
 sudo /etc/init.d/elasticsearch restart 
 #or
 sudo service elasticsearch restart
`

install elasticsearch

http://www.unixmen.com/install-elasticsearch-ubuntu-14-04/


Mac, install
`
brew install elasticsearch
`
