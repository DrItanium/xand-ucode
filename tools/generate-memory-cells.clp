; build the alias listings for the different memory cells
(deffunction generate-memory-cell
             (?cell-index ?register-index)
             (printout t ".alias mem" ?cell-index " = r" ?register-index crlf))
(loop-for-count (?i 32 160) do
                (generate-memory-cell (- ?i 32) 
                                      ?i))
(exit)
