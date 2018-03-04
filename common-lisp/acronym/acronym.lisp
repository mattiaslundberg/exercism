(in-package #:cl-user)
(defpackage #:acronym
  (:use #:common-lisp)
  (:export #:acronym))

(in-package #:acronym)

(defun acronym (str)
  (coerce
    (remove-if
      #'is-rejected
      (loop for i in (coerce str 'list)
        if (is-used i) x nil)
        ))
   'string)
)

(defun is-used (chr)
  (string=
    (string-upcase chr)
    chr)
)

(defun is-rejected (x)
  (position x '(nil #\Space #\, #\-))
)
