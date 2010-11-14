;;;; -*- mode:lisp;coding:utf-8 -*-
;;;;**************************************************************************
;;;;FILE:               compile.lisp
;;;;LANGUAGE:           Common-Lisp
;;;;SYSTEM:             Common-Lisp
;;;;USER-INTERFACE:     NONE
;;;;DESCRIPTION
;;;;    
;;;;    Compile all the libraries with ASDF.
;;;;    
;;;;AUTHORS
;;;;    <PJB> Pascal J. Bourguignon <pjb@informatimago.com>
;;;;MODIFICATIONS
;;;;    2010-11-01 <PJB> Created.
;;;;BUGS
;;;;LEGAL
;;;;    GPL
;;;;    
;;;;    Copyright Pascal J. Bourguignon 2010 - 2010
;;;;    
;;;;    This program is free software; you can redistribute it and/or
;;;;    modify it under the terms of the GNU General Public License
;;;;    as published by the Free Software Foundation; either version
;;;;    2 of the License, or (at your option) any later version.
;;;;    
;;;;    This program is distributed in the hope that it will be
;;;;    useful, but WITHOUT ANY WARRANTY; without even the implied
;;;;    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;;;;    PURPOSE.  See the GNU General Public License for more details.
;;;;    
;;;;    You should have received a copy of the GNU General Public
;;;;    License along with this program; if not, write to the Free
;;;;    Software Foundation, Inc., 59 Temple Place, Suite 330,
;;;;    Boston, MA 02111-1307 USA
;;;;**************************************************************************



(let ((path (merge-pathnames
             (make-pathname :directory '(:relative "TOOLS")
                            :name "INIT-ASDF" :type "LISP" :case :common)
              *load-pathname*)))

  #+abcl (setf path (pathname (string-downcase (namestring path))))
  
  (format t "~&;;;;; Loading ~S~%" path)
  (load path :verbose t))


;; Add all the subdirectories containing a .asd file to
;; asdf:*central-registry*.

(setf asdf:*central-registry*
      (append (remove-duplicates
               (mapcar (lambda (path)
                         (make-pathname :name nil :type nil :version nil :defaults path))
                       (directory "**/*.asd"))
               :test (function equalp))
              asdf:*central-registry*))


          (asdf-load  :com.informatimago.common-lisp)
#-ccl     (asdf-load  :com.informatimago.clext)
          (asdf-load  :com.informatimago.clmisc)
#+sbcl    (asdf-load  :com.informatimago.sbcl)
#+clisp   (asdf-load  :com.informatimago.clisp)
#+clisp   (asdf-load  :com.informatimago.susv3)


;;;; THE END ;;;;
