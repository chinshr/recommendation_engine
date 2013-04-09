Recommendation Engine
=====================

RecommendationEngine is a gem for Rails 3+ that simplifies collaborative filtering.

The gem provides a mechanism for finding loose associations between users and items which we can tell you

* Given a user, return other similar users based on what items they have all bought/bookmarked/rated/etc
* Given a user, return recommended items based on the items bought/bookmarked/rated/etc by that user and the items 
bought/bookmarked/rated/etc by other users.

The gem calculations can be made online and offline and stored using the rails cache (such as memcache) for online retrieval. Online retrieval of recommendations uses item-based collaborative filtering using the offline items similarity matrix stored in the cache. This can give up-to-date results with a much lower processing overhead.

Much thanks to Toby Segaran and his excellent book [Programming Collective Intelligence](http://oreilly.com/catalog/9780596529321/).

Features
========

* Use join rating scores
* Using abitrary calculated scores
* Similar Items
* Recommended Users
* Cached dataset

Current Release
===============

v0.1 should be considered early alpha and not ready for production applications.

Lots of performance optimizations still to be done.

Example
=======

    class Book < ActiveRecord::Base
      has_many :user_books
      has_many :users, :through => :user_books
    end

    class UserBook < ActiveRecord::Base
      belongs_to :book
      belongs_to :user
    end

    class User < ActiveRecord::Base
      has_many :user_books
      has_many :books, :through => :user_books
      acts_as_recommendable :books, :through => :user_books
    end

    user = User.find(:first)
    user.similar_users #=> [...]
    user.recommended_books #=> [...]

    book = Book.find(:first)
    book.similar_books #=> [...]

Example 2
=========

    class Movie < ActiveRecord::Base
      has_many :user_movies
      has_many :users, :through => :user_movies
    end

    class UserMovie < ActiveRecord::Base
      belongs_to :movie
      belongs_to :user
    end

    class User < ActiveRecord::Base
      has_many :user_movies
      has_many :movies, :through => :user_movies
      acts_as_recommendable :movies, :through => :user_movies, :score => :score
      # 'score' is an attribute on the users_movies table
    end

    user = User.find(:first)
    user.similar_users #=> [...]
    user.recommended_movies #=> [...]

Example 3
=========

    class Book < ActiveRecord::Base
      has_many :user_books
      has_many :users, :through => :user_books, :use_dataset => true
      # Uses cached dataset
    end

    class UserBook < ActiveRecord::Base
      belongs_to :book
      belongs_to :user
    end

    class User < ActiveRecord::Base
      has_many :user_books
      has_many :books, :through => :user_books
      acts_as_recommendable :books, :through => :user_books
    end

    user = User.find(:first)
    user.recommended_books #=> [...]

    # The example above uses a cached dataset.
    # You need to generate a cached dataset every so often (depending on how much your content changes)
    # You can do that by calling the rake task recommendations:build, you should run this with a cron job every so often.
  
    # If you only want to use the dataset in production put this in production.rb:
    User.aar_options[:use_dataset] = true
  
    # Note:
    # user.similar_users doesn't use the dataset
    #
    # The advantage of using a dataset is that you don't need to load all the users & items into
    # memory (which you do normally). The disadvantage is that you won't get as accurate results.
    #

Contact
=======

alex@madebymany.co.uk

jfesslmeier@gmail.com

Copyright (c) 2008-2013 released under the MIT license
