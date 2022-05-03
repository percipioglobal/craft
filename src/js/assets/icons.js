// importing and setting up Font Awesome
import { dom, library } from '@fortawesome/fontawesome-svg-core';

import {
    faTwitter as fabTwitter,
    faFacebookF as fabFacebookF,
    faInstagram as fabInstagram,
    faLinkedinIn as fabLinkedinIn,
    faYoutube as fabYoutube,
    faVimeoV as fabVimeoV,
    faGithub as fabGithub,
} from '@fortawesome/free-brands-svg-icons';

// load font-awesome libraries
library.add(
    fabFacebookF,
    fabGithub,
    fabInstagram,
    fabLinkedinIn,
    fabVimeoV,
    fabTwitter,
    fabYoutube,
);

// convert i tags to SVG
dom.watch({
    autoReplaceSvgRoot: document,
    observeMutationsRoot: document.body
});
