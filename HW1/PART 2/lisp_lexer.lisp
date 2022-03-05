; *********************************************
; *  341 Programming Languages                *
; *  Fall 2021                                *
; *  Author: Yunus Emre Geyik                 *
; *  File  : gpp_lexer.lisp 				  *
; * 										  *
; *  Lexical Syntax Analyser for G++.		  * 
; *********************************************

(defun LEXER(whole_input _length)
	
	(setq k 0)
	(setq m 0)
	(setq _color nil)
	(setq _curly 1)
	(loop while (< k _length) do ; While loop for whole operations
		
		(setq only_char (char whole_input k))	; Each character of string given input

		(cond((or (in_term only_char) (check_digit only_char))
			(setq temporary (string ""))
			(setf m k)

			(loop while (or (check_digit only_char) (in_term only_char)) do 	; Store the all chars or digits.
				(setq temporary (concatenate 'string temporary (string only_char)))
				(setq m (+ m 1))
				(setq k (+ k 1))
				(setq only_char (char whole_input m))
			)
			(cond
				; Checking keywords
			 	((string-equal temporary "exit")   (exit)(setq _color nil))
			 	((string-equal temporary "and")    (print "KW_AND")(setq _color t))
			 	((string-equal temporary "or")     (print "KW_OR")(setq _color t))
			 	((string-equal temporary "not")    (print "KW_NOT")(setq _color t))
			 	((string-equal temporary "equal")  (print "KW_EQUAL")(setq _color t))
			 	((string-equal temporary "less")   (print "KW_LESS")(setq _color t))
			 	((string-equal temporary "nil")    (print "KW_NIL")(setq _color t))
			 	((string-equal temporary "list")   (print "KW_LIST")(setq _color t))
			 	((string-equal temporary "append") (print "KW_APPEND")(setq _color t))
			 	((string-equal temporary "concat") (print "KW_CONCAT")(setq _color t))
			 	((string-equal temporary "set")    (print "KW_SET")(setq _color t))
			 	((string-equal temporary "deffun") (print "KW_DEFFUN")(setq _color t))
			 	((string-equal temporary "for")    (print "KW_FOR")(setq _color t))
			 	((string-equal temporary "if")     (print "KW_IF")(setq _color t))
			 	((string-equal temporary "laod")   (print "KW_LOAD")(setq _color t))
			 	((string-equal temporary "disp")   (print "KW_DISP")(setq _color t))
			 	((string-equal temporary "true")   (print "KW_TRUE")(setq _color t))
			 	((string-equal temporary "false")  (print "KW_FALSE")(setq _color t))
			 	
			 	
			 	;In this part code check the value
			 	;if value begin with zero then write a error message at the terminal
			 	
			 	((eq (char temporary 0) #\0)
					(if (and ( > (length temporary) 1)(check_digit (char temporary 1)))
						(progn
							(print "Given Value Can NOT Begin With Zero !!!")
							(return-from LEXER nil)
						)
					)
				)
			 	((check_digit (char temporary 0))(print "VALUE")(setq _color t)); check the value in a string
			 	((in_term (char temporary 0)) (print "IDENTIFIER") (setq _color t)); check the indetifier in a string

			)
		))			 

		(cond
			((equal only_char #\+) (print "OP_PLUS")(setq _color t))
			((equal only_char #\-) (print "OP_MINUS")(setq _color t))
			((equal only_char #\/) (print "OP_DIV")(setq _color t))
			((equal only_char #\*)
				(if(equal (char whole_input (+ k 1)) #\*)
					(progn
						(print "OP_DBLMULT")
						(setq _color t)
						(setq k (+ k 1))
					)
					(progn
						(setq _color t)
						(print "OP_MULT")
					)
				)
			)
			((equal only_char #\() (print "OP_OP")(setq _color t))	
			((equal only_char #\)) (print "OP_CP")(setq _color t))
			((equal only_char #\")
				(if(equal _curly 1)
					(progn
						(print"OP_OC")
						(setq _color t)
					 	(setf _curly 0)
					)
					(progn
						(print "OP_CC")
						(setq _color t)
					  	(setf _curly 1)
					)
				)
			)	
		)
		(if(equal only_char #\;)
			(if(equal (char whole_input (+ k 1)) #\;)
				(progn
					(print "COMMENT")
					(setq _color t)
					(return-from LEXER _color)
				)
		))
		(setf k (+ k 1))
	) 	
	(return-from LEXER _color)
)

(defun read-file(filename)		; Read File Function
	(with-open-file (file filename)
		(let ((chars (make-string (file-length file))))
			(read-sequence chars file) chars
		)
	)
)

; In this function, function checking the considered char is in the alphabet
(defun in_term(alpha)		
	(if (not(or (and (> (char-int alpha) 96) (< (char-int alpha) 123))
			(and (> (char-int alpha) 64) (< (char-int alpha) 91))
		))
		nil
		t
	)
)



; This function using for take(read) input from the file that is a option for user
(defun read_from_file(filename)

	(let ((in (open filename :if-does-not-exist nil))) ; checking if file open right way
	 	(when in
	    	(loop for line = (read-line in nil)      ; read file till arrive the end 
	       		while line do
					
					(setq main_code (coerce line 'string))
					(setq _length (length main_code))						; File text length.
					(setq test (LEXER main_code _length))
					(if (eq nil test)
						(progn
							(print "Please Enter A Right Input !!!")
							(return-from read_from_file)
						)
					)
	    	)
	  	)
	  	(close in)
	 )
)
; This function has two input type can take from user in the terminal or take from input file
(defun gppinterpreter() ; This function is doing for starting interpreter

	;Input as terminal or file reading input
	(setq Str(read-line))
	(if(> 5 (length Str))
		(progn 			;input from user
			(loop
			
				(print "_>")
				(setf Str(read-line))
				(setq _length (length Str))      ;File text length.
				(setq test(LEXER Str _length))
				(if(equal test nil)
					(progn
						(print "Please Enter A Right Input !!!")
						(return-from gppinterpreter)
					)
				)
			)
		)
		(progn ;input from input file
			(print"_>")
			(setq filename(subseq Str 5)) ;get the filename from the string stored in Str
			(read_from_file filename))
	)
)

(defun check_digit(digit)		; Digit Checking Function
	(if (not(and (> (char-int digit) 47) (< (char-int digit) 58)))
		nil
		t)
)

;calling gppinterpreter Function
(gppinterpreter)