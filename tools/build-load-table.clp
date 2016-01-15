(deffunction build-load-table
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
(deffunction build-offset-table-entry
             (?index)
             (printout t tab ".word next_instruction_case" ?index ":" crlf))

(loop-for-count (?i 0 127) do
                (build-load-table ?i))
(printout t 
          .microcode crlf
          .org #x0 crlf
          "next_instruction_jump_table:" crlf)

(loop-for-count (?i 0 127) do
                (build-offset-table-entry ?i))


(exit)
