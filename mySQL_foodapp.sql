//tạo bảng food_type
CREATE TABLE foot_type (
    type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(250)
);
//tạo bảng food
CREATE TABLE food (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(250),
    image VARCHAR(250),
    price FLOAT,
    description VARCHAR(250),
    type_id INT,
    FOREIGN KEY (type_id) REFERENCES foot_type(type_id)
);

//tạo bảng sub_food
CREATE TABLE sub_food (
    sub_id INT PRIMARY KEY AUTO_INCREMENT,
    sub_name VARCHAR(250),
    sub_price FLOAT,
    food_id INT,
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

//tạo bảng user 
CREATE TABLE user (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(250),
    email VARCHAR(250),
    password VARCHAR(250)
);

//tạo bảng restaurant
CREATE TABLE restaurant (
    res_id INT PRIMARY KEY AUTO_INCREMENT,
    res_name VARCHAR(250),
    image VARCHAR(250),
    description VARCHAR(250)
);

//tạo bảng order
CREATE TABLE orders (
    user_id INT,
    food_id INT,
    amount INT,
    code VARCHAR(100),
    arr_sub_id VARCHAR(250),
    PRIMARY KEY (user_id, food_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

//tạo bảng rate_res
CREATE TABLE rate_res (
    user_id INT,
    food_id INT,
    amount INT,
    date_rate DATETIME,
    PRIMARY KEY (user_id, food_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

//tạo bảng like_res
CREATE TABLE rate_like (
    user_id INT,
    food_id INT,
    date_like DATETIME,
    PRIMARY KEY (user_id, food_id),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (food_id) REFERENCES food(food_id)
);

-- Thêm dữ liệu vào bảng foot_type
INSERT INTO foot_type (type_name) VALUES
('Appetizer'),
('Main Course'),
('Dessert'),
('Beverage'),
('Snack');

-- Thêm dữ liệu vào bảng food
INSERT INTO food (food_name, image, price, description, type_id) VALUES
('Caesar Salad', 'caesar_salad.jpg', 9.99, 'Fresh romaine lettuce, Caesar dressing, croutons, and Parmesan cheese', 1),
('Spaghetti Bolognese', 'spaghetti_bolognese.jpg', 12.99, 'Spaghetti pasta with traditional Italian Bolognese sauce', 2),
('Cheesecake', 'cheesecake.jpg', 5.99, 'Creamy cheesecake topped with strawberry sauce', 3),
('Iced Coffee', 'iced_coffee.jpg', 3.49, 'Chilled coffee beverage served with ice', 4),
('Popcorn', 'popcorn.jpg', 2.99, 'Classic buttered popcorn', 5);

-- Thêm dữ liệu vào bảng sub_food
INSERT INTO sub_food (sub_name, sub_price, food_id) VALUES
('Extra Dressing', 1.99, 1),
('Garlic Bread', 2.49, 2),
('Chocolate Brownie', 3.99, 3),
('Extra Shot of Espresso', 0.99, 4),
('Caramel Popcorn', 3.49, 5);

-- Thêm dữ liệu vào bảng user
INSERT INTO user (full_name, email, password) VALUES
('John Doe', 'john@example.com', 'password123'),
('Jane Smith', 'jane@example.com', 'securepass'),
('Alice Johnson', 'alice@example.com', 'strongpassword'),
('Bob Brown', 'bob@example.com', 'bobpass'),
('Emily Davis', 'emily@example.com', 'emilypass');

-- Thêm dữ liệu vào bảng restaurant
INSERT INTO restaurant (res_name, image, description) VALUES
('Italiano Ristorante', 'italiano_restaurant.jpg', 'Authentic Italian cuisine in a cozy atmosphere'),
('Burger Joint', 'burger_joint.jpg', 'Casual dining spot known for its juicy burgers and fries'),
('Sweet Delights Bakery', 'sweet_delights_bakery.jpg', 'Artisanal bakery offering a variety of sweet treats'),
('Café Latte', 'cafe_latte.jpg', 'Charming café serving coffee, pastries, and light meals'),
('Cinema Snacks', 'cinema_snacks.jpg', 'Concession stand with a range of movie snacks');

-- Thêm dữ liệu vào bảng orders
INSERT INTO orders (user_id, food_id, amount, code, arr_sub_id) VALUES
(1, 2, 1, 'ORDER123', '1,3'),
(2, 4, 2, 'ORDER456', '2,4,5'),
(3, 1, 1, 'ORDER789', '1'),
(4, 3, 1, 'ORDERABC', '2,3'),
(5, 5, 3, 'ORDERDEF', '1,5');

-- Thêm dữ liệu vào bảng rate_res
INSERT INTO rate_res (user_id, food_id, amount, date_rate) VALUES
(1, 2, 5, '2024-05-25 10:30:00'),
(2, 4, 4, '2024-05-25 12:45:00'),
(3, 1, 4, '2024-05-26 09:15:00'),
(4, 3, 5, '2024-05-26 14:20:00'),
(5, 5, 3, '2024-05-27 17:00:00');

-- Thêm dữ liệu vào bảng rate_like
INSERT INTO rate_like (user_id, food_id, date_like) VALUES
(1, 2, '2024-05-25 10:30:00'),
(2, 4, '2024-05-25 12:45:00'),
(3, 1, '2024-05-26 09:15:00'),
(4, 3, '2024-05-26 14:20:00'),
(5, 5, '2024-05-27 17:00:00');


//Tìm 5 người đã like nhà hàng nhiều nhất:
SELECT user_id, COUNT(*) AS total_likes
FROM rate_like
GROUP BY user_id
ORDER BY total_likes DESC
LIMIT 5;


//Tìm 2 nhà hàng có lượt like nhiều nhất:
SELECT food_id, COUNT(*) AS total_likes
FROM rate_like
GROUP BY food_id
ORDER BY total_likes DESC
LIMIT 2;

//Tìm người đã đặt hàng nhiều nhất:
SELECT user_id, COUNT(*) AS total_orders
FROM orders
GROUP BY user_id
ORDER BY total_orders DESC
LIMIT 1;

//Tìm người dùng không hoạt động trong hệ thống:
SELECT u.user_id, u.full_name
FROM user u
LEFT JOIN orders o ON u.user_id = o.user_id
LEFT JOIN rate_like rl ON u.user_id = rl.user_id
LEFT JOIN rate_res rr ON u.user_id = rr.user_id
WHERE o.user_id IS NULL AND rl.user_id IS NULL AND rr.user_id IS NULL;
