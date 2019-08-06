# == Schema Information
#
# Table name: albums
#
#  asin        :string       not null, primary key
#  title       :string
#  artist      :string
#  price       :float
#  rdate       :date
#  label       :string
#  rank        :integer
#
# Table name: styles
#
# album        :string       not null
# style        :string       not null
#
# Table name: tracks
# album        :string       not null
# disk         :integer      not null
# posn         :integer      not null
# song         :string

require_relative './sqlzoo.rb'

def alison_artist
  # Select the name of the artist who recorded the song 'Alison'.
  execute(<<-SQL)
  SELECT artist from albums 
  JOIN tracks ON asin = tracks.album where song='Alison'
  SQL
end


def exodus_artist
  # Select the name of the artist who recorded the song 'Exodus'.
  execute(<<-SQL)
  SELECT artist from albums 
  JOIN tracks ON asin = tracks.album where song='Exodus'
  SQL
end

def blur_songs
  # Select the `song` for each `track` on the album `Blur`.
  execute(<<-SQL)
  SELECT song from tracks 
  JOIN albums ON album = albums.asin where title='Blur'
  SQL
end


def heart_tracks
  # For each album show the title and the total number of tracks containing
  # the word 'Heart' (albums with no such tracks need not be shown). Order first by
  # the number of such tracks, then by album title.
  execute(<<-SQL)
  SELECT title, count(song) from albums 
  JOIN tracks ON asin = tracks.album where song like '%Heart%'
  group by title
  order by count(song) desc, title asc
  SQL
end


def title_tracks
  # A 'title track' has a `song` that is the same as its album's `title`. Select
  # the names of all the title tracks.
  execute(<<-SQL)
  SELECT distinct title from albums
  JOIN tracks ON asin = tracks.album where title in (select song from albums
  JOIN tracks ON asin = tracks.album)
  SQL
end


def eponymous_albums
  # An 'eponymous album' has a `title` that is the same as its recording
  # artist's name. Select the titles of all the eponymous albums.
  execute(<<-SQL)
  SELECT distinct title from albums
  JOIN tracks ON asin = tracks.album where title in (select artist from albums
  JOIN tracks ON asin = tracks.album)
  SQL
end

def song_title_counts
  # Select the song names that appear on more than two albums. Also select the
  # COUNT of times they show up.
  execute(<<-SQL)
  SELECT  song,count(album) from albums
  JOIN tracks ON asin = tracks.album
  group by song
  having count(distinct album) > 2
  SQL
end

def best_value
  # A "good value" album is one where the price per track is less than 50
  # pence. Find the good value albums - show the title, the price and the number
  # of tracks.
  execute(<<-SQL)
  SELECT title, price, count(song) from albums
  JOIN tracks ON asin = tracks.album
  group by title, price
  having price/count(song) < .5
  
  
  
  SQL
end


def top_track_counts
  # Wagner's Ring cycle has an imposing 173 tracks, Bing Crosby clocks up 101
  # tracks. List the top 10 albums. Select both the album title and the track
  # count, and order by both track count and title (descending).
  execute(<<-SQL)
  SELECT
  title,count(title)
  FROM
  albums JOIN tracks ON asin = tracks.album
  group by artist, title
  order by count(title) desc, title desc
  limit 10
  

  SQL
end


def rock_superstars
  # Select the artist who has recorded the most rock albums, as well as the
  # number of albums. HINT: use LIKE '%Rock%' in your query.
  execute(<<-SQL)
  SELECT
  artist, count(distinct asin)
  FROM
  albums JOIN tracks ON asin = tracks.album
  JOIN styles ON asin = styles.album
  WHERE style LIKE '%Rock%'
  group by artist
  order by count(distinct asin) desc
  LIMIT 1
  
  
  
  
  SQL
end



def expensive_tastes
  # Select the five styles of music with the highest average price per track,
  # along with the price per track. One or more of each aggregate functions,
  # subqueries, and joins will be required.
  #
  # HINT: Start by getting the number of tracks per album. You can do this in a
  # subquery. Next, JOIN the styles table to this result and use aggregates to
  # determine the average price per track.
  execute(<<-SQL)
  SELECT style, count(tracks) as avf from (
    SELECT
      style, tracks, price
      FROM
      albums JOIN tracks ON asin = tracks.album
      JOIN styles ON asin = styles.album
      WHERE price IS NOT NULL
      group by style, price, tracks
      ) AS temp
    group by price, temp.style
    order by avf desc
    LIMIT 5
  SQL
end

puts expensive_tastes
