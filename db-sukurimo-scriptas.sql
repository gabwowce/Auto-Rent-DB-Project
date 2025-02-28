CREATE TABLE `Klientai` (
 `kliento_id` INTEGER PRIMARY KEY AUTO_INCREMENT,
  `vardas` VARCHAR(255) NOT NULL,
  `pavarde` VARCHAR(255) NOT NULL,
  `el_pastas` VARCHAR(255) NOT NULL UNIQUE CHECK (`el_pastas` LIKE '%_@_%._%'),
  `telefono_nr` VARCHAR(255) NOT NULL,
  `gimimo_data` DATE NOT NULL,
  `registracijos_data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `bonus_taskai` INTEGER DEFAULT 0 CHECK (`bonus_taskai` >= 0)
);



CREATE TABLE `Uzsakymai` (
  `uzsakymo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `kliento_id` INTEGER NOT NULL,
  `automobilio_id` INTEGER NOT NULL,
  `darbuotojo_id` INTEGER NOT NULL,
  `nuomos_data` DATE NOT NULL,
  `grazinimo_data` DATE NOT NULL,
  `paemimo_vietos_id` INTEGER NOT NULL,
  `grazinimo_vietos_id` INTEGER NOT NULL,
  `bendra_kaina` DECIMAL(10,2) NOT NULL,
  `uzsakymo_busena` ENUM('laukiama', 'patvirtinta', 'vykdoma', 'užbaigta', 'atšaukta') NOT NULL,
  `turi_papildomas_paslaugas` BOOLEAN NOT NULL DEFAULT FALSE
);



CREATE TABLE `Klientu_Palaikymas` (
  `uzklausos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `kliento_id` INTEGER NOT NULL,
  `darbuotojo_id` INTEGER, 
  `tema` VARCHAR(255) NOT NULL,
  `pranesimas` TEXT NOT NULL,
  `atsakymas` TEXT,
  `pateikimo_data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `atsakymo_data` TIMESTAMP
);


CREATE TABLE `Automobilio_Atsiliepimai` (
  `atsiliepimo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `kliento_id` INTEGER NOT NULL,
  `automobilio_id` INTEGER NOT NULL,
  `ivertinimas` INTEGER NOT NULL CHECK (`ivertinimas` BETWEEN 1 AND 5),
  `komentaras` TEXT,
  `data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);



