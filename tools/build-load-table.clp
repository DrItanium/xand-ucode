(deffunction build-load-table
             (?start)
             (printout t 
                       "next_instruction_case" ?start ":" crlf
                       tab "move ?xop0 = ?mem" ?start crlf
                       tab "gt ?micro-pred = ?xop0, ?max-signed" crlf
                       tab "branch terminate if ?micro-pred" crlf
                       tab "move ?xop1 = ?mem" (+ ?start 1) crlf
                       tab "gt ?micro-pred = ?xop1, ?max-signed" crlf
                       tab "branch terminate if ?micro-pred" crlf
                       tab "move ?xop2 = ?mem" (+ ?start 2) crlf
                       tab "gt ?micro-pred = ?xop2, ?max-signed" crlf
                       tab "branch terminate if ?micro-pred" crlf
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
