domain : [pemicu2-pemicu2.d.aivencloud.com](pemicu2-pemicu2.d.aivencloud.com)  
port : 25264

- format umum eksekusi file sql  
    ```sh
    psql "postgres://[user]:[password]@[domain]:[port]/defaultdb?sslmode=require" -f [nama_file.sql]
    ```

- **admin_northwind**  
    user : `admin_northwind`  
    password : `adminnorthwind123`  
    ```sh
    psql "postgres://admin_northwind:adminnorthwind123@pemicu2-pemicu2.d.aivencloud.com:25264/defaultdb?sslmode=require" -f 
    ```

- **sales_northwind**  
    user : `sales_northwind`  
    password : `salesnorthwind123`  
    ```sh
    psql "postgres://sales_northwind:salesnorthwind123@pemicu2-pemicu2.d.aivencloud.com:25264/defaultdb?sslmode=require" -f 
    ```

- **hr_northwind**  
    user : `hr_northwind`  
    password : `hrnorthwind123`  
    ```sh
    psql "postgres://hr_northwind:hrnorthwind123@pemicu2-pemicu2.d.aivencloud.com:25264/defaultdb?sslmode=require" -f 
    ```