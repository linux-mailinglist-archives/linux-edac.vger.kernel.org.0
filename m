Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9C4F3875
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 20:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfKGTUb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 14:20:31 -0500
Received: from mail-eopbgr790084.outbound.protection.outlook.com ([40.107.79.84]:55946
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfKGTUb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 14:20:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXh+QtlB9AuFO+lHNe+DuQW/RqnjvjFwFvlld/WE1h2M/EazDUUTPaEM3y9w6O4GVKYezG6+4n/M1iRrcqzMVhTXuxY+DuY7I5ROnEPBZ8vRmY8OmpQKlxPcDBZkRezXutqLZlgv6FN9YMQ8X3kQl+OaFyj3/U+CHS/p6/zzm+ofWZ/TP4kJ6ui4VuM80h2zGQEznOZpB7R6T37syK4lvrZNJCinj/dXvochU0H78KYSswoycoMJyVSn3kZwB3WIYUrmXyGeMWYzFRoB0Iu/mIN/vH3/VFLCuQzb26DcU/u8K6rX61Rm/VOF0Ss1/Lft0dj63HqDeEDauFLtVzThxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81A8AshbYdjP6EpHB5rqezkUALqjsTZIjD8Oq0l1aiU=;
 b=dpJRlp7oiKKX1Yf0g2dM7xy356kdZlAtD+zfdCM5vW/7BleCQrKwJKTpmsFYbQC57I4VHy24ZSVc//4qDaH7BvRoCEyjBpT5JKifNv6VztrSzC+9gASeObCDhHhn7frkt3w+OulmHwjJhYXpHVVt2yzoCWaGRwtJ50AI4NpG17Ljp7hmuRebq0KQ5h4+5K0NbFkrWstBNsG+oqiqgkHxvtAq5rv6X+qSo+R3aENns1Hp+yGpAb6vgbOZcuQgWlCaU7Worywpa/XiL/r+u4RQR7a3LKGDmJUVYpHG9+hvTG2rDAfAtbe4puve6LrwbFXqoS86QYwg5jCb55scyN30CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81A8AshbYdjP6EpHB5rqezkUALqjsTZIjD8Oq0l1aiU=;
 b=sDvOaCqBxmfv6JmKCsXKUdkwLC1dqp5sVr09BIvG3FUmyvtG099YmfJVP2SKWMFitP8bxWRSLJOkXt/auxvM44AUZat8Ua0nwCRz3vdRUf4LhwUWp+ZJj/ovrjZRAIFfT4gSNUmeLj+WMtU0FsWX+JNORWAuuML0ZrpPYEiQ3eQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Thu, 7 Nov 2019 19:20:25 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 19:20:25 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVlEEBkkiHg8UvLEKx+Q/uzElWBqd+T6+AgAAi68CAABzVgIAA9yyAgAAyaVCAACG7AIAAO3tw
Date:   Thu, 7 Nov 2019 19:20:25 +0000
Message-ID: <SN6PR12MB263925E6F18C3EDC8D398932F8780@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic> <20191107103857.GC19501@zn.tnic>
 <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107154006.GF19501@zn.tnic>
In-Reply-To: <20191107154006.GF19501@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2603:9001:1a05:3100:9de1:18ac:4797:8053]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 626645be-3dcb-4ba1-1443-08d763b78ad8
x-ms-traffictypediagnostic: SN6PR12MB2720:
x-microsoft-antispam-prvs: <SN6PR12MB2720D4674005582FFFCE6465F8780@SN6PR12MB2720.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(13464003)(199004)(189003)(476003)(486006)(102836004)(256004)(14444005)(53546011)(9686003)(55016002)(186003)(86362001)(6116002)(14454004)(66556008)(6506007)(2906002)(66446008)(66476007)(76176011)(64756008)(5660300002)(6246003)(76116006)(11346002)(52536014)(66946007)(74316002)(4326008)(71190400001)(46003)(25786009)(7696005)(33656002)(316002)(99286004)(7736002)(54906003)(446003)(6436002)(71200400001)(6916009)(478600001)(8676002)(81156014)(81166006)(305945005)(8936002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2720;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yk82iDGkkgRyZ23UKij81c/cbBhjWzQSC5VYC29VQiM5lJdqCRMOSP4Z/UrnkJyyGLblbm/wD8K33uzwv9V2C9sNvwXiNIjiOXRqNhBWc3kIPO1NEPQhFPVySIsuF5T/rGmeRLQ9mDf5TKmTxbHAWqJf+ZsDaW3CY2Y1YtkCZGDZcToRzpShYiJgYewtiSqli3JnkU1uRo/ceS3fRTk8TjZCy6bsW9I4UQ9TJ6mPsVXJSQWX5f8MpVa8Njs/6GwuGUwEQSyKwiifsuLBfyqSaW4rIZRvNd1YI+dGxKPcVZJ4ZplJwnowagJzdj0LLrLH76OBe6DJY7IIHdoCeZw4C+FOBiYSF7EoamiwmsCqcWn+x5nzOEX1ivB5pBGYmTX4h120DTdbchrMPnD9hyvZJ0qG6BsUirHFxziA6JbUz85+0mXnuY40/3SCTuOyhX1f
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626645be-3dcb-4ba1-1443-08d763b78ad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 19:20:25.4886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7+6zUDz1bKJNCVvi5ZYLJV9Es6DAMlJ6K5TkqS69tQ70AvhN6JOrMu7HI4/ZBTQ7Wv5BrjJ2LGfsykqwboUpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1rZXJuZWwtb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA3LCAy
MDE5IDEwOjQwIEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29t
Pg0KPiBDYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzVdIEFNRDY0IEVEQUM6IENoZWNr
IGZvciBub2RlcyB3aXRob3V0IG1lbW9yeSwgZXRjLg0KPiANCj4gT24gVGh1LCBOb3YgMDcsIDIw
MTkgYXQgMDE6NDc6NTNQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gQlRXLCB3
aGF0IGRvIHlvdSB0aGluayBhYm91dCBsb2FkaW5nIGJhc2VkIG9uIFBDSSBkZXZpY2VzPyBUaGUg
bW9kdWxlDQo+ID4gdXNlZCB0byBkbyB0aGlzLiBJIGFzayBiZWNhdXNlIEknbSBzdGFydGluZyB0
byBzZWUgdGhhdCBmdXR1cmUgc3lzdGVtcyBtYXkNCj4gPiByZS11c2UgUENJIElEcywgYW5kIHRo
aXMgaW5kaWNhdGVzIHRoZSBzYW1lIGxldmVsIG9mIGhhcmR3YXJlIHN1cHBvcnQuDQo+IA0KPiBU
aGUgcmVhc29uIHdlIHN3aXRjaGVkIHRvIGZhbWlseS1iYXNlZCBhdXRvbG9hZGluZyB3YXMgdGhh
dCBhbG1vc3QNCj4gZXZlcnkgbmV3IHBsYXRmb3JtIHdvdWxkIGFkZCBhIG5ldyBQQ0kgZGV2aWNl
IElELCB3aGljaCB3b3VsZCByZXF1aXJlDQo+IGVuYWJsZW1lbnQgd29yay4uLg0KPiANCg0KWWVz
LCB0aGF0J3MgcmlnaHQuIEJ1dCBpdCBsb29rcyBsaWtlIGZ1dHVyZSBzeXN0ZW1zIHdpbGwgcmUt
dXNlIFBDSSBJRHMgZXZlbg0KYWNyb3NzIGZhbWlsaWVzIGFuZCBtb2RlbHMuIEFuZCB0aGUgUENJ
IElEcyB3aWxsIGJlIG1vcmUgY2xvc2VseSByZWxhdGVkIHRvDQpoYXJkd2FyZSBjYXBhYmlsaXRp
ZXMgdGhhbiBmYW1pbHkgYW5kIG1vZGVsLg0KDQpJbiBhbnkgY2FzZSwgd2UgY2FuIGFkZHJlc3Mg
dGhhdCB3aGVuIHdlIGdldCB0aGVyZS4NCg0KPiA+IEp1c3QgYSBuaXQsIGJ1dCB0aGlzIGVsc2Ug
c2VlbXMgdW5uZWNlc3NhcnkgcmlnaHQ/DQo+IA0KPiBNYXliZSBpdCBpcyBlYXNpZXIgaWYgeW91
IGxvb2sgYXQgdGhlIGZ1bmN0aW9uIGVuZCBpbiB0aGUgLmMgZmlsZSBkaXJlY3RseSBhcw0KPiBk
aWZmcyBjYW4gYmUgY29uZnVzaW5nOg0KPiANCj4gc3RhdGljIGJvb2wgZWNjX2VuYWJsZWQoc3Ry
dWN0IGFtZDY0X3B2dCAqcHZ0KQ0KPiB7DQo+IA0KPiAJLi4uDQo+IA0KPiAgICAgICAgIGFtZDY0
X2luZm8oIk5vZGUgJWQ6IERSQU0gRUNDICVzLlxuIiwNCj4gICAgICAgICAgICAgICAgICAgIG5p
ZCwgKGVjY19lbiA/ICJlbmFibGVkIiA6ICJkaXNhYmxlZCIpKTsNCj4gDQo+ICAgICAgICAgaWYg
KCFlY2NfZW4gfHwgIW5iX21jZV9lbikNCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsN
Cj4gICAgICAgICBlbHNlDQoNClJpZ2h0LCBJIG1lYW50IHlvdSBjYW4gZHJvcCB0aGlzIGVsc2Ug
YW5kIGp1c3QgcmV0dXJuIHRydWUuDQoNCj4gICAgICAgICAgICAgICAgIHJldHVybiB0cnVlOw0K
PiB9DQo+IA0KDQpUaGFua3MsDQpZYXplbg0K
