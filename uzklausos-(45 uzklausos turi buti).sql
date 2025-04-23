
-- 1. Kiek klientų yra užsakę bent vieną automobilį?
SELECT COUNT(DISTINCT kliento_id) AS uzsake_klientai
FROM Uzsakymai;

-- 2. Kokie klientai išleido daugiausiai pinigų nuomai?
SELECT k.kliento_id, k.vardas, k.pavarde, SUM(u.bendra_kaina) AS viso_isleista
FROM Uzsakymai u
JOIN Klientai k ON u.kliento_id = k.kliento_id
GROUP BY k.kliento_id
ORDER BY viso_isleista DESC
LIMIT 10;

-- 3. Klientai, kurie turi nesumokėtų sąskaitų
SELECT k.kliento_id, k.vardas, k.pavarde, s.saskaitos_id, s.suma
FROM Saskaitos s
JOIN Uzsakymai u ON s.uzsakymo_id = u.uzsakymo_id
JOIN Klientai k ON u.kliento_id = k.kliento_id
LEFT JOIN Mokejimai m ON s.saskaitos_id = m.uzsakymo_id
WHERE m.mokejimo_id IS NULL;
 

-- 4. Klientų palaikymas. Gauti visas klientų užklausas, kurios dar neatsakytos
SELECT * 
FROM klientu_palaikymas
WHERE atsakymas IS NULL;


-- 5. Klientų palaikymas. Rasti vidutinį laiką, per kurį darbuotojai atsako į užklausas
SELECT AVG(TIMESTAMPDIFF(minute, pateikimo_data, atsakymo_data)) AS vidutinis_atsakymo_laikas_sekundemis
FROM klientu_palaikymas
WHERE atsakymo_data IS NOT NULL;

-- 6. Automobilių atsiliepimai. Gauti vidutinį automobilių įvertinimą 
SELECT aa.automobilio_id, a.marke, a.modelis, FORMAT(AVG(aa.ivertinimas), 2) AS vidutinis_ivertinimas
FROM automobilio_atsiliepimai aa
join automobiliai a on aa.automobilio_id = a.automobilio_id 
GROUP BY aa.automobilio_id;


-- 7. Automobilių servisas. Rasti visus šiuo metu servise esančius automobilius
SELECT * 
FROM automobiliu_servisas  
WHERE serviso_pabaigos_data IS NULL;

-- 8.Automobilių servisas. Gauti kiekvieno automobilio serviso darbų vidutinę kainą
SELECT automobilio_id, AVG(kaina) AS vidutine_kaina
FROM automobiliu_servisas
GROUP BY automobilio_id;

-- 9.Kuro sąnaudos. Apskaičiuoti kuro vidutinę kainą pagal datas
SELECT data, AVG(kaina/kuro_kiekis) AS vidutine_kaina
FROM kuro_sanaudos
GROUP BY data
ORDER BY data;

-- 10.Remonto darbai. Apskaičiuoti vidutinę remonto kainą pagal servisus
SELECT serviso_pavadinimas , AVG(kaina) AS vidutine_remonto_kaina
FROM remonto_darbai
GROUP BY serviso_pavadinimas;

-- 11.Atrinkti automobilius, kurie buvo remontuojami daugiau nei 2 kartus per metus
SELECT automobilio_id, YEAR(remonto_pradzios_data) AS metai, COUNT(*) AS remonto_kartu
FROM remonto_darbai
GROUP BY automobilio_id, YEAR(remonto_pradzios_data)
HAVING remonto_kartu > 1;

-- 12.Draudimai. Atrinkti visus automobilius, kurių draudimas baigsis per artimiausias 300 dienų
SELECT automobilio_id, galiojimo_pabaiga 
FROM draudimai
WHERE galiojimo_pabaiga BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 300 DAY);

-- 13.Draudimai. Atrinkti automobilius, kurie šiuo metu neturi galiojančio draudimo
SELECT automobilio_id
FROM draudimai
WHERE galiojimo_pabaiga < CURDATE();

