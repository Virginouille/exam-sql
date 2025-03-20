Créer la base de données « bibliotheque » en UTF8
CREATE DATABASE bibliotheque DEFAULT CHARSET=UTF8MB4 COLLATE utf8mb4_unicode_ci;

Créer les 3 tables en respectant les contraintes de relation et de référence. Les # ne doivent pas paraître dans le nom des champs.
CREATE TABLE adherents (
id INT PRIMARY KEY AUTO_INCREMENT,
nom VARCHAR(90) NOT NULL,
adresse VARCHAR(120) NOT NULL,
date_inscription DATE NOT NULL,
a_surveiller BOOL NOT NULL);

CREATE TABLE livres (
id INT PRIMARY KEY AUTO_INCREMENT,
isbn INT NOT NULL,
auteur VARCHAR(120) NOT NULL,
annee_publication DATE NOT NULL,
disponible BOOL NOT NULL);

CREATE TABLE emprunts (
id_adherent INT,
id_isbn INT,
date_emprunt DATE NOT NULL,
date_retour DATE NOT NULL,
PRIMARY KEY (id_adherent, id_isbn),
FOREIGN KEY (id_adherent) REFERENCES adherents(id),
FOREIGN KEY (id_isbn) REFERENCES livres(id) );

Créer un utilisateur « bibliothecaire » avec le mot de passe « secret » ayant accès uniquement à cette base de données bibliotheque avec tous les droits.
CREATE USER 'bibliothecaire'@'localhoost'
IDENTIFIED BY 'secret'

GRANT ALL PRIVILEGES ON bibliotheque
TO 'bibliothecaire'@'localhoost'

FLUSH PRIVILEGES;

Ajouter les adhérents : Jane Austen, Charles Dickens, Jules Verne, Mary Shelley. 
INSERT INTO adherents (id, nom, adresse, date_inscription, a_surveiller)
VALUES (2, 'Charles Dickens', '3 rue du Bourg', '2019-09-23', FALSE),
(3, 'Jules Verne', '80 rue du Monde', '2009-09-06', FALSE),
(4, 'Mary Shelley', '76 rue de la paix', '2019-08-07', TRUE);

Ajouter les livres : "Orgueil et Préjugés", "David Copperfield", "Vingt mille lieues sous les mers", "Frankenstein".
INSERT INTO livres (id, isbn, nom, auteur, annee_publication, disponible) VALUES 
(1, '978-2-07-033866-5', 'Orgueil et Préjugés', 'Jane Austen', '1813-01-28', 1),
(2, '978-0-14-043944-1', 'David Copperfield', 'Charles Dickens', '1850-05-01', 1),
(3, '978-2-07-011379-3', 'Vingt mille lieues sous les mers', 'Jules Verne', '1870-06-20', 1),
(4, '978-0-14-143947-1', 'Frankenstein', 'Mary Shelley', '1818-01-01', 1);

Ajouter des emprunts pour que chaque adhérent emprunte chaque chaque livre.
INSERT INTO emprunts (id_adherent, id_isbn, date_emprunt, date_retour)
VALUES (1, '978-2-07-033866-5', '2025-03-20', '2025-04-15'),
(2, '978-0-14-043944-1','2025-04-05', '2025-05-15'),
(3, '978-2-07-011379-3', '2025-04-05', '2025-04-15'),
(4, '978-0-14-143947-1', '2025-04-12', '2025-04-23');


Charles Dickens déménage, mettez à jour son adresse dans la base de données. 
UPDATE adherents
SET adresse='15 impasse des champs'
WHERE id=2;

Un livre est empruntable 30 jours, faites une vue qui affiche les personnes qui ont des livres en retard et les livres en question

Créer un trigger qui passe le booléen « disponible » à true si la date de retour d’un livre est précisée

Créer une procédure stockée qui passe le booléen « a_surveiller » à true si une personne a un retard de plus de 30 jours

Mary Shelley arrête son adhésion à la bibliothèque, supprimez son enregistrement de la base de données.
DELETE FROM adherents
WHERE id=4;

Sur quel(s) champ(s) pourrait-on mettre un index pour optimiser les requêtes et pourquoi ?
/*Sur le champ a_surveiller de la table adhérents et sur le champ disponibilite dans la table livres*/

La bibliothèque doit se conformer à la RGPD. Quelle requête SQL utiliseriez-vous pour anonymiser la base de données? pour supprimer toute la base de données ?
