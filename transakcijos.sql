USE autorentdb;


DROP PROCEDURE IF EXISTS CreateUzsakymas;


CREATE PROCEDURE CreateUzsakymas(
    IN in_klientoID INT,
    IN in_automobilioID INT,
    IN in_darbuotojoID INT,
    IN in_nuomosData DATE,
    IN in_grazinimoData DATE,
    IN in_paemimoVietaID INT,
    IN in_grazinimoVietaID INT,
    IN in_papildomosPaslaugos TEXT  -- sąrašas paslaugų ID (pvz., "1,2,3")
)
BEGIN
    DECLARE v_dienosNuomos INT;
    DECLARE v_kainaParai DECIMAL(10,2);
    DECLARE v_bendraKaina DECIMAL(10,2);
    DECLARE v_autoUzimtas INT DEFAULT 0;
    DECLARE v_klientasUzimtas INT DEFAULT 0;
    DECLARE v_uzsakymoID INT;

    -- 1️⃣ Tikriname, ar automobilis jau rezervuotas arba išnuomotas pasirinktomis dienomis
    SELECT COUNT(*) INTO v_autoUzimtas
    FROM Uzsakymai
    WHERE automobilio_id = in_automobilioID
      AND uzsakymo_busena IN ('patvirtinta', 'isnuomota')
      AND (nuomos_data BETWEEN in_nuomosData AND in_grazinimoData
           OR grazinimo_data BETWEEN in_nuomosData AND in_grazinimoData);

    IF v_autoUzimtas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Automobilis jau rezervuotas arba išnuomotas tomis dienomis.';
    END IF;

    -- 2️⃣ Tikriname, ar klientas neturi kitos rezervacijos tomis dienomis
    SELECT COUNT(*) INTO v_klientasUzimtas
    FROM Uzsakymai
    WHERE kliento_id = in_klientoID
      AND uzsakymo_busena IN ('patvirtinta', 'isnuomota')
      AND (nuomos_data BETWEEN in_nuomosData AND in_grazinimoData
           OR grazinimo_data BETWEEN in_nuomosData AND in_grazinimoData);

    IF v_klientasUzimtas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Klientas jau turi kitą rezervuotą automobilį tomis dienomis.';
    END IF;

    -- 3️⃣ Apskaičiuojame nuomos trukmę ir bendrą kainą
    SELECT DATEDIFF(in_grazinimoData, in_nuomosData) INTO v_dienosNuomos;
    SELECT kaina_parai INTO v_kainaParai 
      FROM Automobiliai 
      WHERE automobilio_id = in_automobilioID;
    SET v_bendraKaina = v_kainaParai * v_dienosNuomos;

    START TRANSACTION;

    -- 4️⃣ Įrašome naują užsakymą (būsena "rezervuota")
    INSERT INTO Uzsakymai (
        kliento_id, automobilio_id, darbuotojo_id, nuomos_data,
        grazinimo_data, paemimo_vietos_id, grazinimo_vietos_id,
        bendra_kaina, uzsakymo_busena, turi_papildomas_paslaugas
    )
    VALUES (
        in_klientoID, in_automobilioID, in_darbuotojoID, in_nuomosData,
        in_grazinimoData, in_paemimoVietaID, in_grazinimoVietaID,
        v_bendraKaina, 'rezervuota', IF(LENGTH(in_papildomosPaslaugos) > 0, TRUE, FALSE)
    );

    -- Gauti paskutinio įterpto užsakymo ID
    SET v_uzsakymoID = LAST_INSERT_ID();

    -- 5️⃣ Jei yra papildomų paslaugų, įrašome jas į `Uzsakymo_Paslaugos`
    IF LENGTH(in_papildomosPaslaugos) > 0 THEN
        SET @sql = CONCAT(
            'INSERT INTO Uzsakymo_Paslaugos (uzsakymo_id, paslaugos_id) ',
            'SELECT ', v_uzsakymoID, ', paslaugos_id FROM Papildomos_Paslaugos ',
            'WHERE FIND_IN_SET(paslaugos_id, "', in_papildomosPaslaugos, '") > 0'
        );
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;

    COMMIT;

    SELECT 'Rezervacija sukurta sėkmingai. Automobilis rezervuotas.' AS rezultatas;
END

-- Tai pridės papildomas paslaugas, kurių ID yra 1, 3 ir 5
CALL CreateUzsakymas(3, 21, 2, '2025-03-14', '2025-03-20', 1, 2, '1,3,5');


-- Jei papildomų paslaugų nereikia, galima kviesti taip:
CALL CreateUzsakymas(3, 21, 2, '2025-03-14', '2025-03-20', 1, 2, '');



-------------------------------------------------------------------------------------------------------------------

USE autorentdb;
START TRANSACTION;
	INSERT INTO autorentdb.baudu_registras (
	    automobilio_id, baudos_priezastis, data, laikas, suma, kliento_id
	) VALUES 
	(25, 'Neleistinas parkavimas', '2025-03-15', '14:30:00', 50.00, 7);
	UPDATE autorentdb.klientai  
	SET bonus_taskai = GREATEST(0, bonus_taskai - 50)
	WHERE kliento_id = 7;
ROLLBACK;



START TRANSACTION;
UPDATE `Klientai` 
SET `bonus_taskai` = GREATEST(0, `bonus_taskai` - 50)
WHERE `id` = 6;
COMMIT;








