;;;; -*- Lisp -*-

;;;; This is the features customization lambda form we will use if the
;;;; user has "threads" in USE *and* they are building for the x86
;;;; architecture.

;;;; :sb-futex is dependent on the presence of a Linux 2.6.x kernel.
;;;; For users of Linux 2.4.x kernels, this is still okay to enable,
;;;; as SBCL will fall back if the futex system-call is not present.

(lambda (list)
  (flet ((enable (x)
	   (pushnew x list))
   	 (disable (x)
	   (setf list (remove x list))))
    (enable :sb-thread)
    (enable :sb-futex)
    (disable :sb-test))
  list)
