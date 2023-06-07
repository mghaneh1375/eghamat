@extends('layouts.structure')

@section('header')
    @parent
@stop

@section('content')

    <form method="post" action="{{route('doLogin')}}">

        {{csrf_field()}}

        <div class="login-form-area mg-t-30 mg-b-40">
            <div class="container-fluid">
                <div class="row" style="direction: rtl">
                    <div class="col-lg-4"></div>
                    <div class="col-lg-4">
                        <div class="login-bg">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="logo">
                                        <a href="#"><img src="{{URL::asset('img/logo.png')}}" alt="" />
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="login-title">
                                        <h1>فرم ورود</h1>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="login-input-area">
                                        <input type="tel" name="phone" />
                                        <i class="fa fa-user login-user" aria-hidden="true"></i>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="login-input-head">
                                        <p>شماره همراه</p>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-lg-8">
                                    <div class="login-input-area">
                                        <input type="password" name="password" />
                                        <i class="fa fa-lock login-user"></i>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="login-input-head">
                                        <p>رمزعبور</p>
                                    </div>
                                </div>
                            </div>
                            <center class="row">
                                <div>
                                    <input type="submit" class="btn btn-success" value="ورود">
                                    <p style="margin-top: 10px">{{$msg}}</p>
                                </div>
                            </center>
                        </div>
                    </div>
                    <div class="col-lg-4"></div>
                </div>
            </div>
        </div>

    </form>
@stop
