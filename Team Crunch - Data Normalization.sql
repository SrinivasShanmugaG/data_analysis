-- ################################ ------------------------ ############################## -- 
-- Create and Insert 

DROP DATABASE IF EXISTS `recipes`;
CREATE DATABASE  IF NOT EXISTS `recipes`;
USE `recipes`;


--
-- Table structure for table `recipe_main`
--

DROP TABLE IF EXISTS `recipe_main`;
CREATE TABLE `recipe_main` (
  `recipe_id` int(11) NOT NULL AUTO_INCREMENT,
  `rec_title` varchar(255) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `recipe_desc` varchar(1024) DEFAULT NULL,
  `prep_time` int(11) DEFAULT NULL,
  `cook_time` int(11) DEFAULT NULL,
  `servings` int(11) DEFAULT NULL,
  `difficulty` int(11) DEFAULT NULL,
  `directions` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`recipe_id`),
  KEY `recipe_title_idx` (`rec_title`),
  KEY `prep_time_idx` (`prep_time`),
  KEY `cook_time_idx` (`cook_time`),
  KEY `difficulty_idx` (`difficulty`),
  KEY `FK_category_id_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipe_main`
--

LOCK TABLES `recipe_main` WRITE;
INSERT INTO `recipe_main` VALUES (1,'Miso Soup',1,'Dashi, Miso and Tofu',5,10,4,1,'Combine water and dashi granules in a medium saucepan over medium-high heat; bring to a boil. Reduce heat to medium and whisk in miso paste. Stir in tofu. Separate the layers of green onions, and add them to the soup. Simmer gently for 2 to 3 minutes before serving.'),
(2,'Greek Salad',2,'Healthy and Nutritious Salad',10,15,6,2,'Whisk the olive oil, lemon juice, garlic, vinegar, oregano, and dill together until blended. Season to taste with salt and freshly ground black pepper.Combine the tomatoes, cucumber, onion, bell pepper, olives in a bowl. Toss with dressing. Sprinkle with cheese and serve.'),
(3,'Chicken Marsala',3,'Chicken and mushrooms',20,20,6,2,'Flatten chicken breats to 1/4 inch. Place flour in a resealable plastic bag with two pieces of chicken at a time and shake to coat.Cook chicken in olive oil in a large skillet over medium heat for 3-5 minutes on each side or until the meat reaches a temparature of 170°. Remove chicken from skillet and keep warm.Use the same skillet to saute the mushrooms in butter until tender. Add the wine, parsley and rosemary. Bring mixture to a boil and cook until liquid is reduced by half. Serve chicken with mushroom sauce; sprinkle with cheese if desired.'),
(4,'Absolute Brownies',4,'Rich, chcolate brownies',25,35,16,2,'Preheat oven to 350 degrees F (175 degrees C). Grease and flour an 8 inch square pan.In a large saucepan, melt 1/2 cup butter. Remove from heat, and stir in sugar, eggs, and 1 teaspoon vanilla. Beat in 1/3 cup cocoa, 1/2 cup flour, salt, and baking powder. Spread batter into prepared pan.Bake in preheated oven for 25 to 30 minutes. Do not overcook.To Make Frosting: Combine 3 tablespoons butter, 3 tablespoons cocoa, 1 tablespoon honey, 1 teaspoon vanilla, and 1 cup confectioners sugar. Frost brownies while they are still warm.');
UNLOCK TABLES;

--
-- Table structure for table `rec_ingredients`
--

