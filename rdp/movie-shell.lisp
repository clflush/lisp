;;;; -*- mode:lisp;coding:utf-8 -*-
;;;;**************************************************************************
;;;;FILE:               movie-shell.lisp
;;;;LANGUAGE:           Common-Lisp
;;;;SYSTEM:             Common-Lisp
;;;;USER-INTERFACE:     NONE
;;;;DESCRIPTION
;;;;    
;;;;    A silly little shell, taking commands like in Tron.
;;;;    The commands are parsed with a recursive descent grammar,
;;;;    the parser being generated by com.informatimago.rdp.
;;;;    
;;;;AUTHORS
;;;;    <PJB> Pascal J. Bourguignon <pjb@informatimago.com>
;;;;MODIFICATIONS
;;;;    2011-07-19 <PJB> Created.
;;;;BUGS
;;;;LEGAL
;;;;    AGPL3
;;;;    
;;;;    Copyright Pascal J. Bourguignon 2011 - 2012
;;;;    
;;;;    This program is free software: you can redistribute it and/or modify
;;;;    it under the terms of the GNU Affero General Public License as published by
;;;;    the Free Software Foundation, either version 3 of the License, or
;;;;    (at your option) any later version.
;;;;    
;;;;    This program is distributed in the hope that it will be useful,
;;;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;;    GNU Affero General Public License for more details.
;;;;    
;;;;    You should have received a copy of the GNU Affero General Public License
;;;;    along with this program.  If not, see http://www.gnu.org/licenses/
;;;;**************************************************************************

(ql:quickload :com.informatimago.rdp)
(use-package  :com.informatimago.rdp)


(defvar *password* '("0" . "NONE"))

(defun sh-code-password-to-memory (ident address)
  (setf *password* (cons address ident))
  (format t "~&PASSWORD STORED TO MEMORY ~A~%" address))

(defun sh-request-access-to (&key program database)
  (format t "~&ACCESS TO ~:[PROGRAM~;DATABASE~] ~A IS ~:[REJECTED~;GRANTED~]~%"
          database (or program database)  (string= (cdr *password*) "GOLDFINGER")))

(defun sh-status-report-on (&rest what)
  (format t "~&~{~A~^ ~} STATUS IS OK~%" what))

(defun sh-quit ()
  (format t "~&GOOD BYE, M. DILLIGER.~%")
  (throw 'gazongues nil))


(defgrammar movie-shell
    :terminals ((ident   "[A-Za-z][A-Za-z0-9]*")
                (address "[0-9][0-9A-F]*"))
    :start command
    :rules ((--> command (alt request code quit) :action (values))
            (--> request
                 "REQUEST"
                 (alt (seq "ACCESS" "TO" ident (alt "PROGRAM" "DATABASE")
                           :action (sh-request-access-to
                                    (intern (second $4) "KEYWORD") (second $3)))
                      (seq "STATUS" "REPORT" "ON" "MISSING" "DATA"
                           :action (sh-status-report-on (second $4) (second $5)))))
            (--> code
                 "CODE" ident "TO" "MEMORY" address
                 :action (sh-code-password-to-memory (second $2) (second $5)))
            (--> quit
                 "QUIT"
                 :action (sh-quit))))

(defun movie-shell ()
  (catch 'gazongues
    (loop
       :for command = (progn (format *query-io* "~%> ")
                             (finish-output *query-io*)
                             (clear-input *query-io*)
                             (read-line *query-io*))
       :do (progn
             (handler-case (parse-movie-shell (string-upcase command))
               (error (err)
                 (format t "~&~A~%" err)))
             (finish-output))))
  (finish-output)
  (values))


;; CL-USER> (movie-shell)
;; 
;; > request access to secret program
;; 
;; ACCESS TO PROGRAM SECRET IS GRANTED
;; 
;; > code zero to memory 42
;; 
;; PASSWORD STORED TO MEMORY 42
;; 
;; > request access to secret program
;; 
;; ACCESS TO PROGRAM SECRET IS REJECTED
;; 
;; > request access to big database
;; 
;; ACCESS TO DATABASE BIG IS REJECTED
;; 
;; > code goldfinger to memory 42
;; 
;; PASSWORD STORED TO MEMORY 42
;; 
;; > request access to big database
;; 
;; ACCESS TO DATABASE BIG IS GRANTED
;; 
;; > request status report on missing data
;; 
;; MISSING DATA STATUS IS OK
;; 
;; > quit
;; 
;; GOOD BYE, M. DILLIGER.
;; ; No value
;; CL-USER> 

;;;; THE END ;;;;