-- 14.Baudų registras. Gauti visas baudas, kurios viršija 100 EUR
SELECT *
FROM baudu_registras
WHERE suma > 100;

-- 15.Baudų registras. Rasti 5 automobilius su didžiausia bendra baudų suma
SELECT automobilio_id, SUM(suma) AS bendra_baudu_suma
FROM baudu_registras
GROUP BY automobilio_id
ORDER BY bendra_baudu_suma DESC
LIMIT 5;

-- 16.Darbuotojai. Atrinkti visus darbuotojus, dirbančius daugiau nei 5 metus
SELECT *
FROM darbuotojai
WHERE isidarbinimo_data <= DATE_SUB(CURDATE(), INTERVAL 5 YEAR);

-- 17.Darbuotojai. Gauti darbuotoją su didžiausiu atlyginimu
SELECT *
FROM darbuotojai
ORDER BY atlyginimas DESC
LIMIT 1;

-- 18.Atsakingi automobiliai. Gauti visus darbuotojus, kurie šiuo metu atsakingi už bent vieną automobilį
SELECT d.darbuotojo_id, d.vardas, d.pavarde
FROM darbuotojai d
JOIN atsakingi_automobiliai aa ON d.darbuotojo_id = aa.darbuotojo_id
WHERE (aa.pabaigos_data IS NULL)
GROUP BY d.darbuotojo_id, d.vardas, d.pavarde;


-- 19.Papildomos paslaugos. Apskaičiuoti vidutinę papildomų paslaugų sumą už užsakymą
SELECT up.uzsakymo_id, SUM(pp.kaina) AS uzsakymo_suma
FROM uzsakymo_paslaugos up
JOIN papildomos_paslaugos pp ON up.paslaugos_id = pp.paslaugos_id
GROUP BY up.uzsakymo_id;


-- 20.Papildomos paslaugos. Rasti populiariausią papildomą paslaugą pagal užsakymų kiekį
SELECT pp.paslaugos_id, COUNT(up.uzsakymo_id) AS uzsakymu_kiekis
FROM uzsakymo_paslaugos up
JOIN papildomos_paslaugos pp ON pp.paslaugos_id = up.paslaugos_id 
GROUP BY pp.paslaugos_id
ORDER BY uzsakymu_kiekis DESC
LIMIT 1;

-- 21.Rezervavimas.Atrinkti visus klientus, kurie turi aktyvias rezervacijas
SELECT DISTINCT kliento_id
FROM rezervavimas r 
WHERE rezervacijos_pabaiga >= CURDATE();

-- 22.Rezervavimas.Rasti vidutinį rezervacijos laiką (nuo pradžios iki pabaigos datos)
SELECT AVG(DATEDIFF(rezervacijos_pabaiga , rezervacijos_pradzia)) AS vidutine_rezervacijos_trukme_dienomis
FROM rezervavimas r ;

-- 23.Nuolaidos. Atrinkti užsakymus, kuriems buvo pritaikytos didžiausios nuolaidos
SELECT uzsakymo_id, 
FROM uzsakymo_nuolaidos un 
ORDER BY nuolaidos_suma DESC
LIMIT 1;


-- 24.Pristatymo vietos. Kiek pristatymų vietų turime kiekviename mieste?
SELECT miestas, COUNT(*) AS vietu_kiekis
FROM pristatymo_vietos
GROUP BY miestas
ORDER BY vietu_kiekis DESC


-- 25.Bonusų naudojimas.Gauti top 10 klientų, kurie panaudojo daugiausiai bonus taškų
SELECT kliento_id, SUM(panaudoti_taskai) AS is_viso_panaudota
FROM bonusu_naudojimas bn 
GROUP BY kliento_id
ORDER BY is_viso_panaudota DESC
LIMIT 10;

