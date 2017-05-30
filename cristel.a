********************************
*                              *
* CRISTEL V 1.14  (C) Ch.QUEST *
* --------------    16/10/85   *
*                              *
*  LOGICIEL DE COMMUNICATION   *
*                              *
*   POUR LA CARTE APPLE-TELL   *
*                              *
*    (ET LA CARTE TIME ][)     *
*                              *
********************************
*
*
*
*
*
*
          ORG $8880      ;(A CAUSE DU PLE)
* (SINON ORG $9000)
*
* ADRESSES ROM ET PAGE ZERO UTILISEES
*
SYNTERR   = $DEC9        ;AFFICHE SYNTAX ERROR
LOMEM     = $6D
HIMEM     = $6F
FREE      = $73
PTRVAR    = $83          ;ADRESSE DU PRTGET
FAC       = $9D
SPEED     = $F1
CHRGET    = $B1          ;LECTURE D'UN CHAR DU PRGM
CHRGOT    = $B8          ;RELECTURE DERNIER CARAC
ONERR     = $D8
BUFFER    = $200
AMPER     = $3F5
HORL      = $C0F2        ;$C082+s0
V1ON      = $C059
V1OFF     = $C058
V2ON      = $C05B
V2OFF     = $C05A
V3ON      = $C05D
V3OFF     = $C05C
DOSLEN    = $AA60        ;L$ (BLOAD,BSAVE)
DOSADD    = $AA72        ;A$
CSW       = $AA53        ;ADRESSES DES ROUTINES
KSW       = $AA55        ;NORMAL D'AFFICHAGE (DOS)
COUT      = $FDED        ;AFFICHAGE
BASRUN    = $D566        ;RUN (ROM)
BASERR    = $D412        ;GESTION DES ERREURS
CHKCOM    = $DEBE        ;ATTEND UNE VIRGULE
FINDVAR   = $DFE3        ;RECHERCHE UN VARIABLE
WAITROM   = $FCA8        ;ROUTINE TEMPO (ROM)
HOMEROM   = $FC58        ;HOME (ROM)
PTRGET    = $DFE3        ;RECHERCHE VARIABLE
GARBAGE   = $E484
MOVFM     = $EAF9        ;TRANSFERT FAC>VARIABLE
SETVAR    = $EB27        ; '' ''
FLOAT     = $EB93        ;A => FAC
PRINORM   = $FDF0
NORINPUT  = $FD1B        ;ENTREE NORMALE D'UN CARACT
PRINTROM  = $DAD5        ;PRINT (ROM)
*
* SCRATCHPAD
*
SLOT16    = $6
SLOTCARD  = $7
STACKLVL  = $8
TEMPOL    = $9
TEMPOH    = $18
TEMPO     = $19
TEMP      = $1A          ;STOCKAGE TEMPORAIRE
MINUS     = $1A
TEMP2     = $1B
XCOOR     = $1C
MINUS2    = $1C
YCOOR     = $1D
LEN       = $1E
CARINP    = $FE
LEN2      = $CE
*
* TOKENS UTILISES
*
CLEAR:    = 189
COLOR:    = 160
DRAW:     = 148
END:      = 128
FLASH:    = 159
GET:      = 190
GR:       = 136
HCOLOR:   = 146
HOME:     = 151
POS:      = $D9
INPUT:    = 132
INVERSE:  = 158
NORMAL:   = 157
NOTRACE:  = $9C
PLOT:     = $8D
PRINT:    = 186
READ:     = 135
SCALE:    = 153
STEP:     = 199
TEXT:     = 137
TRACE:    = $9B
VTAB:     = 162
WAIT:     = 181
XDRAW:    = 149
LOAD:     = $B6
DEL:      = $85
IF:       = $AD
ON:       = $B4
*
* COMMANDES ROM
*
INITUART  = 0
MODESLCT  = 1
DTAFORMT  = 2
LINEREL   = 3
VIDEOREL  = 4
SETRTS    = 5
EMITSTAT  = 6
SENDCHAR  = 7
RCVSTAT   = 8
READCHAR  = 9
ASCDIAL   = 10
RINGTEST  = 11
ANSWER    = 12
SMARTCD   = 13
CLEANUP   = 14
BIGBELL   = 15
*
* CODES VIDEOTEX
*
BELL      = $7
BS        = $8
HT        = $9
LF        = $A
VT        = $B
FF        = $C
CR        = $D
SO        = $E
SI        = $F
CSRON     = $11
REP       = $12
SEP       = $13
CSROFF    = $14
SS2       = $16
CAN       = $18
SUB       = $1A
ESC       = $1B
RS        = $1E
US        = $1F
LINE      = $5A
NOLINE    = $59
ENVOI     = $41
RETOUR    = $42
REPETITI  = $43
GUIDE     = $44
ANNULATI  = $45
SOMMAIRE  = $46
CORRECTI  = $47
SUITE     = $48
CONFIN    = $49
*
* CONSTANTES
*
JOUR      = $26
*
* MISE EN PLACE...
*
INIT      LDA #DEBUT
          STA AMPER+1
          LDA #/DEBUT
          STA AMPER+2
          LDA #$4C
          STA AMPER
          LDA #32
          STA CARINP
          LDA #INIT
          STA FREE
          LDA #/INIT
          STA FREE+1
          LDA #0
          STA XCOOR
          BIT V1OFF
          BIT V2OFF
          BIT V3OFF
          RTS
