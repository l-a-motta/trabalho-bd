<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** l-a-motta, trabalho-bd, @DaAntonetti, l.a.motta@usp.br, Banco de Dados - Turismo Internacional, Esse repositorio tem como principal objetivo guardar os arquivos SQL para criacao de um banco de dados de uma empresa fantasia de turismo internacional. O foco dessa empresa seria os eventos de cada localidade que ela oferece uma viagem para.
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][https://github.com/l-a-motta/trabalho-bd/graphs/contributors]
[![Forks][forks-shield]][https://github.com/l-a-motta/trabalho-bd/network/members]
[![Stargazers][stars-shield]][https://github.com/l-a-motta/trabalho-bd/stargazers]
[![Issues][issues-shield]][https://github.com/l-a-motta/trabalho-bd/issues]
[![MIT License][license-shield]][https://github.com/l-a-motta/trabalho-bd/blob/main/LICENSE]
[![LinkedIn][linkedin-shield]][https://www.linkedin.com/in/l-a-motta/]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/l-a-motta/trabalho-bd">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Banco de Dados - Turismo Internacional</h3>

  <p align="center">
    This repository is used to keep the SQL files for the creation of a database of a fantasy international tourism company. The focus of this company would be the events of each location that it offers a trip to. The language used for code comments is Brazilian Portuguese.
    <br />
    <a href="https://github.com/l-a-motta/trabalho-bd"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/l-a-motta/trabalho-bd">View Demo</a>
    ·
    <a href="https://github.com/l-a-motta/trabalho-bd/issues">Report Bug</a>
    ·
    <a href="https://github.com/l-a-motta/trabalho-bd/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Local Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

PostgreSQL 13.2 or newer, PGAdmin 4 or newer.

### Local Installation

1. Clone the repo
   ```sh
   git clone https://github.com/l-a-motta/trabalho-bd.git
   ```
2. Open up your PostgreSQL manager (we suggest PGAdmin 4, that comes with a full installation of PostgreSQL already)
   
3. Create a local database to run our .sql files, then open up the Query Tool inside that database

4. Execute our .sql scripts, in the following order: 
    ```limpa.sql 
    esquema.sql
    dados.sql
    ```

5. Now you have a fully populated database! Make sure to always run limpa.sql before the others, so you don't run the risk of leaving some table behind when recreating

6. If you'd like, we also have a few SELECT statements ready to be executed inside consultas.sql


<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_



<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/l-a-motta/trabalho-bd/issues) for a list of proposed features (and known issues).



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Leonardo Antonetti da Motta - [@DaAntonetti](https://twitter.com/@DaAntonetti) - l.a.motta@usp.br

Project Link: [https://github.com/l-a-motta/trabalho-bd](https://github.com/l-a-motta/trabalho-bd)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/l-a-motta/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/l-a-motta/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/l-a-motta/repo.svg?style=for-the-badge
[forks-url]: https://github.com/l-a-motta/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/l-a-motta/repo.svg?style=for-the-badge
[stars-url]: https://github.com/l-a-motta/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/l-a-motta/repo.svg?style=for-the-badge
[issues-url]: https://github.com/l-a-motta/repo/issues
[license-shield]: https://img.shields.io/github/license/l-a-motta/repo.svg?style=for-the-badge
[https://github.com/l-a-motta/trabalho-bd/blob/main/LICENSE]: https://github.com/l-a-motta/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/l-a-motta
