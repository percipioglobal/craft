// importing and setting up Font Awesome
import { dom, library } from '@fortawesome/fontawesome-svg-core'

import {
    faCircleDown as farCircleDown,
    faEnvelope as farEnvelope,
    faFileArchive as farFileArchive,
    faFileExcel as farFileExcel,
    faFilePdf as farFilePdf,
    faFilePowerpoint as farFilePowerPoint,
    faFileWord as farFileWord,
    faFileZipper as farFileZipper
} from '@fortawesome/free-regular-svg-icons'

import {
    faArrowUpRightFromSquare as fasArrowUpRightFromSquare,
    faHashtag as fasHashtag,
    faLink as fasLink,
    faPrint as fasPrint
} from '@fortawesome/free-solid-svg-icons'

import {
    faFacebookF as fabFacebookF,
    faGithub as fabGithub,
    faInstagram as fabInstagram,
    faLinkedinIn as fabLinkedinIn,
    faTwitter as fabTwitter,
    faVimeoV as fabVimeoV,
    faWikipediaW as fabWikipediaW,
    faYoutube as fabYoutube,
} from '@fortawesome/free-brands-svg-icons'

// load font-awesome libraries
library.add(
    fabFacebookF,
    fabGithub,
    fabInstagram,
    fabLinkedinIn,
    fabTwitter,
    fabVimeoV,
    fabWikipediaW,
    fabYoutube,
    farCircleDown,
    farEnvelope,
    farFileArchive,
    farFileExcel,
    farFilePdf,
    farFilePowerPoint,
    farFileWord,
    farFileZipper,
    fasArrowUpRightFromSquare,
    fasHashtag,
    fasLink,
    fasPrint
)

// convert i tags to SVG
dom.watch({
    autoReplaceSvgRoot: document,
    observeMutationsRoot: document.body
})