CARSEND   HEX 00
CAREP     HEX 00
NBREP     HEX 00
NORPRINT  HEX 0000
NOPAGE    HEX 00
*
* PRGM
*
DEBUT     PHA
          JSR CHRGET
          PLA
          LDX #CMDADDR-CMDNAME
NEXTCMD   CMP CMDNAME-1,X
          BEQ CMDFOUND
          DEX
          BNE NEXTCMD
          JMP SYNTERR
CMDFOUND  DEX
          TXA
          ASL
          TAX
          LDA CMDADDR+1,X
          PHA
          LDA CMDADDR,X
          PHA
          TSX
          INX
          INX
          STX STACKLVL
          RTS            ;RETOUR PAR LA COMMANDE
CMDNAME   DFB CLEAR:,COLOR:,DRAW:,END:,FLASH:,GET:,GR:
          DFB HCOLOR:,HOME:,POS:,INPUT:,INVERSE:,NORMAL:
          DFB TRACE:,NOTRACE:,PLOT:
          DFB PRINT:,READ:,SCALE:,STEP:,TEXT:,VTAB:,WAIT:,XDRAW:,LOAD:
          DFB DEL:,IF:,ON:
CMDADDR   DA CLEAR-1,COLOR-1,DRAW-1,END-1,FLASH-1,GET-1,GR-1
          DA HCOLOR-1,HOME-1,POS-1,INPUT-1,INVERSE-1,NORMAL-1
          DA TRACE-1,NOTRACE-1,PLOT-1
          DA PRINT-1,READ-1,SCALE-1,STEP-1,TEXT-1,VTAB-1,WAIT-1,XDRAW-1
          DA LOAD-1,DEL-1,IF-1,ON-1
*
* POINT D'ENTREE ROM
*
ROM       JMP $C211
*
* ROUTINE MSGOUT
*
MSGOUT    PLA
          STA TEMP
          PLA
          STA TEMP+1
          LDY #0
MSG2      INC TEMP
          BNE MSG3
          INC TEMP+1
MSG3      LDA (TEMP),Y
          BEQ MSG4
          ORA #$80
          JSR COUT
          JMP MSG2
MSG4      LDA TEMP+1
          PHA
          LDA TEMP
          PHA
          RTS
*
*
*
INTERUPT  PHA
          TXA
          PHA
          TYA
          PHA
          JSR INT
          PLA
          TAY
          PLA
          TAX
          PLA
          INC CHRGOT
          BNE INTRTS
          INC CHRGOT+1
