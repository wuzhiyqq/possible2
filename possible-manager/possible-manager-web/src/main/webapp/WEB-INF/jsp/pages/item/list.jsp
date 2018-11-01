<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>商品列表-后台管理系统-Wuzhi 1.0</title>
    <meta name="Description" content="基于layUI数据表格操作"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/treeselect.css">
    <%--<script type="text/javascript" src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/itemlist.js" charset="utf-8"></script>--%>

    <!--<script type="text/javascript" src="../../static/js/admin.js"></script>-->
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style type="text/css">
        .layui-form-switch {
            width: 55px;
        }
        .layui-form-switch em {
            width: 40px;
        }
        .layui-form-onswitch i {
            left: 45px;
        }
        body{overflow-y: scroll;}
    </style>
</head>

<body>
<div class="weadmin-nav">
			<span class="layui-breadcrumb">
        <a href="">首页</a>
        <a href="">商品管理</a>
        <a>
          <cite>商品列表</cite></a>
      </span>
    <a class="layui-btn layui-btn-sm" style="line-height:1.6em;margin-top:3px;float:right" href="javascript:location.replace(location.href);" title="刷新">
        <i class="layui-icon" style="line-height:30px">&#x1002;</i></a>
</div>
<div class="weadmin-body">
    <div class="layui-row">
        <form class="layui-form layui-col-md12 we-search" onsubmit="return false;">
            商品搜索：
            <div class="layui-inline">
                <input type="text" id="pname" name="pname" placeholder="请输入商品名称关键字" autocomplete="off" class="layui-input">
            </div>
            <button class="layui-btn" lay-submit="" lay-filter="search" data-type="reload"><i class="layui-icon">&#xe615;</i></button>
        </form>
    </div>
    <div class="weadmin-block demoTable">
        <button class="layui-btn layui-btn-danger" data-type="getCheckData"><i class="layui-icon">&#xe640;</i>批量删除</button>
        <button class="layui-btn" onclick="WeAdminShow('添加商品','./add',600,500)"><i class="layui-icon">&#xe61f;</i>添加</button>
    </div>
    <table class="layui-hide" id="articleList" lay-filter="myTable"></table>



    <script type="text/html" id="operateTpl">
        <%--<a title="查看" onclick="WeAdminShow('查看','./see', 2, 600, 400)" href="javascript:;">--%>
            <%--<i class="layui-icon">&#xe63c;</i>--%>
        <%--</a>--%>
        <%--<a title="编辑" onclick="WeAdminEdit('编辑','./edit', 2, 600, 400)" href="javascript:;">--%>
            <%--<i class="layui-icon">&#xe642;</i>--%>
        <%--</a>--%>
        <%--<a title="删除" onclick="delete(pid)"  href="javascript:;">--%>
            <%--<i class="layui-icon">&#xe640;</i>--%>
        <%--</a>--%>
        <a title="查看"  lay-event="detail"><i class="layui-icon">&#xe63c;</i></a>
        <a title="编辑"  lay-event="edit"><i class="layui-icon">&#xe642;</i></a>
        <a title="删除"  lay-event="del"><i class="layui-icon">&#xe640;</i></a>
    </script>
    <%--<script type="text/html" id="shelfTpl">--%>
        <%--<form class="layui-form">--%>
            <%--<input type="checkbox" name="itemstatus" lay-filter="itemstatus" lay-skin="switch" lay-text="正常|下架" {{1==d.status?'checked':''}}/>--%>
        <%--</form>--%>
    <%--</script>--%>
    <script type="text/html" id="myTpl">
        <div class="layui-form">
            <input type="checkbox" value="{{d.pid}}" id="is_hot" name="is_hot" lay-skin="switch" lay-filter="switch1" lay-text="热门|非热门" {{1==d.is_hot?'checked':''}}  />
        </div>
    </script>


    <script>
        layui.extend({
            admin: '{/}../../static/js/admin',
            treeselect: '{/}../../static/js/treeselect'
        });
        layui.use(['form', 'admin','table','jquery'], function(){
            var table = layui.table,
                $ = layui.jquery,
                form = layui.form;
            table.render({
                //elem\url\cols表格属性
                //type\field\title 表头属性
                //将数据绑定到这个容器上
                elem: '#articleList',
                //发送这个异步请求到后台
                url:'../../products',
                //表头
                cols:[[
                    {type: 'checkbox'},
                    {field: 'pid', title: '商品编号'},
                    {field: 'pname', title: '商品名称'},
                    {field: 'market_price', title: '市场价格'},
                    {field: 'shop_price', title: '商店价格'},
                    {field: 'is_hot', title: '是否热门',toolbar: '#myTpl'},
                    {field: 'pflag', title: '库存'},
                    {field: 'pdate', title: '修改时间', templet: '<div>{{ layui.laytpl.toDateString(d.pdate,\'yyyy-MM-dd\') }}</div>'},
                    {field: 'cname', title: '分类名称'},
                    {field : 'pid',title:'操作',toolbar: '#operateTpl'}
                ]],
                page: true,
            });
            //定义了一个空对象
            var active = {
                getCheckData: function () {
                    //获取到选中行
                    var data = table.checkStatus("articleList").data;

                    if (data.length > 0) {
                        //有被选中的行
                        //定义空数组
                        var ids = [];
                        //遍历选中行，取出里面的id设值到数组中
                        for (var i = 0; i < data.length; i++) {
                            ids.push(data[i].pid);
                        }
                        //异步请求
                        $.post(
                            //url:这次异步请求提交给后台的谁进行处理
                            '../../products/batch',
                            //data:这次异步请求提交什么数据给后台
                            {'ids[]':ids},
                            //success:异步请求执行成功之后的回调函数
                            function(data){
                                //至少删除一条记录
                                if (data > 0) {
                                    //停留在原来页面刷新
                                    $('.layui-laypage-btn').click();
                                    layer.msg("恭喜，删除成功！", {icon: 1});
                                }
                            }
                            //dataType:返回类型
//                            ,'json'
                        );
                    } else {
                        //没有选中行
                        layer.msg("请至少选中一行", {icon: 5});
                    }
                },
                reload:function(){
                    var pname = $('#pname').val();
                    if(pname != null && $.trim(pname).length>0 ){
                        //带条件重新加载表格
                        table.reload('articleList',{
                            //page
                            page: {curr:1},
                            //where
                            where:{pname:pname}
                        });
                    }
                },
            };

            //批量删除按钮的点击事件
            $('.demoTable .layui-btn-danger').on('click',function () {
                //获取按钮的data-type的值 //getCheckData
                var type = $(this).data('type');
                //在js存在一个对象，对象叫active
                active[type] ? active[type].call(this) : '';
            });
            //模糊查询按钮事件
            $('.weadmin-body .layui-btn').on('click',function(){
                //获取按钮的data-type的值,//reload
                var type = $(this).data('type');
                active[type] ? active[type].call(this) : '';
            });
            //修改是否热门信息
            form.on('switch(switch1)', function (data) {
                if(data.elem.checked){
                    var is_hot = 1;
                }else{
                    var is_hot = 0;
                }
                // 获取当前控件
                //var selectIfKey=data.othis;
                // 获取当前所在行
                //var parentTr = selectIfKey.parents("tr");
                //var pid = $(parentTr).find("td:eq(1)").find(".layui-table-cell").text();
                var param = "is_hot="+is_hot+"&pid="+data.value;
                    //修改商品是否热门
                    //异步请求
                    $.post(
                        //url:这次异步请求提交给后台的谁进行处理
                        '../../products/ishot',
                        //data:这次异步请求提交什么数据给后台
                        param,
                        //success:异步请求执行成功之后的回调函数
                        function(data){
                            //是否修改成功
                            if (data > 0) {
                                //停留在原来页面刷新
                                $('.layui-laypage-btn').click();
                                layer.msg("恭喜，修改成功！", {icon: 1});
                            }
                        }
                    );
            });
            //监听工具条
            table.on('tool(myTable)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
                var data = obj.data; //获得当前行数据
                var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
                var tr = obj.tr; //获得当前行 tr 的DOM对象
                var pid = data.pid;

                if(layEvent === 'detail'){ //查看
                    WeAdminEdit('查看', './see' ,data, 600, 500);
                } else if(layEvent === 'del'){ //删除
                    layer.confirm('真的删除行么', function(index){
                        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                        layer.close(index);
                        //向服务端发送删除指令
                        //异步请求
                        $.post(
                            //url:这次异步请求提交给后台的谁进行处理
                            '../../products/batch',
                            //data:这次异步请求提交什么数据给后台
                            {'ids[]':pid},
                            //success:异步请求执行成功之后的回调函数
                            function(data){
                                //至少删除一条记录
                                if (data > 0) {
                                    //停留在原来页面刷新
                                    $('.layui-laypage-btn').click();
                                    layer.msg("恭喜，删除成功！", {icon: 1});
                                }
                            }
                            //dataType:返回类型
//                            ,'json'
                        );
                    });
                } else if(layEvent === 'edit'){
                    //编辑
                    //do something
                    WeAdminEdit('编辑', './edit' ,data, 600, 500);
                    //同步更新缓存对应的值
                   /* obj.update({

                    });*/
                }
            });
            <%--时间戳的处理--%>
            layui.laytpl.toDateString = function(d, format){
                var date = new Date(d || new Date())
                    ,ymd = [
                    this.digit(date.getFullYear(), 4)
                    ,this.digit(date.getMonth() + 1)
                    ,this.digit(date.getDate())
                ]
                    ,hms = [
                    this.digit(date.getHours())
                    ,this.digit(date.getMinutes())
                    ,this.digit(date.getSeconds())
                ];

                format = format || 'yyyy-MM-dd HH:mm:ss';

                return format.replace(/yyyy/g, ymd[0])
                    .replace(/MM/g, ymd[1])
                    .replace(/dd/g, ymd[2])
                    .replace(/HH/g, hms[0])
                    .replace(/mm/g, hms[1])
                    .replace(/ss/g, hms[2]);
            };
            //数字前置补零
            layui.laytpl.digit = function(num, length, end){
                var str = '';
                num = String(num);
                length = length || 2;
                for(var i = num.length; i < length; i++){
                    str += '0';
                }
                return num < Math.pow(10, length) ? str + (num|0) : num;
            };
        });


    </script>

</div>
</body>

</html>