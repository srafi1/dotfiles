
(require 'package) ;; You might already have this line
 (add-to-list 'package-archives
              '("melpa" . "https://melpa.org/packages/"))
 (when (< emacs-major-version 24)
For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

(autoload 'auto "auto-complete-mode" "Autmatically loads auto-complete-mode" t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (darcula)))
 '(custom-safe-themes (quote ("fad38808e844f1423c68a1888db75adf6586390f5295a03823fa1f4959046f81" "eb0a314ac9f75a2bf6ed53563b5d28b563eeba938f8433f6d1db781a47da1366" "938d8c186c4cb9ec4a8d8bc159285e0d0f07bad46edf20aa469a89d0d2a586ea" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "d606ac41cdd7054841941455c0151c54f8bff7e4e050255dbd4ae4d60ab640c1" default)))
 '(inhibit-startup-screen t)
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(progn
	 (goto-char (region-beginning))
	 (setq beg (line-beginning-position))
	 (goto-char (region-end))
	 (setq end (line-end-position)))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(yas-global-mode 1)
(setq show-paren-delay 0)
(show-paren-mode 1)
(global-linum-mode t)
(global-hl-line-mode t)
(global-auto-complete-mode 1)
(delete-selection-mode 1)

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-c C-c") 'kill-ring-save)
(global-set-key (kbd "C-x C-x") 'kill-region)
(global-set-key (kbd "C-v") 'yank)
(global-set-key (kbd "C-y") 'kill-whole-line)
(global-set-key (kbd "M-f") 'find-file)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "C-x C-a") 'mark-whole-buffer)
(global-set-key (kbd "C-j") 'goto-line)
