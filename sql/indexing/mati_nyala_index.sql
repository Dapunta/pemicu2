-- matikan index
SET enable_indexscan = off;
SET enable_bitmapscan = off;
SET enable_seqscan = on;

-- nyalakan index
RESET enable_indexscan;
RESET enable_bitmapscan;