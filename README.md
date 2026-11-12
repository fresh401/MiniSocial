<img width="1498" height="954" alt="image" src="https://github.com/user-attachments/assets/d3f92bc4-22ce-49b2-80bb-450844287317" /># Atelier 3 : Smart Contract « Mini Réseau Social » en Solidity

**Module :** Blockchain — 2026/2027  
**Auteur :** Mehdi Arbai  
**Encadrante :** Pr. Ikram BEN ADBEL OUAHAB  
**Outils :** Remix IDE, MetaMask, réseau de test Sepolia (SepoliaETH)

---

## 1. Objectif

Réaliser un smart contract `MiniSocial` permettant à des utilisateurs de publier des messages stockés sur la blockchain, de consulter un message par son index et de connaître le nombre total de messages.

## 2. Structure du dépôt

```
.
├── contracts/MiniSocial.sol   # Smart contract
├── webapp/index.html          # (Bonus) DApp web3.js
├── docs/screenshots/          # Captures d'écran des tests
└── README.md                  # Rapport
```

## 3. Implémentation

Le code source complet est dans [`contracts/MiniSocial.sol`](contracts/MiniSocial.sol).

| Élément | Rôle |
|---|---|
| `struct Post` | Regroupe le message (`string`) et l'adresse de l'auteur (`address`). |
| `Post[] public posts` | Tableau dynamique stockant tous les messages publiés. `public` génère un getter automatique `posts(uint)`. |
| `publishPost(string memory _message)` | Crée un `Post` avec le message et `msg.sender` (l'adresse qui appelle la fonction), puis l'ajoute au tableau avec `push`. Émet l'événement `PostPublished`. |
| `getPost(uint index)` | Fonction `view` (lecture gratuite) qui retourne le message et l'auteur. Le `require` évite un accès hors limites. |
| `getTotalPosts()` | Retourne `posts.length`. |
| `event PostPublished` | Ajout facultatif : permet à une interface d'écouter les nouveaux posts. |

## 4. Déploiement et tests

### 4.1 Préparation
1. Installation de **MetaMask** et création d'un compte.
2. Passage sur le réseau de test **Sepolia**.
3. Obtention de SepoliaETH via un faucet.

### 4.2 Compilation (Remix)
1. Création du fichier `MiniSocial.sol` dans Remix IDE.
2. Onglet **Solidity Compiler** : compilation réussie.

> Remarque : Remix utilisait par défaut le compilateur 0.8.34, alors que le contrat imposait exactement `0.8.26`. J'ai remplacé `pragma solidity 0.8.26;` par `pragma solidity ^0.8.26;` pour autoriser les versions supérieures.

![Compilation](docs/screenshots/01-compilation.png)

### 4.3 Déploiement sur Sepolia
Dans l'onglet **Deploy & Run Transactions**, l'environnement a été connecté à MetaMask, puis le contrat `MiniSocial` a été déployé avec le compte 1 (confirmation dans MetaMask).

| Information | Valeur |
|---|---|
| Réseau | Sepolia |
| Adresse du contrat | `0x75AD1C5ED3A165B0eE11f12a17928617479FD1fE` |
| Hash de la transaction de déploiement | `0x401b0279adcc490f3e01053c605bfb696f0fece51be0a4404abb0e290836e0f2` |
| Adresse du déployeur (compte 1) | `0xb31EF24FdB63fC7e57e900BF81F9dA923879753A` |
| Etherscan (contrat) | https://sepolia.etherscan.io/address/0x75AD1C5ED3A165B0eE11f12a17928617479FD1fE |
| Etherscan (transaction) | https://sepolia.etherscan.io/tx/0x401b0279adcc490f3e01053c605bfb696f0fece51be0a4404abb0e290836e0f2 |

![Déploiement](docs/screenshots/02-deploiement.png)

### 4.4 Tests

#### Test 1 : contrat vide
- **Étapes :** appel de `getTotalPosts()`.
- **Résultat attendu :** `0`.
- **Résultat obtenu :** `0`. ✅

#### Test 2 : publication d'un message
- **Étapes :** `publishPost("Bonjour depuis compte 1")` avec le compte 1, puis confirmation dans MetaMask.
- **Résultat attendu :** transaction validée.
- **Résultat obtenu :** transaction validée sur Sepolia. ✅

#### Test 3 : lecture d'un post
- **Étapes :** `getPost(0)`.
- **Résultat attendu :** le message et l'adresse du compte 1.
- **Résultat obtenu :**
  - message : `Bonjour depuis compte 1`
  - auteur : `0xb31EF24FdB63fC7e57e900BF81F9dA923879753A` ✅

#### Test 4 : nombre total de messages
- **Étapes :** `getTotalPosts()` après la publication.
- **Résultat attendu :** `1`.
- **Résultat obtenu :** _(à compléter)_

#### Test 5 : index invalide
- **Étapes :** `getPost(99)`.
- **Résultat attendu :** erreur `Index hors limites`.
- **Résultat obtenu :** _(à compléter)_

#### Test 6 : publication avec d'autres comptes
- **Étapes :** connexion de MetaMask avec les comptes `test1` et `test2`, puis `publishPost(...)` depuis chaque compte.
- **Résultat attendu :** chaque message est enregistré avec l'adresse de son auteur.
- **Résultat obtenu :** _(à compléter)_

![Tests](docs/screenshots/03-tests.png)

### 4.5 Remarques
- `publishPost` modifie l'état de la blockchain : elle consomme du gas et nécessite une confirmation MetaMask.
- `getPost` et `getTotalPosts` sont des fonctions `view` : lecture gratuite, sans transaction.
- L'auteur est toujours `msg.sender` : il ne peut pas être falsifié par l'utilisateur.
- Les messages sont publics et immuables.
- Difficulté rencontrée : Remix connecté via WalletConnect n'affichait qu'un seul compte ; il faut utiliser *Injected Provider - MetaMask* et autoriser chaque compte dans MetaMask pour changer d'auteur.

## 5. Conclusion

Ce TP m'a permis de définir une structure et un tableau dynamique en Solidity, d'utiliser `msg.sender`, de distinguer fonctions de lecture (`view`) et d'écriture, et de déployer et tester un contrat sur le réseau de test Sepolia avec Remix et MetaMask.

## 6. Licence

MIT
