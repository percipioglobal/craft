// importing and setting up Font Awesome
import { dom, library } from '@fortawesome/fontawesome-svg-core';
import {
    faFilePdf as farFilePdf,
    faFileExcel as farFileExcel,
    faFileWord as farFileWord,
    faFilePowerpoint as farFilePowerPoint,
    faFileArchive as farFileArchive,
    faEnvelope as farEnvelope,
} from '@fortawesome/free-regular-svg-icons';

import {
    faCloudDownloadAlt as fasCloudDownloadAlt,
    faExternalLinkAlt as fasExternalLinkAlt,
    faPrint as fasPrint,
    faHashtag as fasHashtag,
    faDownload as fasDownload,
    faCircle as fasCircle,
    faSquareFull as fasSquareFull
} from '@fortawesome/free-solid-svg-icons';

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
    farFilePdf,
    farFileExcel,
    farFileWord,
    farFilePowerPoint,
    farFileArchive,
    fasCloudDownloadAlt,
    fasExternalLinkAlt,
    fabTwitter,
    fabFacebookF,
    farEnvelope,
    fasPrint,
    fabInstagram,
    fabLinkedinIn,
    fabYoutube,
    fabVimeoV,
    fabGithub,
    fasHashtag,
    fasDownload,
    fasCircle,
    fasSquareFull
);

// convert i tags to SVG
dom.watch({
    autoReplaceSvgRoot: document,
    observeMutationsRoot: document.body
});
