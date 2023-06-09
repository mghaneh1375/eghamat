@extends('layouts.structure')

@section('header')
    @parent
@stop

@section('content')

    <div class="col-md-1"></div>

    <div class="col-md-10">
        <div class="sparkline8-list shadow-reset mg-tb-30">
            <div class="sparkline8-hd">
                <div class="main-sparkline8-hd">
                    <h1>assets</h1>
                </div>
            </div>

            <div class="sparkline8-graph dashone-comment messages-scrollbar dashtwo-messages">

                <center class="row">

                    <div style="direction: rtl" class="col-xs-12">
                        <table>
                            <tr>
                                <td>دسته</td>
                                <td>نام</td>
                                <td>تصویر شاخص</td>
                                <td>وضعیت</td>
                                <td>عملیات</td>
                            </tr>
                            @foreach($userAssets as $asset)

                                <tr id="tr_{{$asset->id}}">
                                    <td>{{$asset->asset->name}}</td>
                                    <td>{{$asset->title}}</td>
                                    <td><img width="100px" src="{{URL::asset('storage/' . $asset->pic)}}"></td>
                                    <td id="status_{{$asset->id}}">{{$asset->status}}</td>
                                    <td>
                                        <a class="btn btn-success" href="{{url('user_asset/' . $asset->id)}}">مشاهده پاسخ کاربر</a>

                                        @if($asset->status != "INIT")
                                            <button data-toggle="modal" data-target="#editModal" onclick="changeStatus('{{$asset->id}}')" class="btn btn-primary">تغییر وضعیت</button>
                                        @endif

                                        <button class="btn btn-danger" onclick="remove('{{$asset->id}}')">حذف</button>
                                    </td>
                                </tr>

                            @endforeach

                        </table>
                    </div>

                </center>

            </div>
        </div>
    </div>

    <div class="col-xs-1"></div>

    <div id="editModal" class="modal fade" role="dialog">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">تغییر وضعیت</h4>
                </div>
                <div class="modal-body">

                    <center>
                        <p>وضعیت مورد نظر</p>
                        <select id="status" name="status">
                            <option value="PENDING">PENDING</option>
                            <option value="REJECT">REJECT</option>
                            <option value="CONFIRM">CONFIRM</option>
                        </select>
                    </center>

                </div>
                <div class="modal-footer">
                    <button id="closeModalBtn" type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                    <input onclick="doChangeStatus()" type="submit" class="btn btn-success" value="تایید">
                </div>
            </div>

        </div>
    </div>

    <div id="removeModal" class="modal fade" role="dialog">

        <div class="modal-dialog">

            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">حذف دارایی کاربر</h4>
                </div>
                <div class="modal-body">
                    <h3>آیا از حذف دارایی کاربر اطمینان دارید؟</h3>
                </div>
                <div class="modal-footer">
                    <button id="closeRemoveModalBtn" type="button" class="btn btn-default" data-dismiss="modal">انصراف</button>
                    <input onclick="doRemove()" type="submit" class="btn btn-success" value="تایید">
                </div>
            </div>

        </div>
    </div>

    <script>

        var selectedId = -1;

        function remove(id) {
            selectedId = id;
        }

        function doRemove() {

            $.ajax({
                type: "DELETE",
                url: '{{url('user_asset')}}' + "/" + selectedId,
                success: function (res) {
                    if(res.status == "0") {
                        $("#tr_" + selectedId).remove();
                        $("#closeRemoveModalBtn").click();
                    }
                }
            });
        }

        function changeStatus(id) {
            selectedId = id;
        }

        function doChangeStatus() {

            var newStatus = $("#status").val();

            $.ajax({
                type: 'post',
                url: '{{url('setAssetStatus')}}' + "/" + selectedId,
                data: {
                    'status': newStatus
                },
                success: function (res) {

                    if(res.status == "0") {
                        $("#closeModalBtn").click();
                        $("#status_" + selectedId).empty().append(newStatus);
                    }
                }
            });

        }
        
    </script>
    
@stop
