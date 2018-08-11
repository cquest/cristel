******************************
*                            *
* 'BIOS' POUR LA CARTE A-TEL *
*                            *
*  DATE : 9/4/86             *
*                            *
******************************
*
* COMMANDES DE LA ROM APPLE-TELL
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
* INITIALISATION MODEM
*
INITMDM   JSR FINDSLOT
          BCS WAIT2
          JSR MSGOUT
          HEX 0D
          ASC "PAS DE CARTE !"
          HEX 0D00
          JMP SYNTERR
WAIT2     LDA SLOTCARD
          STA ROM+2
          LDY #INITUART
          LDA #7
          JSR ROM
          LDY #LINEREL
          LDA #0
          JMP ROM
          DO EXPO
*
* CONNEXION SPECIALE POUR EXPOSITIONS
*
CONNECT   JSR RACCROCH
          LDY #5
LOOP      LDA #$FF
          JSR WAITROM
          DEY
          BNE LOOP
          ELSE
*
* CONNEXION AVEC LE MINITEL
*
CONNECT   JSR RACCROCH
          BIT $C010
          LDY #BIGBELL
          LDA #0
          JSR ROM
          FIN
          LDY #LINEREL
          LDA #$FF
          JSR ROM
          LDY #DTAFORMT
          LDA #%00100111
          JSR ROM
          LDY #ANSWER
          JSR ROM
          LDY #SETRTS
          LDA #1
          JSR ROM
          BIT $C010
LOOPORT   LDY #SMARTCD
          LDA #76
          LDX #170
          JSR ROM
          DO EXPO
          BEQ LOOPORT
          ELSE
          BEQ CONNECT
          FIN
          RTS
*
* CHERCHE LA CARTE APPLE-TELL
*
POINTL    = TEMP
POINTH    = TEMP+1
FINDSLOT  LDA #$C700
          STA TEMP
          LDX #/$C700
FIND1     STX POINTH
          LDY #$0B
          LDA #1
          CMP (POINTL),Y
          BNE FIND3
          CMP (POINTL),Y
          BNE FIND3
          INY
          LDA #$49
          CMP (POINTL),Y
          BNE FIND3
          CMP (POINTL),Y
FIND3     STA $CFFF
          BEQ FIND2
          DEX
          CPX #/$C100
          BCS FIND1
          RTS
FIND2     TXA
          STA SLOTCARD
          ASL
          ASL
          ASL
          ASL
          STA SLOT16
          SEC
          RTS
*
* POINT D'ENTREE ROM
*
ROM       JMP $C211
          DO BUFSEND
*
* PEUT-ON ENVOYER UN CARACTERE ?
*
SENDCLEA  LDY #EMITSTAT
          JMP ROM
          FIN
*
* ENVOI D'UN CARACTERE
*
ENVOICAR  LDY #SENDCHAR
          JMP ROM
*
* TEST PORTEUSE PRESENTE
* SI ABSENTE -> LOST
*
PORTEUSE  LDY #RCVSTAT
          JSR ROM
          AND #8
          BEQ LOSTBIS
          RTS
LOSTBIS   JMP LOST
*
* TEST SI CARACTERE RECU...
* NE SI CARACTERE RECU
*
CARECU    LDY #RCVSTAT
          JSR ROM
          AND #1
          RTS
*
* RECOIT UN CARACTERE DANS L'ACCUM.
*
RECOICAR  LDY #READCHAR
          AND #$7F
          JMP ROM
*
* RACCROCHE
*
RACCROCH  LDY #LINEREL
          LDA #0
          JMP ROM
*
* EFFACE LE BUFFER DE RECEPTION DU MODEM
*
CLEARCV   LDY #CLEANUP
          JMP ROM
********************************
* FIN DU BIOS 'APPLE-TELL'     *
********************************
