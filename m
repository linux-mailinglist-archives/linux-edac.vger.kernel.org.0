Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43015633CA
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jul 2019 11:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfGIJ7Y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Jul 2019 05:59:24 -0400
Received: from mx01.quantatw.com ([219.87.191.90]:31098 "EHLO
        mx01.quantatw.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfGIJ7X (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Jul 2019 05:59:23 -0400
X-Greylist: delayed 619 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jul 2019 05:59:22 EDT
Received: from unknown (HELO mailbx06.quanta.corp) ([10.243.91.101])
  by mx01.quantatw.com with ESMTP; 09 Jul 2019 17:49:00 +0800
Received: from mailbx05.quanta.corp (10.243.91.100) by mailbx06.quanta.corp
 (10.243.91.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 9 Jul 2019
 17:48:59 +0800
Received: from mailbx05.quanta.corp ([192.168.0.5]) by mailbx05.quanta.corp
 ([192.168.0.5]) with mapi id 15.01.1713.004; Tue, 9 Jul 2019 17:48:59 +0800
From:   =?big5?B?R2VvcmdlIEh1bmcgKKx4qb63cSk=?= <George.Hung@quantatw.com>
To:     Rob Herring <robh@kernel.org>, George Hung <ghung.quanta@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tali Perry <tali.perry1@gmail.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "wak@google.com" <wak@google.com>,
        "benjaminfair@google.com" <benjaminfair@google.com>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Avi.Fishman@nuvoton.com" <Avi.Fishman@nuvoton.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        "Patrick Venture" <venture@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH 5.2 v2 2/2] dt-binding: edac: add NPCM ECC documentation
Thread-Topic: [PATCH 5.2 v2 2/2] dt-binding: edac: add NPCM ECC documentation
Thread-Index: AQHVNfd78GrHFC2ty02NT0e+R3uriabCCCsA
Date:   Tue, 9 Jul 2019 09:48:59 +0000
Message-ID: <0c90f9376c0e425c9a226379f7e5bfad@quantatw.com>
References: <20190605141253.38554-1-ghung.quanta@gmail.com>
 <20190605141253.38554-2-ghung.quanta@gmail.com>
 <20190709014058.GA30269@bogus>
In-Reply-To: <20190709014058.GA30269@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.243.91.252]
x-tm-as-product-ver: SMEX-12.0.0.1727-8.200.1013-24746.005
x-tm-as-result: No--21.007500-0.000000-31
x-tm-as-matchedid: 140026-150567-700225-703140-701090-703503-704039-139010-1
        39006-188199-702601-702887-702754-702304-702058-702617-823290-705012-703129
        -106660-703408-700069-701429-702604-705249-110462-701342-704841-863519-1880
        19-703017-702395-703213-701478-704585-701337-703958-700737-704384-704397-70
        2392-700786-703880-148004-148133-20043-42000-42003-63
x-tm-as-user-approved-sender: Yes
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgUm9iLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogb3BlbmJt
Yw0KPiBbbWFpbHRvOm9wZW5ibWMtYm91bmNlcytnZW9yZ2UuaHVuZz1xdWFudGF0dy5jb21AbGlz
dHMub3psYWJzLm9yZ10gT24NCj4gQmVoYWxmIE9mIFJvYiBIZXJyaW5nDQo+IFNlbnQ6IFR1ZXNk
YXksIEp1bHkgMDksIDIwMTkgOTo0MSBBTQ0KPiBUbzogR2VvcmdlIEh1bmcNCj4gQ2M6IE1hcmsg
UnV0bGFuZDsgTGludXMgV2FsbGVpajsgVGFsaSBQZXJyeTsgcGF1bG1ja0BsaW51eC5pYm0uY29t
Ow0KPiB3YWtAZ29vZ2xlLmNvbTsgYmVuamFtaW5mYWlyQGdvb2dsZS5jb207IG9wZW5ibWNAbGlz
dHMub3psYWJzLm9yZzsNCj4gdG9tZXIubWFpbW9uQG51dm90b24uY29tOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgQm9yaXNsYXYgUGV0a292Ow0KPiBBdmkuRmlzaG1hbkBudXZvdG9uLmNv
bTsgSm9uYXRoYW4gQ2FtZXJvbjsgTWF1cm8gQ2FydmFsaG8gQ2hlaGFiOw0KPiBsaW51eC1lZGFj
OyBQYXRyaWNrIFZlbnR1cmU7IE5pY29sYXMgRmVycmU7IGxpbnV4LWtlcm5lbDsgSmFtZXMgTW9y
c2U7IEdyZWcNCj4gS3JvYWgtSGFydG1hbjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDUuMiB2MiAyLzJdIGR0LWJpbmRpbmc6IGVkYWM6IGFkZCBOUENNIEVDQw0K
PiBkb2N1bWVudGF0aW9uDQo+IA0KPiBPbiBXZWQsIEp1biAwNSwgMjAxOSBhdCAxMDoxMjo1M1BN
ICswODAwLCBHZW9yZ2UgSHVuZyB3cm90ZToNCj4gPiBBZGQgZGV2aWNlIHRyZWUgZG9jdW1lbnRh
dGlvbiBmb3IgTnV2b3RvbiBCTUMgRUNDDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHZW9yZ2Ug
SHVuZyA8Z2h1bmcucXVhbnRhQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdz
L2VkYWMvbnBjbTd4eC1zZHJhbS1lZGFjLnR4dCAgICAgICAgfCAxNw0KPiArKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWRhYy9u
cGNtN3h4LXNkcmFtLWVkYWMudHh0DQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWRhYy9ucGNtN3h4LXNkcmFtLWVkYWMudHh0DQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWRhYy9ucGNtN3h4LXNkcmFt
LWVkYWMudHh0DQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLmRkNGRhYzU5YTViZA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWRhYy9ucGNtN3h4LXNkcmFtLWVkYWMudHh0DQo+ID4g
QEAgLTAsMCArMSwxNyBAQA0KPiA+ICtOdXZvdG9uIE5QQ003eHggU29DIEVEQUMgZGV2aWNlIGRy
aXZlcg0KPiA+ICsNCj4gPiArVGhlIE51dm90b24gTlBDTTd4eCBTb0Mgc3VwcG9ydHMgRERSNCBt
ZW1vcnkgd2l0aC93aXRob3V0IEVDQyBhbmQNCj4gdGhlDQo+ID4gK2RyaXZlciB1c2VzIHRoZSBF
REFDIGZyYW1ld29yayB0byBpbXBsZW1lbnQgdGhlIEVDQyBkZXRlY3Rpb24gYW5kDQo+IGNvcnJ0
ZWN0aW9uLg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiArLSBjb21wYXRp
YmxlOglzaG91bGQgYmUgIm51dm90b24sbnBjbTd4eC1zZHJhbS1lZGFjIg0KPiANCj4gSXMgdGhp
cyBmb3IgdGhlIHdob2xlIFNEUkFNIGNvbnRyb2xsZXIgb3IganVzdCBFQ0MgcmVsYXRlZCByZWdp
c3RlcnM/DQo+IEluIHRoZSBmb3JtZXIgY2FzZSwgdGhlIG5hbWluZyBzaG91bGQganVzdCByZWZs
ZWN0IHRoZSBibG9jayBuYW1lIGFuZCBub3QgYQ0KPiBMaW51eCB0ZXJtLg0KDQpTb3JyeSBmb3Ig
Y29uZnVzZWQgbmFtaW5nLCB0aGUgYWRkcmVzcyBzcGFjZSBpcyBmb3IgdGhlIHdob2xlIG1lbW9y
eSBjb250cm9sbGVyIHJlZ2lzdGVycyBpbmRlZWQsDQpidXQgdGhlIGRyaXZlciBvbmx5IHVzZXMg
dGhlIEVDQyByZWxhdGVkIHJlZ2lzdGVycy4NClNob3VsZCBJIGNoYW5nZSB0aGUgbmFtZSB0byAi
bnV2b3RvbixucGNtN3h4LWVkYWMiID8NCg0KPiANCj4gPiArLSByZWc6CQlNZW1vcnkgY29udHJv
bGxlciByZWdpc3RlciBzZXQgc2hvdWxkIGJlIDwweGYwODI0MDAwDQo+IDB4MTAwMD4NCj4gPiAr
LSBpbnRlcnJ1cHRzOglzaG91bGQgYmUgTUMgaW50ZXJydXB0ICMyNQ0KPiA+ICsNCj4gPiArRXhh
bXBsZToNCj4gPiArDQo+ID4gKwltYzogbWVtb3J5LWNvbnRyb2xsZXJAZjA4MjQwMDAgew0KPiA+
ICsJCWNvbXBhdGlibGUgPSAibnV2b3RvbixucGNtN3h4LXNkcmFtLWVkYWMiOw0KPiA+ICsJCXJl
ZyA9IDwweGYwODI0MDAwIDB4MTAwMD47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDwwIDI1IDQ+Ow0K
PiA+ICsJfTsNCj4gPiAtLQ0KPiA+IDIuMjEuMA0KPiA+DQo=
