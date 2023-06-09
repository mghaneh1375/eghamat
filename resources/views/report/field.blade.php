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
                    <h1>پاسخ های کاربر</h1>
                </div>
            </div>

            <div class="sparkline8-graph dashone-comment messages-scrollbar dashtwo-messages">

                <center class="row">

                    <div style="direction: rtl" class="col-xs-12">

                        @foreach($forms as $form)

                            <h3 style="margin-top: 20px">{{$form->name}}</h3>

                            <table>
                                <tr>
                                    <td>سوال</td>
                                    <td>نوع سوال</td>
                                    <td>پاسخ</td>
                                </tr>

                                @foreach($form->fields as $field)
                                    <tr>
                                        <td>{{$field->name}}</td>
                                        <td>{{$field->type}}</td>
                                        <td>
                                            @if($field->data == null || empty($field->data))
                                                پاسخی ثبت نشده است
                                            @else
                                                @if($field->type == "MAP")
                                                    <?php $tmp = explode('_', $field->data); $lat = $tmp[0]; $lng = $tmp[1]; ?>
                                                    <a target="_blank" href="https://www.google.com/maps/?q={{$lat}},{{$lng}}">کلیک کنید</a>
                                                @else
                                                    {{$field->data}}
                                                @endif
                                            @endif
                                        </td>
                                    </tr>
                                @endforeach

                            </table>

                        @endforeach
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