INTRTS    RTS
INT       LDA FINBUF
          SEC
          SBC DEBUTBUF
          CMP #$FF
          BEQ INTRTS
          LDY #RCVSTAT
          JSR ROM
          AND #1
          BEQ INTRTS
          LDY #READCHAR
          BIT V1ON
          JSR ROM
          JSR SCROLLR
          AND #$7F
          PHA
          BIT V1OFF
          PLA
          CMP #CR
          BEQ RESET?
RETINT    JSR STABUF
          INC FINBUF
          BNE INT
*
STABUF    BIT $C089
          BIT $C089
          HEX 8D
FINBUF    HEX 00
          HEX D0
          BIT $C08A
          RTS
*
LDABUF    BIT $C088
          BIT $C088
          HEX AD
DEBUTBUF  HEX 00
          HEX D0
          BIT $C08A
          RTS
*
*

RESET?    LDX KSW
          CPX #NORINPUT
          BEQ RETINT
RESET     JMP $3D0       ;INTDOS !!!
*
*
*
BFRON     LDX #5
LOOPON    LDA BFR1,X
          STA CHRGET,X
          DEX
          BPL LOOPON
          RTS
BFR1      HEX 20
          DA INTERUPT
          HEX EAEAEA
          RTS
*
BFROFF    LDX #5
LOOPOFF   LDA BFR2,X
          STA CHRGET,X
          DEX
          BPL LOOPOFF
          RTS
BFR2      INC CHRGOT
          BNE WAIT2PT
          INC CHRGOT+1
*
*
*
WAIT2PT   LDY #0
          LDA (CHRGOT),Y
          BEQ END2PT
          CMP #':'
END2PT    RTS
*
*
*
SENDESC   STA TEMP
          LDA #ESC
          JSR SEND5
          LDA TEMP
          JMP SEND5
SENDIT    STA CARSEND
          LDA XCOOR
          CMP #$FF
          BEQ SEND1
          JSR PORTEUSE
SEND1     LDA CARSEND
          CMP CAREP
          BEQ REP1
SEND6     LDA NBREP
          BEQ SEND2
          LDA NBREP
          CMP #1
          BEQ SEND4
REPEND    LDA #REP
          JSR SEND3
          LDA NBREP
          CLC
          ADC #$40
          JSR SEND3
          JMP SEND2
REP1      LDA CARSEND
          CMP #$20
          BMI SEND2
          LDA NBREP
          CMP #63
          BEQ REPEND
          INC NBREP
          RTS
SEND4     LDA CAREP
          JSR SEND3
SEND2     LDA #0
          STA NBREP
          LDA CARSEND
          STA CAREP
SEND3     PHA
          JSR SCROLLS
          BIT V2ON
          PLA
          LDY #SENDCHAR
          JSR ROM
          BIT V2OFF
          JMP INT
SEND5     STA CARSEND
          JSR SEND6
          LDA #0
          STA CAREP
          RTS
*
*
*
SCROLLS   PHA
          LDY #0
SCLOOP2   LDA $481,Y
          STA $480,Y
          INY
          CPY #39
          BNE SCLOOP2
          PLA
          JSR CONTROL
          STA $4A7
          RTS
*
*
*
CONTROL   AND #$7F
          CMP #$1F
          BMI CONRTS
          ORA #$80
CONRTS    RTS
*
*
*
PORTEUSE  LDY #RCVSTAT
          JSR ROM
          AND #%00001000
          BEQ LOST
          RTS
*
*
*
READIT    JSR READIT2
          LDX #READIT2-FILTBL-1
READIT3   CMP FILTBL,X
          BEQ READIT
          DEX
          BPL READIT3
          RTS
FILTBL    HEX 1B070300
READIT2   LDA FINBUF
          CMP DEBUTBUF
          BEQ READOLD
          JSR LDABUF
          INC DEBUTBUF
          RTS
READOLD   LDA #0
          STA TEMPOL
          STA TEMPOH
          LDA #-11
          STA SLOT16
WAITCHAR  LDY #RCVSTAT
          JSR ROM
          STA TEMPO
          AND #%00001000
          BEQ LOST
          LDA TEMPO
          AND #%00000001
          BNE RECEIVED
          INC TEMPOL
          BNE WAITCHAR
          INC TEMPOH
          BNE WAITCHAR
          INC SLOT16
          BNE WAITCHAR
