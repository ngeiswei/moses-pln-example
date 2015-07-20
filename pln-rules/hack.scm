(define pln-rule-equivalence-hack
  (BindLink
     (ImplicationLink
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (QuoteLink (VariableNode "X"))
              (VariableNode "treatment-1")
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (QuoteLink (VariableNode "X"))
              (VariableNode "compound-A")
           )
        )
     )
     (ImplicationLink (stv 1 1)
         (PredicateNode "take-treatment-1")
         (PredicateNode "take-compound-A")
     )
  )
)

(define pln-rule-eliminate-neutral-element-hack
  (BindLink
     (ImplicationLink
        (AndLink
           (EvaluationLink
              (PredicateNode "contain")
              (ListLink
                 (VariableNode "treatment-1")
                 (VariableNode "compound-A")
              )
           )
           (EvaluationLink
              (PredicateNode "take")
              (ListLink
                 (QuoteLink (VariableNode "X"))
                 (VariableNode "treatment-1")
              )
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (QuoteLink (VariableNode "X"))
              (VariableNode "compound-A")
           )
        )
     )
     (ImplicationLink (stv 1 1)
        (AndLink
           (EvaluationLink
              (PredicateNode "take")
              (ListLink
                 (VariableNode "X")
                 (VariableNode "treatment-1")
              )
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (VariableNode "X")
              (VariableNode "compound-A")
           )
        )
     )
  )
)

(define pln-rule-eliminate-dangling-junctor-hack
  (BindLink
     (ImplicationLink
        (AndLink
           (EvaluationLink
              (PredicateNode "take")
              (ListLink
                 (QuoteLink (VariableNode "X"))
                 (VariableNode "treatment-1")
              )
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (QuoteLink (VariableNode "X"))
              (VariableNode "compound-A")
           )
        )
     )
     (ImplicationLink (stv 1 1)
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (VariableNode "X")
              (VariableNode "treatment-1")
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (VariableNode "X")
              (VariableNode "compound-A")
           )
        )
     )
  )
)

(define pln-rule-and-hack
(BindLink
   (AndLink
      (EvaluationLink
         (PredicateNode "take")
         (ListLink
            (QuoteLink (VariableNode "X"))
            (VariableNode "Y")
         )
      )
      (EvaluationLink
         (PredicateNode "contain")
         (ListLink
            (VariableNode "Y")
            (VariableNode "Z")
         )
      )
   )
   (AndLink (stv 1 1)
      (EvaluationLink
         (PredicateNode "take")
         (ListLink
            (VariableNode "X")
            (VariableNode "Y")
         )
      )
      (EvaluationLink
         (PredicateNode "contain")
         (ListLink
            (VariableNode "Y")
            (VariableNode "Z")
         )
      )
   )
)
)

(define pln-rule-for-all-hack
  (BindLink
     (ForAllLink
        (ListLink
           (QuoteLink (VariableNode "X"))
           (QuoteLink (VariableNode "Y"))
           (QuoteLink (VariableNode "Z"))
        )
        (ImplicationLink
           (AndLink
              (EvaluationLink
                 (PredicateNode "take")
                 (ListLink
                    (QuoteLink (VariableNode "X"))
                    (QuoteLink (VariableNode "Y"))
                 )
              )
              (EvaluationLink
                 (PredicateNode "contain")
                 (ListLink
                    (QuoteLink (VariableNode "Y"))
                    (QuoteLink (VariableNode "Z"))
                 )
              )
           )
           (EvaluationLink
              (PredicateNode "take")
              (ListLink
                 (QuoteLink (VariableNode "X"))
                 (QuoteLink (VariableNode "Z"))
              )
           )
        )
     )
     (ImplicationLink (stv 1 1)
        (AndLink
           (EvaluationLink
              (PredicateNode "take")
              (ListLink
                 (VariableNode "X")
                 (VariableNode "treatment-1")
              )
           )
           (EvaluationLink
              (PredicateNode "contain")
              (ListLink
                 (VariableNode "treatment-1")
                 (VariableNode "compound-A")
              )
           )
        )
        (EvaluationLink
           (PredicateNode "take")
           (ListLink
              (VariableNode "X")
              (VariableNode "compound-A")
           )
        )
     )
  )
)

(define pln-rule-average-hack
  (BindLink
     (AverageLink (stv 0.7 0.6)
        (QuoteLink (VariableNode "X"))
        (ImplicationLink
           (EvaluationLink
              (PredicateNode "injury-speed-predicate")
              (QuoteLink (VariableNode "X"))
           )
           (ImplicationLink
              (PredicateNode "is-well-hydrated")
              (QuoteLink (VariableNode "X"))
           )
        )
     )
     (ImplicationLink (stv 0.7 0.6)
        (EvaluationLink
           (PredicateNode "injury-speed-predicate")
           (VariableNode "recovery-speed-of-injury-alpha")
        )
        (ImplicationLink
           (PredicateNode "is-well-hydrated")
           (VariableNode "recovery-speed-of-injury-alpha")
        )
     )
  )
)
