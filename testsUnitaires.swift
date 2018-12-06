import Foundation


// Fonctions pour verifier les fonctions du tableDeJeuProtocol :

func verifSearchPiecePosition() -> Int {
    var ret  : Int = 0
    var tdj = tableDeJeu()

    // Premier cas  : 
    if let piece = tdj.searchPiecePosition(coordX : -1 , coordY : 5){
        print("[searchPiecePosition] Mal definie pour parametres <1 ou >4.")
        ret = ret + 1;
    }
    else {
        print("[searchPiecePosition] Bien definie pour parametres <1 ou >4.")
    }

    // Deuxieme cas  :
    if let piece = tdj.searchPiecePosition(coordX :1, coordY :2){
        print("[searchPiecePosition] mal definie pour cases vides.")
        ret = ret + 1
    }
    else {
        print("[searchPiecePosition] bien definie pour cases vides.")
    }

    // Troisieme cas  : 
    if let piece = tdj.searchPiecePosition(coordX :2, coordY :2){
        if(piece.nom == "kodama" ){
            print("[searchPiecePosition] trouve correctement les pieces.")
        }
        else {
            print("[searchPiecePosition] ne trouve pas correctement les pieces.")
            ret = ret + 1
        }
    }

    return ret
}

func verifSearchPieceNJ() -> Int{
    var ret  : Int = 0;
    var tdj = tableDeJeu();

    // Premier cas  : 
    if let piece = tdj.searchPieceNJ(nom : "" , nbJoueur : 1 ){
        print("[searchPieceNJ] mal definie pour nom vide.")
        ret = ret + 1;
    }
    else {
        print("[searchPieceNJ] bien definie pour nom vide.")
    }

    // Deuxieme cas  :
    if let piece = tdj.searchPieceNJ(nom :"kitsune", nbJoueur : 9999){
        print("[searchPieceNJ] mal definie pour nombre joueur invalide.")
        ret = ret + 1
    }
    else {
        print("[searchPieceNJ] bien definie pour nombre joueur invalide.")
    }
    
    // Troisieme cas  : 
    if let piece = tdj.searchPieceNJ(nom :"kitsunette", nbJoueur : 1){
        print("[searchPieceNJ] mal definie pour nom piece invalide.")
        ret = ret + 1
    }
    else {
        print("[searchPieceNJ] bien definie pour nom piece invalide.")
    }

    // Quatrieme et cinquieme cas  : 
    if let piece = tdj.searchPieceNJ(nom :"kitsune", nbJoueur : 1){
        if(piece.coordX == 3  && piece.coordY == 1) {
            print("[searchPieceNJ] bien definie pour donnes valides")
        }
        else {
            print("[searchPieceNJ] mal definie pour donnes valides  : il ne renvoie pas la bonne piece.")
            ret = ret + 1
        }    
    }
    else {
        print("[searchPieceNJ] mal definie pour donnes valides : il renvoie Vide.")
        ret = ret + 1
    }
    return ret
}

func verifPositionsPossibles() -> Int {

    var ret  : Int = 0
    var tdj  = TableDeJeu()
    var pc = tdj.searchPiecePosition(coordX : 1, coordY : 1) // tanuki de j1
    var cpp = tdj.positionsPossibles(piece : pc)

    if (cpp.countPositions() == 0) {
        print("[positionsPossibles] Il y a des positions que vous n’avez pas trouve.")
    }

    for position in cpp {
        let (x , y) = position
        if( x == 1 && y == 2){
            print("[positionsPossibles] Vous avez bien trouve une position possible.")
        }
        else if(x == 2 && y == 1) {
                print("[positionsPossibles] Il y a deja une piece de vous la-bas.")
                ret = ret + 1
            } 
            else {
                print("[positionsPossibles] Vous n’avez pas respecte les regles de jeu, votre pièce ne peux pas se deplacer la, meme si la cas est vide.")
                ret = ret + 1
            }
    }
    return ret
}

