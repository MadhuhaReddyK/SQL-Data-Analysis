
/*1. Select all records from the aircrafts_data table:*/

SELECT * FROM aircrafts_data;

/*2. Select all records from the airports_data table:*/

SELECT * FROM  airports_data;

/*3.. Select all records from the flights table:*/

SELECT * FROM flights ;

/*4.Select all columns from the airports_data table where the city is {"en": "Moscow", "ru": "Москва"} :*/

SELECT * FROM airports_data
WHERE CITY='{"en": "Moscow", "ru": "Москва"}';

/*5.Select the model and range of aircraft with a range greater than 5000:*/

SELECT model, range FROM aircrafts_data
WHERE range > 5000;

/*6.Find the distinct cities in the airports_data table:*/

SELECT DISTINCT city FROM airports_data;

/*7.Get all bookings made on a specific date:*/
    
SELECT * FROM bookings
WHERE book_date = '2017-07-01 03:40:00+03';

/*8. List all flights with their actual departure and arrival times:*/

SELECT flight_id, flight_no, actual_departure, actual_arrival FROM flights;

/*9. Find the total number of flights scheduled to depart from a specific airport:*/

SELECT departure_airport, COUNT(*) as total_flights FROM flights
GROUP BY departure_airport;

/*10. Join the tickets and bookings tables to get the booking date for each ticket:*/

SELECT t.ticket_no, t.book_ref, b.book_date FROM tickets t
JOIN bookings b ON t.book_ref = b.book_ref;

/*11.Get the list of passengers, who have booked flights with a specific fare condition Business :*/

SELECT t.passenger_id FROM tickets t
JOIN ticket_flights tf ON t.ticket_no = tf.ticket_no
WHERE tf.fare_conditions = 'Business';

/*12.Retrieve the total amount spent on each booking:*/

SELECT b.book_ref, SUM(a.amount) as total_amount
FROM bookings b
JOIN tickets t ON b.book_ref = t.book_ref
JOIN ticket_flights a ON t.ticket_no = a.ticket_no
GROUP BY b.book_ref;

/*13.List the number of seats available for each fare condition on a specific aircraft:*/

SELECT aircraft_code, fare_conditions, COUNT(seat_no) as available_seats FROM seats
WHERE aircraft_code = 321
GROUP BY aircraft_code, fare_conditions;

/*14.Find the top 2 aircraft model based on the number of flights:*/

SELECT a.model, COUNT(f.flight_id) as flight_count FROM flights f
JOIN aircrafts_data a ON f.aircraft_code = a.aircraft_code
GROUP BY a.model
ORDER BY flight_count DESC
LIMIT 2;

/*15.Get the list of airports along with the number of flights and flight number arriving at each airport:*/

SELECT arrival_airport as airports ,flight_no , COUNT(*) as total_arrivals FROM flights
GROUP BY arrival_airport ;

/*16.Calculate the total revenue generated from ticket sales by flight_id:*/

SELECT flight_id ,SUM(amount) as total_revenue FROM ticket_flights
GROUP BY flight_id ;


/*17. Find the average flight range of all aircrafts:*/

SELECT AVG(range) as average_range
FROM aircrafts_data;

/*18.Find the busiest departure airport based on the number of flights:*/

SELECT departure_airport, COUNT(*) as flight_count FROM flights
GROUP BY departure_airport
ORDER BY flight_count DESC
LIMIT 1;

/*19. Get the flight details for flights with no boarding passes issued:*/
SELECT f.* FROM flights f
LEFT JOIN boarding_passes bp ON f.flight_id = bp.flight_id
where boarding_no is null;

/*20.The number of passengers and flights traveled.*/

SELECT t.passenger_id, COUNT(f.flight_id) as flight_count FROM tickets t
JOIN ticket_flights f ON t.ticket_no = f.ticket_no
GROUP BY t.passenger_id
ORDER BY flight_count DESC;

/*21.Get the average amount spent per passenger for each fare condition:*/

SELECT fare_conditions, AVG(amount) as avg_amount_spent FROM ticket_flights
GROUP BY fare_conditions;

/*22.The top 5 aircraft models based on total distance covered:*/

SELECT a.model, SUM(a.range) as total_distance_covered FROM flights f
JOIN aircrafts_data a ON f.aircraft_code = a.aircraft_code
GROUP BY a.model
ORDER BY total_distance_covered DESC
LIMIT 5;

/*23.Find the flight with the maximum number of passengers:*/
SELECT f.flight_id, COUNT(t.passenger_id) as passenger_count FROM flights f
JOIN ticket_flights tf ON f.flight_id = tf.flight_id
JOIN tickets t ON tf.ticket_no = t.ticket_no
GROUP BY f.flight_id
ORDER BY passenger_count DESC
limit 1;

/*24.Determine the city with the most connected airports (having the most number of airports):*/

SELECT city, COUNT(*) as airport_count FROM airports_data
GROUP BY city
ORDER BY airport_count DESC
LIMIT 1;

/*25.Identify the most profitable flight route (based on total ticket amount):*/

SELECT f.departure_airport, f.arrival_airport, SUM(tf.amount) as total_revenue
FROM flights f
JOIN ticket_flights tf ON f.flight_id = tf.flight_id
GROUP BY f.departure_airport, f.arrival_airport
ORDER BY total_revenue DESC
LIMIT 1;

