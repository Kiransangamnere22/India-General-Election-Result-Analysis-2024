-- PROBLEM STATEMENTS

-- 1) Total Seats

select COUNT(Parliament_Constituency) As Total_Seats
from [India Elections Results].dbo.constituencywise_results;

-- 2) What is the total number of seats available for elections in each state

-- short From we use 
-- 1.constituency_results= (cr)
-- 2.constituency_details= (cd)
-- 3.partrywise_results = (pr)
-- 4.statewise_results = (sr)
-- 5. state =(s)      

 select 
 s.state as State_Name,
 count(cr.Parliament_Constituency) as Total_Seats
 from [India Elections Results].dbo.constituencywise_results cr
 inner join [India Elections Results].dbo.statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
 inner join [India Elections Results].dbo.states s on sr.State_id=s.State_id
 group by s.state;

 --3. Total Seats won by NDA Alliance   (NDA is combination of all this party)

 SELECT 
    SUM(CASE 
          WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN [Won]
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    [India Elections Results].dbo.partywise_results;

-- Seats Won by NDA Allianz Parties

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    [India Elections Results].dbo.partywise_results
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC;

-- Total Seats Won by I.N.D.I.A. Allianz (I.N.D.I.A Allianz Combine all this party)

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    [India Elections Results].dbo.partywise_results;


-- Seats Won by I.N.D.I.A. Allianz Parties

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
     [India Elections Results].dbo.partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC;


-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER

alter Table partywise_results
add party_allianz varchar(50);

-- I.N.D.I.A Allianz

UPDATE [India Elections Results].dbo.partywise_results
SET party_allianz = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);


-- NDA Allianz

UPDATE [India Elections Results].dbo.partywise_results
SET party_allianz = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

-- OTHER
UPDATE [India Elections Results].dbo. partywise_results
SET party_allianz = 'OTHER'
WHERE party_allianz IS NULL;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?

SELECT 
    p.party_allianz,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    [India Elections Results].dbo.constituencywise_results cr
JOIN 
    [India Elections Results].dbo.partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    p.party_allianz IN ('NDA', 'I.N.D.I.A', 'OTHER')
GROUP BY 
    p.party_allianz
ORDER BY 
    Seats_Won DESC;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

-- i am, checking for my district State = Maharashtra  and Constituency_Name

