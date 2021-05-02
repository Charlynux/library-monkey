# Library Monkey

Gestion automatisée de cartes de bibliothèque pour Amiens.

## Pourquoi ?

Sur le [site](http://bibliotheques.amiens.fr/) de la bibliothèque d'Amiens, le prolongement des emprunts n'est pas très ergonomique (clic unitaire amenant vers une page blanche).

Lorsque l'on ajoute à cela la nécessité de suivre les emprunts sur plusieurs cartes. Il devient utile d'avoir un processus automatisé pour gérer ça.

## Fonctionnalités

- Renouvelle tous les emprunts en cours
- Affiche la liste des emprunts par carte

```
...............
Total : 5 document(s)
Carte Alice - 2 document(s)

|                       :titre | :date-de-retour |
|------------------------------+-----------------|
|                   Germinal   |      03/05/2021 |
| 20000 lieues sous les mers   |      03/05/2021 |

Carte Bob - 0 document(s)
** Aucun document pour cette carte **

Carte Clyde - 3 document(s)

|                      :titre | :date-de-retour |
|-----------------------------+-----------------|
|               Dragon Ball   |      11/05/2021 |
|                Evangelion   |      11/05/2021 |
|                 One Piece   |      11/05/2021 |
```

## Utilisation

Vous avez besoin du jar présent dans le dossier `dist`. Soit en clonant le repository, soit en le téléchargeant directement.

### Configuration

1. Copier le fichier de configuration

```sh
cp config.edn.example config.edn
```

2. Modifier le fichier pour renseigner les identifiants de vos cartes.

(L'information `:pseudo` est optionnelle.)

```edn
{
 :accounts
 [{:pseudo "Toto"
   :username "numéro de carte"
   :password "mot de passe"}]
}
```

### Exécution

Lancer la commande

```sh
java -jar dist/library-monkey.jar config.edn
```
