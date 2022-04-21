<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:dc="http://purl.org/dc/elements/1.1/"
      xmlns:cc="http://creativecommons.org/ns#"
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
      xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
>
<head>
    <title>DH2020: Visualisation of semantic shifts: the case of modal markers</title>
    <script src="js/paths-collapse.js" type="text/javascript">/**/</script>
    <script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript">/**/</script>
    <script src="http://bigspotteddog.github.io/ScrollToFixed/jquery-scrolltofixed.js"
            type="text/javascript">/**/</script>
    <script src="js/timeline-poster.js" type="text/javascript">/**/</script>
    <script src="js/language.js" type="text/javascript">/**/</script>
    <link type="text/css" rel="stylesheet" href="css/maps.css"/>
    <link type="text/css" rel="stylesheet" href="css/poster.css"/>
    <?php include("ssi/head.html"); ?>

</head>
<body>
<main>
    <img src="images/all-versions_logos/woposs_logo/wop_light.png" style="float: right"/>
    <h1>Visualisation of semantic shifts: the case of modal markers</h1>
    <h3 class="center">Helena Bermúdez Sabel, Francesca Dell’Oro, Paola Marongiu</h3>
    <h3 class="center">Swiss National Science Foundation – University of Lausanne</h3>
    <h2>Outline</h2>
    <ol>
        <li><a href="#rationale">Rationale</a></li>
        <li><a href="#stateoftheart">State of the art</a></li>
        <li><a href="#functionalities">New functionalities in a nutshell</a></li>
        <li><a href="#example">An example: semantic map of CERTUS</a></li>
        <li><a href="#more">To know more</a></li>
        <li><a href="#biblio">Bibliographic references</a></li>
    </ol>

    <h2 id="rationale">1. Rationale</h2>

    <p>A visual representation can replace complex cognitive calculations, presenting data in a more accessible and
        attractive manner. However, selecting the most efficient visualization can be challenging, especially when
        dealing with abstract concepts. The importance of an efficient visualization in our case arises from:</p>

    <div class="container">
        <div><h4>Need for condensation</h4>
            <img src="other/dhposter/books.png"/>
            <p>Can a visualization summarize pages and pages of dictionaries and historical
                grammars?</p></div>
        <div><h4>Need for simplicity</h4>
            <img src="other/dhposter/addInfo.png"/>
            <p>How do we add more information to previous models to better convey the
                multidimensionality of modal semantic shifts?</p></div>
        <div><h4>Need for legibility</h4>
            <img src="other/dhposter/interaction.jpg"/>
            <p>Can we update the traditional visualization models by incorporating animation, color
                and user interactivity?</p></div>
    </div>
    <h2 id="stateoftheart">2. State of the art</h2>
    <div class="container2">
        <div class="art">
            <p>The semantic map visualisation method was defined by <a href="#haspelmath">Haspelmath (2003)</a> as the
                geometric representation of functions connected together in semantic space. The goal of the semantic
                maps is to describe and illustrate the multifunctionality patterns of linguistic elements <a
                        href="#haspelmath">(Haspelmath 2003: 213)</a>. Semantic maps were employed in various ways,
                cross-linguistically or on individual languages, and synchronically or diachronically. To name a few,
                see:

            </p>
            <ul>
                <li><a href="#anderson82">Anderson (1982)</a>: tense and aspect</li>
                <li><a href="#anderson86">Anderson (1986)</a>: evidentiality</li>
                <li><a href="#traugott">Traugott (1985)</a>: conditionals</li>
                <li><a href="#croft">Croft <em>et al.</em> (1987)</a>: voice</li>
                <li><a href="#françois">François (2008)</a>: monolingual approach together with a cross-linguistic
                    one
                </li>
            </ul>

            <p><a href="#auwera">Van der Auwera and Plungian (1998)</a> apply this resource to visually represent and
                predict
                universal patterns
                of modalisation. They build on the single patterns of modalisation for possibility and necessity of the
                cross-linguistic study by <a href="#bybee">Bybee <em>et al</em>. (1994)</a>, complementing them with
                lexical
                information
                from other languages. An overview of the modalisation and grammaticalisation paths is achieved by
                including
                pre-
                and post-modal meanings.</p>
            <p>Our proposal follows this model but our aim is to produce a digital visualisation with <strong>additional
                    features</strong>.
            </p></div>
        <div class="art">
            <figure><img src="other/dhposter/fig1.png"/>
                <figcaption>Fig. 1. “To possibility and beyond” <a href="#auwera">(van der Auwera and Plungian
                        1998: 91)</a>.
                </figcaption>
            </figure>

            <figure><img src="other/dhposter/fig1.jpg"/>
                <figcaption>Fig. 2. “Unifying the possibility and necessity paths”: Example of a semantic map
                    representing the
                    shifts of possibility and necessity <a href="#auwera">(van der Auwera and Plungian 1998: 98)</a>.
                </figcaption>
            </figure>
        </div>
    </div>

    <h2 id="functionalities">3. New functionalities in a nutshell</h2>
    <div class="overview">
        <div class="img">
            <figure><img src="other/dhposter/potestasa.png">
                <figcaption>Fig. 3. Screenshot of the semantic map of POTESTAS</figcaption>
            </figure>
        </div>
        <div class="aside">
            <ol>
                <li>A timeline (fixed on scroll) provides the chronological information: the time (here expressed
                    through a
                    segmentation in centuries) works as the x axis.
                </li>
                <li>In the y axis the different meanings are displayed and ordered according to the organization of the
                    description
                    of the headword in the dictionary of reference (the <a href="#thll"><em>ThLL</em></a>), i.e.
                    according to semantic groups.
                </li>
                <li>Collocations
                    containing the headword are also registered (they appear on the left outside the arrow).
                </li>
                <li>The etymology of the headword is provided on the left side</li>
                <li>Colors indicate the type of modality.
                </li>
                <li>Language selection: besides a bilingual map (English-Latin), a monolingual (Latin) version is
                    also available.
                </li>
            </ol>
        </div>
    </div>
    <div class="overview">
        <div class="img">
            <figure><img src="other/dhposter/postestasb.png">
                <figcaption>Fig. 4. Screenshot of the semantic map of POTESTAS after clicking on a sense</figcaption>
            </figure>
        </div>
        <div class="aside">
            <ol class="second">
                <li>When you click on a sense, semantic relations between meanings become visible (while loosely related
                    meanings
                    disappear). The visualization is reset by double-clicking.
                </li>
                <li>The first attestation is visible when hovering the mouse over a sense.</li>
            </ol>
        </div>
    </div>
    <h2 id="example">4. An example: the semantic map of CERTUS</h2>
    <div class="container2">
        <div class="imgContainer"><img src="other/dhposter/try_it_yourself_en.png"></div>
        <div class="instructions">
            <h4>Basic instructions</h4>
            <ul>
                <li><strong>Click</strong> on a sense to see the semantic relations in synchrony and diachrony. To reset
                    the
                    visualization, <strong>double click</strong> in any of the visible senses.
                </li>
                <li>The modal types are color-coded: please refer to the legend available above each semantic modal map.
                </li>
                <li>Mouse over a meaning to read its first attestation.</li>
                <li>Meanings between square brackets are an interpretation of the meaning based on the attestations (and
                    not
                    only on the <em>ThLL</em>). Senses preceded by “~” are an approximate translation.
                </li>
            </ul>
        </div>
    </div>


    <div class="map">
        <h2>CERTUS</h2>
        <div class="languages">
            Select language:
            <a title="English version" data-idno="en" class="language">EN</a>
            <a title="Latin version" data-idno="la" class="language">LA</a>
        </div>

        <?php include("semantic-maps/legend.svg"); ?>
        <?php include("semantic-maps/certus-timeline.svg"); ?>

        <?php include("semantic-maps/certus.svg"); ?>
        <div id="limit"/>
    </div>

    <h2 id="more">5. To know more</h2>
    <a href="semantic-modal-maps.php" target="_blank"><img src="other/dhposter/info.png" id="info"></a>
    <h2 id="biblio">6. Bibliography</h2>
    <ul>
        <li id="anderson82">Anderson, Lloyd B. (1982). ‘The “Perfect” as a Universal and as a Language-Particular
            Category’. In
            <em>Tense-Aspect:
                Between Semantics &amp; Pragmatics</em>. Amsterdam: John Benjamins, 227–64.
        </li>
        <li id="anderson86">Anderson, Lloyd B. (1986). ‘Evidentials, Paths of Change, and Mental Maps: Typologically
            Regular Asymmetries’. In
            <em>Evidentiality:
                The Linguistic Coding of Epistemology</em>. Norwood,
            N.J.: Ablex, 273–312.
        </li>
        <li id="dh2020abstract">Bermúdez Sabel, Helena, Dell’Oro, Francesca &amp; Marongiu, Paola (2020). ‘Visualisation
            of
            semantic
            shifts:
            the case of modal markers’.
            <em>Book of Abstracts DH2020</em>.
        </li>
        <li id="bybee">Bybee, Joan L., Perkins, Revere &amp; Pagliuca, William (1994). <em>The Evolution of Grammar:
                Tense, Aspect and
                Modality in the Languages of the World</em>. Chicago: University of Chicago Press.
        </li>
        <li id="croft">Croft, William, Shyldkrot, Hava Bat-Zeev &amp; Kemmer, Suzanne (1987). ‘Diachronic Semantic
            Processes
            in the Middle Voice’. In <em>Papers from the 7th International Conference on Historical Linguistics</em>.
            Amsterdam: John Benjamins, 179–92.
        </li>
        <li>Dell’Oro, Francesca (2019). <em>WoPoss guidelines for annotation</em>. Zenodo.

            <a href="https://doi.org/10.5281/zenodo.3560951"><img
                        src="https://zenodo.org/badge/DOI/10.5281/zenodo.3560951.svg" alt="DOI"></a>

        </li>
        <li id="françois">François, Alexandre (2008). ‘Semantic Maps and the Typology of Colexification: Intertwining
            Polysemous
            Networks across Languages’. In <em>From Polysemy to Semantic Change: Towards a Typology of Lexical Semantic
                Associations</em>. Amsterdam: John Benjamins, 163–215.
            <a href="https://halshs.archives-ouvertes.fr/halshs-00526845/document" target="_blank">https://halshs.archives-ouvertes.fr/halshs-00526845/document</a>.
        </li>
        <li id="haspelmath">Haspelmath, Martin (2003). ‘The Geometry of Grammatical Meaning: Semantic Maps and
            Cross-Linguistic Comparison’. In <em>The New Psychology of Language</em>. East Sussex: Psychology Press,
            217–48.
            <a href="https://doi.org/10.4324/9781410606921-11"
               target="_blank">https://doi.org/10.4324/9781410606921-11</a>.
        </li>
        <li id="marongiu2020">Marongiu, Paola &amp; Dell’Oro, Francesca (in preparation). <em>Syntheses of the
                descriptions of the modal markers in the</em> ThLL.
        </li>
        <li id="thll">ThLL: Thesaurusbüro München Internationale Thesaurus-Kommission, ed.
            (1900-). <em>Thesaurus Linguae Latinae</em>. B.G. Teubner, Leipzig. <a href="https://www.degruyter.com/view/db/tll​" target="_blank">https://www.degruyter.com/view/db/tll​</a>
        </li>
        <li id="traugott">Traugott, Elizabeth Closs (1985). ‘Conditional Markers’. In <em>Iconicity in Syntax</em>.
            Amsterdam: John Benjamins,
            289–307.
        </li>
        <li id="auwera">van der Auwera, Johan &amp; Plungian, Vladimir A. (1998). ‘Modality’s Semantic Map’. <em>Linguistic
                Typology</em> 2 (1): 79–124.
        </li>
    </ul>
</main>

<?php include("ssi/footer.html"); ?>
</body>
</html>