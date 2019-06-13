Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0073C44DF8
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 23:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbfFMVAV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 17:00:21 -0400
Received: from mail-eopbgr690057.outbound.protection.outlook.com ([40.107.69.57]:62518
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727274AbfFMVAV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 17:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43Y+ljpMHEkz8Ps88oMGjbyWINN0702zEF4jEqjUSJE=;
 b=Fy/10pN7sJF/ujp949NtApFWSJx4WrjyofPmEZuvT/OFUD6uNkP2aHMi+aPxuUqkw1umyLX4eIOpx8RtWOXuPsFlNWYv5Mwcz87w6s5Poa7DDT6yT2yx+eSVlBwm29zsK8i8XFsUcQSFB8cO6za4Xtg+c0JVowpU9GboNmuzYyM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Thu, 13 Jun 2019 21:00:19 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 21:00:19 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Thread-Topic: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Thread-Index: AQHVGArj49LndWtr30OrnYGuWE2J2aaZsAoAgAB1UyA=
Date:   Thu, 13 Jun 2019 21:00:19 +0000
Message-ID: <SN6PR12MB263988EC0AC99DA2D29B21F3F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-2-Yazen.Ghannam@amd.com>
 <20190613135822.GC11598@zn.tnic>
In-Reply-To: <20190613135822.GC11598@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cd21270-c5a9-44dd-7a6f-08d6f0422495
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2816;
x-ms-traffictypediagnostic: SN6PR12MB2816:
x-microsoft-antispam-prvs: <SN6PR12MB281680FDFC0734E7B9115B7CF8EF0@SN6PR12MB2816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(11346002)(6246003)(4326008)(86362001)(76176011)(68736007)(26005)(99286004)(229853002)(186003)(3846002)(2906002)(25786009)(6436002)(6116002)(478600001)(6506007)(74316002)(7696005)(53546011)(72206003)(102836004)(33656002)(66066001)(316002)(476003)(53936002)(486006)(76116006)(66556008)(66946007)(71200400001)(73956011)(71190400001)(66446008)(5660300002)(8936002)(256004)(81156014)(66476007)(8676002)(55016002)(52536014)(9686003)(305945005)(6916009)(14454004)(7736002)(81166006)(64756008)(14444005)(54906003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PBPPuR/35s3TvhNcS6GJfIledwcTCeNzppDIQfrTSfvO79iuHxABgc9gEWPn3lD1VmGaeI7p4h6ADV8CZbQQkBIR9AM2NWw/X4EARGHTXN2yEMypKQZGW9wUi9hC7+o/F1d+gp3jMB9KWPOC7s4+rlhyeY1zCXf970ynBKv4zjqhiFyqSIByr7NwNNToN4QRDtzMiveum2Tg0yCP7iR3USSuIuKKP/PAPWrOnTmDPgjBESov5+BJG6Zyz8zL75NZWY8lrurUcabq+ui5AI6PIZcxbLtNz6VFrcgr6kxpECROtxV7glqsuctOy69cJqZuaYXtBozjJY9/hl9+Z0wRhhPTFfK/XZ8IMsZk8eeD7wE3V24FtgacVQnjwYY9dW8bNPpktOXuwJ6orGhLtHbF+gRul/14qkMFgtrPfC+Z10Q=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd21270-c5a9-44dd-7a6f-08d6f0422495
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 21:00:19.0768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTMsIDIwMTkgODo1OCBBTQ0KPiBU
bzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWVk
YWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS84XSBFREFDL2FtZDY0OiBGaXggbnVtYmVyIG9mIERJTU1zIGFuZCBD
aGlwIFNlbGVjdCBiYXNlcy9tYXNrcyBvbiBGYW1pbHkxN2gNCj4gDQo+IE9uIEZyaSwgTWF5IDMx
LCAyMDE5IGF0IDExOjQ1OjExUE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IEZy
b206IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4NCj4gPg0KPiA+IC4uLmJl
Y2F1c2UgQU1EIEZhbWlseSAxN2ggc3lzdGVtcyBzdXBwb3J0IDIgRElNTXMsIDQgQ1MgYmFzZXMs
IGFuZCAyIENTDQo+ID4gbWFza3MgcGVyIGNoYW5uZWwuDQo+ID4NCj4gPiBGaXhlczogMDdlZDgy
ZWY5M2Q2ICgiRURBQywgYW1kNjQ6IEFkZCBGYW0xN2ggZGVidWcgb3V0cHV0IikNCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgfCA1ICsrKystDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jIGIvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMu
Yw0KPiA+IGluZGV4IDg3MzQzN2JlODZkOS4uOWZhMmYyMDVmMDVjIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCj4gPiArKysgYi9kcml2ZXJzL2VkYWMvYW1kNjRf
ZWRhYy5jDQo+ID4gQEAgLTgxMCw3ICs4MTAsNyBAQCBzdGF0aWMgdm9pZCBkZWJ1Z19kaXNwbGF5
X2RpbW1fc2l6ZXNfZGYoc3RydWN0IGFtZDY0X3B2dCAqcHZ0LCB1OCBjdHJsKQ0KPiA+DQo+ID4g
IAllZGFjX3ByaW50ayhLRVJOX0RFQlVHLCBFREFDX01DLCAiVU1DJWQgY2hpcCBzZWxlY3RzOlxu
IiwgY3RybCk7DQo+ID4NCj4gPiAtCWZvciAoZGltbSA9IDA7IGRpbW0gPCA0OyBkaW1tKyspIHsN
Cj4gPiArCWZvciAoZGltbSA9IDA7IGRpbW0gPCAyOyBkaW1tKyspIHsNCj4gPiAgCQlzaXplMCA9
IDA7DQo+ID4gIAkJY3MwID0gZGltbSAqIDI7DQo+ID4NCj4gPiBAQCAtOTQyLDYgKzk0Miw5IEBA
IHN0YXRpYyB2b2lkIHByZXBfY2hpcF9zZWxlY3RzKHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCj4g
PiAgCX0gZWxzZSBpZiAocHZ0LT5mYW0gPT0gMHgxNSAmJiBwdnQtPm1vZGVsID09IDB4MzApIHsN
Cj4gPiAgCQlwdnQtPmNzZWxzWzBdLmJfY250ID0gcHZ0LT5jc2Vsc1sxXS5iX2NudCA9IDQ7DQo+
ID4gIAkJcHZ0LT5jc2Vsc1swXS5tX2NudCA9IHB2dC0+Y3NlbHNbMV0ubV9jbnQgPSAyOw0KPiA+
ICsJfSBlbHNlIGlmIChwdnQtPmZhbSA+PSAweDE3KSB7DQo+ID4gKwkJcHZ0LT5jc2Vsc1swXS5i
X2NudCA9IHB2dC0+Y3NlbHNbMV0uYl9jbnQgPSA0Ow0KPiA+ICsJCXB2dC0+Y3NlbHNbMF0ubV9j
bnQgPSBwdnQtPmNzZWxzWzFdLm1fY250ID0gMjsNCj4gDQo+IEkgZ3Vlc3MgaXQgaXMgYWJvdXQg
dGltZSB0aGF0IGZ1bmN0aW9uIGdldHMgdHVybmVkIGludG8gYSBzd2l0Y2gtY2FzZSBzbw0KPiB0
aGF0IHRoZSBhc3NpZ25tZW50IGxpbmVzIGRvIG5vdCBnZXQgZHVwbGljYXRlZC4NCj4gDQoNCk9r
YXksIEknbGwgd3JpdGUgdXAgYSBwYXRjaCBmb3IgdGhhdC4NCg0KRG8geW91IGhhdmUgYW55IHRp
cHMgb24gaG93IHRvIGhhbmRsZSBpdD8gSSdtIHRoaW5raW5nIGl0IG1heSBiZSB0cmlja3kgYmVj
YXVzZSBvZiB0aGUgcmFuZ2VzIGFuZCBtdWx0aXBsZSB2YXJpYWJsZXMuDQoNClRoYW5rcywNCllh
emVuDQo=