func verifValiderDeplacement() -> Int {
    var ret  : Int = 0
    var tdj = TableDeJeu()
    var pc = tdj.searchPiecePosition(coordX : 1, coordY : 1) // tanuki de j1
    
    // Premier cas  : la case ou on veut deplacer n’est pas vide
    var x = tdj.validerAction(piece :pc, coordX :2, coordY :1)
    if(x == true){
        print("[validerDeplacement] On ne peux pas deplacer sur une autre piece amie. Mal defini.")
        ret = ret + 1
    }
    else {
        print("[validerDeplacement] Bien definie pour les cases deja occupees de nous.")
    }

    // Deuxieme cas  : la case est vide, mais pas touchable
    x = tdj.validerAction(piece : pc, coordX : 1, coordY : 3)
    if(x==true){
        print("[validerDeplacement] On ne peux pas deplacer sur les cases vides, mais pas touchables! Mal defini.")
        ret = ret + 1
    }
    else {
        print("[validerDeplacement] Bien definie pour les cases vides et pas touchables.")
    }

    // troisieme cas  : la case est vide et touchable
    x = tdj.validerAction(piece :pc, coordX :1, coordY :2)
    if(x==false){
        print("[validerDeplacement] On peux deplacer sur les cases touchables et vides! Mal defini.")
        ret = ret + 1
    }
    else {
        print("[validerDeplacement] Bien definie pour les cases touchables et vides.")
    }

    // quatrieeme  : positions invalides
    x = tdj.validerAction(piece :pc, coordX :2, coordY :7)
    if(x == true){
        print("[validerDeplacement] Mal defini pour positions invalides.")
        ret = ret + 1
    }
    else {
        print("[validerDeplacement] Bien definie pour positions invalides.")
    }
 
    return ret       
}

func verifDeplacerPiece() -> Int {
    // mutating func deplacerPiece(piece : Piece, xApres  : Int, yApres  : Int)
    var ret  : Int = 0
    var tdj = TableDeJeu()
    var pc = tdj.searchPiecePosition(coordX  : 1,coordY  : 1) // tanuki de j1

    var tdj2 = tdj.deplacerPiece(piece : pc, xApres : 1 , yApres : 2)
    var tdj3 = tdj.deplacerPiece(piece : pc, xApres : 2 , yApres : 1)

    if(tdj2 == tdj){
        print("Mal defini pour deplacements valides")
        ret = ret + 1
    }

    if(tdj3 != tdj){
        print("Mal defini pour deplacements invalides")
        ret = ret + 1
    }

    return ret
}

func verifValiderCapture() -> Int {
    var ret  : Int = 0
    var tdj = TableDeJeu()
    var pc = tdj.searchPiecePosition(coordX : 1, coordY : 1) // tanuki de j1
    
    // Premier cas  : la case qu'on veut capturer est une de nos cases
    var x = tdj.validerCapture(piece :pc, coordX :2, coordY :1)
    if(x == true){
        print("[validerCapture] On ne peux pas capturer une autre piece amie. Mal definie.")
        ret = ret + 1
    }
    else {
        print("[validerCapture] Bien definie pour les cases occupees de nous.")
    }

    // Deuxieme cas  : la case est de l'autre, mais pas touchable
    x = tdj.validerAction(piece : pc, coordX : 1, coordY : 4)
    if(x == true){
        print("[validerCapture] On ne peux pas capturer sur les cases ennemies, mais pas touchables. Mal definie.")
        ret = ret + 1
    }
    else {
        print("[validerCapture] Bien definie pour les cases ennemies et pas touchables.")
    }

    // troisieme cas  : la case est ennemie et touchable
    pc = tdj.searchPiecePosition(coordX : 2, coordY : 2) // kodama de j1
    x = tdj.validerAction(piece : pc, coordX : 2, coordY : 3)
    if(x == false){
        print("[validerCapture] On peux attaquer les cases touchables et ennemies! Mal defini.")
        ret = ret + 1
    }
    else {
        print("[validerCapture] Bien definie pour les cases touchables et ennemies.")
    }

    // quatrieeme  : positions invalides
    x = tdj.validerAction(piece :pc, coordX :2, coordY :7)
    if(x == true){
        print("[validerCapture] Mal defini pour positions invalides.")
        ret = ret + 1
    }
    else {
        print("[validerCapture] Bien definie pour positions invalides.")
    }
 
    return ret       
}

