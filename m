Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0EEF305C
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 14:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfKGNr5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 08:47:57 -0500
Received: from mail-eopbgr790043.outbound.protection.outlook.com ([40.107.79.43]:22528
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727858AbfKGNr5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 08:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bOTpmqJMAOzLNnJ8xKj7qQAxRobgBNJq/NZipRWmOxCk6t5DVqPdMMEibD7j3Qh1oD6j2Z+zGSBBqbs3zzSOJoayVOAt5tFxkliy2G//39LOzrwi+jKxD771MqZehTJQcAQdCQSZ8DAEI4kd3rLHkxxNfq0PHErov405L78SBEO0WLHij7MfBsML+VO2gPIBlzFpvVBoNFKx/lumG15YDEiXq1R6FbQ3gRybWRAJBEbRXGBPOl9KgWnQbqJXa4qLIwlDbVFPCXgIzYc1xgk5/DZbaPX+q9gRJRgQRKaRjzZntgbj0wgvDNR5JJqLdZfdBIwfKSNeM+v/ISN78o8w8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UybovwT+h70EvbisJNIoQhij8UpuR/p6k7O0vCPgiVs=;
 b=FdiIL+hxDeI1fDlSaCN5yI8S4aQ2Mi9LUnMpzM2TEfSgKmGE2VYKQpN8y0pDUENrJZ8ACWilsbNcGXKCGcEQ5gYqzjd+5cgLgDqMtIVWkp1W3AA34SMh9P8NjaTkvRUoCabF/XYhLsnZ9gAc3UN2t13qQSyeIY2W/ibeH4oL3aI7Xao2pp6bUbvkfu8I2iIYZeNVnldaruOyiqqbfFpwh5AvqyBWpmqHoT36wWneF1mpzYE62RPK+tSYWYp3v19vGl50ND7PwIuzAk8tqoSTtmJS+8RtiRkgm07+lmysWM9v8HuAGoHStP9ke7ZtYcCJ5RT1gwopN39+cHouO/dt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UybovwT+h70EvbisJNIoQhij8UpuR/p6k7O0vCPgiVs=;
 b=YDZCrrkT3b0eOaAjNUlcEw3BR0gCnKpH/4EncI2jN82tn2PBSKShneRcxn2jFTernQXR/Izsi5GLj+wWFUCY1Dmd4mkijZ1PKf6ULO3/s7R62J2WjMORpwWtOdYlv6UEGGats2DQ4iRuIor7616aW1YRorffdKbSWl8urtgHUjw=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2829.namprd12.prod.outlook.com (20.177.250.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 13:47:53 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 13:47:53 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVlEEBkkiHg8UvLEKx+Q/uzElWBqd+T6+AgAAi68CAABzVgIAA9yyAgAAyaVA=
Date:   Thu, 7 Nov 2019 13:47:53 +0000
Message-ID: <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic> <20191107103857.GC19501@zn.tnic>
In-Reply-To: <20191107103857.GC19501@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2603:9001:1a05:3100:9de1:18ac:4797:8053]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94449d23-dde2-4515-3bfc-08d7638916b6
x-ms-traffictypediagnostic: SN6PR12MB2829:
x-microsoft-antispam-prvs: <SN6PR12MB282902A79FDC16F3F4072D5DF8780@SN6PR12MB2829.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:378;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(52314003)(13464003)(189003)(199004)(55016002)(86362001)(186003)(25786009)(6506007)(6116002)(8676002)(9686003)(486006)(5660300002)(7696005)(81156014)(66476007)(99286004)(76116006)(66946007)(33656002)(66446008)(66556008)(4326008)(8936002)(64756008)(46003)(305945005)(74316002)(11346002)(52536014)(446003)(71190400001)(76176011)(316002)(2906002)(7736002)(476003)(14444005)(81166006)(256004)(6916009)(71200400001)(54906003)(229853002)(14454004)(102836004)(6246003)(478600001)(53546011)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2829;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: erbUhfKcmzRjAbQbLjB/Z1Dtm2eTgBtZZ9M/Dk9xrQ+HgXVPh1JsyEZ1mx0hBnb58MUaH0jykzpU3AqBsdY192j4VlU91gFmD3qdSpGcBG+3+EuoQtfeI9uuYXeCKnr6w4Fzi90u/R0Ci+K27Ogyewr/4a4j2+eZLtSxaJh9qnrUkuQ7MqV7AlR9UIMbLKwk+8Hf3G2f3lO4pp7XsoiDDfrC2FBC4y/q99oyPBpEMUDeRhkETUZe0HoYJrtPkvA7L4k1VmGQ6dHAbw7daUSrdzxalH16t1463u3/64Qi+0Wgl+g+h42EaZJdk6UdiEaCJTxHMjFgOjDIlgNvnAof9BemFYf/kAqTaxGa0kaiTdgyvbV+DmjI0F+fHijV3cysovYInFUhR9+B82ZHs1aZFmzkx7P1TIbAo9yg4eVmfCBKvzxXVVzRkntmKtBJ1NC6
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94449d23-dde2-4515-3bfc-08d7638916b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:47:53.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4Tn4+uJ0yXvHi1IkIMIllHM9RgocN3gTUD7gYQ2goxlYSRRYnG0uWdEMCwrTGzDPDmRQnaR49JIz0RkCnDpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2829
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIwMTkg
NTozOSBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC81XSBBTUQ2NCBFREFDOiBDaGVjayBmb3Ig
bm9kZXMgd2l0aG91dCBtZW1vcnksIGV0Yy4NCj4gDQo+IE9uIFdlZCwgTm92IDA2LCAyMDE5IGF0
IDA4OjU0OjE3UE0gKzAxMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gPiB3aGljaCBhcmUg
YWxzbyB0d28gYXR0ZW1wdHMuDQo+ID4NCj4gPiBBbnl3YXksIEknbGwgcXVldWUgeW91ciBzZXQg
YW5kIEknbGwgdHJ5IHRvIGRlYnVnIHRoYXQgdGhpbmcgYmVjYXVzZSBpdA0KPiA+IGlzIGdldHRp
bmcgb24gbXkgbmVydmVzIHNsb3dseS4uLg0KPiANCj4gWWFoLCB0aGUgcHJvYmxlbSBpcyB0aGF0
IGJlY2F1c2Ugd2UgaGF2ZToNCj4gDQo+IE1PRFVMRV9ERVZJQ0VfVEFCTEUoeDg2Y3B1LCBhbWQ2
NF9jcHVpZHMpOw0KPiANCj4gaXQgZ2V0cyB0cmllZCBvbiBlYWNoIENQVSBiZWNhdXNlIGFuIHVl
dmVudCBnZXRzIGRpc3BhdGNoZWQgZm9yIGVhY2gNCj4gZGV2aWNlLCBhbmQgZWFjaCBDUFUgaXMg
YSBkZXZpY2UuDQo+IA0KPiBUaGF0J3Mgd2h5IEkgc2VlIGl0IHR3aWNlIG9uIHRoaXMgYm94IC0g
aXQgaGFzIHR3byBDUFVzLg0KPiANCg0KT2theSwgdGhhdCdzIG1ha2VzIHNlbnNlLg0KDQpCVFcs
IHdoYXQgZG8geW91IHRoaW5rIGFib3V0IGxvYWRpbmcgYmFzZWQgb24gUENJIGRldmljZXM/IFRo
ZSBtb2R1bGUNCnVzZWQgdG8gZG8gdGhpcy4gSSBhc2sgYmVjYXVzZSBJJ20gc3RhcnRpbmcgdG8g
c2VlIHRoYXQgZnV0dXJlIHN5c3RlbXMgbWF5DQpyZS11c2UgUENJIElEcywgYW5kIHRoaXMgaW5k
aWNhdGVzIHRoZSBzYW1lIGxldmVsIG9mIGhhcmR3YXJlIHN1cHBvcnQuDQoNCj4gQW5kIEdyZWcg
c2F5cyBtYWtpbmcgaXQgYXR0ZW1wdCBvbmNlIHBlciBzeXN0ZW0gY2FuJ3QgYmUgZG9uZS4gVW5s
ZXNzIHdlDQo+IHN0YXJ0IGRvaW5nIGhhY2tzIHdpdGggc2VuZGluZyB1ZXZlbnRzIHBlciBCU1Ag
b25seSB3aGljaCBpcyB0b28gbXVjaC4NCj4gT3Igd2UgY2FuIHJlbWVtYmVyIHRoZSBwcmV2aW91
cyByZXR1cm4gdmFsdWUgb2YgdGhlIG1vZHVsZSBpbml0IGZ1bmN0aW9uDQo+IGludG8gZWRhY19j
b3JlIGJ1dCB0aGF0J3MgbmFzdHkgdG9vLg0KPiANCj4gSSdtIHRoaW5raW5nIHdlIHNob3VsZCBz
aW1wbHkga2lsbCB0aGlzIGZhdCBlY2NfbXNnIHRoaW5nIHdoaWNoIGlzIG5vdA0KPiB2ZXJ5IHVz
ZWZ1bCBhbmQgYmUgZG9uZSB3aXRoIGl0Og0KPiANCj4gWyAgICA1LjY5NzI3NV0gRURBQyBNQzog
VmVyOiAzLjAuMA0KPiBbICAgIDUuOTA5NTMwXSBFREFDIGFtZDY0OiBGMTBoIGRldGVjdGVkIChu
b2RlIDApLg0KPiBbICAgIDYuMzQ1MjMxXSBFREFDIGFtZDY0OiBOb2RlIDA6IERSQU0gRUNDIGRp
c2FibGVkLg0KPiBbICAgIDYuMzcwODE1XSBFREFDIGFtZDY0OiBGMTBoIGRldGVjdGVkIChub2Rl
IDApLg0KPiBbICAgIDYuMzcwOTI5XSBFREFDIGFtZDY0OiBOb2RlIDA6IERSQU0gRUNDIGRpc2Fi
bGVkLg0KPiANCj4gVGhhdCdzIHByb2JhYmx5IHN0aWxsIGEgYml0IGFubm95aW5nIG9uIGEgbGFy
Z2UgbWFjaGluZSBidXQgYmV0dGVyIHRoYW4NCj4gbm90aGluZy4NCj4gDQoNClllYWgsIEkgYWdy
ZWUuDQoNCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jIGIv
ZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KPiBpbmRleCAzYWViNTE3M2UyMDAuLjA3MzgyMzdl
M2YwOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KPiArKysgYi9k
cml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+IEBAIC0zMTg4LDE4ICszMTg4LDYgQEAgc3RhdGlj
IHZvaWQgcmVzdG9yZV9lY2NfZXJyb3JfcmVwb3J0aW5nKHN0cnVjdCBlY2Nfc2V0dGluZ3MgKnMs
IHUxNiBuaWQsDQo+ICAJCWFtZDY0X3dhcm4oIkVycm9yIHJlc3RvcmluZyBOQiBNQ0dDVEwgc2V0
dGluZ3MhXG4iKTsNCj4gIH0NCj4gDQo+IC0vKg0KPiAtICogRURBQyByZXF1aXJlcyB0aGF0IHRo
ZSBCSU9TIGhhdmUgRUNDIGVuYWJsZWQgYmVmb3JlDQo+IC0gKiB0YWtpbmcgb3ZlciB0aGUgcHJv
Y2Vzc2luZyBvZiBFQ0MgZXJyb3JzLiBBIGNvbW1hbmQgbGluZQ0KPiAtICogb3B0aW9uIGFsbG93
cyB0byBmb3JjZS1lbmFibGUgaGFyZHdhcmUgRUNDIGxhdGVyIGluDQo+IC0gKiBlbmFibGVfZWNj
X2Vycm9yX3JlcG9ydGluZygpLg0KPiAtICovDQo+IC1zdGF0aWMgY29uc3QgY2hhciAqZWNjX21z
ZyA9DQo+IC0JIkVDQyBkaXNhYmxlZCBpbiB0aGUgQklPUyBvciBubyBFQ0MgY2FwYWJpbGl0eSwg
bW9kdWxlIHdpbGwgbm90IGxvYWQuXG4iDQo+IC0JIiBFaXRoZXIgZW5hYmxlIEVDQyBjaGVja2lu
ZyBvciBmb3JjZSBtb2R1bGUgbG9hZGluZyBieSBzZXR0aW5nICINCj4gLQkiJ2VjY19lbmFibGVf
b3ZlcnJpZGUnLlxuIg0KPiAtCSIgKE5vdGUgdGhhdCB1c2Ugb2YgdGhlIG92ZXJyaWRlIG1heSBj
YXVzZSB1bmtub3duIHNpZGUgZWZmZWN0cy4pXG4iOw0KPiAtDQo+ICBzdGF0aWMgYm9vbCBlY2Nf
ZW5hYmxlZChzdHJ1Y3QgYW1kNjRfcHZ0ICpwdnQpDQo+ICB7DQo+ICAJdTE2IG5pZCA9IHB2dC0+
bWNfbm9kZV9pZDsNCj4gQEAgLTMyNDYsMTEgKzMyMzQsMTAgQEAgc3RhdGljIGJvb2wgZWNjX2Vu
YWJsZWQoc3RydWN0IGFtZDY0X3B2dCAqcHZ0KQ0KPiAgCWFtZDY0X2luZm8oIk5vZGUgJWQ6IERS
QU0gRUNDICVzLlxuIiwNCj4gIAkJICAgbmlkLCAoZWNjX2VuID8gImVuYWJsZWQiIDogImRpc2Fi
bGVkIikpOw0KPiANCj4gLQlpZiAoIWVjY19lbiB8fCAhbmJfbWNlX2VuKSB7DQo+IC0JCWFtZDY0
X2luZm8oIiVzIiwgZWNjX21zZyk7DQo+ICsJaWYgKCFlY2NfZW4gfHwgIW5iX21jZV9lbikNCj4g
IAkJcmV0dXJuIGZhbHNlOw0KPiAtCX0NCj4gLQlyZXR1cm4gdHJ1ZTsNCj4gKwllbHNlDQo+ICsJ
CXJldHVybiB0cnVlOw0KPiAgfQ0KDQpKdXN0IGEgbml0LCBidXQgdGhpcyBlbHNlIHNlZW1zIHVu
bmVjZXNzYXJ5IHJpZ2h0Pw0KDQpUaGFua3MsDQpZYXplbg0K
