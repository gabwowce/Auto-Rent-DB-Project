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
 
--gtama tikslinimui:
-- 7. Klientų palaikymas. Gauti visus klientų užklausas, kurios dar neatsakytos
SELECT * 
FROM klientu_uzklausos
WHERE atsakymo_data IS NULL;
-- Arba jeigu yra boolean laukas:
SELECT * 
FROM klientu_uzklausos
WHERE atsakyta = 0;

-- 8. Klientų palaikymas. Rasti vidutinį laiką, per kurį darbuotojai atsako į užklausas
SELECT AVG(TIMESTAMPDIFF(SECOND, sukurta_data, atsakymo_data)) AS vidutinis_atsakymo_laikas_sekundemis
FROM klientu_uzklausos
WHERE atsakymo_data IS NOT NULL;

-- 9. Automobilių atsiliepimai. Gauti vidutinį automobilio įvertinimą pagal jo ID
SELECT automobilio_id, AVG(ivertinimas) AS vidutinis_ivertinimas
FROM automobiliu_atsiliepimai
GROUP BY automobilio_id;
-- Jeigu reikia konkrečiam automobiliui, tarkim ID = 3:
SELECT AVG(ivertinimas) AS vidutinis_ivertinimas
FROM automobiliu_atsiliepimai
WHERE automobilio_id = 3;

-- 10. Automobilių servisas. Rasti visus šiuo metu servise esančius automobilius
SELECT * 
FROM serviso_darbai
WHERE pabaigos_data IS NULL;

-- 11.Automobilių servisas. Gauti kiekvieno automobilio serviso darbų vidutinę kainą
SELECT automobilio_id, AVG(kaina) AS vidutine_kaina
FROM serviso_darbai
GROUP BY automobilio_id;

-- 12.Kuro sąnaudos. Rasti automobilį, kuris sunaudojo daugiausiai kuro per paskutinį mėnesį
SELECT automobilio_id, SUM(kiekis_litrais) AS sunaudotas_kiekis
FROM kuro_sanaudos
WHERE data >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
GROUP BY automobilio_id
ORDER BY sunaudotas_kiekis DESC
LIMIT 1;

-- 13.Kuro sąnaudos. Apskaičiuoti kuro vidutinę kainą pagal datas
SELECT data, AVG(kaina_uz_litra) AS vidutine_kaina
FROM kuro_sanaudos
GROUP BY data
ORDER BY data;

-- 14.Remonto darbai. Apskaičiuoti vidutinę remonto kainą pagal servisus
SELECT serviso_id, AVG(kaina) AS vidutine_remonto_kaina
FROM remonto_darbai
GROUP BY serviso_id;

-- 15.Atrinkti automobilius, kurie buvo remontuojami daugiau nei 3 kartus per metus
SELECT automobilio_id, YEAR(data) AS metai, COUNT(*) AS remonto_kartu
FROM remonto_darbai
GROUP BY automobilio_id, YEAR(data)
HAVING remonto_kartu > 3;

-- 16.Draudimai. Atrinkti visus automobilius, kurių draudimas baigsis per artimiausias 30 dienų
SELECT automobilio_id, pabaigos_data
FROM draudimai
WHERE pabaigos_data BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- 17.Draudimai. Atrinkti automobilius, kurie šiuo metu neturi galiojančio draudimo
SELECT automobilio_id
FROM draudimai
WHERE pabaigos_data < CURDATE();

-- 18.Baudų registras. Gauti visas baudas, kurios viršija 100 EUR
SELECT *
FROM baudos
WHERE baudos_suma > 100;

-- 19.Baudų registras.Rasti automobilius su didžiausia bendra baudų suma
SELECT automobilio_id, SUM(baudos_suma) AS bendra_baudu_suma
FROM baudos
GROUP BY automobilio_id
ORDER BY bendra_baudu_suma DESC
LIMIT 1;

-- 20.Darbuotojai. Atrinkti visus darbuotojus, dirbančius daugiau nei 5 metus
SELECT *
FROM darbuotojai
WHERE darbo_pradzios_data <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 21.Darbuotojai. Gauti darbuotoją su didžiausiu atlyginimu
SELECT *
FROM darbuotojai
ORDER BY atlyginimas DESC
LIMIT 1;

-- 22.Atsakingi automobiliai. Gauti visus darbuotojus, kurie šiuo metu atsakingi už bent vieną automobilį
SELECT DISTINCT darbuotojo_id
FROM atsakingi_automobiliai
WHERE pabaigos_data IS NULL;

-- 23.Atsakingi automobiliai.Rasti darbuotoją, kuris ilgiausiai atsakingas už konkretų automobilį
SELECT darbuotojo_id, MIN(pradzios_data) AS atsakomybes_pradzia
FROM atsakingi_automobiliai
WHERE automobilio_id = 3
GROUP BY darbuotojo_id
ORDER BY atsakomybes_pradzia ASC
LIMIT 1;

