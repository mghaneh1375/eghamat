<?php

namespace App\Http\Controllers;

use App\Http\Resources\UserAssetDigest;
use App\models\Asset;
use App\models\UserAsset;
use App\models\UserFormsData;
use App\models\UserSubAsset;
use App\Rules\InForm;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class UserAssetController extends Controller
{

//    public function __construct()
//    {
//        $this->authorizeResource(UserAsset::class);
//    }

    /**
     * Display a listing of the resource.
     *
     * @param Asset $asset
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Asset $asset) {
        return response()->json([
            "status" => "0",
            "assets" => UserAssetDigest::collection($asset->user_assets()->where('user_id', Auth::user()->id)->get())
        ]);
    }

    public function all(Request $request) {

        $assets = Asset::all();
        $output = [];
        $uId = Auth::user()->id;

        foreach($assets as $asset) {

            $userAssets = $asset->user_assets()->where('user_id', $uId)->get();

            if(count($userAssets) == 0)
                continue;

            $tmp = UserAssetDigest::collection($userAssets)->toArray($request);
            $arr = [];
            
            foreach($tmp as $itr) {
                $itr['asset'] = $asset->name;
                $itr['assetId'] = $asset->id;
                array_push($arr, $itr);
            }

            array_push($output, $arr);
        }

        return response()->json([
            "status" => "0",
            "assets" => $output
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Asset $asset
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Asset $asset, Request $request)
    {
        $form_fields = $asset->forms()->where("step", 1)->first()->form_fields()->select("id")->get();

        $request->validate([
            "id" => ["required", "exists:form_fields,id", new InForm($form_fields)],
            "data" => ["required"]
        ]);

        $title = $request["data"];
        $user = Auth::user();

        // $token = self::createToken();

        // $apiRes = Http::asForm()->withoutVerifying()->post(self::$apiBaseUrl . "addUser", [
        //     "token" => $token[0],
        //     "time" => $token[1],
        //     "data" => $title,
        //     "parentUsername" => $user->name,
        // ]);

        // if(!$apiRes->successful()) {
        //     return response()->json([
        //         "status" => "-1",
        //         "err" => "نام انتخابی شما در سیستم موجود است."
        //     ]);
        // }

        // $apiRes = $apiRes->json();
        // if(!isset($apiRes["status"]) || $apiRes["status"] != "0") {
        //     return response()->json([
        //         "status" => "-1",
        //         "err" => "نام انتخابی شما در سیستم موجود است."
        //     ]);
        // }

        $user_asset = new UserAsset();
        $user_asset->asset_id = $asset->id;
        $user_asset->user_id = $user->id;
        $user_asset->title = $title;

        $user_asset->save();

        return response()->json([
            "status" => "0", "id" => $user_asset->id
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\models\UserAsset  $userAsset
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     */
    public function show(UserAsset $userAsset) {

        
        $forms = $userAsset->asset->forms()->where("step", ">", 1)->get();
        
        $userId = $userAsset->user_id;

        foreach ($forms as $form) {

            $isSubAsset = ($form->asset->super_id != -1);
            if($isSubAsset) {
                $tmp = UserSubAsset::whereUserId($userId)->whereAssetId($form->asset->id)->whereUserAssetId($userAsset->id)->first();
                $userAssetId = ($tmp == null) ? -1 : $tmp->id;
            }
            else
                $userAssetId = $userAsset->id;

            $form->fields = $form->form_fields()->where("type", "!=", "REDIRECTOR")->leftJoin("user_forms_data", function ($join) use ($userId, $isSubAsset, $userAssetId) {
                $join->on("form_fields.id", "=", "field_id")->where('user_id', $userId)->where('is_sub_asset', $isSubAsset)->where('user_asset_id', $userAssetId);
            })->select(['name', 'type', 'data'])->get();

        }

        // return response()->json([
        //     'status' => '0',
        //     'forms' => $forms
        // ]);

        return view('report.field', ['forms' => $forms]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\models\UserAsset  $userAsset
     * @return \Illuminate\Http\JsonResponse
     */
    public function update(UserAsset $userAsset, Request $request) {

        $request->validate([
            "data" => "required"
        ]);

        $title = $request["data"];

        if($userAsset->title == $title) {
            return response()->json([
                "status" => "0"
            ]);
        }

        // $token = self::createToken();
        // $apiRes = Http::asForm()->withoutVerifying()->post(self::$apiBaseUrl . "updateUserName", [
        //     "token" => $token[0],
        //     "time" => $token[1],
        //     "oldUsername" => $userAsset->title,
        //     "newUsername" => $title
        // ]);

        // if(!$apiRes->successful()) {
        //     return response()->json([
        //         "status" => "-1",
        //         "err" => "نام انتخابی شما در سیستم موجود است."
        //     ]);
        // }

        // $apiRes = $apiRes->json();
        // if(!isset($apiRes["status"]) || $apiRes["status"] != "0") {
        //     return response()->json([
        //         "status" => "-1",
        //         "err" => "نام انتخابی شما در سیستم موجود است."
        //     ]);
        // }

        $userAsset->title = $title;
        $userAsset->save();

        return response()->json([
            "status" => "0"
        ]);

    }

    private function hasUserAnswerToThisField($userFormsData, $fieldId) {

        foreach($userFormsData as $data) {

            if($data->field_id == $fieldId)
                return true;

        }

        return false;
        
    }

    private function checkAsset($asset, $userFormsData, $userAssetId) {

        $forms = $asset->forms;
        $errs = [];

        foreach($forms as $form) {

            if($form->step == 1)
                continue;

            $fields = $form->form_fields;

            foreach($fields as $field) {

                if($field->type == 'LISTVIEW') {

                    $subAssetId = explode('_', $field->options)[1];
                    if(UserSubAsset::whereAssetId($subAssetId)->whereUserAssetId($userAssetId)->count() == 0)
                        array_push($errs, $form->name . " : " . $field->name);

                    continue;
                }
                

                if($field->necessary && !$this->hasUserAnswerToThisField($userFormsData, $field->id))
                    array_push($errs, $form->name . " : " . $field->name);

            }
        }

        return $errs;
    }

    public function updateStatus(UserAsset $userAsset) {
        
        $userFormsData = $userAsset->user_forms_data()->get();
        
        $errs = $this->checkAsset($userAsset->asset, $userFormsData, $userAsset->id);

        if(count($errs) > 0) {
            return response()->json([
                'status' => -2,
                'errs' => $errs
            ]);
        }
        

        $userAsset->status = "PENDING";
        $userAsset->save();

        return response()->json([
            "status" => "0"
        ]);

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\models\UserAsset  $userAsset
     * @return \Illuminate\Http\JsonResponse
     */
    public static function destroy(UserAsset $userAsset) {

        try {

            DB::transaction(function () use ($userAsset) {

                $pic = $userAsset->pic;

                if($pic != null) {

                    if (file_exists(__DIR__ . '/../../../storage/app/public/' . $pic))
                        unlink(__DIR__ . '/../../../storage/app/public/' . $pic);
                }

                $userFormsData = UserFormsData::whereUserAssetId($userAsset->id)->whereIsSubAsset(false)->get();

                foreach ($userFormsData as $itr) {
                    if (strpos($itr->data, "assets/") !== false &&
                        file_exists(__DIR__ . '/../../../storage/app/' . $itr->data)) {
                        unlink(__DIR__ . '/../../../storage/app/' . $itr->data);
                    }

                    $itr->delete();
                }

                $assets = Asset::whereSuperId($userAsset->asset_id)->get();
                foreach ($assets as $asset) {
                    $userSubAssets = $asset->user_sub_assets;
                    foreach ($userSubAssets as $userSubAsset)
                        UserSubAssetController::destroy($userSubAsset);
                }

                $userAsset->delete();
            });

            return response()->json([
                "status" => "0"
            ]);

        }
        catch (\Exception $x) {}

        return response()->json([
            "status" => "-1"
        ]);

    }
}
