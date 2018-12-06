import Foundation


// afficheTableCourante : tableDeJeu ->
// une fonction qui, apres chaque tour, montre la table de jeu aux joueurs
func afficheTableCourante(tdj : tableDeJeu) ->

// parseCommandJoueur: tableDeJeu x joueur x String -> Boolean
// une fonction qui parse et execute la commande pris, en appelant les fonctions necessaires pour
// l’executer. 
// Pre : aucune
// Post : Retourne true si l’action est valide, false sinon
func parseCommandeJoueur(tdj : tableDeJeu, joueur: Joueur, cmd : String) -> Bool {


    // Une petite implementation pour voir si on a bien pense.
    // cmda = array de mots dans cmd (‘move 1 2 3 4’ devient [‘move’ , ‘1‘, ’2’ , ‘3’, ‘4’ ])
    // switch (cmda[0]) // trouver type de commande {
    //     case “deplacer”:
    //         var piece : Pièce = tdj.searchPieceParPosition(cmda[1],cmda[2])
    //         if (validerDeplacement(piece, (cmda[3], cmda[4])) // position est un touple, c’est pour ca que j’ai un pair des parantheses la-bas {
    //             deplacer(pièce, (cmda[3], cmda[4]))
    //         }
    //         else {
    //             return False // l’action n’est pas valide
    //         }

    //     case “parachuter”

    //     case “deplacer”
    // }
}

// La boucle principale : 

var tdj = tableDeJeu()

while(true){
    var cmd : String?;
    var cmd2 : String;

    // Pour joueur 1
    while(true) {
        cmd = readLine()
		if let cmd2 = cmd {
			if(parseCommandeJoueur(tdj : tdj, joueur: tdj.j1, cmd : cmd)) {
				break;
			}
		}

    }

    if (tdj.gagnerPartie(tdj.j1)){
        // Dire a j1 qu’il a gagne et finit le jeu
        break;
    }

    // Pour joueur 2
    while(true) {
        cmd = readLine()
		if let cmd2 = cmd {
			if(parseCommandeJoueur(tdj : tdj, joueur: tdj.j2, cmd : cmd)) {
				break;
			}
		}

    }

    if ( tdj.gagnerPartie(tdj.j2)){
        // Dire a j2 qu’il a gagne et finit le jeu
        break;
    }
}
