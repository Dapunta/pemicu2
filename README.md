# Pemicu 2

Query SQL untuk create table, relation, dan insert data  
Link : [Download Disini](https://drive.google.com/file/d/1g_OGEaDeOvwNqglYqdX8l87gs1VicFQ1/view)  
Kemudian letakkan dalam `sql/`  

PostgreSQL : [Download](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)  
pgAdmin 4 : [Windows](https://www.pgadmin.org/download/pgadmin-4-windows/)/[Linux](https://www.pgadmin.org/download/pgadmin-4-apt/)

# Pekerjaan 1 (indexing)

## Kondisi

- Kolom sering digunakan dalam klausa WHERE atau dalam kondisi join 
- Kolom berisi nilai dengan jangkauan yang luas 
- Kolom berisi banyak nilai null 
- Beberapa kolom sering digunakan dalam klausa WHERE atau dalam kondisi join 
- Tabel berukuran besar dan sebagian besar query menampilkan data kurang dari 2-4%

### Prosedur

- mencari kolom berisi nilai dengan jangkauan yang luas :
    - table orders : 900929 data
        ```sql
        SELECT COUNT(*) FROM orders;
        ```
    - table order_details : 4977189 data
        ```sql
        SELECT COUNT(*) FROM order_details;
        ```
- kolom berisi banyak nilai null :
    - kolom `ship_region` pada table `orders` *(ditemukan 592835 data bernilai NULL)*
        ```sql
        SELECT COUNT(o.ship_region)
        FROM orders o
        WHERE o.ship_region IS NULL
           OR o.ship_region ILIKE 'null'
           OR o.ship_region = '';
        ```

### Ketentuan Query

dari informasi diatas,  
ketentuan pembuatan query adalah :
- menggunakan table `orders` dan `order_details`, selain itu opsional *(usahakan ada)*
- menggunakan kolom `ship_region` pada table `orders` *(karena terdapat banyak nilai null)*
- menggunakan **WHERE** dan **JOIN**
- query harus menampilkan data kurang dari 2-4% dari seluruh data table, tidak boleh lebih.

### Contoh Query

<br>

- contoh 1
    - query select
        ```sql
        EXPLAIN ANALYZE
        SELECT 
            o.order_id,
            o.order_date,
            o.ship_region,
            c.company_name,
            d.product_id,
            d.unit_price,
            d.quantity,
            d.discount
        FROM orders o
        JOIN order_details d ON o.order_id = d.order_id
        JOIN customers c ON o.customer_id = c.customer_id
        WHERE 
            (o.ship_region IS NULL
             OR o.ship_region ILIKE 'null'
             OR o.ship_region = '')
          AND o.order_date BETWEEN '1996-01-01' AND '1998-01-01'
          AND d.unit_price > 100
          AND d.discount > 0.2
        ORDER BY o.order_date DESC;
        ```
    - query index
        ```sql
        CREATE INDEX idx_orders_ship_region ON orders(ship_region);
        CREATE INDEX idx_order_details_unit_price ON order_details(unit_price);
        CREATE INDEX idx_order_details_discount ON order_details(discount);
        CREATE INDEX idx_orders_order_id ON orders(order_id);
        CREATE INDEX idx_order_details_order_id ON order_details(order_id);
        CREATE INDEX idx_orders_customer_id ON orders(customer_id);
        CREATE INDEX idx_customers_customer_id ON customers(customer_id);
        CREATE INDEX idx_orders_order_date ON orders(order_date);
        ```
    - hasil analisis
        - [sebelum indexing](/image/indexing/indexing_1_sebelum.png)
        - [setelah indexing](/image/indexing/indexing_1_setelah.png)
<div>
    <table style="border-collapse: collapse; width: 100%; max-width: 800px; table-layout: fixed; margin-left:8%;">
        <tr>
            <td style="border: 1px solid white; padding: 5px; text-align: center;">Parameter</td>
            <td style="border: 1px solid white; padding: 5px; text-align: center;">Sebelum Indexing</td>
            <td style="border: 1px solid white; padding: 5px; text-align: center;">Setelah Indexing</td>
        </tr>
        <tr>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Waktu eksekusi</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">181.518 ms</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">31.579 ms</td>
        </tr>
        <tr>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Strategi scan</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">	Parallel Seq Scan</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Bitmap Index + Index Scan</td>
        </tr>
        <tr>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Strategi join</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Parallel Hash Join</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Nested Loop Join</td>
        </tr>
        <tr>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Efisiensi filter</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Lambat (dengan full scan)</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Cepat (difilter oleh index)</td>
        </tr>
        <tr>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Baris yang dieliminasi</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Jutaan</td>
            <td style="border: 1px solid white; padding: 5px 10px; text-align: left;">Ratusan</td>
        </tr>
    </table>
</div>

<br>

- contoh 2