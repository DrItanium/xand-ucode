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
                       "store_table_case" ?start ":" crlf
                       tab "move ?mem" ?start " = ?in1" crlf
                       tab "return"))
(deffunction build-load-table
             (?index)
             (printout t
                       "load_table_case" ?start ":" crlf
                       tab "move ?out = ?mem" ?start crlf
                       tab "return" crlf))

(deffunction build-offset-table-entry
             (?index)
             (printout t tab ".word next_instruction_case" ?index ":" crlf))
(deffunction for-each-cell-do
             (?fn)
             (loop-for-count (?i 0 127) do
                             (funcall ?fn ?i)))
(printout t 
          .code crlf)
(for-each-cell-do build-operand-table)
(printout t 
          .microcode crlf
          .org #x0 crlf
          "next_instruction_jump_table:" crlf)

(for-each-cell-do build-offset-table-entry)
(printout t 
          "store_jump_table:" crlf)


(for-each-cell-do build-store-table)

(printout t 
          "load_jump_table:" crlf)
(for-each-cell-do build-load-table)

(exit)
