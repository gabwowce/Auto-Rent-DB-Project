CREATE TRIGGER check_gimimo_data
BEFORE INSERT ON Klientai
FOR EACH ROW
BEGIN
  IF TIMESTAMPDIFF(YEAR, NEW.gimimo_data, CURDATE()) < 18 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Klientas turi būti bent 18 metų.';
  END IF;
END;


CREATE TRIGGER `check_grazinimo_data`
BEFORE INSERT ON `Uzsakymai`
FOR EACH ROW
BEGIN
  IF NEW.grazinimo_data < NEW.nuomos_data THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Grąžinimo data negali būti anksčiau nei nuomos data.';
  END IF;
END;


CREATE TRIGGER `check_ivertinimas`
BEFORE INSERT ON `Automobilio_Atsiliepimai`
FOR EACH ROW
BEGIN
  IF NEW.ivertinimas < 1 OR NEW.ivertinimas > 5 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Įvertinimas turi būti tarp 1 ir 5.';
  END IF;
END;


CREATE TRIGGER `check_serviso_pradzios_data`
BEFORE INSERT ON `Automobiliu_Servisas`
FOR EACH ROW
BEGIN
  IF NEW.serviso_pradzios_data > CURDATE() THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Serviso pradžios data negali būti ateityje.';
  END IF;
END;




-- patikriname triggeri check_gimimo_data
INSERT INTO `Klientai` (`vardas`, `pavarde`, `el_pastas`, `telefono_nr`, `gimimo_data`, `registracijos_data`, `bonus_taskai`)
VALUES 
('Antanas', 'Petrauskas', 'Antdsfdfadfnddffasdd1.petrauskas@example.com', '+37061224567', '2015-05-12', '2023-01-15 10:30:00', 150);



-- check_grazinimo_data - Tikriname, ar grąžinimo data nėra anksčiau nei nuomos data
INSERT INTO `Uzsakymai` (`kliento_id`, `automobilio_id`, `darbuotojo_id`, `nuomos_data`, `grazinimo_data`, `paemimo_vietos_id`, `grazinimo_vietos_id`, `bendra_kaina`, `uzsakymo_busena`, `turi_papildomas_paslaugas`)
VALUES 
(1, 23, 2, '2025-02-10', '2025-02-05', 1, 2, 150.00, 'patvirtinta', TRUE);



-- check_ivertinimas - Tikriname, ar įvertinimas yra tarp 1 ir 5
INSERT INTO `Automobilio_Atsiliepimai` (`kliento_id`, `automobilio_id`, `ivertinimas`, `komentaras`, `data`)
VALUES 
(1, 23, 6, 'Automobilis buvo neblogas, bet negaliu įvertinti kitaip.', NOW());



-- check_serviso_pradzios_data - Tikriname, ar serviso pradžios data nėra
INSERT INTO `Automobiliu_Servisas` (`automobilio_id`, `serviso_pradzios_data`, `serviso_pabaigos_data`, `plovimas`, `salono_valymas`, `technine_apziura`, `tepalai_pakeisti`, `kaina`, `busena`)
VALUES 
(1, '2030-05-01', NULL, TRUE, FALSE, TRUE, TRUE, 120.00, 'vyksta');





