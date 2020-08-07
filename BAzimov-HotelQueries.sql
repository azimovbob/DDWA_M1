-- 1. Write a query that returns a list of reservations that end in July 2023, 
-- including the name of the guest, the room number(s), 
-- and the reservation dates.
SELECT g.FirstName,g.LastName,
	   r.RoomNumber, r.Check_in, r.Check_out 
FROM Reservation r
INNER JOIN Guest g ON r.GuestId = g.GuestId
WHERE r.Check_out BETWEEN '2023/07/01' AND '2023/07/31';



-- 2.Write a query that returns a list of all 
-- reservations for rooms with a jacuzzi, 
-- displaying the guest's name, the room number, 
-- and the dates of the reservation.
SELECT g.FirstName,g.LastName,
	   r.RoomNumber, r.Check_in, r.Check_out
FROM Reservation r	   
INNER JOIN Guest g ON r.GuestId = g.GuestId
INNER JOIN Room ro ON r.RoomNumber = ro.RoomNumber
INNER JOIN RoomAmenities ra ON ro.RoomNumber = ra.RoomNumber
INNER JOIN Amenities a ON ra.AmenityId = a.AmenityId
WHERE a.AmenityType = 'Jacuzzi';


-- 3.Write a query that returns all the rooms 
-- reserved for a specific guest, including 
-- the guest's name, the room(s) reserved, 
-- the starting date of the reservation, 
-- and how many people were included in the reservation. 
-- (Choose a guest's name from the existing data.)
SELECT CONCAT(g.FirstName, " ",g.LastName) AS 'Name',
	   r.RoomNumber, r.Check_in, 
	   r.Adults+r.Children AS 'Total People'
FROM Reservation r
INNER JOIN Guest g ON g.GuestId = r.GuestId
WHERE g.FirstName = 'Mack' AND g.LastName = 'Simmer';


-- 4.Write a query that returns a list of rooms, reservation ID, 
-- and per-room cost for each reservation. The results should 
-- include all rooms, whether or not there is a reservation 
-- associated with the room.
SELECT ro.RoomNumber, 
	   r.ReservationId, 
	   r.TotalPrice
FROM Room ro
LEFT OUTER JOIN Reservation r ON ro.RoomNumber = r.RoomNumber;


-- 5.Write a query that returns all the rooms 
-- accommodating at least three guests and 
-- that are reserved on any date in April 2023.
SELECT r.RoomNumber,
	   r.Adults + r.Children AS 'TotalPeople'
FROM Reservation r
WHERE r.Adults+r.Children > 2 
AND r.Check_in BETWEEN 2023/04/01 AND 2023/04/31;


-- 6.Write a query that returns a list of 
-- all guest names and the number of 
-- reservations per guest, sorted 
-- starting with the guest with the 
-- most reservations and then by the guest's last name.
SELECT CONCAT(g.FirstName, " ", g.LastName) AS 'Name',
	   COUNT(R.GuestId) AS 'TotalReservations'
FROM  Reservation r
INNER JOIN Guest g ON g.GuestId = r.GuestId
GROUP BY r.GuestId
ORDER BY COUNT(*) DESC , g.LastName ASC;


-- 7.Write a query that displays the name, 
-- address, and phone number of a guest 
-- based on their phone number. 
-- (Choose a phone number from the existing data.)
SELECT CONCAT(g.FirstName, " ", g.LastName) AS 'Name',
	   CONCAT(a.Address, ", ", a.City, ", ", a.StateAbb, ", ", a.Zipcode),
	   g.Phone FROM Guest g
INNER JOIN Address a ON g.AddressId = a.AddressId
WHERE g.Phone = '2915530508';
