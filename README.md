npm init -y 

npm install express mysql2 bcrypt express-session

npm install nodemon --save-dev

หลังจากติดตั้งด้านบนเสร็จให้เปลี่ยน script เป็นอันนี้

"scripts": {
    "test": "node app.js",
    "dev": "nodemon app.js"
  },
