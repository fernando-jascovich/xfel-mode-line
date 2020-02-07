;;; xfel-mode-line.el --- Custom minimal mode-line

;; Author: Fernando Jascovich
;; Keywords: mode-line, convenience
;; Version: 0.1
;; Url:
;; Package-Requires: ((emacs "24.1"))

;; This file is NOT part of GNU Emacs
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


;;; Commentary:
;; Simple, fast and minimal mode-line for getting messages and mode-line
;; information in echo area.

;;; Code:
(defgroup xfel-mode-line nil
  "mode line in echo area"
  :group 'convenience
  :prefix "xfel-mode-line")

(defcustom xfel-mode-line-format-function
  'xfel-mode-line-format-default
  "This should be a symbol pointing to a function which produces a string.
That string will be mode line information.
Keep it simple, because this function will be evaluated on 'post-command-hook'."
  :type 'symbol
  :group 'xfel-mode-line)

(defvar xfel-mode-line-orig-format mode-line-format
  "Holds original 'mode-line-format' for disable event.")
(defvar xfel-mode-line-orig-recursive-minibuffers enable-recursive-minibuffers
  "Original value of 'enable-recursive-minibuffers' for disable event.")

(defun xfel-mode-line-format-default ()
  "Default string for XFEL-MODE-LINE."
  (format "%s | %s"
          (format-mode-line "%l %12b")
          (substring-no-properties (format-mode-line mode-line-misc-info))))

(defun xfel-mode-line ()
  "Generate and place message on echo area."
  (when (not mark-active)
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (funcall xfel-mode-line-format-function)))))

(defun xfel-mode-line-enable ()
  "Enable xfel-mode-line."
  (setq enable-recursive-minibuffers nil)
  (setq-default mode-line-format nil)
  (add-hook 'post-command-hook 'xfel-mode-line))

(defun xfel-mode-line-disable ()
  "Disable xfel-mode-line."
  (remove-hook 'post-command-hook 'xfel-mode-line)
  (setq enable-recursive-minibuffers
        xfel-mode-line-orig-recursive-minibuffers
        mode-line-format xfel-mode-line-orig-format)
  (setq-default mode-line-format xfel-mode-line-orig-format)
  (with-current-buffer " *Minibuf-0*"
    (erase-buffer)))


(define-minor-mode xfel-mode-line-mode
  "This mode is for displaying mode-line info at echo area."
  :init-value nil
  :global t
  :lighter " xfel-mode-line"
  (if xfel-mode-line-mode
      (xfel-mode-line-enable)
    (xfel-mode-line-disable)))

(provide 'xfel-mode-line)
;;; xfel-mode-line.el ends here