CREATE TABLE `Saskaitos` (
  `saskaitos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `uzsakymo_id` INTEGER NOT NULL,
  `suma` DECIMAL(10,2) NOT NULL,
  `saskaitos_data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE `Mokejimai` (
  `mokejimo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `uzsakymo_id` INTEGER NOT NULL,
  `suma` DECIMAL(10,2) NOT NULL,
  `mokejimo_data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  `mokejimo_tipas`  ENUM('grynieji', 'kortele', 'bankinis pavedimas', 'paypal') NOT NULL
);

CREATE TABLE `Automobiliai` (
  `automobilio_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `marke` VARCHAR(255) NOT NULL,
  `modelis` VARCHAR(255) NOT NULL,
  `metai` INTEGER NOT NULL,
  `numeris` VARCHAR(255) NOT NULL UNIQUE,
  `vin_kodas` VARCHAR(17) UNIQUE NOT NULL,
  `spalva` VARCHAR(255) NOT NULL,
  `kebulo_tipas` VARCHAR(255) NOT NULL,
  `pavarų_deze` ENUM('mechaninė', 'automatinė', 'pusiau automatinė') NOT NULL,
  `variklio_turis` DECIMAL(3,1) NOT NULL,
  `galia_kw` INTEGER NOT NULL,
  `kuro_tipas` ENUM('benzinas', 'dyzelinas', 'elektra', 'hibridas', 'dujos') NOT NULL,
  `rida` INTEGER NOT NULL,
  `sedimos_vietos` INTEGER NOT NULL,
  `klimato_kontrole` BOOLEAN NOT NULL DEFAULT FALSE,
  `navigacija` BOOLEAN NOT NULL DEFAULT FALSE,
  `kaina_parai` DECIMAL(10,2) NOT NULL,
  `automobilio_statusas` ENUM('laisvas', 'isnuomotas', 'servise', 'remonte') NOT NULL,
  `technikines_galiojimas` DATE NOT NULL,
  `dabartine_vieta_id` INTEGER NOT NULL,
  `pastabos` TEXT
);

CREATE TABLE `Automobiliu_Servisas` (
  `serviso_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `serviso_pradzios_data` DATE NOT NULL,
  `serviso_pabaigos_data` DATE,
  `plovimas` BOOLEAN NOT NULL DEFAULT FALSE,
  `salono_valymas` BOOLEAN NOT NULL DEFAULT FALSE,
  `technine_apziura` BOOLEAN NOT NULL DEFAULT FALSE,
  `tepalai_pakeisti` BOOLEAN NOT NULL DEFAULT FALSE,
  `kaina` DECIMAL(10,2) NOT NULL,
  `busena` ENUM('laukia', 'vyksta', 'baigtas') NOT NULL
);




CREATE TABLE `Kuro_Sanaudos` (
  `sanaudu_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `data` DATE NOT NULL,
  `kuro_kiekis` DECIMAL(10,2) NOT NULL,
  `kaina` DECIMAL(10,2) NOT NULL
);

CREATE TABLE `Remonto_Darbai` (
  `remonto_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `remonto_pradzios_data` DATE NOT NULL,
  `remonto_pabaigos_data` DATE,
  `aprasymas` TEXT NOT NULL,
  `detales_pakeistos` TEXT,
  `garantija_menesiais` INTEGER,
  `meistras` VARCHAR(255) NOT NULL,
  `serviso_pavadinimas` VARCHAR(255) NOT NULL,
  `kaina` DECIMAL(10,2) NOT NULL,
  `busena` ENUM('laukia', 'vyksta', 'baigtas') NOT NULL
);

CREATE TABLE `Draudimai` (
  `draudimo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `draudimo_tipas`  ENUM('civilinis', 'kasko', 'kita') NOT NULL,
  `galiojimo_pradzia` DATE NOT NULL,
  `galiojimo_pabaiga` DATE NOT NULL,
  `suma` DECIMAL(10,2) NOT NULL
);

CREATE TABLE `Baudu_Registras` (
  `baudos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `baudos_priezastis` VARCHAR(255) NOT NULL,
  `data` DATE NOT NULL,
  `suma` DECIMAL(10,2) NOT null,
  `kliento_id` INTEGER NOT NULL
);

CREATE TABLE `Darbuotojai` (
 `darbuotojo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `vardas` VARCHAR(255) NOT NULL,
  `pavarde` VARCHAR(255) NOT NULL,
  `el_pastas` VARCHAR(255) NOT NULL UNIQUE CHECK (el_pastas LIKE '%_@_%._%'),
  `telefono_nr` VARCHAR(255) NOT NULL ,
  `pareigos` VARCHAR(255) NOT NULL,
  `atlyginimas` DECIMAL(10,2) NOT NULL,
  `isidarbinimo_data` DATE NOT NULL
);

CREATE TABLE `Atsakingi_Automobiliai` (
   `atsakomybes_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `darbuotojo_id` INTEGER NOT NULL,
  `automobilio_id` INTEGER NOT NULL,
  `pradzios_data` DATE NOT NULL,
  `pabaigos_data` DATE
);

CREATE TABLE `Papildomos_Paslaugos` (
  `paslaugos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `pavadinimas` VARCHAR(255) NOT NULL,
  `aprasymas` TEXT NOT NULL,
  `kaina` DECIMAL(10,2) NOT NULL
);

CREATE TABLE `Uzsakymo_Paslaugos` (
 `uzsakymo_paslaugos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `uzsakymo_id` INTEGER NOT NULL,
  `paslaugos_id` INTEGER NOT NULL
);

CREATE TABLE `Rezervavimas` (
  `rezervacijos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `kliento_id` INTEGER NOT NULL,
  `automobilio_id` INTEGER NOT NULL,
  `rezervacijos_pradzia` DATE NOT NULL,
  `rezervacijos_pabaiga` DATE NOT NULL,
  `busena` ENUM('patvirtinta', 'atšaukta', 'laukia') NOT NULL
);

CREATE TABLE `Nuolaidos` (
 `nuolaidos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `pavadinimas` VARCHAR(255) NOT NULL,
  `procentas` DECIMAL(5,2) NOT NULL CHECK (`procentas` > 0 AND `procentas` <= 100),
  `galiojimo_pradzia` DATE NOT null, 
  `galiojimo_pabaiga` DATE NOT NULL 
);

CREATE TABLE `Uzsakymo_Nuolaidos` (
  `uzsakymo_nuolaidos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `uzsakymo_id` INTEGER NOT NULL,
  `nuolaidos_id` INTEGER NOT NULL
);

CREATE TABLE `Pristatymo_Vietos` (
   `vietos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `pavadinimas` VARCHAR(255) NOT NULL,
  `adresas` VARCHAR(255) NOT NULL ,
  `miestas` VARCHAR(255) NOT NULL 
);

CREATE TABLE `Kuro_Korteles` (
  `korteles_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `korteles_numeris` VARCHAR(255) UNIQUE NOT NULL,
  `galiojimo_pabaiga` DATE NOT NULL
);

CREATE TABLE `Bonusu_Naudojimas` (
  `naudojimo_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `kliento_id` INTEGER NOT NULL,
  `uzsakymo_id` INTEGER NOT NULL,
  `panaudoti_taskai` INTEGER NOT NULL,
  `nuolaidos_id` INTEGER NOT NULL,
  `data` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE `Automobilio_Grazinimo_Vietos` (
  `grazinimo_vietos_id` INTEGER PRIMARY key AUTO_INCREMENT,
  `automobilio_id` INTEGER NOT NULL,
  `vietos_id` INTEGER NOT NULL
);

ALTER TABLE `Uzsakymai` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);

ALTER TABLE `Klientu_Palaikymas` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);

