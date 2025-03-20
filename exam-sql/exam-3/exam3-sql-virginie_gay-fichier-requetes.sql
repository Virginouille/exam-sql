Lister tous les plats avec un prix inférieur à 20 €.
SELECT `name`, price
FROM dishes
WHERE price < 20;

Lister tous les plats des restaurants de cuisine Française et de cuisine Italienne en utilisant IN.
SELECT d.chef_id, restaurants.`name`, cuisine_type, d.`name`
FROM dishes d
JOIN chefs ON d.chef_id=chefs.id
JOIN restaurants ON chefs.id=restaurants.id
WHERE cuisine_type IN('Française', 'Italienne');

Lister tous les ingrédients du Bœuf Bourguignon. 
SELECT ingredients.`name`
FROM dishes
JOIN ingredients ON dishes.id=ingredients.dish_id
WHERE dish_id=1;
Lister tous les chefs (leur nom uniquement) et leurs restaurants (leur nom uniquement).
SELECT chefs.`name`, restaurants.`name`
FROM chefs
JOIN restaurants ON chefs.restaurant_id=restaurants.id;
Lister les chefs et le nombre de plats qu'ils ont créés.
SELECT chefs.`name`, COUNT(chef_id) AS nombre_plats
FROM chefs
JOIN dishes ON chefs.id=dishes.chef_id
GROUP BY chefs.`name`;
Lister les chefs qui ont créé plus d'un plat.
SELECT chefs.`name`, COUNT(chef_id) AS plus_d_un_plat
FROM chefs
JOIN dishes ON chefs.id=dishes.chef_id
GROUP BY chefs.`name`
HAVING plus_d_un_plat > 1
ORDER BY plus_d_un_plat;
Calculez le nombre de chefs ayant créé un seul plat.
SELECT chefs.`name`, COUNT(chef_id) AS un_seul_plat
FROM chefs
JOIN dishes ON chefs.id=dishes.chef_id
GROUP BY chefs.`name`
HAVING un_seul_plat = 1
ORDER BY un_seul_plat;
Calculez le nombre de plats pour chaque type de cuisine.
SELECT r.cuisine_type, COUNT(r.cuisine_type) AS nombre_plat_type_cuisine
FROM restaurants r
JOIN chefs c ON r.id=c.restaurant_id
JOIN dishes d ON c.id=d.chef_id
GROUP BY r.cuisine_type;
Calculez le prix moyen des plats par type de cuisine.
SELECT r.cuisine_type, AVG(d.price) AS prix_moyen_par_type
FROM restaurants r
JOIN chefs c ON r.id=c.restaurant_id
JOIN dishes d ON c.id=d.chef_id
GROUP BY r.cuisine_type;
Trouver le prix moyen des plats créés par chaque chef, en incluant seulement les chefs ayant créé plus de 2 plats
/*pas terminee*/
SELECT c.`name`, d.`name`, AVG(d.price) AS prix_moyen_par_type
FROM restaurants r
JOIN (SELECT COUNT(chef_id)
FROM dishes
GROUP BY chef_id
HAVING chef_id >=2) AS chef_plus_de_deux_plats
JOIN chefs c ON r.id=c.restaurant_id
JOIN dishes d ON c.id=d.chef_id
GROUP BY c.`name`, d.`name`;
