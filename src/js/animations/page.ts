interface Animation {
    initial: string[]
    in: string[]
    out: string[]
}

interface Animations {
    [key: string]: Animation
}

const ANIMATIONS: Animations = {
    'fadeIn': {
        initial: [],
        in: ['transition-opacity', 'ease-out', 'duration-1000', 'opacity-1'],
        out: ['opacity-0']
    },
    'slideInRightToLeft': {
        initial: [],
        in: ['transition-all', 'ease-out', 'duration-1000', 'opacity-1', 'transform', 'translate-x-0'],
        out: ['opacity-0', 'transform', 'translate-x-5', 'md:translate-x-10']
    },
    'slideLeftToRight': {
        initial: [],
        in: ['transition-all', 'ease-out', 'duration-1000', 'opacity-1', 'transform', 'translate-x-0'],
        out: ['opacity-0', 'transform', '-translate-x-5', 'md:-translate-x-10']
    },
    'slideBottomToTop': {
        initial: [],
        in: ['transition-all', 'ease-out', 'duration-1000', 'opacity-1', 'translate-y-0'],
        out: ['opacity-0', 'translate-y-10', 'md:translate-y-20']
    }
}

//instanciate init
export const init = () => {
    let ticking = false;
    const animateElements: NodeListOf<HTMLElement> = document.querySelectorAll('.animate')

    setInitialAnimations(animateElements)

    window.addEventListener('scroll', () => {
        if (!ticking) {
            window.requestAnimationFrame(() => {
                animateBlocks(animateElements);
                ticking = false;
            });

            ticking = true;
        }

    });
}

const setInitialAnimations = (animateElements: NodeListOf<HTMLElement>) => {

    for (const block of animateElements) {
        const animationType = block.dataset.animation ?? 'fadeIn'
        const animation = ANIMATIONS[animationType]
        block.classList.add(...animation.initial, ...animation.out)
    }

    animateBlocks(animateElements);
}

const animateBlocks = (animateElements: NodeListOf<HTMLElement>) => {

    for (const block of animateElements) {
        const animationType = block.dataset.animation ?? 'fadeIn'

        const boundingBox = block.getBoundingClientRect()

        const isVisible = boundingBox.y < (window.innerHeight * .75)

        if (isVisible) {
            const animation = ANIMATIONS[animationType]

            block.classList.add(...animation.in)
            block.classList.remove(...animation.out)
        }

    }
}
