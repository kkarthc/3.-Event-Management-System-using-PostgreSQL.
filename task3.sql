-- Create the Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,           -- Unique identifier for events
    Event_Name TEXT NOT NULL,              -- Name of the event
    Event_Date DATE NOT NULL,              -- Date of the event
    Event_Location TEXT,                   -- Location of the event
    Event_Description TEXT                 -- Description of the event
);

-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,        -- Unique identifier for attendees
    Attendee_Name TEXT NOT NULL,           -- Name of the attendee
    Attendee_Phone NUMERIC(15),            -- Phone number of the attendee
    Attendee_Email TEXT,                   -- Email address of the attendee
    Attendee_City TEXT                     -- City of the attendee
);

-- Create the Registrations table
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,    -- Unique identifier for registrations
    Event_Id INT REFERENCES Events(Event_Id) ON DELETE CASCADE, -- References Event_Id in Events table
    Attendee_Id INT REFERENCES Attendees(Attendee_Id) ON DELETE CASCADE, -- References Attendee_Id in Attendees table
    Registration_Date DATE NOT NULL,       -- Date of registration
    Registration_Amount NUMERIC(10, 2)    -- Registration fee
);
-- Insert sample data into the Events table
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Hackathon 2024', '2024-12-01', 'New York', 'A conference for tech enthusiasts.'),
('Pradeep Concert', '2024-11-30', 'Chennai', 'An exciting music festival.'),
('AR Rahman Concert', '2024-12-15', 'Dubai', 'A showcase of Oscar Winning Performance.');

-- Insert sample data into the Attendees table
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('Karthick', 1234567890, 'karthick@example.com', 'Chennai'),
('Athish', 9876543210, 'athish@example.com', 'Dubai'),
('Abdul', 1122334455, 'abdul@example.com', 'NY'),
('Sakthi', 5566778899, 'sakthi@example.com', 'Chennai');

-- Insert sample data into the Registrations table
INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(1, 1, '2024-11-20', 10000.00),
(1, 2, '2024-11-21', 15000.00),
(2, 3, '2024-11-25', 12000.00),
(3, 4, '2024-12-01', 8000.00);
-- Insert a new event
INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES ('Debugging 2024', '2024-12-10', 'Austin', 'A 24-hour coding challenge.');
select * from Events;
-- Update an event's information
UPDATE Events
SET Event_Location = 'ECR', Event_Description = 'Updated description for the tech conference.'
WHERE Event_Id = 1;
select * from Events;
-- Delete an event
DELETE FROM Events
WHERE Event_Id = 1;
select * from Events;
-- Insert a new attendee
INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('Subash', 3344556677, 'subash@example.com', 'Besant Nagar');
select * from Attendees;
-- Retrieve all event information
SELECT * FROM Events;
-- Generate attendee list for Event_Id = 1
SELECT A.Attendee_Name, A.Attendee_Email, A.Attendee_City
FROM Registrations R
JOIN Attendees A ON R.Attendee_Id = A.Attendee_Id
WHERE R.Event_Id = 2;
-- Count attendees for each event
SELECT E.Event_Name, COUNT(R.Attendee_Id) AS Total_Attendees
FROM Events E
LEFT JOIN Registrations R ON E.Event_Id = R.Event_Id
GROUP BY E.Event_Id, E.Event_Name
ORDER BY Total_Attendees DESC;
