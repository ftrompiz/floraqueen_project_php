<?php
abstract class Voucher
{
    public $apply_at_end;
    abstract public function getDiscount(Cart $cart): float;
}

abstract class Product
{
    protected $price;
    abstract public function getPrice(): float;
}

class ProductA extends Product
{
    const PRODUCT_PRICE = 10;
    public function __construct()
    {
        $this->price = self::PRODUCT_PRICE;
    }
    public function getPrice(): float
    {
        return $this->price;
    }
}
class ProductB extends Product
{
    const PRODUCT_PRICE = 8;
    public function __construct()
    {
        $this->price = self::PRODUCT_PRICE;
    }
    public function getPrice(): float
    {
        return $this->price;
    }
}
class ProductC extends Product
{
    const PRODUCT_PRICE = 12;
    public function __construct()
    {
        $this->price = self::PRODUCT_PRICE;
    }
    public function getPrice(): float
    {
        return $this->price;
    }
}

class VoucherV extends Voucher
{
    const DISCOUNT_VALUE = 1;
    const NO_DISCOUNT_VALUE = 0;
    const PRODUCT_COUNT_DISCOUNT_CONDITION = 2;

    public function __construct()
    {
        $this->apply_at_end = false;
    }
    public function getDiscount(Cart $cart):float
    {
        $count_product = 0;
        foreach ($cart->elements as $element){
            if ($element instanceof ProductA){
                $count_product++;
                if ($count_product >= self::PRODUCT_COUNT_DISCOUNT_CONDITION){
                    return self::DISCOUNT_VALUE;
                }
            }
        }
        return self::NO_DISCOUNT_VALUE;
    }
}

class VoucherR extends Voucher
{
    const DISCOUNT_VALUE = 5;
    public function __construct()
    {
        $this->apply_at_end = false;
    }
    public function getDiscount(Cart $cart):float
    {
        $discount = 0;

        foreach ($cart->elements as $element){
            if ($element instanceof ProductB){
                /**
                 * @var ProductB $product
                 */
                $discount += self::DISCOUNT_VALUE;
            }
        }
        return $discount;
    }
}

class VoucherS extends Voucher
{
    const DISCOUNT_APPLY_AFTER_TOTAL = 40;
    const PERCENTAGE_DISCOUNT_ON_TOTAL = 5/100; // 5%

    public function __construct()
    {
        $this->apply_at_end = true;
    }
    public function getDiscount(Cart $cart):float
    {
        if ($cart->total > self::DISCOUNT_APPLY_AFTER_TOTAL){
            return ($cart->total)*(self::PERCENTAGE_DISCOUNT_ON_TOTAL);
        }
        return 0;
    }
}
class Cart{

    /**
     * @var  array
     */
    public $elements;
    public $total;

    public function __construct()
    {
        $this->elements = [];
        $this->total = 0;
    }


    /**
     *
     */
    public function getElements(): array
    {
        return $this->elements;
    }

    public function recalculate()
    {
        $this->total = 0;
        $list_voucher = [];
        foreach ($this->elements as $element)
        {
            if ($element instanceof Product) {
                $price = $element->getPrice();
                $this->total += $price;
            } elseif ($element instanceof Voucher){
                if ($element->apply_at_end){
                    array_push($list_voucher, $element);
                } else {
                    array_unshift($list_voucher, $element);
                }
            }
        }

        foreach ($list_voucher as $element)
        {
            if ($element instanceof Voucher)
            {
                $dis = $element->getDiscount($this);
                $this->total -= $dis;
            }
        }

    }

    /**
     * @param Product|Voucher $element
     */
    public function addElement($element)
    {
        $this->elements[] = $element;
        $this->recalculate();
    }
}

class case1 {

    public $list;

    public function __construct()
    {
        $this->list =  [
            new ProductA(),
            new ProductC(),
            new VoucherS(),
            new ProductA(),
            new VoucherV(),
            new ProductB(),
        ];
    }

    public function execute()
    {
        $cart = new Cart();

        foreach ($this->list as $item)
        {
            echo "Agregando un elemento al carrito: ".get_class($item).PHP_EOL;
            $cart->addElement($item);
            echo "Total en el carrito: ".$cart->total.PHP_EOL;
        }

    }
}

class case2 {

    public $list;

    public function __construct()
    {
        $this->list =  [
            new ProductA(),
            new VoucherS(),
            new ProductA(),
            new VoucherV(),
            new ProductB(),
            new VoucherR(),
            new ProductC(),
            new ProductC(),
            new ProductC(),
        ];
    }

    public function execute()
    {
        $cart = new Cart();

        foreach ($this->list as $item)
        {
            echo "Agregando un elemento al carrito: ".get_class($item).PHP_EOL;
            $cart->addElement($item);
            echo "Total en el carrito: ".$cart->total.PHP_EOL;
        }

    }
}

echo "Ejecutando caso 1" . PHP_EOL;
$case = new Case1();
$case->execute();
echo PHP_EOL;
echo PHP_EOL;
echo "Ejecutando caso 2" . PHP_EOL;
$case = new Case2();
$case->execute();



