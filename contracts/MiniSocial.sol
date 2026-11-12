// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

/// @title MiniSocial - Mini réseau social décentralisé
/// @notice Permet à n'importe quelle adresse de publier un message, stocké on-chain
contract MiniSocial {
    // 1. Structure Post : message + adresse de l'auteur
    struct Post {
        string message;
        address author;
    }

    // 2. Tableau dynamique contenant tous les messages publiés
    Post[] public posts;

    /// @notice Émis à chaque nouvelle publication
    event PostPublished(uint256 indexed index, address indexed author, string message);

    // 3. Publication d'un message
    function publishPost(string memory _message) public {
        posts.push(Post(_message, msg.sender));
        emit PostPublished(posts.length - 1, msg.sender, _message);
    }

    // 4. Consultation d'un post par son index
    function getPost(uint index) public view returns (string memory, address) {
        require(index < posts.length, "Index hors limites");
        Post storage p = posts[index];
        return (p.message, p.author);
    }

    // 5. Nombre total de messages publiés
    function getTotalPosts() public view returns (uint) {
        return posts.length;
    }
}