SELECT cr.Winning_Candidate, p.Party,  p.party_allianz, cr.Total_Votes, cr.Margin, cr.Constituency_Name, s.State
FROM [India Elections Results].dbo.constituencywise_results cr
JOIN [India Elections Results].dbo. partywise_results p ON cr.Party_ID = p.Party_ID
JOIN [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
WHERE s.State = 'Maharashtra' AND cr.Constituency_Name = 'NASHIK';


-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

SELECT 
    cd.Candidate,
    cd.Party,
    cd.EVM_Votes,
    cd.Postal_Votes,
    cd.Total_Votes,
    cr.Constituency_Name
FROM 
    [India Elections Results].dbo.constituencywise_details cd  
JOIN 
    [India Elections Results].dbo.constituencywise_results cr   ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
    cr.Constituency_Name = 'NASHIK'
ORDER BY cd.Total_Votes DESC;

-- To Makes it's dynamic

CREATE PROCEDURE GetConstituencyVotes
    @ConstituencyName NVARCHAR(100)
AS
BEGIN
    SELECT 
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.Total_Votes,
        cr.Constituency_Name
    FROM 
        [India Elections Results].dbo.constituencywise_details cd  
    JOIN 
        [India Elections Results].dbo.constituencywise_results cr   
        ON cd.Constituency_ID = cr.Constituency_ID
    WHERE 
        cr.Constituency_Name = @ConstituencyName
    ORDER BY 
        cd.Total_Votes DESC;
END;

EXEC GetConstituencyVotes 'PUNE';   

-- Which parties won the most seats in s State, and how many seats did each party win?

SELECT 
    p.Party,
    COUNT(cr.Constituency_ID) AS Seats_Won
FROM 
    [India Elections Results].dbo.constituencywise_results cr
inner JOIN 
    [India Elections Results].dbo.partywise_results p ON cr.Party_ID = p.Party_ID
inner JOIN 
    [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
inner JOIN [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
WHERE 
    s.state = 'Maharashtra'
GROUP BY 
    p.Party
ORDER BY 
    Seats_Won DESC;

-- to make Dynamic

CREATE PROCEDURE GetPartySeatsByState
    @StateName NVARCHAR(100)
AS
BEGIN
    SELECT 
        p.Party,
        COUNT(cr.Constituency_ID) AS Seats_Won
    FROM 
        [India Elections Results].dbo.constituencywise_results cr
    INNER JOIN 
        [India Elections Results].dbo.partywise_results p ON cr.Party_ID = p.Party_ID
    INNER JOIN 
        [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    INNER JOIN 
        [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
    WHERE 
        s.state = @StateName
    GROUP BY 
        p.Party
    ORDER BY 
        Seats_Won DESC;
END;

-- Excute 

EXEC GetPartySeatsByState 'Goa';

-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_allianz = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_allianz = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_allianz = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
   [India Elections Results].dbo. constituencywise_results cr
JOIN 
   [India Elections Results].dbo. partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
WHERE 
    p.party_allianz IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;


-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?

SELECT TOP 10
    cr.Constituency_Name,
    cd.Constituency_ID,
    cd.Candidate,
    cd.EVM_Votes
FROM 
    [India Elections Results].dbo.constituencywise_details cd
JOIN 
    [India Elections Results].dbo.constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE       -- Filters the results to only include candidates who received the maximum number of EVM votes within their respective constituencies.
    cd.EVM_Votes = (
        SELECT MAX(cd1.EVM_Votes)
        FROM [India Elections Results].dbo.constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )
ORDER BY 
    cd.EVM_Votes DESC;


-- Which candidate received the highest number of Postal_Votes votes in each constituency (Top 10)?

SELECT TOP 10
    cr.Constituency_Name,
    cd.Constituency_ID,
    cd.Candidate,
    cd.Postal_Votes
FROM 
    [India Elections Results].dbo.constituencywise_details cd
JOIN 
    [India Elections Results].dbo.constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE       -- Filters the results to only include candidates who received the maximum number of EVM votes within their respective constituencies.
    cd.Postal_Votes = (
        SELECT MAX(cd1.Postal_Votes)
        FROM [India Elections Results].dbo.constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )
ORDER BY 
    cd.Postal_Votes DESC;


-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections?

WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        [India Elections Results].dbo.constituencywise_details cd
    JOIN 
        [India Elections Results].dbo.constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Maharashtra'
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    [India Elections Results].dbo.constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;


-- Dynamic

CREATE PROCEDURE GetTopCandidatesByState
    @StateName NVARCHAR(100)
AS
BEGIN
    WITH RankedCandidates AS (
        SELECT 
            cd.Constituency_ID,
            cd.Candidate,
            cd.Party,
            cd.EVM_Votes,
            cd.Postal_Votes,
            cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
            ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
        FROM 
            [India Elections Results].dbo.constituencywise_details cd
        JOIN 
            [India Elections Results].dbo.constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
        JOIN 
            [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
        JOIN 
            [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
        WHERE 
            s.State = @StateName
            
    )

    SELECT 
        cr.Constituency_Name,
        MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
        MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
    FROM 
        RankedCandidates rc
    JOIN 
        [India Elections Results].dbo.constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
    GROUP BY 
        cr.Constituency_Name
    ORDER BY 
        cr.Constituency_Name;
END;

EXEC GetTopCandidatesByState 'Goa';

-- For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?


SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    [India Elections Results].dbo.constituencywise_results cr
JOIN 
    [India Elections Results].dbo.constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
JOIN 
    [India Elections Results].dbo.partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';

-- Dynamic

CREATE PROCEDURE GetElectionSummaryByState
    @StateName VARCHAR(100)
AS
BEGIN
    SELECT 
        COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
        COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
        COUNT(DISTINCT p.Party) AS Total_Parties,
        SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
        SUM(cd.EVM_Votes) AS Total_EVM_Votes,
        SUM(cd.Postal_Votes) AS Total_Postal_Votes
    FROM 
        [India Elections Results].dbo.constituencywise_results cr
    JOIN 
        [India Elections Results].dbo.constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
    JOIN 
        [India Elections Results].dbo.statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        [India Elections Results].dbo.states s ON sr.State_ID = s.State_ID
    JOIN 
        [India Elections Results].dbo.partywise_results p ON cr.Party_ID = p.Party_ID
    WHERE 
        s.State = @StateName;
END;

EXEC GetElectionSummaryByState 'Goa';


