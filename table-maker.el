(require 'cl)

(defun make-tables ()
  (interactive)
  (progn
    (write-file (concat (substring (buffer-name) 0 -3) ".html"))
    (beginning-of-buffer)
    (look-for-table)
    (save-buffer)))

(defun look-for-table ()
  (loop
   (if (eobp) (return t))
   (if (eq (char-after 1) ?\\)
       (if (equal "table-start" (current-word))
           (make-this-table)))
   (forward-line)))

(defun make-this-table ()
  (make-table-start)
  (forward-line)
  (loop
   (ecase (get-first-word)
     (left-cell (make-left-cell))
     (right-cell (make-right-cell))
     (h1 (make-h1-tag) (make-full-width-cell))
     (table-end (make-table-end) (return t))
     (no-word (make-full-width-cell)))
   (beginning-of-line)
   (insert
    (replace-regexp-in-string "\\\\n" "</br>" (thing-at-point 'line)))
   (kill-line 1)))

(defun get-first-word ()
  (cond
   ((and (eq (char-after (point)) ?\<) (eq (char-after (+ (point) 1)) ?\<))
    'left-cell)
   ((and (eq (char-after (point)) ?\>) (eq (char-after (+ (point) 1)) ?\>))
    'right-cell)
   ((eq (char-after (point)) ?\\)
    (cond
     ((equal "h1" (current-word))
      'h1)
     ((equal "table-end" (current-word))
      'table-end)
     (t
      'no-word)))
   (t
    'no-word)))

(defun make-table-start () (kill-line) (insert "<table style=\"border-spacing:5px\"><tbody>"))

(defun make-table-end () (kill-line) (insert "</tbody></table>"))

(defun make-h1-tag () (delete-char 4) (insert "<h1>") (end-of-line) (insert "</h1>") (beginning-of-line))

(defun make-left-cell ()
  (delete-char 2)
  (insert (concat
           "<tr><td><image style=\"width:450px\" src=\"" ;; test width                                                                           
           (substring (buffer-name) 0 -5) ;; try this. maybe change                                                                              
           "/"))
  (end-of-line)
  (insert "\"></td>"))

(defun make-right-cell () (delete-char 2) (insert "<td>") (end-of-line) (insert "</td></tr>"))

(defun make-full-width-cell () (insert "<tr><td>") (end-of-line) (insert "</td></tr>"))
