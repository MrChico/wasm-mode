;; wasm-mode.el --- Major mode for web assembly

;; Copyright (C) 2018  Martin Lundfall

;; Author: Martin Lundfall  <martin.lundfall@protonmail.com>
;; Keywords: languages
;; Version: 0.0.1

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU Affero General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU Affero General Public License for more details.
;;
;; You should have received a copy of the GNU Affero General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

(defvar wasm-instructions
  '("br" "br_if" "br_table" "block" "call" "call_indirect" "else" "if" "end" "export" "loop" "return" "then"))

(defvar wasm-declarations
 '("data" "elem" "func" "global" "import" "local" "memory" "module" "offset" "param" "result" "start" "table" "type"))

;; regexp matching index labels: "\$[-A-Za-z0-9_.+*/\\\\^~=<>!?@#$%&|:'`]+"

(defvar wasm-mode-syntax-table nil "Syntax table for `wasm-mode'.")
 
(setq wasm-mode-syntax-table
      (let ( (synTable (make-syntax-table)))
        ;; lisp style single line comments: “;; …”
        ;; block comments as "(; ... ;)"
        (modify-syntax-entry ?\; ". 123b" synTable)
        (modify-syntax-entry ?\( ". 1cn" synTable)
        (modify-syntax-entry ?\) ". 4cn" synTable)
        (modify-syntax-entry ?\n "> ab" synTable)
        synTable))

(defvar wasm-font-lock-defaults
  `((
     ( ,(regexp-opt wasm-declarations 'words) . font-lock-keyword-face)
     ( ,(regexp-opt wasm-instructions 'words) . font-lock-builtin-face)
     )))

(define-derived-mode wasm-mode lisp-mode "wasm"
  "wasm mode is a major mode for editing web assembly code"
  (setq font-lock-defaults wasm-font-lock-defaults)

  (set-syntax-table wasm-mode-syntax-table)
  ;; for comments
  (setq comment-start "//")
  (setq comment-end "")
)

(add-to-list 'auto-mode-alist '("\\.wasm\\|\\.wat'" . wasm-mode))

(provide 'wasm-mode)