LOST      JSR END
          LDX STACKLVL
          TXS
          LDA KSW
          CMP #NORINPUT
          BEQ LOST2
          JMP $C600
LOST2     BIT ONERR
          BMI ERROR
          JMP BASRUN
RECEIVED  BIT V1ON
          LDY #READCHAR
          JSR ROM
          PHA
          BIT V1OFF
          PLA
          JSR SCROLLR
          AND #$7F
          RTS
ERROR     LDA #17
          JMP BASERR
*
*
*
SCROLLR   ORA #$80
          PHA
          LDY #0
SCLOOP    LDA $401,Y
          STA $400,Y
          INY
          CPY #39
          BNE SCLOOP
          PLA
          JSR CONTROL
          STA $427
          RTS
VALEUR    JSR $E6F8
          LDA $A1
          RTS
*
*
*
OUTMEM    LDA #77
          JMP BASERR
*
* PRISE DE MAIN PAR LE MINITEL...
*
ON        JSR VALEUR
          BEQ OFF
          LDA #SAVPRINT
          STA CSW
          LDA #/SAVPRINT
          STA CSW+1
          LDA #ON2
          STA KSW
          LDA #/ON2
          STA KSW+1
          JSR HOME
          JSR CLEAR
          LDA #1
          JSR STEPIN
          LDA #17
          JMP SENDIT
OFF       LDA #PRINORM
          STA CSW
          LDA #/PRINORM
          STA CSW+1
          LDA #NORINPUT
          STA KSW
          LDA #/NORINPUT
          STA KSW+1
          RTS
ONVAR     HEX 0000
ON2       STX ONVAR
          STY ONVAR+1
ONIN      LDA #17
          JSR SEND5
          JSR READIT
          CMP #SEP
          BNE ONRTS
ON3       JSR READIT
          CMP #SEP
          BEQ ON3
          AND #$0F
          TAX
          LDA ONTBL,X
          BMI ON4
ONRTS     LDX ONVAR
          LDY ONVAR+1
          ORA #$80
          RTS
ONTBL     HEX 200D2080201880082020202020202020
ON4       CPX #3
          BNE ON5
          JSR HOME
          JMP ONIN
ON5       JSR READIT
          AND #$1F
          JMP ONRTS
*
* WAIT: INITIALISATION ET ATTENTE
*
WAIT      JSR MSGOUT
          ASC 'ATTENTE'
          HEX 0D00
          BIT V3OFF
          JSR FINDSLOT   ;CHERCHE LA CARTE
          BCS WAIT2      ;TROUVEE ??
          JSR MSGOUT     ;MSG ERREUR
          HEX 0D
          ASC "PAS DE CARTE !"
          HEX 0D00
          JMP SYNTERR
WAIT2     LDA SLOTCARD
          STA ROM+2
          LDA #0
          STA DOSLEN
          STA DOSLEN+1
          STA DOSADD
          STA DOSADD+1
          LDY #INITUART  ;RAZ CARTE
          LDA #$07
          JSR ROM
          LDY #LINEREL
          LDA #0
          JSR ROM        ;RACCROCHE
          BIT $C010
          LDY #BIGBELL
          LDA #0
          JSR ROM        ;WAITS FOR RING
          LDY #LINEREL
          LDA #$FF
          JSR ROM        ;DECROCHE
          BIT V3ON
          LDY #DTAFORMT  ;SETS DATA FORMAT
          LDA #%00100111 ;TO 7 BITS 1 STOP
          JSR ROM        ;EVEN PARITY
          LDY #ANSWER
          JSR ROM        ;CONNEXION TYPE CCITT V23
          LDY #SETRTS
          LDA #1
          JSR ROM        ;SEND CARRIER
          BIT $C010
          LDY #SMARTCD
          LDA #76        ;CHERCHE PORTEUSE
          LDX #170       ;PENDANT 30s
          JSR ROM        ;PORTEUSE: 1,7s
          BNE WAITOK
          JSR MSGOUT
          HEX 0D0D
          ASC "PORTEUSE ?"
          HEX 0D00
          JMP WAIT
