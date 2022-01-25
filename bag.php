<?php

const LIMIT_NUMBER_BAG = 100;

function initBag(): array
{
    $bag = [];
    for ($i = 1; $i <= LIMIT_NUMBER_BAG; $i++){
        $bag[] = $i;
    }
    return $bag;
}
function removeRandomNumberFromBah($bag): array
{
    $number_removed = rand(1,LIMIT_NUMBER_BAG);
    if (($key = array_search($number_removed, $bag)) !== false)
    {
        unset($bag[$key]);
    }
    // se regresa esto es para uqe los index se vuelvan a setear
    return array_values ( $bag );
}
function getMissingNumber ($bag): int
{
    $total = 1;
    for ($i = 2; $i <= ( count($bag) + 1); $i++)
    {
        $total += $i;
        $total -= $bag[$i - 2];
    }
    return $total;
}


$bag = initBag();
echo 'Initializing bag of numbers:'.PHP_EOL;
echo 'The current bag is'.PHP_EOL;
print_r($bag);
echo 'We proceed to remove one number from the bag'.PHP_EOL;
$bag_updated = removeRandomNumberFromBah($bag);
echo 'The number has been taken'.PHP_EOL;
echo 'The current bag is: '.PHP_EOL;
print_r($bag_updated);

$missing_number = getMissingNumber($bag_updated);
echo 'The number removed was: '.$missing_number .PHP_EOL;
