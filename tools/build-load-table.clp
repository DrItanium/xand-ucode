(deffunction build-operand-table
             (?start)
             (printout t 
                       "next_instruction_case" ?start ":" crlf
                       tab "move ?xop0 = ?mem" ?start crlf
                       tab "call check-xop0" crlf
                       tab "move ?xop1 = ?mem" (+ ?start 1) crlf
                       tab "call check-xop1" crlf
                       tab "move ?xop2 = ?mem" (+ ?start 2) crlf
                       tab "call check-xop2" crlf
                       tab "return" crlf))
(deffunction build-store-table
             (?index)
             (printout t 
                       "store_table_case" ?index ":" crlf
                       tab "move ?mem" ?index " = ?in1" crlf
                       tab "return" crlf))
(deffunction build-load-table
             (?index)
             (printout t
                       "load_table_case" ?index ":" crlf
                       tab "move ?out = ?mem" ?index crlf
                       tab "return" crlf))

(deffunction build-offset-table-entry
             (?index ?prefix)
             (printout t tab ".word " ?prefix "_case" ?index ":" crlf))
(deffunction build-next-instruction-entry
             (?index)
             (build-offset-table-entry ?index next_instruction))
(deffunction build-store-table-entry
             (?index)
             (build-offset-table-entry ?index store_table ))
(deffunction build-load-table-entry
             (?index)
             (build-offset-table-entry ?index load_table))
(deffunction for-each-cell-do
             (?fn)
             (loop-for-count (?i 0 127) do
                             (funcall ?fn ?i)))
(printout t .code crlf)
(for-each-cell-do build-operand-table)
(for-each-cell-do build-store-table)
(for-each-cell-do build-load-table)
(printout t 
          .microcode crlf
          .org " " #x0 crlf
          "next_instruction_jump_table:" crlf)
(for-each-cell-do build-next-instruction-entry)
(printout t 
          "load_jump_table:" crlf)
(for-each-cell-do build-load-table-entry)
(printout t 
          "store_jump_table:" crlf)
(for-each-cell-do build-store-table-entry)
(exit)