WAITOK    JSR CLEAR
          JSR BFRON
          LDA #0
          JSR STEPIN
          JMP HOME       ;CONNEXION OK
*
*
*
CLEAR     LDA #0
          STA FINBUF
          STA DEBUTBUF
          LDY #CLEANUP
          JMP ROM
*
*
*
HOME      LDA #FF        ;EFFACE ECRAN MINITEL
          JSR SENDIT
          LDA #0
          STA TEMP
          JSR POS1
          JSR DEL2
          LDA #RS        ;RETOUR 'HOME'
          JMP SEND5
*
*
*
VTAB      JSR VALEUR
          STA TEMP
POS1      LDA #1
POSMNTL   STA TEMP2
          LDA #US
          JSR SEND5
          LDA TEMP
          CLC
          ADC #$40
          JSR SEND5
          LDA TEMP2
          CLC
          ADC #$40
          JMP SEND5
*
*
*
POS       JSR VALEUR
          STA TEMP
          JSR WAIT2PT
          BEQ POS2
          JSR CHKCOM
          JSR VALEUR
          JMP POSMNTL
POS2      LDA #1
          JMP POSMNTL
*
*
*
*
*
DEL       JSR POS
DEL2      LDA #CAN
          JMP SEND5
*
*
*
LOAD      JSR VALEUR
          STA NOPAGE
          ASL
          ASL
          PHA
          JSR CHKCOM
          JSR BLOAD
          PLA
          TAX
          LDA DOSADD
          STA DOSTABL,X
          INX
          LDA DOSADD+1
          STA DOSTABL,X
          INX
          LDA DOSLEN
          STA DOSTABL,X
          INX
          LDA DOSLEN+1
          STA DOSTABL,X
          RTS
DOSTABL   DS 32
*
*
*
BLOAD     JSR MSGOUT
          HEX 0D04
          ASC 'BLOAD'
          HEX 00
          LDX #1
          JSR BANKSEL
          LDA #14
          JSR PRINTROM
          LDX #2
          JMP BANKSEL
*
*
*
BANKSEL   TXA
          CLC
          ADC #$80
          STA RAM+1
          TAX
          LDY NOPAGE
          CPY #6
          BMI RAM2
          TXA
          CLC
          ADC #8
          STA RAM+1
RAM2      JSR RAM
RAM       LDA $C080
          RTS
*
*
*
FLASH     LDA #'H'
          JMP SENDESC
*
*
*
INVERSE   LDA #']'
          JMP SENDESC
*
*
*
NORMAL    LDA #'I'
          JSR SENDESC
          LDA #'\'
          JMP SENDESC
*
*
*
COLOR     JSR VALEUR
          CLC
          ADC #$40
          JMP SENDESC
*
*
*
HCOLOR    JSR VALEUR
          CLC
          ADC #$50
          JMP SENDESC
*
*
*
TEXT      LDA #SI
          JMP SENDIT
*
*
*
GR        LDA #SO
          JMP SENDIT
*
*
*
READ      LDY #19
READLOOP  LDA TABHORL,Y
          BMI READ2
          JSR READHORL
          STA BUFFER,Y
READNEXT  DEY
          BPL READLOOP
          LDA #JOUR
          JSR READHORL
          AND #$07
          ASL
          TAY
          LDA TABJOUR,Y
          STA BUFFER+9
          LDA TABJOUR+1,Y
          STA BUFFER+10
          LDA #20
          STA LEN2
          LDA #0
          STA TEMP
          JMP CARSEP2
READ2     AND #3
          TAX
          LDA TABCAR,X
          STA BUFFER,Y
          BPL READNEXT   ; JMP READNEXT
READHORL  STA HORL
          LDA HORL
          STA TEMP
          CPY #0
          BNE HORL2
          AND #$3
HORL2     CPY #12
          BNE HORL3
          AND #3
HORL3     CLC
          ADC #$30
          RTS
