;;;; -*- mode:lisp;coding:utf-8 -*-
;;;;***************************************************************************
;;;;FILE:                com.informatimago.tools.make-depends.test.asd
;;;;LANGUAGE:            Common-Lisp
;;;;SYSTEM:              None
;;;;USER-INTERFACE:      None
;;;;DESCRIPTION:
;;;;
;;;;    This file defines the com.informatimago.tools.make-depends.test system.
;;;;    Tests the com.informatimago.tools.make-depends system.
;;;;
;;;;USAGE:
;;;;
;;;;AUTHORS:
;;;;    <PJB> Pascal J. Bourguignon <pjb@informatimago.com>
;;;;MODIFICATIONS:
;;;;    2015-02-23 <PJB> Created.
;;;;BUGS:
;;;;
;;;;LEGAL:
;;;;
;;;;    AGPL3
;;;;    
;;;;    Copyright Pascal J. Bourguignon 2015 - 2015
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
;;;;    along with this program.  If not, see <http://www.gnu.org/licenses/>
;;;;
;;;;***************************************************************************

(asdf:defsystem "com.informatimago.tools.make-depends.test"
  ;; system attributes:
  :description    "Tests the com.informatimago.tools.make-depends system."
  :author         "Pascal J. Bourguignon <pjb@informatimago.com>"
  :maintainer     "Pascal J. Bourguignon <pjb@informatimago.com>"
  :licence        "AGPL3"
  ;; component attributes:
  :version        "1.0.0"
  :properties     ((#:author-email . "pjb@informatimago.com")
                   (#:date . "Winter 2015")
                   ((#:albert #:output-dir)
                    . "/tmp/documentation/com.informatimago.tools.make-depends.test/")
                   ((#:albert #:formats) "docbook")
                   ((#:albert #:docbook #:template) . "book")
                   ((#:albert #:docbook #:bgcolor) . "white")
                   ((#:albert #:docbook #:textcolor) . "black"))
  #+asdf-unicode :encoding #+asdf-unicode :utf-8
  :depends-on     ("com.informatimago.common-lisp.cesarum"
                   "com.informatimago.tools.make-depends")
  :components     ((:file "make-depends-test" :depends-on nil))
  :perform        (asdf:test-op
                   (operation system)
                   (declare (ignore operation system))
                   (dolist (p '("COM.INFORMATIMAGO.TOOLS.MAKE-DEPENDS.TEST"))
                     (let ((*package* (find-package p)))
                       (uiop/package:symbol-call p "TEST/ALL")))))

;;;; THE END ;;;;
