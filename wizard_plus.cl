(load "wizard.cl")

(defun have (object)
  (member object (inventory)))

(defmacro game-action (command subj obj place &body body)
  `(progn (defun ,command (subject object)
			(if (and (eq *location* ',place)
					 (eq subject ',subj)
					 (eq object ',obj)
					 (have ',subj))
				,@body
				'(i cant ,command like that.)))
		  (pushnew ',command *allowed-commands*)))

(defparameter *chain-welded* nil)

(game-action weld chain bucket attic
			 (if (and (have 'bucket) (not *chain-welded*))
				 (progn (setf *chain-welded 't)
						'(the chain is now securely welded to the bucket.))
				 '(you do not have a bucket.)))

(defparameter *bucket-filled* nil)

(game-action dunk bucket well garden
			 (if *chain-welded*
				 (progn (setf *bucket-filled* 't)
						'(the bucket is now full of water))
				 '(the water level is too low to reach.)))
