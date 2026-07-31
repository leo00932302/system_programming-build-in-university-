# system_programming-build-in-university-
大學上課時完成，用pascal,lazarus完成，日後可以用qt改寫
主要可以展示系統設計成果
這是一套**白沙網路書城管理系統**，主要包含登入權限、顧客管理、商品管理、訂單、採購、退貨、員工管理等模組，並完成需求分析、DFD、ERD、介面設計等系統分析文件。
---

# 白沙網路書城管理系統 (Bookstore Management System)

> 大學資訊管理系專題

## 專案介紹

白沙網路書城管理系統是一套提供書店內部營運管理的資訊系統，協助業務部與採購部完成日常管理工作，包含顧客管理、商品管理、訂單處理、庫存管理、採購管理及員工管理等功能。

本專案以**系統分析與設計 (System Analysis and Design)** 方法進行規劃，完成需求分析、流程塑模、資料塑模、ERD、DFD、介面設計與資料庫設計等完整開發流程。

---

# 系統特色

* 使用者登入與權限管理
* 顧客資料管理（CRUD）
* 商品資料管理
* 商品庫存盤點
* 商品資訊維護
* 訂單管理
* 匯款確認
* 商品退貨流程
* 採購管理
* 應付帳款管理
* 員工管理

---

# 系統流程

```
登入
 │
 ▼
權限驗證
 │
 ├── 顧客管理
 ├── 商品管理
 ├── 訂單管理
 ├── 採購管理
 ├── 員工管理
 └── 登出
```

---

# 系統架構

```
Customer
     │
     ▼
Web System
     │
 ┌── Customer Module
 ├── Product Module
 ├── Order Module
 ├── Purchase Module
 ├── Employee Module
 └── Payment Module
     │
     ▼
Database
```

---

# 主要功能

## 使用者登入

* 帳號密碼驗證
* 身分權限判斷
* 管理者權限控制

---

## 顧客管理

* 新增顧客
* 修改顧客
* 刪除顧客
* 查詢顧客

---

## 商品管理

* 商品新增
* 商品修改
* 商品刪除
* 商品查詢
* 庫存管理

---

## 訂單管理

* 建立訂單
* 出貨流程
* 更改配送方式
* 訂單狀態管理

---

## 採購管理

* 採購需求
* 出版商訂貨
* 商品入庫
* 商品上架

---

## 員工管理

* 員工新增
* 員工修改
* 員工刪除
* 權限管理

---

# 系統分析文件

本專案完成完整的系統分析與設計文件，包括：

* Requirements Analysis
* Business Process Analysis
* Activity Diagram
* Data Flow Diagram (DFD)
* Entity Relationship Diagram (ERD)
* Data Dictionary
* Database Normalization
* UI Prototype
* System Architecture Design



---

# 專案成果

✔ 完成企業需求分析

✔ 完成系統流程設計

✔ 完成 DFD

✔ 完成 ERD

✔ 完成資料庫正規化

✔ 完成 UI Prototype

✔ 完成資料字典

✔ 完成完整系統規格書

---

# 使用技術

如果有程式碼，可以依照實際情況修改：

```
Frontend
- HTML
- CSS
- JavaScript
- Bootstrap

Backend
- PHP

Database
- MySQL

Tools
- XAMPP
- phpMyAdmin
- Visual Studio Code
```

---

# 專案展示

```
登入畫面

顧客管理

商品管理

訂單管理

採購管理

員工管理
```

---

# 我的負責內容
* 系統需求分析
* DFD 與 ERD 設計
* MySQL 資料庫設計
* 後端部分程式開發
* 前端部分介面設計
* 測試與除錯
