-- Įterpiamos sąskaitos tik užbaigtiems arba patvirtintiems užsakymams
INSERT INTO `Saskaitos` (`uzsakymo_id`, `suma`, `saskaitos_data`)
SELECT 
    `uzsakymo_id`, 
    `bendra_kaina`, 
    DATE_ADD(`grazinimo_data`, INTERVAL 1 DAY) AS `saskaitos_data`
FROM `Uzsakymai`
WHERE `uzsakymo_busena` IN ('užbaigta', 'patvirtinta');


-- Įterpiami mokėjimai tik toms sąskaitoms, kurios buvo sukurtos
INSERT INTO `Mokejimai` (`uzsakymo_id`, `suma`, `mokejimo_data`, `mokejimo_tipas`)
SELECT 
    `uzsakymo_id`, 
    `suma`, 
    DATE_ADD(`saskaitos_data`, INTERVAL 2 HOUR) AS `mokejimo_data`,
    CASE 
        WHEN RAND() < 0.25 THEN 'kortele'
        WHEN RAND() < 0.50 THEN 'bankinis pavedimas'
        WHEN RAND() < 0.75 THEN 'paypal'
        ELSE 'grynieji'
    END AS `mokejimo_tipas`
FROM `Saskaitos`;

