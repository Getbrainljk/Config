(load-file "/root/tmp_config/.emacs.d/.emacs-plugin/std_comment.el")
(load-file "/root/tmp_config/.emacs.d/linum+.el")
(load-file "/root/tmp_config/.emacs.d/.emacs-plugin/php-mode.el")
(load-file "/root/tmp_config/.emacs.d/.emacs-plugin/file-history.el")
(load-file "/root/tmp_config/.emacs.d/highlight-current-line.el")
(add-to-list 'load-path "/root/tmp_config/.emacs.d/")
(add-to-list 'load-path "/root/tmp_config/.emacs.d/.emacs-plugin/")
(add-to-list 'load-path "/root/tmp_config/.emacs.d/color-theme/")

(add-to-list 'custom-theme-load-path "/root/tmp_config/.emacs.d/themes")

;; tuareg
(load-file "/root/tmp_config/.emacs.d/tuareg.el")
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
		("\\.topml$" . tuareg-mode))
	      auto-mode-alist))

; AUCTeX plugins
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; coloration
;; (require 'color-theme-autoload "color-theme-autoloads")
(require 'color-theme)
(color-theme-initialize)
(color-theme-midnight)

;; Set transparency of emacs
(defun on-after-init ()
(unless (display-graphic-p (selected-frame))
  (set-face-background 'default "unspecified-bg" (selected-frame))))

(add-hook 'window-setup-hook 'on-after-init)

;; autocompletion
(require 'auto-complete-config)
(line-number-mode 1)
(column-number-mode 1)
(add-to-list 'ac-dictionary-directories "/root/tmp_config/.emacs.d//ac-dict")
(ac-config-default)

(require 'linum+)
(global-linum-mode 1)

; Supprime tous les espaces en fin de ligne
(autoload 'nuke-trailing-whitespace "whitespace" nil t)

;; Suppression des espaces en fin de ligne a l'enregistrement
(add-hook 'c++-mode-hook '(lambda ()
(add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))
(add-hook   'c-mode-hook '(lambda ()
(add-hook 'write-contents-hooks 'delete-trailing-whitespace nil t)))

;colorise espace
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)

;parentheses
(require 'paren)
(show-paren-mode)

;voir espace
(transient-mark-mode t)
(global-font-lock-mode t)

(require 'highlight-current-line)
(highlight-current-line-on t)
(set-face-background 'highlight-current-line-face "#111")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" default)))
 '(delete-selection-mode nil)
 '(inhibit-startup-screen t)
 '(mark-even-if-inactive t)
 '(scroll-bar-mode (quote right))
 '(transient-mark-mode 1))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ctags
(setq path-to-ctags "/usr/bin/ctags.emacs")
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "%s -f %s/TAGS -e -R %s" path-to-ctags dir-name (directory-file-name dir-name)))
  )
(put 'scroll-left 'disabled nil)
(put 'downcase-region 'disabled nil)
(global-font-lock-mode 1)

;; Vire les menus les outils et les barres de défilement
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; empèche la troncation des lignes trop longues
(setq truncate-partial-width-windows nil)

;; combinaison de touche
; compilation
(global-set-key (kbd "C-c c") 'compile )
(global-set-key (kbd "C-c r") 'recompile )
(global-set-key (kbd "C-c k") 'kill-compilation )
(global-set-key (kbd "C-c g") 'gdb )

;; Selection avec shift pour screen
;;(define-key input-decode-map "\e[1;2D" [S-left])
;;(define-key input-decode-map "\e[1;2C" [S-right])
;;(define-key input-decode-map "\e[1;2B" [S-down])
;;(define-key input-decode-map "\e[1;2A" [S-up])
;;(define-key input-decode-map "\e[1;2F" [S-end])
;;(define-key input-decode-map "\e[1;2H" [S-home])

;; file history 
;; (require 'file-history)
;; (global-set-key (kbd "C-t") 'file-history)

;; c++ mode in .h
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; auto insert header guards

 (global-set-key [f12]

		 '(lambda ()
		    (interactive)
		    (if (buffer-file-name)
			(let*
			    ((fName (upcase (file-name-nondirectory (file-name-sans-extension buffer-file-name))))
			     
			     (ifDef (concat "#ifndef\t\t" fName "_H" "\n# define\t" fName "_H" "\n"))
			     (begin (point-marker))
			     )
			  (progn
					; If less then 5 characters are in the buffer, insert the class definition
			    (insert ifDef)
			    ;;(if (< (- (point-max) (point-min)) 5 )
			    (progn
			      (insert "\n/*\n** Class\n*/\n\nclass " (capitalize fName) "\n{\npublic:\n\n  //ctor & dtor\n  " (capitalize fName) "();\n  ~" (capitalize fName) "();\n\nprivate:\n\n};\n")
			      (goto-char (point-min))
			      ;;(next-line-nomark 3)
			      (setq begin (point-marker))
			      )
			    (goto-char (point-max))
			    (insert "\n#endif" "      /* !" fName "_H_ */")
			    (goto-char begin))
			  )
					;else
		      (message (concat "Buffer " (buffer-name) " must have a filename"))
		      )
		    )
		 )