ALTER TABLE `Automobilio_Atsiliepimai` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);

ALTER TABLE `Saskaitos` ADD FOREIGN KEY (`uzsakymo_id`) REFERENCES `Uzsakymai` (`uzsakymo_id`);

ALTER TABLE `Mokejimai` ADD FOREIGN KEY (`uzsakymo_id`) REFERENCES `Uzsakymai` (`uzsakymo_id`);

ALTER TABLE `Uzsakymai` ADD FOREIGN KEY (`paemimo_vietos_id`) REFERENCES `Pristatymo_Vietos` (`vietos_id`);

ALTER TABLE `Uzsakymai` ADD FOREIGN KEY (`grazinimo_vietos_id`) REFERENCES `Pristatymo_Vietos` (`vietos_id`);

ALTER TABLE `Automobilio_Atsiliepimai` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Uzsakymai` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Automobiliu_Servisas` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Kuro_Sanaudos` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Remonto_Darbai` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Draudimai` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Baudu_Registras` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Kuro_Korteles` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Atsakingi_Automobiliai` ADD FOREIGN KEY (`darbuotojo_id`) REFERENCES `Darbuotojai` (`darbuotojo_id`);

ALTER TABLE `Atsakingi_Automobiliai` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Uzsakymo_Paslaugos` ADD FOREIGN KEY (`uzsakymo_id`) REFERENCES `Uzsakymai` (`uzsakymo_id`);

ALTER TABLE `Uzsakymo_Paslaugos` ADD FOREIGN KEY (`paslaugos_id`) REFERENCES `Papildomos_Paslaugos` (`paslaugos_id`);

ALTER TABLE `Rezervavimas` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);

ALTER TABLE `Rezervavimas` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Uzsakymo_Nuolaidos` ADD FOREIGN KEY (`uzsakymo_id`) REFERENCES `Uzsakymai` (`uzsakymo_id`);

ALTER TABLE `Uzsakymo_Nuolaidos` ADD FOREIGN KEY (`nuolaidos_id`) REFERENCES `Nuolaidos` (`nuolaidos_id`);

ALTER TABLE `Bonusu_Naudojimas` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);

ALTER TABLE `Bonusu_Naudojimas` ADD FOREIGN KEY (`uzsakymo_id`) REFERENCES `Uzsakymai` (`uzsakymo_id`);

ALTER TABLE `Bonusu_Naudojimas` ADD FOREIGN KEY (`nuolaidos_id`) REFERENCES `Nuolaidos` (`nuolaidos_id`);

ALTER TABLE `Automobiliai` ADD FOREIGN KEY (`dabartine_vieta_id`) REFERENCES `Pristatymo_Vietos` (`vietos_id`);

ALTER TABLE `Automobilio_Grazinimo_Vietos` ADD FOREIGN KEY (`automobilio_id`) REFERENCES `Automobiliai` (`automobilio_id`);

ALTER TABLE `Automobilio_Grazinimo_Vietos` ADD FOREIGN KEY (`vietos_id`) REFERENCES `Pristatymo_Vietos` (`vietos_id`);

ALTER TABLE `Baudu_Registras` ADD FOREIGN KEY (`kliento_id`) REFERENCES `Klientai` (`kliento_id`);







