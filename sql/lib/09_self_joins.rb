# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
  SELECT count(*) from stops
  
  SQL
end


def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
  SELECT id FROM stops WHERE name='Craiglockhart'
  SQL
end



def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
  select id, name from stops join routes on stops.id=routes.stop_id where num='4' and company='LRT'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
  SELECT
     company,
     num,
     COUNT(*)
   FROM
     routes
   WHERE
     stop_id = 149 or stop_id = 53
   GROUP BY
     company, num
   HAVING 
    COUNT(*) = 2
  SQL
end


def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
   SELECT
     a.company,
     a.num,
     a.stop_id,
     b.stop_id
   FROM
     routes a
   JOIN
     routes b ON (a.company = b.company AND a.num = b.num)
   WHERE
     a.stop_id = 53 and b.stop_id=149
  SQL
end


def cl_to_lr_by_name
  # Consider the query:
  #
  
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
  SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  JOIN
    stops stopa ON (a.stop_id = stopa.id)
  JOIN
    stops stopb ON (b.stop_id = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart' and stopb.name = 'London Road'
  SQL
end


def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
  SELECT DISTINCT
    a.company,
    a.num
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  JOIN
    stops stopa ON (a.stop_id = stopa.id)
  JOIN
    stops stopb ON (b.stop_id = stopb.id)
  WHERE
    stopa.name = 'Haymarket' and stopb.name = 'Leith'
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
  SELECT DISTINCT
    a.company,
    a.num
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  JOIN
    stops stopa ON (a.stop_id = stopa.id)
  JOIN
    stops stopb ON (b.stop_id = stopb.id)
  WHERE
    stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
  SELECT distinct name, combined.company, combined.num
  FROM stops JOIN routes AS combined ON id=stop_id
  JOIN (SELECT num, company FROM stops JOIN routes ON id=stop_id where name = 'Craiglockhart') as buses ON combined.num=buses.num and combined.company=buses.company
  
  SQL
end



def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
  SELECT DISTINCT
  start.num, start.company, transfer.name, finish.num, finish.company
  FROM routes as start
  JOIN routes as to_transfer 
  ON start.num=to_transfer.num and start.company=to_transfer.company
  JOIN stops as transfer
  ON to_transfer.stop_id = transfer.id
  JOIN routes as from_transfer
  ON transfer.id = from_transfer.stop_id
  JOIN routes as finish
  ON from_transfer.num=finish.num and from_transfer.company=finish.company
  JOIN stops as start_stop
  ON start.stop_id = start_stop.id
  JOIN stops as finish_stop
  ON finish.stop_id = finish_stop.id
  WHERE
    start_stop.name='Craiglockhart' and finish_stop.name='Sighthill'
  SQL
end
puts craiglockhart_to_sighthill


