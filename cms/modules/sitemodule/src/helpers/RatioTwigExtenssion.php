<?php

namespace modules\sitemodule\helpers;

use Craft;

class RatioTwigExtenssion extends \Twig\Extension\AbstractExtension
{
    private $ratios = [
        100 => 'aspect-w-1 aspect-h-1',
        50 => 'aspect-w-2 aspect-h-1',
        33 => 'aspect-w-3 aspect-h-1',
        75 => 'aspect-w-4 aspect-h-3',
        133 => 'aspect-w-3 aspect-h-4',
        74 => 'aspect-w-7 aspect-h-5',
        62 => 'aspect-w-8 aspect-h-5',
        56 => 'aspect-w-16 aspect-h-9',
        42 => 'aspect-w-21 aspect-h-9'
    ];

    public function getFilters()
    {
        return [];
    }

    public function getFunctions()
    {
        return [
            new \Twig\TwigFunction('getRatioClass', array($this, 'getRadioClass')),
        ];
    }

    public function getRadioClass($obj){
        $ratio = round( ($obj['height'] / $obj['width']) * 100);
        $sorted = [];

        foreach(array_keys($this->ratios) as $i){
            $sorted[$i] = abs($i - $ratio);
        }
        asort($sorted);

        $key = key(array_slice($sorted, 0, 1, true));

        return $this->ratios[$key];
    }
}
