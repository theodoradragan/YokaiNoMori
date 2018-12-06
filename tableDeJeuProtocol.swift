import Foundation 

// tableDeJeu est une collection de Pieces

protocol tableDeJeuProtocol : Sequence {

	// l'iterateur associe
	associatedtype CollectionPiecesIterateur : IteratorProtocol where CollectionPiecesIterateur.Element == Piece 

	var joueur1 : Joueur {get}
	var joueur2 : Joueur {get}

	// init : -> tableDeJeu
	// creation d’une table de jeu: on initialise la table de jeu, les 2 joueurs et apres, les pieces
	init()

	// searchPiecePosition : Int x Int -> (Piece | Vide)
	// fonction pour chercer une pièce selon sa position
	// Pre : le touple correspond a un pair des (coordX, coordY) detenues par une pièce
	// Post : la piece cherche si la precondition est respectee, sinon retourne Vide
	func searchPiece(coordX : Int, coordY : Int) -> Piece?

	// searchPieceNJ : String x Int -> (Piece | Vide)
	// fonction pour chercer une pièce selon son nom et son joueur
	// Pre : le String est non vide et corresponde a un nom valide de pièce
	// Pre : le nombre de Joueur existe parmi les joueurs
	// Post : la Pièce cherche si la precondition est respectee, sinon retourne Vide
	// ON GARDE CA ???
	func searchPieceNJ(nom : String, nbJoueur : Int) -> Piece?

	// searchPieceNJR : String x Int x Boolean -> (Piece | Vide)
	// fonction pour chercer une pièce selon son nom et son joueur, dans la table (Boolean False) ou dans la reserve (Boolean True)
	// Pre : le String est non vide et corresponde a un nom valide de pièce
	// Pre : le nombre de Joueur existe parmi les joueurs
	// Post : la Pièce cherche si la precondition est respectee, sinon retourne Vide
	func searchPieceNJR(nom : String, nbJoueur : Int, estEnReserve : Bool) -> Piece?


	// positionsPossibles : tableDeJeu x Piece -> CollectionPositions
	// evaluation des toutes les futurs positions disponibles pour une pièce
	func positionsPossibles(Piece: Piece) -> CollectionPositions 

	// validerDeplacement : tableDeJeu x Piece x Int x Int -> Bool
	// verifie qu'une Piece a bien le droit d'aller à l'emplacement indique
	// Pre : aucune 
	// Post : renvoie True si le deplacement respecte les regles du jeu, et False sinon 
	func validerDeplacement(Piece : Piece, neufX : Int, neufY : Int) -> Bool

	// validerCapture : tableDeJeu x Piece x Int x Int -> Bool
	// verifie qu'une Piece a bien le droit d'attaquer à l'emplacement indique
	// Pre: sur (neufX, neufY) il y a une piece ennemi
	// Post : renvoie True si le capturement respecte les regles du jeu, et False sinon 
	func validerCapture(Piece : Piece, neufX : Int, neufY : Int) -> Bool

	// deplacerPiece : tableDeJeu x Piece x Int x Int -> tableDeJeu
	// deplace une Piece d'une position à une autre 
	// Pre : le deplacement est valide, conforme au validerDeplacement
	// Post : si les preconditions sont satisfaites, la position de depart est vide, 
	//		la Piece est à la position voulue. Sinon, l’etat de la table de jeu reste le meme.
	@discardableResult
	mutating func deplacerPiece(Piece: Piece, xApres : Int, yApres : Int) -> Self

	// attaquerPiece : tableDeJeu x Piece x Piece -> tableDeJeu
	// attaquer une pièce de l’autre joueur (donnee par le deuxieme parametre) avec une Piece de le joueur courant
	// Pre : la capture est valide, conforme au validerDeplacement
	// Post : si les preconditions sont satisfaites, les deux Pieces changent leurs positions 
	//	et la pièce attaquee est dans la reserve de le joueur attaquant . Sinon, l’etat de la table de jeu reste le meme.
	@discardableResult
	mutating func attaquerPiece(pieceAttaquante : Piece, xApres : Int, yApres : Int) -> Self

	// transformerKodama : tableDeJeu x Piece
	// transforme un "kodama" en "kodama samourai" ou la chose inverse
	// Pre : la Piece est un kodama et se trouve dans la zone de promotion 
	//        ou c'est un kodama samurai qui est capture
	// Post : la nouvelle Piece est au même emplacement mais est un kodama samourai
	//        ou c'est un kodama dans la reserve de l'attaquant
	@discardableResult
	mutating func transformerKodama(piece : Piece) throws -> Self

    // mettreEnReserve : tableDeJeu x Piece -> tableDeJeu
    // met un pion en reserve en changeant son joueur d'origine 
    // Pre : la pièce est sur la table de jeu (contre-exemple : etre deja en reserve)
    // Post : la Piece est en reserve et son joueur est changé
	@discardableResult
	mutating func mettreEnReserve(piece : Piece) -> Self

	// parachuter : tableDeJeu x String x Joueur x Int x Int -> tableDeJeu
    // parachute un pion, qui est identifie par son nom, de la reserve du joueur Joueur sur la table de jeu;
    //           la position voulue est donnee par les troisieme et quatrieme parametres
    // Pre : la pièce est en reserve du joueur qui veut parachuter une Piece
    // Pre : la pneuf case est libre avant parachuter
    // Post : si les preconditions sont respectees, l’etat de la pièce est change
	@discardableResult
	mutating func parachuter(nomPiece: String, joueur : Joueur, neufX : Int, neufY : Int) throws -> Self

	// gagnerPartie : tableDeJeu x Joueur -> Bool
	// verifie si la partie est gagnée par le joueur indique par le parametre
	// Pre : aucune 
	// Post : renvoie true si le jouer donne a gagne, false sinon
	func gagnerPartie(joueur : Joueur) -> Bool

	// makeIterator : tableDeJeuProtocol -> CollectionPiecesIterateur
    // crée un itérateur sur le collection pour itérer avec for in.
    func makeIterator() -> CollectionPiecesIterateur

}
