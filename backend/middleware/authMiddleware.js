const jwt = require('jsonwebtoken');
const fs = require('fs');
const path = require('path');

// ฟังก์ชันสำหรับสร้างโทเคน
const JWT_SECRET = 'my_secret_key';

// โหลดข้อมูล roles จากไฟล์ JSON (หรือกำหนดไว้ในโค้ด)
const roles = {
    1: 'user',
    2: 'admin',
    3: 'approver'
};

// ฟังก์ชันสำหรับสร้างโทเคน
function generateToken(userId, userRole) {
    // ตรวจสอบว่า role ที่ได้รับเป็น role ที่มีใน roles หรือไม่
    if (!roles[userRole]) {
        throw new Error('Invalid role ID');
    }

    // สร้าง payload สำหรับโทเคน
    const payload = {
        id: userId,
        role: userRole
    };

    // เซ็นโทเคนด้วย JWT_SECRET
    const token = jwt.sign(payload, JWT_SECRET, { expiresIn: '1h' });
    return token;
}

// ฟังก์ชันสำหรับตรวจสอบว่า token ถูกต้องหรือไม่
function verifyToken(req, res, next) {
    const token = req.headers["authorization"];
    if (!token) {
        return res.status(403).send("Token is required");
    }

    jwt.verify(token, JWT_SECRET, (err, decoded) => {
        if (err) {
            return res.status(401).send("Unauthorized");
        }
        req.userId = decoded.id;  // เก็บข้อมูลผู้ใช้
        req.userRole = decoded.role;  // เก็บ role ของผู้ใช้
        next(); // ไปยัง middleware ถัดไป
    });
}

// ฟังก์ชันสำหรับตรวจสอบ role ของผู้ใช้
function hasRole(role) {
    return (req, res, next) => {
        if (req.userRole !== role) {
            return res.status(403).send("Forbidden: You don't have the right role");
        }
        next(); // ถ้า role ตรงไปยัง middleware ถัดไป
    };
}

// ตัวอย่างการใช้งาน
try {
    const tokenUser = generateToken(1, 1); // user
    const tokenAdmin = generateToken(2, 2); // admin
    const tokenApprover = generateToken(3, 3); // approver

    console.log('User Token:', tokenUser);
    console.log('admin Token:', tokenAdmin);
    console.log('Approver Token:', tokenApprover);
} catch (error) {
    console.error(error.message);
}

module.exports = { verifyToken, hasRole, generateToken };  // Export ฟังก์ชันที่ใช้
