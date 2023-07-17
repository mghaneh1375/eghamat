<?php

use App\Http\Controllers\AssetController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\CKEditor;
use App\Http\Controllers\FormController;
use App\Http\Controllers\FormFieldController;
use App\Http\Controllers\StateController;
use App\Http\Controllers\CityController;
use \App\Http\Controllers\UserAssetController;
use App\Http\Controllers\UserFormController;
use App\Http\Controllers\UserSubAssetController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::middleware('auth:api')->group(function () {

    Route::group(["prefix" => "ckeditor"], function () {

        Route::post("/{userFormsData}", [CKEditor::class, 'storePic'])->name('ckeditorStorePic');

        Route::get('/', [CKEditor::class, 'showEmpty']);

        Route::get('/{userFormsData}', [CKEditor::class, 'show']);

    });

    Route::get('/user', [AuthController::class, 'user']);
    Route::get('logout', [AuthController::class, 'logout']);

    Route::post('chooseUsername', [AuthController::class, 'chooseUsername']);
    Route::post('version', [AuthController::class, 'versionWithAuth']);

    Route::apiResource('state.city', CityController::class)->shallow()->only(["index"]);
    Route::apiResource('state', StateController::class)->only(["index"]);

    Route::get('asset', [AssetController::class, 'indexAPI']);
    Route::get('asset/{asset}/form', [FormController::class, 'indexAPI']);
    Route::get('form/{form}', [FormController::class, 'showAPI']);
    Route::get("form/{form}/{userAssetId}", [FormController::class, "showAPI"]);

    Route::apiResource('form_field', FormFieldController::class);
    Route::apiResource('user_forms_data', UserFormController::class)->except("store");

    Route::post("user_forms_data/{user_asset}", [UserFormController::class, 'store'])->middleware('can:update,user_asset');

    Route::post("user_sub_forms_data/{user_sub_asset}", [UserFormController::class, 'storeSub']);

    Route::get('asset/user_assets', [UserAssetController::class, 'all']);

    Route::apiResource('asset.user_asset', UserAssetController::class)->shallow();

    Route::get("get_sub_asset/{form}", [UserSubAssetController::class, "sub_asset"]);

    Route::group(["prefix" => "user_asset/{user_asset}", "middleware" => ['can:update,user_asset']], function () {

        Route::put("updateStatus", [UserAssetController::class, "updateStatus"]);

        Route::post("set_asset_pic/{form_field}", [UserFormController::class, 'set_asset_pic']);

        Route::post("set_pic/{form_field}", [UserFormController::class, 'set_pic']);

        Route::delete("delete_pic_from_gallery/{form_field}", [UserFormController::class, 'delete_pic_from_gallery']);

        Route::post("add_pic_to_gallery/{form_field}", [UserFormController::class, 'add_pic_to_gallery']);

        Route::post("add_video_to_gallery/{form_field}", [UserFormController::class, 'add_video_to_gallery']);

        Route::post("add_pic_to_gallery_sub/{form_field}/{sub_asset}/{user_sub_asset_id}", [UserFormController::class, 'add_pic_to_gallery_sub']);

        Route::post("add_video_to_gallery_sub/{form_field}/{sub_asset}/{user_sub_asset_id}", [UserFormController::class, 'add_video_to_gallery_sub']);

        Route::post("edit_pic_gallery/{form_field}/{curr_file}", [UserFormController::class, 'edit_pic_gallery']);
    });

    Route::group(['prefix' => "user_sub_asset/{user_sub_asset}", "middleware" => ['can:update,user_sub_asset']], function () {

        Route::delete('/', [UserSubAssetController::class, 'destroy']);

        Route::post("edit_pic_gallery_sub/{form_field}/{curr_file}", [UserSubAssetController::class, 'edit_pic_gallery_sub']);

        Route::delete("delete_pic_from_gallery_sub/{form_field}", [UserSubAssetController::class, 'delete_pic_from_gallery_sub']);

    });

});

Route::get('version', [AuthController::class, 'version']);
Route::post('activation_code', [AuthController::class, 'activation_code']);
Route::post('login', [AuthController::class, 'login']);


Route::get("test", [AssetController::class, "getVillage"]);


Route::get("getVillage", [AssetController::class, "getVillage"]);

Route::put("getVillage", [AssetController::class, "setGeom"]);

Route::post('koochita', function (Illuminate\Http\Request $request) {

    $key = $request["key"];
    
    $cities = \Illuminate\Support\Facades\DB::connection("mysql2")->select("select concat(name, ' در ', (select name from state where id = stateId)) as name from cities where isVillage = 0 and name like '%" . $key . "%'");
    $out = [];
    $counter = 0;

    foreach ($cities as $city) {
        $out[$counter++] = $city->name;
    }
    return response()->json([
        "status" => "0",
        "result" => $out
    ]);
});

Route::post('koochita_has_exist', function (Illuminate\Http\Request $request) {

    $key = $request["key"];
    $id = \Illuminate\Support\Facades\DB::connection("mysql2")->select("select id from cities where isVillage = 0 and name = '" . $key . "'");

    if($id == null || count($id) == 0)
        return response()->json([
            "status" => "-1"
        ]);

    return response()->json([
        "status" => "0"
    ]);
});