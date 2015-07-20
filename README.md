# MOSES PLN synergy demo

Simple demo showing how PLN reasoning can be used to overcome the
uncertainties resulting from the low number of samples used during
learning.

## Run MOSES with the following command

```
$ moses \
      --input-file dataset.csv \
      --target-feature recovery-speed-injury-alpha \
      --output-with-labels 1 \
      --problem pre \
      -q 0.7 \
      -p 0.5 \
      --result-count 1 \
      --output-format scheme
```

## Load the models and the background knowledge in guile

```
$ guile
scheme@(guile-user)> (load "moses-model.scm")
scheme@(guile-user)> (load "background-knowledge.scm")
```

## Load the rule-based system (here PLN)

```
scheme@(guile-user)> (load "pln-config.scm")
```

## Apply rules iteratively

```
scheme@(guile-user)> ;; Infer that take-treatment-1 implies take-compound-A
scheme@(guile-user)> (cog-bind pln-rule-for-all-hack)
scheme@(guile-user)> (cog-bind pln-rule-eliminate-neutral-element-hack)
scheme@(guile-user)> (cog-bind pln-rule-eliminate-dangling-junctor-hack)
scheme@(guile-user)> (cog-bind pln-rule-equivalence-hack)
$6 = (SetLink
   (ImplicationLink (stv 0.55000001 0.80000001)
      (PredicateNode "take-treatment-1" (stv 0.1 0.80000001))
      (PredicateNode "recovery-speed-of-injury-alpha" (stv 0.055000003 0.99999982))
   )
)

scheme@(guile-user)> ;; Infer that being well hydrated speeds up recovery 
scheme@(guile-user)> (cog-bind pln-rule-average-hack)
scheme@(guile-user)> (cog-bind pln-rule-modus-ponens)
$8 = (SetLink
   ...
   (ImplicationLink (stv 0.69999999 0.60000002)
      (PredicateNode "is-well-hydrated" (stv 0.059500001 0.99999982))
      (VariableNode "recovery-speed-of-injury-alpha" (stv 0.041650001 0.99999982))
   )
)

scheme@(guile-user)> ;; Infer relationships between input and target features
scheme@(guile-user)> (cog-bind pln-rule-deduction)

scheme@(guile-user)> ;; Infer MOSES model precision
scheme@(guile-user)> (cog-bind pln-rule-implication-or)
```
