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
 

-- 7. Klientų palaikymas. Gauti visus klientų užklausas, kurios dar neatsakytos
-- 8. Klientų palaikymas. Rasti vidutinį laiką, per kurį darbuotojai atsako į užklausas
-- 9. Automobilių atsiliepimai. Gauti vidutinį automobilio įvertinimą pagal jo ID
-- 10. Automobilių servisas. Rasti visus šiuo metu servise esančius automobilius
-- 11.Automobilių servisas. Gauti kiekvieno automobilio serviso darbų vidutinę kainą
-- 12.Kuro sąnaudos. Rasti automobilį, kuris sunaudojo daugiausiai kuro per paskutinį mėnesį
-- 13.Kuro sąnaudos. Apskaičiuoti kuro vidutinę kainą pagal datas
-- 14.Remonto darbai. Apskaičiuoti vidutinę remonto kainą pagal servisus
-- 15.Atrinkti automobilius, kurie buvo remontuojami daugiau nei 3 kartus per metus
-- 16.Draudimai. Atrinkti visus automobilius, kurių draudimas baigsis per artimiausias 30 dienų
-- 17.Draudimai. Atrinkti automobilius, kurie šiuo metu neturi galiojančio draudimo
-- 18.Baudų registras. Gauti visas baudas, kurios viršija 100 EUR
-- 19.Baudų registras.Rasti automobilius su didžiausia bendra baudų suma
-- 20.Darbuotojai. Atrinkti visus darbuotojus, dirbančius daugiau nei 5 metus
-- 21.Darbuotojai. Gauti darbuotoją su didžiausiu atlyginimu
-- 22.Atsakingi automobiliai. Gauti visus darbuotojus, kurie šiuo metu atsakingi už bent vieną automobilį
-- 23.Atsakingi automobiliai.Rasti darbuotoją, kuris ilgiausiai atsakingas už konkretų automobilį
-- 24.Papildomos paslaugos. Apskaičiuoti vidutinę papildomų paslaugų sumą už užsakymą
-- 25.Papildomos paslaugos. Rasti populiariausią papildomą paslaugą pagal užsakymų kiekį
-- 26.Rezervavimas.Atrinkti visus klientus, kurie turi aktyvias rezervacijas
-- 27.Rezervavimas.Rasti vidutinį rezervacijos laiką (nuo pradžios iki pabaigos datos)
-- 28.Nuolaidos. Atrinkti užsakymus, kuriems buvo pritaikytos didžiausios nuolaidos
-- 29.Apskaičiuoti bendrą nuolaidų sumą, pritaikytą užsakymams
-- 30.Pristatymo vietos.Atrinkti visus automobilius, kurie šiuo metu yra konkrečioje pristatymo vietoje
-- 31.Pristatymo vietos.Rasti miestą, kuriame yra daugiausia pristatymo vietų
-- 32.Bonusų naudojimas.Gauti klientus, kurie panaudojo daugiausiai bonus taškų



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

















