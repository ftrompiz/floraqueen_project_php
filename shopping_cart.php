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
    public function __construct()
    {
        $this->price = 10;
    }
    public function getPrice(): float
    {
        return $this->price;
    }
}
class ProductB extends Product
{
    public function __construct()
    {
        $this->price = 8;
    }
    public function getPrice(): float
    {
        return $this->price;
    }
}
class ProductC extends Product
{
    public function __construct()
    {
        $this->price = 12;
    }

    public function getPrice(): float
    {
        return $this->price;
    }
}

class VoucherV extends Voucher
{
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
                if ($count_product >= 2){
                    return 1;
                }
            }
        }
        return 0;
    }
}

class VoucherR extends Voucher
{
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
                $discount += 5;
            }
        }
        return $discount;
    }
}

class VoucherS extends Voucher
{
    public function __construct()
    {
        $this->apply_at_end = true;
    }
    public function getDiscount(Cart $cart):float
    {
        echo "total: $cart->total \n";
        if ($cart->total > 40){
            return ($cart->total)*(.05);
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
                /**
                 * @var Product $element
                 */
                $pr = $element->getPrice();
                echo "Precio: " . $pr . " \n";
                $this->total += $pr;
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
                /**
                 * @var Voucher $element
                 */
                $dis = $element->getDiscount($this);
                echo "Discount: ".$dis." \n";
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
            echo "Agregando un elemento al carrito \n";
            print_r($item);
            $cart->addElement($item);
            echo "Total en el carrito: ".$cart->total." \n";
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
            echo "Agregando un elemento al carrito \n";
            print_r($item);
            $cart->addElement($item);
            echo "Total en el carrito: ".$cart->total." \n";
        }

    }
}

$case = new Case2();
$case->execute();



