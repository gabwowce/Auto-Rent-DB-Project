-- 1. Įterpiamos sąskaitos tik užbaigtiems arba patvirtintiems užsakymams
INSERT INTO `Saskaitos` (`uzsakymo_id`, `suma`, `saskaitos_data`)
SELECT 
    `uzsakymo_id`, 
    `bendra_kaina`, 
    DATE_ADD(`grazinimo_data`, INTERVAL 1 DAY) AS `saskaitos_data`
FROM `Uzsakymai`
WHERE `uzsakymo_busena` IN ('užbaigta', 'patvirtinta');


-- 2. Įterpiami mokėjimai tik toms sąskaitoms, kurios buvo sukurtos
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

-- 3. Kiek klientų yra užsakę bent vieną automobilį?
SELECT COUNT(DISTINCT kliento_id) AS uzsake_klientai
FROM Uzsakymai;

-- 4. Kokie klientai išleido daugiausiai pinigų nuomai?
SELECT k.kliento_id, k.vardas, k.pavarde, SUM(u.bendra_kaina) AS viso_isleista
FROM Uzsakymai u
JOIN Klientai k ON u.kliento_id = k.kliento_id
GROUP BY k.kliento_id
ORDER BY viso_isleista DESC
LIMIT 10;

-- 5. Kokie klientai dažniausiai naudojasi nuolaidomis?
SELECT k.kliento_id, k.vardas, k.pavarde, COUNT(un.uzsakymo_nuolaidos_id) AS nuolaidu_kiekis
FROM Uzsakymo_Nuolaidos un
JOIN Uzsakymai u ON un.uzsakymo_id = u.uzsakymo_id
JOIN Klientai k ON u.kliento_id = k.kliento_id
GROUP BY k.kliento_id
ORDER BY nuolaidu_kiekis DESC
LIMIT 10;

-- 6. Klientų, kurie turi nesumokėtų sąskaitų, sąrašas
SELECT k.kliento_id, k.vardas, k.pavarde, s.saskaitos_id, s.suma
FROM Saskaitos s
JOIN Uzsakymai u ON s.uzsakymo_id = u.uzsakymo_id
JOIN Klientai k ON u.kliento_id = k.kliento_id
LEFT JOIN Mokejimai m ON s.saskaitos_id = m.uzsakymo_id
WHERE m.mokejimo_id IS NULL;