TABCAR    ASC '- /'
TABHORL   HEX 2524802322802120818181812827822A29822C2B
TABJOUR   ASC 'DILUMAMEJEVESA'
*
*
*
PRINT     LDA #$FF
          STA XCOOR
          JSR WAIT2PT
          BEQ PRINT3
          LDA #0
          STA TEMP
          LDA CSW
          STA NORPRINT
          LDA CSW+1
          STA NORPRINT+1
          LDA #SAVPRINT
          STA CSW
          LDA #/SAVPRINT
          STA CSW+1
          JSR PRINTROM
PRINERR   LDA NORPRINT
          STA CSW
          LDA NORPRINT+1
          STA CSW+1
          LDA #0
          STA XCOOR
          RTS
SAVPRINT  AND #%01111111
          PHA
          JSR PRINTIT
          PLA
          CMP #CR
          BEQ CROUT
          RTS
CROUT     LDA #LF
PRINTIT   STX LEN
          STY TEMP2
          JSR SENDIT
          LDY TEMP2
          LDX LEN
          RTS
PRINT3    LDA #CR
          JSR SENDIT
          LDA #LF
          JMP SENDIT
*
*
*
SCALE     JSR VALEUR
          CLC
          ADC #76
          JMP SENDESC
*
*
*
END       JSR BFROFF
          BIT V3OFF
          BIT V2OFF
          BIT V1OFF
          LDY #LINEREL
          LDA #0
          JMP ROM        ;RACCROCHE
*
*
*
TRACE     LDA #LINE
          JMP SENDESC
*
*
*
NOTRACE   LDA #NOLINE
          JMP SENDESC
*
*
*
PLOT      JSR VALEUR
          JSR SENDIT
          JSR CHKCOM
          LDA #REP
          JSR SENDIT
          JSR VALEUR
          ADC #$3E
          JMP SENDIT
*
*
*
XDRAW     LDA #0
          STA NOPAGE
          JSR BLOAD
          JMP DRAWBIS
*
*
*
INPUT     JSR VALEUR
          STA XCOOR
          JSR CHKCOM
          JSR VALEUR
          STA YCOOR
          JSR CHKCOM
          JSR VALEUR
          STA LEN
          JSR CHKCOM
          JSR POSINP
          LDA CARINP
INPUTIN   JSR SEND5
          LDA LEN
          CMP #1
          BEQ ONLY1
          LDA #REP
          JSR SEND5
          LDA LEN
          CLC
          ADC #$3F
          JSR SEND5
ONLY1     JSR POSINP     ;CURSOR = ON
          LDA #CSRON
          JSR SEND5
          LDA #0
          STA LEN2
WAITCAR   JSR READIT
          STA TEMP
          CMP #SEP
          BEQ CARSEP
          LDA TEMP
          LDX LEN2
          STA $200,X
          LDX LEN2
          CPX LEN
          BEQ FULL
          LDA SLOTCARD
          BPL INPUT1
          LDA TEMP
INPUT1    JSR SEND3
          INC LEN2
          JMP WAITCAR
FULL      LDA #BELL
          JSR SEND5
          JMP WAITCAR
CARSEP    JSR READIT
          STA TEMP
          CMP #CORRECTI
          BEQ CORRECT
          LDA TEMP
          CMP #ANNULATI
          BNE CARSEP3
          JSR POSINP
          LDA CARINP
          JMP INPUTIN
CORRECT   LDA LEN2
          BEQ WAITCAR
          LDA #BS
          JSR SEND5
          LDA CARINP
          JSR SEND5
          LDA #BS
          JSR SEND5
          DEC LEN2
          JMP WAITCAR
CARSEP3   LDA #20
          JSR SEND5
CARSEP2   LDA #0
          STA LEN
          LDA TEMP
          AND #$F
          STA $FF
LOOP2     LDA HIMEM
          SEC
          SBC LOMEM
          SEC
          SBC LEN2
          STA TEMP
          LDA HIMEM+1
          SBC LOMEM+1
          STA TEMP2
          BCS LOOPOK
          LDA LEN
          CMP #1
          BNE LOOP5
          JMP OUTMEM
