; =====================================================================
; ImplicationOrRule
;
; ImplicationLink <TV1>
;    A
;    C
; ImplicationLink <TV2>
;    B
;    C
; |-
; ImplicationLink <TV>
;    OrLink
;       A
;       B
;    C
;----------------------------------------------------------------------


(define pln-rule-implication-or
  (BindLink
     (VariableList
        (VariableNode "$A")
        (VariableNode "$B")
        (VariableNode "$C")
        (TypedVariableLink
           (VariableNode "$A")
           (TypeNode "PredicateNode"))
        (TypedVariableLink
           (VariableNode "$B")
           (TypeNode "PredicateNode"))
        (TypedVariableLink
           (VariableNode "$C")
           (TypeNode "PredicateNode"))
     )
     (AndLink
        (ImplicationLink
           (VariableNode "$A")
           (VariableNode "$C")
        )
        (ImplicationLink
           (VariableNode "$B")
           (VariableNode "$C")
        )
        (NotLink (EqualLink (VariableNode "$A") (VariableNode "$B")))
        ;; (NotLink (ImplicationLink (VariableNode "$A") (VariableNode "$B")))
        ;; (NotLink (ImplicationLink (VariableNode "$B") (VariableNode "$A")))
     )
     (ExecutionOutputLink
        (GroundedSchemaNode "scm: pln-formula-implication-or")
        (ListLink
           (ImplicationLink
              (OrLink
                 (VariableNode "$A")
                 (VariableNode "$B")
              )
              (VariableNode "$C")
           )
           (ImplicationLink
              (VariableNode "$A")
              (VariableNode "$C")
           )
           (ImplicationLink
              (VariableNode "$B")
              (VariableNode "$C")
           )
        )
     )
  )
)

(define (pln-formula-implication-or ABC AC BC)
  (cog-set-tv! ABC
   (pln-formula-implication-or-side-effect-free AC BC))
)

;; WARNING: same as Or formula, not sure that is correct
(define (pln-formula-implication-or-side-effect-free AC BC)
  (let 
      ((sAC (cog-stv-strength AC))
       (sBC (cog-stv-strength BC))
       (cAC (cog-stv-confidence AC))
       (cBC (cog-stv-confidence BC)))
    (stv (- (+ sAC sBC) (* sAC sBC)) (min cAC cBC))))
