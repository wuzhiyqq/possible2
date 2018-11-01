<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>查看商品-后台管理系统-Admin 1.0</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/weadmin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/treeselect.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js" charset="utf-8"></script>
    <%--<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/treeselect.js" charset="utf-8"></script>--%>
    <!-- 让IE8/9支持媒体查询，从而兼容栅格 -->
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>
<div class="weadmin-body">
    <form class="layui-form">
       <%-- <div class="layui-form-item">
            <label class="layui-form-label">
                <span class="we-red">*</span>商品类别
            </label>
            <div class="layui-input-block">
                <select name="category" lay-filter="fenlei">

                </select>
            </div>
        </div>--%>
        <input type="hidden" id="date" />
        <input type="hidden" id="is_hot" />
           <input type="hidden" id="cname" />
          <div class="layui-form-item">
             <label for="pid" class="layui-form-label">商品编号</label>
             <div class="layui-input-block">
               <input type="text" id="pid" name="pid" required  lay-verify="required"  autocomplete="off" class="layui-input" disabled="disabled">
             </div>
           </div>

        <div class="layui-form-item">
            <label for="cid" class="layui-form-label">商品类别</label >
            <div class="layui-input-inline" lay-filter="feilei">
                <select name="cid" id="cid" lay-verify="required" autocomplete="off" class="layui-input" disabled="disabled"></select>
                <input type="hidden" id="dataCid" />
            </div>
        </div>
        <div class="layui-form-item">
            <label for="pname" class="layui-form-label">商品名称</label>
            <div class="layui-input-block">
                <input type="text" id="pname" name="pname" required="" lay-verify="required" autocomplete="off"
                       class="layui-input"disabled="disabled">
            </div>
        </div>
           <div class="layui-form-item">
               <label for="shop_price" class="layui-form-label">市场价格</label>
            <div class="layui-input-block">
                <input type="text" id="market_price" name="market_price" required="" lay-verify="number" autocomplete="off"
                       class="layui-input"disabled="disabled">

            </div>
        </div>
        <div class="layui-form-item">
            <label for="shop_price" class="layui-form-label">商店价格</label>
            <div class="layui-input-block">
                <input type="text" id="shop_price" name="shop_price" required="" lay-verify="number" autocomplete="off"
                       class="layui-input" disabled="disabled" />
               <%-- <input type="hidden" id="price" name="price">--%>
            </div>
        </div>
        <div class="layui-form-item">
            <label for="pflag" class="layui-form-label">商品库存</label>
            <div class="layui-input-block">
                <input type="text" id="pflag" name="pflag" required="" lay-verify="number" autocomplete="off"
                       class="layui-input" disabled="disabled">
            </div>
        </div>
        <%--<div class="layui-form-item">
            <label for="barcode" class="layui-form-label">
                <span class="we-red">*</span>条形码
            </label>
            <div class="layui-input-inline">
                <input type="text" id="barcode" name="barcode" required="" lay-verify="required" autocomplete="off"
                       class="layui-input">
            </div>
        </div>--%>
           <div class="layui-form-item layui-form-text">
               <label for="pdesc" class="layui-form-label">商品描述</label>
               <div class="layui-input-block">
                   <textarea  id="pdesc" name="pdesc" class="layui-textarea" disabled="disabled" ></textarea>
               </div>
           </div>
          <%-- <div class="layui-form-item layui-form-text">
               <label for="itemDesc" class="layui-form-label">描述</label>
               <div class="layui-input-block">
                   &lt;%&ndash;第一步&ndash;%&gt;
                   <textarea id="itemDesc" name="itemDesc" class="layui-textarea" style="display: none"></textarea>
               </div>
           </div>--%>
        <%--<div class="layui-form-item">
            <label for="add" class="layui-form-label">
            </label>
            <button id="add" class="layui-btn" lay-filter="add" lay-submit="">修改</button>
        </div>--%>
    </form>

</div>
<script>
    layui.extend({
        admin: '{/}../../static/js/admin',
        treeselect: '{/}../../static/js/treeselect'
    });
    layui.use(['form', 'admin','layer', 'layedit'], function () {
        var form = layui.form,
            admin = layui.admin,
            layer = layui.layer,
            layedit = layui.layedit,
            $=layui.$;
           // form.render('select', 'fenlei');
        var shopid = $("#dataCid").val();
        $.ajax({
            url:"../../showcategory",
            dataType:'json',
            success:function(data){
                //商品分类下拉框的数据回显
                $.each(data,function(index,item){
                    if(item.cid == null || item.cid ==""){
                        $("#cid").append("<option value='0'>未知分类</option>");
                    }else{
                        if(item.cid == shopid){
                            $("#cid").append("<option value='" + item.cid + "' selected>" + item.cname + "</option>");
                        }else{
                            $("#cid").append("<option value='" + item.cid + "'>" + item.cname + "</option>");
                        }
                    }
                   // $('#cid').append(new Option(item.cname,item.cid));
                })
                form.render();
            }
        });
        //第二步
        //初始化富文本编辑器
       /* layedit.build('pdesc', {
            height: 100,//设置编辑器高度
            uploadImage:{
                url:'../../uploadImage',
                type:'post'
            }
        });*/

        //监听提交
        /*form.on('submit(add)', function (data) {
            /!*console.log(data);*!/
            //发异步，把数据提交给后端
            $.ajax({
                url:"../../addproduct",
                data:data.field,
                dataType:'json',
                success:function(message){
                    if(message>0){
                        layer.alert("增加成功", {
                            icon: 6
                        }, function () {
                            // 获得frame索引
                            var index = parent.layer.getFrameIndex(window.name);
                            //关闭当前frame
                            parent.layer.close(index);
                        });
                    }

                }
            });*/
            /*layer.alert("增加成功", {
                icon: 6
            }, function () {
                // 获得frame索引
                var index = parent.layer.getFrameIndex(window.name);
                //关闭当前frame
                parent.layer.close(index);
            });
             return false;
        });*/

    });
</script>

</body>

</html>