LOOP5     INC LEN
          JSR GARBAGE
          JMP LOOP2
LOOPOK    LDA HIMEM
          SEC
          SBC LEN2
          STA HIMEM
          LDA HIMEM+1
          SBC #0
          STA HIMEM+1
          JSR PTRGET
          LDY #0
          LDA LEN2
          STA (PTRVAR),Y
          INY
          LDA HIMEM
          STA (PTRVAR),Y
          INY
          LDA HIMEM+1
          STA (PTRVAR),Y
LOOP3     INY
          LDA #0
          STA (PTRVAR),Y
          CPY #4
          BNE LOOP3
          LDY #0
LOOP4     CPY LEN2
          BEQ INPUTEND
          LDA $200,Y
          STA (HIMEM),Y
          INY
          BNE LOOP4
INPUTEND  RTS
POSINP    LDA XCOOR
          STA TEMP
          LDA YCOOR
          JMP POSMNTL
*
*
*
IF        LDA FINBUF
          CMP DEBUTBUF
          BNE GET
          LDY #RCVSTAT
          JSR ROM
          AND #1
          BNE GET
          LDA #0
          STA BUFFER
          BEQ GET3
GET       JSR READIT
          STA BUFFER
          CMP #SEP
          BNE GET3
          JSR READIT
          AND #$F
          STA BUFFER
GET3      LDA #1
          STA LEN2
          LDA #0
          STA TEMP
          JMP CARSEP2
*
*
*
DRAW      JSR WAIT2PT
          BEQ DRAWBIS
          JSR VALEUR
          STA NOPAGE
          ASL
          ASL
          TAX
          LDA DOSTABL,X
          STA DOSADD
          INX
          LDA DOSTABL,X
          STA DOSADD+1
          INX
          LDA DOSTABL,X
          STA DOSLEN
          INX
          LDA DOSTABL,X
          STA DOSLEN+1
DRAWBIS   LDA DOSADD
          STA TEMP
          CLC
          ADC DOSLEN
          STA LEN
          LDA DOSADD+1
          STA TEMP2
          ADC DOSLEN+1
          STA LEN2
DRAW1     LDX #0
          JSR BANKSEL
          LDY #0
          LDA (TEMP),Y
          PHA
          LDX #2
          JSR BANKSEL
          PLA
          JSR SENDIT
          INC TEMP
          BNE DRAW2
          INC TEMP2
DRAW2     LDA TEMP
          CMP LEN
          BNE DRAW1
          LDA TEMP2
          CMP LEN2
          BNE DRAW1
          RTS
*
*
*
STEP      JSR VALEUR
STEPIN    STA TEMP2
          LDA #':'
          JSR SENDESC
          LDA #'j'
          SEC
          SBC TEMP2
          JSR SENDIT
          LDA #'C'
          JMP SENDIT

*
* FINDSLOT DE L'APPLE-TELL
*
POINTL    = TEMP
POINTH    = POINTL+1
                         ;
FINDSLOT  LDA #$C700
          STA POINTL
          LDX #/$C700      ;commencer en slot 7
FIND1     STX POINTH
          LDY #$0B        ;tester l'octet de signature generique
          LDA #$01        ;signature generique des cartes avec firmware
          CMP (POINTL),Y
          BNE FIND3       ;pas bon
          CMP (POINTL),Y
          BNE FIND3       ;pas bon la deuxieme fois...
          INY             ;tester notre signature de peripherique
          LDA #$49        ;signature de l'APPLE-TELL
          CMP (POINTL),Y
          BNE FIND3       ;pas bonne
          CMP (POINTL),Y  ;deuxieme essai...
FIND3     STA $CFFF       ;debrancher la ROM d'extension
          BEQ FIND2       ;on a trouve...
          DEX
          CPX #/$C100      ;en est-on plus loin que le slot 1 ?
          BCS FIND1       ;non, essayer encore
          RTS
FIND2     TXA
          STA SLOTCARD
          ASL
          ASL
          ASL
          ASL
          STA SLOT16
          SEC
          RTS             ;carte trouvee, retour avec C=1