-- 24.Papildomos paslaugos. Apskaičiuoti vidutinę papildomų paslaugų sumą už užsakymą
SELECT uzsakymo_id, SUM(kaina) AS bendra_papildomu_paslaugų_suma
FROM papildomos_paslaugos
GROUP BY uzsakymo_id;

-- 25.Papildomos paslaugos. Rasti populiariausią papildomą paslaugą pagal užsakymų kiekį
SELECT paslaugos_id, COUNT(uzsakymo_id) AS uzsakymu_kiekis
FROM papildomos_paslaugos
GROUP BY paslaugos_id
ORDER BY uzsakymu_kiekis DESC
LIMIT 1;

-- 26.Rezervavimas.Atrinkti visus klientus, kurie turi aktyvias rezervacijas
SELECT DISTINCT kliento_id
FROM rezervacijos
WHERE pabaigos_data >= CURDATE();

-- 27.Rezervavimas.Rasti vidutinį rezervacijos laiką (nuo pradžios iki pabaigos datos)
SELECT AVG(DATEDIFF(pabaigos_data, pradzios_data)) AS vidutine_rezervacijos_trukme_dienomis
FROM rezervacijos;

-- 28.Nuolaidos. Atrinkti užsakymus, kuriems buvo pritaikytos didžiausios nuolaidos
SELECT uzsakymo_id, nuolaidos_suma
FROM uzsakymu_nuolaidos
ORDER BY nuolaidos_suma DESC
LIMIT 1;

-- 29.Apskaičiuoti bendrą nuolaidų sumą, pritaikytą užsakymams
SELECT SUM(nuolaidos_suma) AS bendra_nuolaidu_suma
FROM uzsakymu_nuolaidos;

-- 30.Pristatymo vietos.Atrinkti visus automobilius, kurie šiuo metu yra konkrečioje pristatymo vietoje
SELECT automobilio_id
FROM pristatymo_vietos
WHERE vietos_id = 3 AND dabartine_vieta = 1;
-- Arba, jei pagal datas::
SELECT automobilio_id
FROM pristatymo_vietos
WHERE vietos_id = 3 AND pabaigos_data IS NULL;

-- 31.Pristatymo vietos.Rasti miestą, kuriame yra daugiausia pristatymo vietų
SELECT miestas, COUNT(*) AS vietu_kiekis
FROM pristatymo_vietos
GROUP BY miestas
ORDER BY vietu_kiekis DESC
LIMIT 1;

-- 32.Bonusų naudojimas.Gauti klientus, kurie panaudojo daugiausiai bonus taškų
SELECT kliento_id, SUM(panaudoti_taskai) AS is_viso_panaudota
FROM bonusai
GROUP BY kliento_id
ORDER BY is_viso_panaudota DESC
LIMIT 1;

-- 33.Gauti visų rezervacijų informaciją kartu su kliento vardu ir pavarde
SELECT r.rezervacijos_id, r.rezervacijos_pradzia, r.rezervacijos_pabaiga, 
       r.busena, k.vardas, k.pavarde
FROM Rezervavimas r
JOIN Klientai k ON r.kliento_id = k.kliento_id;

-- 34.Gauti užsakymus su jų pritaikytomis nuolaidomis ir nuolaidų procentais
SELECT u.uzsakymo_id, n.pavadinimas, n.procentas
FROM Uzsakymo_Nuolaidos un
JOIN Nuolaidos n ON un.nuolaidos_id = n.nuolaidos_id
JOIN Uzsakymai u ON un.uzsakymo_id = u.uzsakymo_id;


-- 35.Surasti klientus, kurie turi aktyvias rezervacijas ir jų paskutinius užsakymus
SELECT k.kliento_id, k.vardas, k.pavarde, r.rezervacijos_pradzia, 
       r.rezervacijos_pabaiga, u.uzsakymo_id, u.uzsakymo_busena
FROM Klientai k
JOIN Rezervavimas r ON k.kliento_id = r.kliento_id
LEFT JOIN Uzsakymai u ON k.kliento_id = u.kliento_id
WHERE r.busena = 'patvirtinta';


-- 36.Surasti automobilius, kurie buvo dažniausiai remontuojami, su jų remonto skaičiumi
SELECT a.automobilio_id, a.marke, a.modelis, COUNT(rd.remonto_id) AS remonto_kartai
FROM Automobiliai a
JOIN Remonto_Darbai rd ON a.automobilio_id = rd.automobilio_id
GROUP BY a.automobilio_id, a.marke, a.modelis
ORDER BY remonto_kartai DESC;