-- 26.Gauti visų rezervacijų informaciją kartu su kliento vardu ir pavarde
SELECT r.rezervacijos_id, r.rezervacijos_pradzia, r.rezervacijos_pabaiga, 
       r.busena, k.vardas, k.pavarde
FROM Rezervavimas r
JOIN Klientai k ON r.kliento_id = k.kliento_id;

-- 27.Gauti užsakymus su jų pritaikytomis nuolaidomis ir nuolaidų procentais
SELECT u.uzsakymo_id, n.pavadinimas, n.procentas
FROM Uzsakymo_Nuolaidos un
JOIN Nuolaidos n ON un.nuolaidos_id = n.nuolaidos_id
JOIN Uzsakymai u ON un.uzsakymo_id = u.uzsakymo_id;


-- 28.Surasti klientus, kurie turi aktyvias rezervacijas
SELECT k.kliento_id, k.vardas, k.pavarde, r.rezervacijos_pradzia, 
       r.rezervacijos_pabaiga,r.busena
FROM Klientai k
JOIN Rezervavimas r ON k.kliento_id = r.kliento_id
WHERE r.busena = 'patvirtinta';


-- 29.Surasti automobilius, kurie buvo dažniausiai remontuojami, su jų remonto skaičiumi
SELECT a.automobilio_id, a.marke, a.modelis, COUNT(rd.remonto_id) AS remonto_kartai
FROM Automobiliai a
JOIN Remonto_Darbai rd ON a.automobilio_id = rd.automobilio_id
GROUP BY a.automobilio_id, a.marke, a.modelis
ORDER BY remonto_kartai DESC;


-- 30.Rasti darbuotojus, kurie atsakė į daugiausiai klientų užklausų
SELECT d.darbuotojo_id, d.vardas, d.pavarde, COUNT(kp.uzklausos_id) AS atsakytu_uzklausu_skaicius
FROM Darbuotojai d
JOIN Klientu_Palaikymas kp ON d.darbuotojo_id = kp.darbuotojo_id
WHERE kp.atsakymas IS NOT NULL
GROUP BY d.darbuotojo_id, d.vardas, d.pavarde
ORDER BY atsakytu_uzklausu_skaicius DESC;


-- 31.Gauti visus automobilius su jų dabartine buvimo vieta
SELECT a.automobilio_id, a.marke, a.modelis, p.pavadinimas AS dabartine_vieta
FROM Automobiliai a
JOIN Pristatymo_Vietos p ON a.dabartine_vieta_id = p.vietos_id;


-- 32.Rasti 5 dažniausiai naudojamas papildomas paslaugas užsakymuose
SELECT p.pavadinimas, COUNT(up.uzsakymo_paslaugos_id) AS naudojimo_kartai
FROM Papildomos_Paslaugos p
JOIN Uzsakymo_Paslaugos up ON p.paslaugos_id = up.paslaugos_id
GROUP BY p.pavadinimas
ORDER BY naudojimo_kartai DESC
LIMIT 5;


-- 33.Surasti automobilius su galiojančiu draudimu
SELECT a.automobilio_id, a.marke, a.modelis
FROM Automobiliai a
JOIN Draudimai d ON a.automobilio_id = d.automobilio_id
WHERE d.galiojimo_pabaiga > CURRENT_DATE;


-- 34.Atrinkti automobilius su baudos įrašais, nurodant didžiausią baudą
SELECT a.automobilio_id, a.marke, a.modelis, MAX(b.suma) AS didziausia_bauda
FROM Automobiliai a
JOIN Baudu_Registras b ON a.automobilio_id = b.automobilio_id
GROUP BY a.automobilio_id, a.marke, a.modelis
ORDER BY didziausia_bauda DESC;


-- 35.Surasti 10 klientų, kurie išleido daugiausiai pinigų užsakymams
SELECT k.kliento_id, k.vardas, k.pavarde, SUM(u.bendra_kaina) AS suma
FROM Klientai k
JOIN Uzsakymai u ON k.kliento_id = u.kliento_id
GROUP BY k.kliento_id, k.vardas, k.pavarde
ORDER BY suma DESC
LIMIT 10;