func verifGagnerPartie() -> Int {
    var ret  : Int = 0
    var tdj = TableDeJeu()

    // en debut de partie, on a pas de gagnant
    if (tdj.gagnerPartie(joueur  : tdj.joueur1) || tdj.gagnerPartie(joueur  : tdj.joueur2)){
        print("[gagnerPartie] En debut de partie il n’y a pas de gagnant, gagnerPartie mal definie.")
        ret = ret + 1
    }
    else{
        print("[gagnerPartie] En debut de partie il n’y a pas de gagnant, gagnerPartie bien definie.")   
    }

    return ret

}

func verifTransformerKodama() -> Int {
    var ret  : Int = 0
    var tdj = TableDeJeu()

    var pc = tdj.searchPiecePosition(coordX : 1, coordY : 1)
    do{
        try tdj.trasformerKodama(pc)
        print("[transformerKodama] On ne peux pas transformer une piece qui n'est pas un kodama. Mal definie.")
        ret = ret + 1
    }
    catch{
        print("[transformerKodama] On ne peux pas transformer une piece qui n'est pas un kodama. Bien definie.")
    }

    pc = tdj.searchPiecePosition(coordX : 2, coordY : 2)
    do{
        try tdj.trasformerKodama(pc)
        print("[transformerKodama] On ne peux pas transformer une kodama qui n'est pas dans la zone de promotion. Mal definie.")
        ret = ret + 1
    }
    catch{
        print("[transformerKodama] On ne peux pas transformer une kodama qui n'est pas dans la zone de promotion. Bien definie.")
    }
    return ret
}

func verifParachuter() -> Int {

    var ret  : Int = 0
    var tdj = TableDeJeu()
    var pc : Piece = tdj.searchPieceNJ(nom: "kodama", nbJoueur : 1)

    // maintenant il n’y a rien dans la réserve, c'est l'etat initiel
    do{
        try tdj.parachuter(nomPiece: "kodama", tdj.joueur1, neufX : 1, neufY : 2)
        print("[parachuter] On ne peut pas parachuter un element sans qu’il ne soit dans la reserve, meme si la case est vide.")
        ret = ret + 1
    }
    catch{
        print("[parachuter] Bien definie pour pieces non existant dans la reserve.")
    }

    

    tdj = tdj.attaquerPiece(pieceAttaquante : pc, xApres : 2, yApres : 3)
    var pc2 : Piece = tdj.searchPieceNJR("kodama", nbJoueur : 1, estEnReserve : true)

    do{
    	try tdj.parachuter(nomPiece: "kodama", joueur : tdj.joueur1, neufX : 1, neufY : 2)
    	print("[parachuter] Bien definie pour pieces existant dans la reserve et mises sur cases vides.")
    }
    catch{
    	print("[parachuter] Mal definie pour pieces existant dans la reserve et mises sur cases vides.")
    	ret = ret + 1
    }

    do{
    	try tdj.parachuter(nomPiece: "kodama", joueur : tdj.joueur1, neufX : 3, neufY : 1)
    	print("[parachuter] Mal definie pour pieces existant dans la reserve et mises sur cases non vides.")
    	ret = ret + 1
    }
    catch{
    	print("[parachuter] Bien definie pour pieces existant dans la reserve et mises sur cases vides.")
    }

    return ret

}

func verifEstEnPromotion() -> Int {

    var ret  : Int = 0
    var tdj = TableDeJeu()
    var pc : Piece = tdj.searchPiecePosition(coordX : 1 , coordY : 1)

    if(tdj.estEnPromotion(pc)){
        print("[estEnPromotion] Mal definie.")
        ret = ret + 1
    }
    else{
        print("[estEnPromotion] Bien definie.")
    }

    return ret

}

// Main
var resFinal : Int = 0
resFinal += verifSearchPiecePosition()
resFinal += verifSearchPieceNJ()
resFinal += verifPositionsPossibles()
resFinal += verifValiderActions()
resFinal += verifDeplacerPiece()
resFinal += verifAttaquerPiece()
resFinal += verifGagnerPartie()
resFinal += verifTransformerKodama()
resFinal += verifParachuter()
resFinal += verifEstEnPromotion()

if resFinal == 0 {
    print("Tous les tests sont passes !")
} else{
    print("Quelques tests echoues. Regardez au-dessus pour details.")
}
