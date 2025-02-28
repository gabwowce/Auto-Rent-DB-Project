USE autorentdb;


DROP PROCEDURE IF EXISTS CreateUzsakymas;


CREATE PROCEDURE CreateUzsakymas(
    IN in_klientoID INT,
    IN in_automobilioID INT,
    IN in_darbuotojoID INT,
    IN in_nuomosData DATE,
    IN in_grazinimoData DATE,
    IN in_paemimoVietaID INT,
    IN in_grazinimoVietaID INT
)
BEGIN
    DECLARE v_dienosNuomos INT;
    DECLARE v_kainaParai DECIMAL(10,2);
    DECLARE v_bendraKaina DECIMAL(10,2);

    -- Apskaičiuojame nuomos trukmę ir bendrą kainą
    SELECT DATEDIFF(in_grazinimoData, in_nuomosData) INTO v_dienosNuomos;
    SELECT kaina_parai INTO v_kainaParai 
      FROM Automobiliai 
      WHERE automobilio_id = in_automobilioID;
    SET v_bendraKaina = v_kainaParai * v_dienosNuomos;

    START TRANSACTION;

    -- Įrašome naują užsakymą
    INSERT INTO Uzsakymai (
        kliento_id, automobilio_id, darbuotojo_id, nuomos_data,
        grazinimo_data, paemimo_vietos_id, grazinimo_vietos_id,
        bendra_kaina, uzsakymo_busena, turi_papildomas_paslaugas
    )
    VALUES (
        in_klientoID, in_automobilioID, in_darbuotojoID, in_nuomosData,
        in_grazinimoData, in_paemimoVietaID, in_grazinimoVietaID,
        v_bendraKaina, 'patvirtinta', FALSE
    );

    -- Įrašome rezervaciją
    INSERT INTO Rezervavimas (
        kliento_id, automobilio_id, rezervacijos_pradzia, rezervacijos_pabaiga, busena
    )
    VALUES (
        in_klientoID, in_automobilioID, in_nuomosData, in_grazinimoData, 'patvirtinta'
    );

    -- Atnaujiname automobilio statusą
    UPDATE Automobiliai
    SET automobilio_statusas = 'isnuomotas'
    WHERE automobilio_id = in_automobilioID;

    COMMIT;

    SELECT 'Transakcija sėkminga' AS rezultatas;
END


CALL CreateUzsakymas(3, 21, 2, '2025-03-14', '2025-03-20', 1, 2);