-- 36.Surasti kiekvieno darbuotojo prižiūrimus automobilius
SELECT d.darbuotojo_id, d.vardas, d.pavarde, COUNT(aa.automobilio_id) AS automobiliu_skaicius
FROM Darbuotojai d
JOIN Atsakingi_Automobiliai aa ON d.darbuotojo_id = aa.darbuotojo_id
GROUP BY d.darbuotojo_id, d.vardas, d.pavarde;


-- 37. Rasti automobilius, kuriuos klientai dažniausiai renkasi pagal klientų amžiaus grupes
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

-- 38. Rasti „populiariausią mėnesį“ automobilių rezervacijoms
SELECT MONTH(rezervacijos_pradzia) AS menuo, COUNT(*) AS rezervaciju_skaicius
FROM Rezervavimas
GROUP BY menuo
ORDER BY rezervaciju_skaicius DESC;

-- 39. Automobilių užimtumo analizė — kiek užsakymų buvo kiekvienam automobiliui
SELECT a.marke, a.modelis, COUNT(*) AS uzsakymu_skaicius
FROM Uzsakymai u
JOIN Automobiliai a ON u.automobilio_id = a.automobilio_id
GROUP BY a.automobilio_id, a.marke, a.modelis
ORDER BY uzsakymu_skaicius DESC;


-- 40. Vidutinė užsakymo suma pagal savaitės dieną
SELECT DAYNAME(u.nuomos_data) AS savaites_diena, ROUND(AVG(u.bendra_kaina), 2) AS vidutine_suma
FROM Uzsakymai u
GROUP BY savaites_diena
ORDER BY FIELD(savaites_diena, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- 41. Kuro sąnaudos pagal metų laikus
SELECT 
    CASE 
        WHEN MONTH(k.data) IN (12, 1, 2) THEN 'Žiema'
        WHEN MONTH(k.data) IN (3, 4, 5) THEN 'Pavasaris'
        WHEN MONTH(k.data) IN (6, 7, 8) THEN 'Vasara'
        ELSE 'Ruduo'
    END AS metu_laikas,
    SUM(k.kuro_kiekis) AS bendros_sanaudos
FROM Kuro_Sanaudos k
GROUP BY metu_laikas
ORDER BY bendros_sanaudos DESC;


-- 42. Populiariausia papildoma paslauga pagal mėnesius
SELECT 
    MONTHNAME(u.nuomos_data) AS menuo,
    pp.pavadinimas,
    COUNT(*) AS pasirinkimu_skaicius
FROM Uzsakymai u
JOIN Uzsakymo_Paslaugos up ON u.uzsakymo_id = up.uzsakymo_id
JOIN Papildomos_Paslaugos pp ON up.paslaugos_id = pp.paslaugos_id
GROUP BY menuo, pp.pavadinimas
ORDER BY menuo, pasirinkimu_skaicius DESC;


-- 43. Klientai, kurie ilgai nesinaudojo paslaugomis (pvz., daugiau nei 1 mėnesį nuo paskutinio užsakymo)
SELECT k.vardas, k.pavarde, MAX(u.nuomos_data) AS paskutinis_uzsakymas
FROM Klientai k
JOIN Uzsakymai u ON k.kliento_id = u.kliento_id
GROUP BY k.kliento_id, k.vardas, k.pavarde
HAVING MAX(u.nuomos_data) < DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
ORDER BY paskutinis_uzsakymas ASC;

-- 44. Nauji klientai per paskutinį mėnesį
SELECT COUNT(*) AS nauji_klientai
FROM Klientai
WHERE registracijos_data >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);


-- 45.Populiariausia automobilio spalva
SELECT a.spalva, COUNT(*) AS vienetų
FROM Uzsakymai u
JOIN Automobiliai a ON u.automobilio_id = a.automobilio_id
GROUP BY a.spalva
ORDER BY vienetų DESC;









