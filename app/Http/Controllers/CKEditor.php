<?php

namespace App\Http\Controllers;

use App\models\UserFormsData;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\URL;

class CKEditor extends Controller {

    public function storePic(UserFormsData $userFormsData, Request $request) {

        if($userFormsData->user_id != Auth::user()->id) {
            return response()->json(["status" => "nok"]);
        }

        $request->validate([
            "pic" => "image"
        ]);

        $path = $request->pic->store('public');
        $path = str_replace('public/', '', $path);

        return response()->json([
            "status" => "0",
            "data" => URL::asset("storage/" . $path)
        ]);
    }

    public function showEmpty() {
        return view('ckeditor', ['data' => '']);
    }

    public function show(UserFormsData $userFormsData) {

        if($userFormsData->form_field->type != "CKEDITOR" ||
            $userFormsData->user_id != Auth::user()->id) {
            return response()->json([
                "status" => "nok"
            ]);
        }

        return view('ckeditor', ['data' => $userFormsData->data]);
    }
}