<?php

const LIMIT_NUMBER_BAG = 100;

function initBag(): array
{
    $bag = [];
    for ($i=1; $i <= LIMIT_NUMBER_BAG; $i++){
        $bag[] = $i;
    }
    return $bag;
}

function sumBag($bag_numbers): int
{
    $sum = 0;
    foreach ($bag_numbers as $number){
        $sum += $number;
    }
    return $sum;
}

function totalSum(): int
{
    return (LIMIT_NUMBER_BAG + 1) * (LIMIT_NUMBER_BAG /2);
}

function removeRandomNumberFromBah($bag): array
{
    $position_to_delete = rand(1, LIMIT_NUMBER_BAG);
    unset($bag[$position_to_delete]);
    return array_values ( $bag );
}

function missingNumberInBag($bag): int
{
    $total = totalSum();
    $sumCurrent = sumBag($bag);

    return $total - $sumCurrent;
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

$missing_number = missingNumberInBag($bag_updated);
echo 'The number removed was: '.$missing_number .PHP_EOL;