DROP TABLE IF EXISTS `rec_ingredients`;
CREATE TABLE `rec_ingredients` (
  `rec_ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `ingredient_id` int(11) NOT NULL,
  PRIMARY KEY (`rec_ingredient_id`),
  KEY `FK_ingredient_recipe_id_idx` (`recipe_id`),
  KEY `FK_recipe_ingredient_id_idx` (`ingredient_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


LOCK TABLES `rec_ingredients` WRITE;
INSERT INTO `rec_ingredients` VALUES (1,1,4.00,35),(2,1,2.00,31),(3,1,3.00,32),(4,1,2.00,33),(5,1,2.00,34),(6,1,0.25,15),
									 (7,2,0.75,3),(8,2,2.00,20),(9,2,0.50,21),(10,2,1.00,22),(11,2,0.50,23),(12,2,0.50,24),(13,2,0.25,15),(14,2,0.50,25),(15,2,3,36),(16,2,0.75,26),(17,2,0.50,27),(18,2,1.00,28),(19,2,0.50,29),(20,2,0.50,30),
                                     (21,3,4.00,1),(22,3,2.00,2),(23,3,2.00,3),(24,3,2.00,4),(25,3,2.00,5),(26,3,0.75,6),(27,3,0.25,8),(28,3,2.00,9),(29,3,2.00,10),
                                     (30,4,0.50,3),(31,4,1.00,11),(32,4,2.00,12),(33,4,1.00,13),(34,4,0.33,14),(35,4,0.50,2),(36,4,0.25,15);
UNLOCK TABLES;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
CREATE TABLE `ingredients` (
  `ingredient_id` int(11) NOT NULL AUTO_INCREMENT,
  `ingred_name` varchar(75) NOT NULL,
  PRIMARY KEY (`ingredient_id`),
  KEY `ingredient_name_idx` (`ingred_name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ingredients`
--

LOCK TABLES `ingredients` WRITE;
INSERT INTO `ingredients` VALUES (1,'Chicken breast halves, boneless'),
(2,'Flour'),(3,'Olive oil'),
(4,'Sliced mushrooms'),(5,'Butter'),
(6,'Marsala wine'),(7,'Chicken broth'),
(8,'Rosemary, dried and crushed'),(9,'Parsley, minced'),
(10,'Parmesan cheese, grated'),(11,'White sugar'),
(12,'Egg(s)'),(13,'Vanilla extract'),
(14,'Unsweetened cocoa powder'),(15,'Salt'),
(16,'Baking powder'),(17,'Butter, softened'),
(18,'Honey'),(19,'Sugar, confectioners'),
(20,'Lime juice'),(21,'Garlic, chopped'),
(22,'Red Wine vinegar'),(23,'Oregano, dried'),
(24,'Dill, dried'),(25,'Black pepper, grounded'),
(26,'Cucumber'),(27,'Red Onion'),
(28,'Bell pepper'),(29,'Black olives'),
(30,'Feta cheese'),(31,'Dashi granules'),
(32,'Miso paste'),(33,'Tofu, silken'),(34,'Green onions'),
(35,'Water'),(36,'Roma tomatoes');
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `category_name_idx` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
INSERT INTO `categories` VALUES (1,'Soup'),(2,'Appetizer'),(3,'Entree'),(4,'Desserts');
UNLOCK TABLES;
-- ################################ ------------------------ ############################## -- 
-- To verify
SELECT * FROM recipes.recipe_main;
SELECT * FROM recipes.rec_ingredients;
SELECT * FROM recipes.ingredients;
SELECT * FROM recipes.categories;
UPDATE recipes.recipe_main SET prep_time = 15, cook_time = 0 WHERE recipe_id = 2;
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE table_schema = 'recipes';

-- ################################ ------------------------ ############################## -- 
-- Question 2: 
SELECT * FROM recipe_main as rec_types 
INNER JOIN rec_ingredients as rec_ingred ON rec_types.recipe_id =  rec_ingred.recipe_id
INNER JOIN ingredients as ingred ON rec_ingred.ingredient_id =  ingred.ingredient_id
INNER JOIN categories as categ ON rec_types.category_id =  categ.category_id WHERE rec_types.rec_title IN ('Miso Soup','Greek Salad') ORDER BY rec_types.recipe_id;

-- ################################ ------------------------ ############################## -- 
-- Question 3: 
	
SELECT rec_types.rec_title as 'Recipe Name', categ.category_name as 'Category Name', ingred.ingred_name as 'Ingredients Name', rec_ingred.amount as 'Ingredients Amount'
FROM recipe_main as rec_types
INNER JOIN rec_ingredients as rec_ingred ON rec_types.recipe_id = rec_ingred.recipe_id
INNER JOIN ingredients as ingred ON rec_ingred.ingredient_id =  ingred.ingredient_id
INNER JOIN categories as categ ON rec_types.category_id =  categ.category_id ORDER BY  categ.category_name DESC,  rec_types.rec_title ASC, ingred.ingred_name DESC ;

-- ################################ ------------------------ ############################## -- 