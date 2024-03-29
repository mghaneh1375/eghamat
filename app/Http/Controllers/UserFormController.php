<?php

namespace App\Http\Controllers;

use App\models\Asset;
use App\models\FormField;
use App\models\Image;
use App\models\Notification;
use App\models\UserAsset;
use App\models\UserFormsData;
use App\models\UserSubAsset;
use App\Rules\UserSubAssetExist;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\URL;

class UserFormController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param UserAsset $user_asset
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(UserAsset $user_asset, Request $request) {

        $request->validate([
            "data" => "required|array",
            "data.*.id" => ["bail", "required", "integer", "exists:form_fields,id"],
            "sub_asset_id" => ['nullable', "exists:assets,id"],
            "user_sub_asset_id" => ['nullable', new UserSubAssetExist(($request->has("sub_asset_id") ? $request["sub_asset_id"] : -1), true)]
        ]);

        $uId = Auth::user()->id;
        $userAssetId = $user_asset->id;
        $userSubAsset = null;
        $userSubAssetId = null;

        if($request->has("user_sub_asset_id")) {

            $userSubAssetId = $request["user_sub_asset_id"];

            if($request["user_sub_asset_id"] != -1) {
                $userSubAsset = UserSubAsset::whereId($request["user_sub_asset_id"])->first();
                if($userSubAsset == null) {
                    return response()->json([
                        "status" => -1
                    ]);
                }
            }
        }


        if($userSubAssetId != null) {
            if ($userSubAssetId == -1 && $request->has("sub_asset_id")) {
                $userSubAsset = new UserSubAsset();
                $userSubAsset->user_id = $uId;
                $userSubAsset->asset_id = $request["sub_asset_id"];
                $userSubAsset->user_asset_id = $user_asset->id;
                $userSubAsset->save();

                $userAssetId = $userSubAsset->id;
            }
            else if($userSubAssetId != -1)
                $userAssetId = $userSubAssetId;
        }

        $isSubAsset = ($userSubAssetId != null);
        $formFields = [];
        $errs = [];

        foreach($request['data'] as $d) {

            $id = $d['id'];
            $formField = FormField::whereId($id)->first();
            array_push($formFields, $formField);

            if(!isset($d['data']) || empty($d['data'])) {

                if($formField->necessary) {
                    array_push($errs, ($formField->err == null || empty($formField->err)) ? "داده وارد شده برای فیلد " . $formField->name . " نامعتبر است. " : $formField->err);
                    continue;
                }

            }

            $data = $d["data"];

            if(!$formField->validateData($data)) {
                array_push($errs, ($formField->err == null || empty($formField->err)) ? "داده وارد شده برای فیلد " . $formField->name . " نامعتبر است. " : $formField->err);
                    continue;
            }

            if(!$request->has("user_sub_asset_id") && !$user_asset->is_in_form($id)) {
                return response()->json([
                    "status" => -1
                ]);
            }

            else if($userSubAsset != null && !$userSubAsset->is_in_form($id)) {
                return response()->json([
                    "status" => -1
                ]);
            }

            if(!$formField->validateData($data, true)) {
                array_push($errs, ($formField->err == null || empty($formField->err)) ? "داده وارد شده برای فیلد " . $formField->name . " نامعتبر است. " : $formField->err);
            }

        }

        if(count($errs) > 0) {
            return response()->json([
                "status" => -2,
                "errs" => $errs
            ]);
        }

        $i = -1;

        foreach($request['data'] as $d) {

            $i++;
            $formField = $formFields[$i];
            $id = $d['id'];
            $field = $id;
            $data = $d['data'];

            $user_data = UserFormsData::whereFieldId($field)->whereUserId($uId)->whereUserAssetId($userAssetId)->firstOr(function () use ($field, $data, $uId, $userAssetId, $isSubAsset) {

                $user_data = new UserFormsData();
                $user_data->field_id = $field;
                $user_data->user_id = $uId;
                $user_data->data = $data;
                $user_data->user_asset_id = $userAssetId;
                $user_data->is_sub_asset = $isSubAsset;
                $user_data->save();
                return null;
                
            });

            if($formField->type == "API") {

                // $apiRes = Http::post($formField->options . "_has_exist", [
                //     "key" => $data
                // ])->json();

                // if($apiRes["status"] == "-1") {
                //     $notification = new Notification();
                //     $notification->msg = "تقاضای افزودن شهر جدید به نام " . $data;
                //     $notification->user_asset_id = $userAssetId;
                //     $notification->save();
                // }
            }

            if($user_data != null) {
                $user_data->data = $data;
                $user_data->save();
            }

        }
        
        return response()->json([
            "status" => 0,
            "id" => $userAssetId
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param UserSubAsset $user_sub_asset
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function storeSub(UserSubAsset $user_sub_asset, Request $request) {

        $request->validate([
            "id" => ["bail", "required", "exists:form_fields,id"],
            "sub_sub_asset_id" => ['nullable', "exists:assets,id"],
            "user_sub_sub_asset_id" => ['nullable', new UserSubAssetExist(($request->has("sub_sub_asset_id") ? $request["sub_sub_asset_id"] : -1), true)]
        ]);

        $formField = FormField::whereId($request["id"])->first();

        if(!$request->has("data") || empty($request["data"])) {

            if($formField->necessary) {
                return response()->json([
                    "status" => -2,
                    "err" => ($formField->err == null || empty($formField->err)) ? "داده وارد شده برای فیلد " . $formField->name . " نامعتبر است. " : $formField->err
                ]);
            }

            return response()->json([
                "status" => 0
            ]);
        }

        if(!$formField->validateData($request["data"])) {
            return response()->json([
                "status" => -2,
                "err" => ($formField->err == null || empty($formField->err)) ? "داده وارد شده برای فیلد " . $formField->name . " نامعتبر است. " : $formField->err
            ]);
        }

        $uId = Auth::user()->id;

        // if(!$request->has("user_sub_sub_asset_id") && !$user_sub_asset->is_in_form($request["id"])) {
        //    return response()->json([
        //        "status" => -1
        //    ]);
        // }
        // else
         
        if($request->has("user_sub_sub_asset_id")) {
            $userSubSubAsset = UserSubAsset::whereId($request["user_sub_sub_asset_id"])->first();
            if($userSubSubAsset == null || $userSubSubAsset->user_id != $uId ||
                !$userSubSubAsset->is_in_form($request["id"])) {
                return response()->json([
                    "status" => -1
                ]);
            }
        }

        $userSubSubAssetId = null;
        $userSubAssetId = $user_sub_asset->id;

        if($request->has("user_sub_sub_asset_id"))
            $userSubSubAssetId = $request["user_sub_sub_asset_id"];
        else if($request->has("sub_sub_asset_id")) {

            $userSubSubAsset = new UserSubAsset();
            $userSubSubAsset->user_id = $uId;
            $userSubSubAsset->asset_id = $request["sub_sub_asset_id"];
            $userSubSubAsset->user_asset_id = $userSubAssetId;
            $userSubSubAsset->save();

            $userSubSubAssetId = $userSubSubAsset->id;
        }

        $data = $request["data"];
        $field = $request["id"];

        $user_data = UserFormsData::whereFieldId($field)->whereUserId($uId)->whereUserAssetId($userSubSubAssetId)->firstOr(function () use ($field, $data, $uId, $userSubSubAssetId) {
            $user_data = new UserFormsData();
            $user_data->field_id = $field;
            $user_data->user_id = $uId;
            $user_data->data = $data;
            $user_data->user_asset_id = $userSubSubAssetId;
            $user_data->is_sub_asset = true;
            $user_data->save();
            return null;
        });

        if($formField->type == "API") {

            $apiRes = Http::post($formField->options . "_has_exist", [
                "key" => $data
            ])->json();

            if($apiRes["status"] == "-1") {
                $notification = new Notification();
                $notification->msg = "تقاضای افزودن شهر جدید به نام " . $data;
                $notification->user_asset_id = $userSubSubAssetId;
                $notification->save();
            }
        }

        if($user_data != null) {
            $user_data->data = $data;
            $user_data->save();
        }

        return response()->json([
            "status" => 0,
            "id" => $userSubSubAssetId
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \App\models\UserAsset $userAsset
     * @param \App\models\FormField $form_field
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function set_pic(UserAsset $userAsset, FormField $form_field, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        $request->validate([
            "pic" => "image"
        ]);

        $uId = Auth::user()->id;
        $path = $request->pic->store('public');
        $formFieldId = $form_field->id;
        $userAssetId = $userAsset->id;

        $userFormData = UserFormsData::whereUserId($uId)->whereFieldId($form_field->id)->whereUserAssetId($userAssetId)->whereIsSubAsset(false)->firstOr(function () use ($uId, $formFieldId, $path, $userAssetId) {
            $user_data = new UserFormsData();
            $user_data->field_id = $formFieldId;
            $user_data->user_id = $uId;
            $user_data->data = $path;
            $user_data->user_asset_id = $userAssetId;
            $user_data->is_sub_asset = false;
            $user_data->save();
            return null;
        });

        if($userFormData == null) {
            return response()->json([
                "status" => "0"
            ]);
        }

        $oldPath = null;
        if($userFormData->data != null)
            $oldPath = __DIR__ . '/../../../storage/app/public/' . $userFormData->data;

        $userFormData->data = $path;
        $userFormData->save();

        if($oldPath != null && file_exists($oldPath))
            unlink($oldPath);

        return response()->json([
            "status" => "0"
        ]);

    }

    /**
     * Update the specified resource in storage.
     *
     * @param \App\models\UserAsset $userAsset
     * @param \App\models\FormField $form_field
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function set_asset_pic(UserAsset $userAsset, FormField $form_field, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        $request->validate([
            "pic" => "image"
        ]);

        $path = $request->pic->store('public');
        $oldPath = null;

        if($userAsset->pic != null)
            $oldPath = __DIR__ . '/../../../storage/app/public/' . $userAsset->pic;

        $userAsset->pic = str_replace("public/", "", $path);
        $userAsset->save();

        if($oldPath != null && file_exists($oldPath))
            unlink($oldPath);

        return response()->json([
            "status" => "0"
        ]);

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\models\UserFormsData  $userFormsData
     * @return \Illuminate\Http\Response
     */
    public function show(UserFormsData $userFormsData)
    {
        //
    }

    public function delete_pic_from_gallery(UserAsset $userAsset, FormField $form_field, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, false, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        $request->validate([
            "pic" => "required"
        ]);

        $uId = Auth::user()->id;
        $data = UserFormsData::whereUserId($uId)->whereFieldId($form_field->id)
            ->whereUserAssetId($userAsset->id)->whereIsSubAsset(false)->first();

        if($data == null) {
            return response()->json([
                "status" => -1
            ]);
        }

        $pic = $request["pic"];
        $pic = explode('/', $pic);
        $pic = "public/" . $pic[count($pic) - 1];

        $image = Image::wherePath($pic)->first();
        if($image == null) {
            return response()->json([
                "status" => -1
            ]);
        }

        $vals = explode('_', $data->data);
        $find = false;
        $newData = "";
        $first = true;

        foreach ($vals as $itr) {
            if(!$find && $itr == $image->id) {
                $find = true;
                if(file_exists(__DIR__ . '/../../../storage/app/' . $pic))
                    unlink(__DIR__ . '/../../../storage/app/' . $pic);
                $image->delete();
            }
            else {
                if($first) {
                    $newData .= $itr;
                    $first = false;
                }
                else
                    $newData .= "_" . $itr;
            }
        }

        if(!$find) {
            return response()->json([
                "status" => -1
            ]);
        }

        $data->data = $newData;
        $data->save();

        $splited = explode('_', $data->data);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out
        ]);
    }

    public function add_pic_to_gallery(UserAsset $userAsset, FormField $form_field, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, false, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        $request->validate([
            "pic" => "image"
        ]);

        $uId = Auth::user()->id;
        $userAssetId = $userAsset->id;
        $fieldId = $form_field->id;

        $data = UserFormsData::whereUserId($uId)->whereFieldId($fieldId)
            ->whereUserAssetId($userAssetId)->whereIsSubAsset(false)
            ->firstOr(function () use ($uId, $fieldId, $userAssetId) {
                $data = new UserFormsData();
                $data->data = '';
                $data->user_asset_id = $userAssetId;
                $data->field_id = $fieldId;
                $data->user_id = $uId;
                $data->is_sub_asset = false;
                $data->save();

                return $data;
            });

        $path = $request->pic->store('public');

        $newImage = new Image();
        $newImage->path = $path;
        $newImage->name = ($request->has("name")) ? $request["name"] : null;
        $newImage->description = ($request->has("description")) ? $request["description"] : null;
        $newImage->save();

        if(empty($data->data))
            $data->data = $newImage->id;
        else
            $data->data .= "_" . $newImage->id;

        $data->save();

        $splited = explode('_', $data->data);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out
        ]);

    }

    public function add_video_to_gallery(UserAsset $userAsset, FormField $form_field, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, false, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        if(!$request->has("video")) {
            return response()->json([
                "status" => -2
            ]);
        }

        $file = $request->video;
        $mime = $file->getMimeType();

        if($mime != "video/x-flv" && $mime != "video/mp4" && $mime != "video/quicktime" &&
            $mime != "video/x-msvideo" && $mime != "video/x-ms-wmv") {
            return response()->json([
                "status" => -3
            ]);
        }

        $uId = Auth::user()->id;
        $userAssetId = $userAsset->id;
        $fieldId = $form_field->id;

        $data = UserFormsData::whereUserId($uId)->whereFieldId($fieldId)
            ->whereUserAssetId($userAssetId)->whereIsSubAsset(false)
            ->firstOr(function () use ($uId, $fieldId, $userAssetId) {
                $data = new UserFormsData();
                $data->data = '';
                $data->user_asset_id = $userAssetId;
                $data->field_id = $fieldId;
                $data->user_id = $uId;
                $data->is_sub_asset = false;
                $data->save();

                return $data;
            });

        $path = $request->video->store('public');

        $newImage = new Image();
        $newImage->path = $path;
        $newImage->name = ($request->has("name")) ? $request["name"] : null;
        $newImage->description = ($request->has("description")) ? $request["description"] : null;
        $newImage->save();

        if(empty($data->data))
            $data->data = $newImage->id;
        else
            $data->data .= "_" . $newImage->id;

        $data->save();

        $splited = explode('_', $data->data);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out
        ]);

    }

    public function add_pic_to_gallery_sub(UserAsset $userAsset, FormField $form_field, Asset $sub_asset, $user_sub_asset_id, Request $request) {

        $uId = Auth::user()->id;

        $request->validate([
            "pic" => "image"
        ]);

        $userSubAsset = null;

        if($user_sub_asset_id == -1) {
            $userSubAsset = new UserSubAsset();
            $userSubAsset->user_id = $uId;
            $userSubAsset->asset_id = $sub_asset->id;
            $userSubAsset->user_asset_id = $userAsset->id;
            $userSubAsset->save();
            $user_sub_asset_id = $userSubAsset->id;
        }
        else
            $userSubAsset = UserSubAsset::whereId($user_sub_asset_id)->whereUserId($uId)->whereAssetId($sub_asset->id)->first();

        if($userSubAsset == null) {
            return response()->json([
                "status" => -1
            ]);
        }

        if(!$userSubAsset->is_in_form($form_field->id, false, true)) {

            if($user_sub_asset_id == -1)
                $userSubAsset->delete();

            return response()->json([
                "status" => -1
            ]);
        }

        $fieldId = $form_field->id;

        $data = UserFormsData::whereUserId($uId)->whereFieldId($fieldId)
            ->whereUserAssetId($user_sub_asset_id)->whereIsSubAsset(true)
            ->firstOr(function () use ($uId, $fieldId, $user_sub_asset_id) {
                $data = new UserFormsData();
                $data->user_id = $uId;
                $data->user_asset_id = $user_sub_asset_id;
                $data->data = "";
                $data->field_id = $fieldId;
                $data->is_sub_asset = true;
                $data->save();

                return $data;
            });

        $path = $request->pic->store('public');

        $newImage = new Image();
        $newImage->path = str_replace("public/", "", $path);
        $newImage->name = ($request->has("name")) ? $request["name"] : null;
        $newImage->description = ($request->has("description")) ? $request["description"] : null;
        $newImage->save();

        if(empty($data->data))
            $data->data = $newImage->id;
        else
            $data->data .= "_" . $newImage->id;

        $data->save();

        $splited = explode('_', $data->data);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out,
            "id" => $user_sub_asset_id
        ]);

    }

    public function add_video_to_gallery_sub(UserAsset $userAsset, FormField $form_field, Asset $sub_asset, $user_sub_asset_id, Request $request) {

        $uId = Auth::user()->id;

        if(!$request->has("video")) {
            return response()->json([
                "status" => -2
            ]);
        }

        $file = $request->video;
        $mime = $file->getMimeType();

        if($mime != "video/x-flv" && $mime != "video/mp4" && $mime != "video/quicktime" &&
            $mime != "video/x-msvideo" && $mime != "video/x-ms-wmv") {
            return response()->json([
                "status" => -3
            ]);
        }

        $userSubAsset = null;

        if($user_sub_asset_id == -1) {
            $userSubAsset = new UserSubAsset();
            $userSubAsset->user_id = $uId;
            $userSubAsset->asset_id = $sub_asset->id;
            $userSubAsset->user_asset_id = $userAsset->id;
            $userSubAsset->save();
            $user_sub_asset_id = $userSubAsset->id;
        }
        else
            $userSubAsset = UserSubAsset::whereId($user_sub_asset_id)->whereUserId($uId)->whereAssetId($sub_asset->id)->first();

        if($userSubAsset == null) {
            return response()->json([
                "status" => -1
            ]);
        }

        if(!$userSubAsset->is_in_form($form_field->id, false, true)) {

            if($user_sub_asset_id == -1)
                $userSubAsset->delete();

            return response()->json([
                "status" => -1
            ]);
        }

        $fieldId = $form_field->id;

        $data = UserFormsData::whereUserId($uId)->whereFieldId($fieldId)
            ->whereUserAssetId($user_sub_asset_id)->whereIsSubAsset(true)
            ->firstOr(function () use ($uId, $fieldId, $user_sub_asset_id) {
                $data = new UserFormsData();
                $data->user_id = $uId;
                $data->user_asset_id = $user_sub_asset_id;
                $data->data = "";
                $data->field_id = $fieldId;
                $data->is_sub_asset = true;
                $data->save();

                return $data;
            });

        $path = $request->video->store('public');

        $newImage = new Image();
        $newImage->path = str_replace("public/", "", $path);
        $newImage->name = ($request->has("name")) ? $request["name"] : null;
        $newImage->description = ($request->has("description")) ? $request["description"] : null;
        $newImage->save();

        if(empty($data->data))
            $data->data = $newImage->id;
        else
            $data->data .= "_" . $newImage->id;

        $data->save();

        $splited = explode('_', $data->data);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out,
            "id" => $user_sub_asset_id
        ]);

    }

    public function edit_pic_gallery(UserAsset $userAsset, FormField $form_field, $curr_file, Request $request) {

        if(!$userAsset->is_in_form($form_field->id, false, true)) {
            return response()->json([
                "status" => -1
            ]);
        }

        $request->validate([
            "pic" => "image"
        ]);

        $uId = Auth::user()->id;
        $pic = "public/" . $curr_file;

        $image = Image::wherePath($pic)->first();
        if($image == null) {
            return response()->json([
                "status" => -1
            ]);
        }

        $data = UserFormsData::whereUserId($uId)->whereFieldId($form_field->id)
            ->whereUserAssetId($userAsset->id)->whereIsSubAsset(false)->first();

        if($data == null || !in_array($image->id, explode('_', $data->data))) {
            return response()->json([
                "status" => -1
            ]);
        }

        $vals = explode('_', $data->data);
        $find = false;
        $newData = "";
        $first = true;

        foreach ($vals as $itr) {
            if(!$find && $itr == $image->id)
                $find = true;
            else {
                if($first) {
                    $newData .= $itr;
                    $first = false;
                }
                else
                    $newData .= "_" . $itr;
            }
        }

        if(!$find) {
            return response()->json([
                "status" => -1
            ]);
        }

        $path = $request->pic->store('public');

        if(file_exists(__DIR__ . '/../../../storage/app/' . $image->path))
            unlink(__DIR__ . '/../../../storage/app/' . $image->path);

        $image->delete();

        $image = new Image();
        $image->path = $path;
        $image->name = ($request->has("name")) ? $request["name"] : null;
        $image->description = ($request->has("description")) ? $request["description"] : null;
        $image->save();

        if(empty($newData))
            $newData = $image->id;
        else
            $newData .= "_" . $image->id;

        $data->data = $newData;
        $data->save();

        $splited = explode('_', $newData);
        $out = "";
        $first = true;

        foreach ($splited as $str) {

            $image = Image::whereId($str)->first();

            if($image == null)
                continue;

            if($first) {
                $first = false;
                $out .= URL::asset("storage/" . str_replace('public/', '', $image->path));
            }
            else
                $out .= '_' . URL::asset("storage/" . str_replace('public/', '', $image->path));
        }

        return response()->json([
            "status" => "0",
            "data" => $out
        ]);

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\models\UserFormsData  $userFormsData
     * @return \Illuminate\Http\Response
     */
    public function edit(UserFormsData $userFormsData)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\models\UserFormsData  $userFormsData
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, UserFormsData $userFormsData)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\models\UserFormsData  $userFormsData
     * @return \Illuminate\Http\Response
     */
    public function destroy(UserFormsData $userFormsData)
    {
        //
    }
}
