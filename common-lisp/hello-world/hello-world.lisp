(defpackage #:hello-world
  (:use #:common-lisp)
  (:export #:hello-world)
  (:nicknames #:hw))

(in-package #:hello-world)

(defun hello-world (&optional (name "World"))
  (format nil "Hello ~A!" name)
  )
