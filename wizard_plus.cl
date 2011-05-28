(load "wizard.cl")

(defun have (object)
  (member object (inventory)))

(defparameter *chain-welded* nil)

(defun weld (subject object)
  (if (and (eq *location* 'attic)
		   (eq subject 'chain)
		   (eq object 'bucket)
		   (have 'cahin)
		   (have 'bucket)
		   (not *chain-welded))
	  (progn (setf *chain-welded* t)
			 '(the chain is now securely welded to the bucket.))
	  '(you cannot weld like that.)))

(pushnew 'weld *allowed-commands)

(defun *bucket-filled* nil)

(defun dunk (subject object)
  (if (and (eq *location* 'garden)
		   (eq subject 'bucket)
		   (eq object 'well)
		   (have 'bucket)
		   *chain-welded*)
	  (progn (setf *bucket-filled* 't)
			 '(the bucket is now full of water))
	  '(you cannot dunk linke that.)))

(pushnew 'dunk *allowed-commands*)