-- 37.Rasti darbuotojus, kurie atsakė į daugiausiai klientų užklausų
SELECT d.darbuotojo_id, d.vardas, d.pavarde, COUNT(kp.uzklausos_id) AS atsakytu_uzklausu_skaicius
FROM Darbuotojai d
JOIN Klientu_Palaikymas kp ON d.darbuotojo_id = kp.darbuotojo_id
WHERE kp.atsakymas IS NOT NULL
GROUP BY d.darbuotojo_id, d.vardas, d.pavarde
ORDER BY atsakytu_uzklausu_skaicius DESC;


-- 38.Gauti visus automobilius su jų dabartine buvimo vieta
SELECT a.automobilio_id, a.marke, a.modelis, p.pavadinimas AS dabartine_vieta
FROM Automobiliai a
JOIN Pristatymo_Vietos p ON a.dabartine_vieta_id = p.vietos_id;


-- 39.Rasti 5 dažniausiai naudojamas papildomas paslaugas užsakymuose
SELECT p.pavadinimas, COUNT(up.uzsakymo_paslaugos_id) AS naudojimo_kartai
FROM Papildomos_Paslaugos p
JOIN Uzsakymo_Paslaugos up ON p.paslaugos_id = up.paslaugos_id
GROUP BY p.pavadinimas
ORDER BY naudojimo_kartai DESC
LIMIT 5;


-- 40.Surasti automobilius su galiojančiu draudimu ir jo sumą
SELECT a.automobilio_id, a.marke, a.modelis, d.suma
FROM Automobiliai a
JOIN Draudimai d ON a.automobilio_id = d.automobilio_id
WHERE d.galiojimo_pabaiga > CURRENT_DATE;


-- 41.Atrinkti automobilius su baudos įrašais, nurodant didžiausią baudą
SELECT a.automobilio_id, a.marke, a.modelis, MAX(b.suma) AS didziausia_bauda
FROM Automobiliai a
JOIN Baudu_Registras b ON a.automobilio_id = b.automobilio_id
GROUP BY a.automobilio_id, a.marke, a.modelis
ORDER BY didziausia_bauda DESC;


-- 42.Surasti 10 klientų, kurie išleido daugiausiai pinigų užsakymams
SELECT k.kliento_id, k.vardas, k.pavarde, SUM(u.bendra_kaina) AS suma
FROM Klientai k
JOIN Uzsakymai u ON k.kliento_id = u.kliento_id
GROUP BY k.kliento_id, k.vardas, k.pavarde
ORDER BY suma DESC
LIMIT 10;


-- 43.Surasti kiekvieno darbuotojo prižiūrimus automobilius
SELECT d.darbuotojo_id, d.vardas, d.pavarde, COUNT(aa.automobilio_id) AS automobiliu_skaicius
FROM Darbuotojai d
JOIN Atsakingi_Automobiliai aa ON d.darbuotojo_id = aa.darbuotojo_id
GROUP BY d.darbuotojo_id, d.vardas, d.pavarde;


-- 44.Rasti kuro sąnaudas pagal automobilio markę ir modelį
SELECT a.marke, a.modelis, SUM(k.kuro_kiekis) AS bendras_kuro_suvartojimas
FROM Automobiliai a
JOIN Kuro_Sanaudos k ON a.automobilio_id = k.automobilio_id
GROUP BY a.marke, a.modelis
ORDER BY bendras_kuro_suvartojimas DESC;


-- 45.Surasti klientus, kurie dažniausiai naudojo bonus taškus
SELECT k.kliento_id, k.vardas, k.pavarde, SUM(bn.panaudoti_taskai) AS panaudoti_taskai
FROM Klientai k
JOIN Bonusu_Naudojimas bn ON k.kliento_id = bn.kliento_id
GROUP BY k.kliento_id, k.vardas, k.pavarde
ORDER BY panaudoti_taskai DESC;

-- 46. Rasti automobilius, kuriuos klientai dažniausiai renkasi pagal klientų amžiaus grupes
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) < 25 THEN 'Jaunesni nei 25'
        WHEN TIMESTAMPDIFF(YEAR, k.gimimo_data, CURDATE()) BETWEEN 25 AND 40 THEN '25-40'
        ELSE 'Vyresni nei 40'
    END AS amziaus_grupe,
    a.marke,
    a.modelis,
    COUNT(*) AS uzsakymu_skaicius
FROM Uzsakymai u
JOIN Klientai k ON u.kliento_id = k.kliento_id
JOIN Automobiliai a ON u.automobilio_id = a.automobilio_id
GROUP BY amziaus_grupe, a.marke, a.modelis
ORDER BY amziaus_grupe, uzsakymu_skaicius DESC;

-- 47. Rasti „populiariausią mėnesį“ automobilių rezervacijoms
SELECT MONTH(rezervacijos_pradzia) AS menuo, COUNT(*) AS rezervaciju_skaicius
FROM Rezervavimas
GROUP BY menuo
ORDER BY rezervaciju_skaicius DESC;













