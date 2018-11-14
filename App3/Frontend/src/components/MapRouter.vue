<template>
<div>
  <div class="navbar">
        <div class="row" style="width: 100%;">
            <div class="col-md-2">
                <img src="/static/pics/logo-desktop-white.png" width="60px;" style="margin: 0 10px 0 0;">
            </div>
            <div class="col-md-8 navTitle">
                    <img src="/static/icons/back.png" style="margin-right: 100px">
                    Đường đi ngắn nhất
            </div>
            <div class="col-md-2" style="text-align: right;">
                <div>
                    <button class="logoutBtn-r">ĐĂNG XUẤT</button>
                </div>
            </div>
        </div>
    </div>
    <div ref="map" v-bind:style="{ width: width, height: height }" id="map"></div>
  </div>
</template>
