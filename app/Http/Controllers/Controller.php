<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Kavenegar\Exceptions\ApiException;
use Kavenegar\Exceptions\HttpException;
use Kavenegar\KavenegarApi;

class Controller extends BaseController
{
    use AuthorizesRequests, DispatchesJobs, ValidatesRequests;

    protected static $sharedKey = "myTokenSharedKeyMammadKia";
   protected static $apiBaseUrl = "https://mykoochita.com/";
    // protected static $apiBaseUrl = "https://koochita.com/";

    protected static function createToken() {
        $time = time();
        return [hash("sha256", self::$sharedKey . $time), $time];
    }

    public static function sendSMS($destNum, $text, $template, $token2 = "") {

        return 1;
        // require_once __DIR__ . '/../../../vendor/autoload.php';

        // try{
        //     $api = new KavenegarApi("4836666C696247676762504666386A336846366163773D3D");
        //     $result = $api->VerifyLookup($destNum, $text, $token2, '', $template);
        //     if($result){
        //         foreach($result as $r){
        //             return $r->messageid;
        //         }
        //     }
        // }
        // catch(ApiException $e){
        //     // در صورتی که خروجی وب سرویس 200 نباشد این خطا رخ می دهد
        //     echo $e->errorMessage();
        //     return -1;
        // }
        // catch(HttpException $e){
        //     // در زمانی که مشکلی در برقرای ارتباط با وب سرویس وجود داشته باشد این خطا رخ می دهد
        //     echo $e->errorMessage();
        //     return -1;
        // }
    }
}
