Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7CC3D3364
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jul 2021 06:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhGWDXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jul 2021 23:23:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:45230 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233585AbhGWDXF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 22 Jul 2021 23:23:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="272914237"
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="272914237"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 21:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="415707800"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 22 Jul 2021 21:01:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 22 Jul 2021 21:01:51 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Thu, 22 Jul 2021 21:01:51 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Thu, 22 Jul 2021 21:01:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
CC:     Borislav Petkov <bp@alien8.de>,
        "dinghui@sangfor.com.cn" <dinghui@sangfor.com.cn>,
        "huangcun@sangfor.com.cn" <huangcun@sangfor.com.cn>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        x86 <x86@kernel.org>, "Song, Youquan" <youquan.song@intel.com>
Subject: RE: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH 2/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHXfwEmVkDftAlLQUekz+CS3pEeK6tPG/EAgAD+lAD//5bsgIAAsOQA//+MXOA=
Date:   Fri, 23 Jul 2021 04:01:44 +0000
Message-ID: <0e39ef0e1b6d4532a09ad2d6e0b28310@intel.com>
References: <CAPcxDJ7YsnYtyzSmgfBj-rmALkjigKx2ODB=SCYCzY8FJYg4iA@mail.gmail.com>
 <20210722151930.GA1453521@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ6bB7GEhTq9fkHuT4chRTUk_s-crci=nh+COCwAzMP8Yw@mail.gmail.com>
 <20210723001436.GA1460637@agluck-desk2.amr.corp.intel.com>
 <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com>
In-Reply-To: <CAPcxDJ4Liv1_zASzRxdGKu7MmjRQ9inXPfhPMQdEZrEjL0U=zw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Pj4gSSdtIG5vdCBhd2FyZSBvZiwgbm9yIGV4cGVjdGluZyB0byBmaW5kLCBwbGFjZXMgd2hlcmUg
dGhlIGtlcm5lbA0KPj4gdHJpZXMgdG8gYWNjZXNzIHVzZXIgYWRkcmVzcyBBIGFuZCBoaXRzIHBv
aXNvbiwgYW5kIHRoZW4gdHJpZXMgdG8NCj4+IGFjY2VzcyB1c2VyIGFkZHJlc3MgQiAod2l0aG91
dCByZXR1cnJuaW5nIHRvIHVzZXIgYmV0d2VlbiBhY2Nlc3MNCj4+IEEgYW5kIGFjY2VzcyBCKS4N
Cj5UaGlzIHNlZW1zIGEgcmVhc29uYWJsZWx5IGVhc3kgc2NlbmFyaW8uDQo+DQo+IEEgdXNlciBz
cGFjZSBhcHAgYWxsb2NhdGVzIGEgYnVmZmVyIG9mIHh5eiBLQi9NQi9HQi4NCj4NCj4gVW5mb3J0
dW5hdGVseSB0aGUgZGltbXMgYXJlIGJhZCBhbmQgbXVsdGlwbGUgY2FjaGUgbGluZXMgaGF2ZQ0K
PiB1bmNvcnJlY3RhYmxlIGVycm9ycyBpbiB0aGVtIG9uIGRpZmZlcmVudCBwYWdlcy4NCj4NCj4g
VGhlbiB0aGUgdXNlciBzcGFjZSBhcHAgdHJpZXMgdG8gd3JpdGUgdGhlIGNvbnRlbnQgb2YgdGhl
IGJ1ZmZlciBpbnRvIHNvbWUNCj4gZmlsZSB2aWEgd3JpdGUoMikgZnJvbSB0aGUgZW50aXJlIGJ1
ZmZlciBpbiBvbmUgZ28uDQoNCkJlZm9yZSB0aGlzIHBhdGNoIExpbnV4IGdldHMgaW50byBhbiBp
bmZpbml0ZSBsb29wIHRha2luZyBtYWNoaW5lDQpjaGVja3Mgb24gdGhlIGZpcnN0IG9mIHRoZSBw
b2lzb24gYWRkcmVzc2VzIGluIHRoZSBidWZmZXIuDQoNCldpdGggdGhpcyBwYXRjaCAoYW5kIGFs
c28gcGF0Y2ggMy8zIGluIHRoaXMgc2VyaWVzKS4gVGhlcmUgYXJlDQphIGZldyBtYWNoaW5lIGNo
ZWNrcyBvbiB0aGUgZmlyc3QgcG9pc29uIGFkZHJlc3MgKEkgdGhpbmsgdGhlIG51bWJlcg0KZGVw
ZW5kcyBvbiB0aGUgYWxpZ25tZW50IG9mIHRoZSBwb2lzb24gd2l0aGluIGEgcGFnZSAuLi4gYnV0
IEknbQ0Kbm90IHN1cmUpLiBNeSB0ZXN0IGNvZGUgc2hvd3MgNCBtYWNoaW5lIGNoZWNrcyBhdCB0
aGUgc2FtZQ0KYWRkcmVzcy4gVGhlbiBMaW51eCByZXR1cm5zIGEgc2hvcnQgYnl0ZSBjb3VudCB0
byB0aGUgdXNlcg0Kc2hvd2luZyBob3cgbWFueSBieXRlcyB3ZXJlIGFjdHVhbGx5IHdyaXR0ZW4g
dG8gdGhlIGZpbGUuDQoNClRoZSBmYXN0IHRoYXQgdGhlcmUgYXJlIG1hbnkgbW9yZSBwb2lzb24g
bGluZXMgaW4gdGhlIGJ1ZmZlcg0KYmV5b25kIHRoZSBwbGFjZSB3aGVyZSB0aGUgd3JpdGUgc3Rv
cHBlZCBvbiB0aGUgZmlyc3Qgb25lIGlzDQppcnJlbGV2YW50Lg0KDQpbV2VsbCwgaWYgdGhlIHNl
Y29uZCBwb2lzb25lZCBsaW5lIGlzIGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBmaXJzdA0KeW91IG1h
eSBoaXQgaC93IHByZWZldGNoIGlzc3VlcyBhbmQgaC93IG1heSBzaWduYWwgYSBmYXRhbA0KbWFj
aGluZSBjaGVjayAuLi4gYnV0IHRoYXQncyBhIGRpZmZlcmVudCBwcm9ibGVtIHRoYXQgcy93IGNv
dWxkDQpvbmx5IHNvbHZlIHdpdGggcGFpbmZ1bCBMRkVOQ0Ugb3BlcmF0aW9ucyBiZXR3ZWVuIGVh
Y2ggNjQtYnl0ZXMNCm9mIHRoZSBjb3B5XQ0KDQotVG9ueQ0K
