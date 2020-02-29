(define-module (cgo)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix download))

(define-public cgo
  (package
    (name "cgo")
    (version "0.6.0")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/kieselsteini/cgo/archive/v" version
                ".tar.gz"))
              (sha256
               (base32
                "0xzn6xz0h3s1c8mnnn2mjd5px0j0l60v4d225dd0p7vn27whmpi5"))))
    (build-system gnu-build-system)
    (arguments
         '(#:phases (modify-phases %standard-phases (delete 'configure))
          #:tests? #f
          #:make-flags (list "CC=gcc" (string-append "PREFIX=" %output))))
    (home-page "https://github.com/kieselsteini/cgo/")
    (synopsis "Terminal based gopher client")
    (description "cgo is a UNIX/Linux terminal based gopher client.
It has no other dependencies than libc and some syscalls.
It should run on every VT100 compatible terminal.
To show media like images, music or webpages
it relies on external programs you can specify.")
    (license license:isc)))
