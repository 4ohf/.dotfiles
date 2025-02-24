(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(add-to-list 'default-frame-alist '(font . "Cascadia Mono-10"))
(setq custom-file "~/.emacs.custom.el")
(setq column-number-mode t)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("elpa" . "https://elpa.gnu.org/packages/")))
(setq-default display-line-numbers 'relative)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80)
(setq-default display-fill-column-indicator-column 80)
(use-package gruber-darker-theme
  :ensure t
  :config (load-theme 'gruber-darker t))

(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'prog-mode-hook 'display-fill-column-indicator-mode)

(ido-mode 1)
(setq ido-everywhere 1)
(use-package ido-completing-read+
  :ensure t
  :config (ido-ubiquitous-mode 1))
(use-package smex
  :ensure t
  :bind(("M-x" . 'smex)
        ("M-X" . 'smex-major-mode-commands)
        ("C-c C-c M-x" . 'execute-extended-command)))

(global-whitespace-mode 1)
(setq-default whitespace-style
              '(face spaces empty tabs trailing space-mark tab-mark))
(setq-default whitespace-global-modes
              '(not shell-mode
                    help-mode
                    ibuffer-mode
                    dired-mode
                    occur-mode))

(setq org-startup-folded 'showall)
(keymap-global-set "C-c n a" 'org-agenda)
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.3))))
 '(org-level-2 ((t (:inherit outline-1 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-1 :height 1.1)))))
(custom-theme-set-faces
  'user
  '(org-verbatim ((t (:inherit default :foreground "#ffdd33")))))
(mapc (lambda (f) (add-hook 'org-mode-hook f))
      '(turn-on-auto-fill
        org-indent-mode
        display-fill-column-indicator-mode))
(add-hook 'after-init-hook #'(lambda ()
                               (let ((org-agenda-window-setup 'only-window))
                                 (org-agenda nil "n"))))

(use-package company
  :ensure
  :config (global-company-mode))
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . 'mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-alike-this)))

(use-package undo-fu
  :ensure t)
(use-package evil
  :ensure t
  :demand t
  :after undo-fu
  :bind (("<escape>" . keyboard-escape-quit))
  :init (setq evil-want-C-u-scroll t)
        (setq evil-want-keybinding nil)
        (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1))
(use-package evil-collection
  :ensure t
  :after evil
  :config (setq evil-want-integration t)
          (evil-collection-init))
(use-package evil-org
  :ensure t
  :after org
  :after evil
  :hook (org-mode . (lambda () evil-org-mode))
  :config (require 'evil-org-agenda)
          (evil-org-agenda-set-keys))
(use-package evil-surround
  :ensure t
  :config (global-evil-surround-mode 1))

(load-file custom-file)
