;;;; -*-coding: utf-8;-*-

(in-package :grieg)

(define-flexible-questionnaire "demo-0-no"
  :title "Demografiske spørsmål"
  :localization :no
  :genderized nil
  :next "FORTSETT"
  :back "TILBAKE"
  :items
  `((:sc "Hvor bekymret er du for klimaendringer?"
     :opt ("Ikke bekymret i det hele tatt"
           "Ikke særlig bekymret"
           "Litt bekymret"
           "Veldig bekymret"
           "Ekstremt bekymret"))
    (:sc "Oppgi ditt kjønn."
     :opt ("Kvinne"
           "Mann"
           ("Annet" :subq ((:te "Vennligst oppgi:")))))
    (:te "Hvilket år er du født?"
     :verifier ,(in-interval-checker 1900 2022 :message "Verdien må være mellom ~a og ~a."))
    (:te "Oppgi hvilket land du bor i nå."
     :helptext "Spørsmålet gjelder fast bosted, ikke midlertidig
     oppholdssted (f.eks. i forbindelse med ferie eller
     tjenestereise)."
     :completions ,*countries-no*)
    (:te "Hvilket språk benytter du oftest? Oppgi det første og
    hyppigst brukte språket:"
     :completions ,*languages-no*)
    (:te "Bruker du mer enn ett språk? Oppgi i så fall det andre
    språket som du bruker hyppigst:"
     :helptext "Valgfritt spørsmål."
     :optional t
     :completions ,*languages-no*)
    (:sc "Hvilken betegnelse passer best på området du bor i?"
     :opt ("En storby"
           "En forstad eller utkanten av en storby"
           "En liten eller mellomstor by"
           "Et bygdesentrum"
           "Et spredtbygd strøk"))
    (:sc "Hva er det høyeste utdanningsnivået du har bestått?"
     :opt ("Grunnskole"
           "Videregående skole"
           "Fagopplæring"
           "Universitets- eller høyskolegrad"
           ("Annet" :subq ((:te "Vennligst oppgi:")))))
    (:sc "Har du politiske synspunkter?"
     :opt ("Nei"
           ("Ja" :subq ((:sc "I politikken brukes iblant ordene
           “venstresiden” og “høyresiden”.  Kan du karakterisere dine
           politiske synspunkter ved hjelp av disse begrepene?"
                          :opt ("Nei"
                                ("Ja" :id "yes"))
                          :id "p2"))
                  :id "yes"))
     :id "p1")
    (:scale "Vennligst oppgi dine politiske synspunkter."
     :helptext "Merk av hvor du vil plassere deg på skalaen under, der
     0 betyr venstresiden, og 10 høyresiden.  Bruk de andre tallene
     for å angi hvor du befinner deg mellom de to ytterpunktene."
     :visible-if (:and (:selected "p1" "yes") (:selected "p2" "yes"))
     :ends (0 10)
     :descriptions ("Venstresiden" "Høyresiden"))
    (:sc "Hvilken av beskrivelsene nedenfor passer best med hvordan du
    opplever husholdningens inntekt for tiden?"
     :opt ("Har det bra med nåværende inntekt"
           "Klarer meg/oss med nåværende inntekt"
           "Det er vanskelig å klare seg på nåværende inntekt"
           "Det er svært vanskelig å klare seg på nåværende inntekt"))))
