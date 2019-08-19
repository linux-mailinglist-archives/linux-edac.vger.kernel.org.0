Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD08794E99
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2019 21:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfHST4c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 19 Aug 2019 15:56:32 -0400
Received: from mail-eopbgr780045.outbound.protection.outlook.com ([40.107.78.45]:30184
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727925AbfHST4c (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 19 Aug 2019 15:56:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM+OU7U0o26noFpbXIfJ47fYF15zVUw3LGX05NxyLeRCmyCo9HF0jxIIGOJ1+/A1pUkjzNPHEXYZDrrHCJySqEeRiAZWOxEuGWA5Km3mUcL+eJo+Oyf7Tn5fv3dqhJ98ywGeqNWwr32wXixiw0sT4qwHEzkwAHsJinZ8Zab4niwqqOpV0EHvBpHTuPmGhA782wrTMcS4WbgbA2XGjuNj3CNlXFZ0bAuy8bi8LUX9RPfrHuAwkZZZwENX7aFzHtMwOv7r/tCQQW76I2BxhE8ClaTXWF4bh+MpBoqSAKjqf9nv/58g2bWbyDgjn0YkGWtWLkGjC3KVVR4swxLTGS0T7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NODcDA+NecqTnMfJXCWmulfmF6H2B2HVGihqZPK93Lw=;
 b=Rn1vMnSyPOcQuIy19E0XaMxBokz4vfYgt/BFdxS7vKBHo6UzSdqhNte7hDGFx8WOZn2DtK94pgv733q66pDEYfn4Obq3/LByI+p95XWxvJrdCxo2kpwd5Svta1KVM/athQNAcPtYaWRtsqEDkyrOzynN23i2NYX8vxS66aPVS1O2VJlUKGFadM6cM4CLSOtXkWdKQP3JFivhFrE5KwpmL9VjCRoXc7egqJPUmDXynGwIp/4UVQyQ1ln0+HwM9gHK1fHyCDhGOx0MFusgoAGWOViVGUo3DwSkeMyeM4wSZl6GjdoHwBQCPSSuKHAr+7eKSD1yXYyPs4SrSLj/x+aWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NODcDA+NecqTnMfJXCWmulfmF6H2B2HVGihqZPK93Lw=;
 b=ToUx6YAUfjrimd+r1TDoqQRojMf/Mo/oRrPeuZlaFvSQSzW8aRfSdBJZUqkSb4fSBcXvjql1z0BJnW8XIsHxcIqTcOOkGW0cZG0BtOq3u/pehOGfAJTgLUbit1gvaEAa+NjeJPDTFJzVqMIv5H84CUxJ4r3u+3orebkoxiKAmjw=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2848.namprd12.prod.outlook.com (52.135.107.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Mon, 19 Aug 2019 19:55:50 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 19:55:50 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/7] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Topic: [PATCH v2 1/7] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Index: AQHVNqE4oirUNEimHEy0KqOPoRGXh6bnj7eAgBuSj1A=
Date:   Mon, 19 Aug 2019 19:55:50 +0000
Message-ID: <SN6PR12MB2639A73ABD69C62132FD0A2CF8A80@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190709215643.171078-2-Yazen.Ghannam@amd.com>
 <20190802064953.GA30661@zn.tnic>
In-Reply-To: <20190802064953.GA30661@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2601:3c2:8280:2327:3414:3059:320b:d027]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10d90c06-5b54-4084-b7b7-08d724df3c8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2848;
x-ms-traffictypediagnostic: SN6PR12MB2848:
x-microsoft-antispam-prvs: <SN6PR12MB28481C0219E0D57B4DD1F8EEF8A80@SN6PR12MB2848.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(396003)(136003)(376002)(199004)(13464003)(189003)(71200400001)(71190400001)(25786009)(99286004)(478600001)(486006)(6506007)(102836004)(53546011)(446003)(476003)(4326008)(33656002)(11346002)(46003)(6246003)(186003)(14454004)(7696005)(256004)(53936002)(76176011)(305945005)(76116006)(74316002)(7736002)(52536014)(66946007)(66476007)(64756008)(66446008)(2906002)(66556008)(86362001)(8676002)(81156014)(54906003)(81166006)(229853002)(8936002)(55016002)(316002)(6916009)(6436002)(9686003)(5660300002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2848;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TF6q67u7REu3hMC3AZMo2fwz/5qrpV+kqwBCE5BwOnvHcxiodjynq4HJnrXVHZKCh2JrjiTZD1weEMUyJGB9vPw6IYPXzLMa4M8o+7pSG/B41RiyRp9yTVOR+Bfj8mjw+Gzbeoh4UUNjgAtADQr3NqfQtvZGx6qVVKt0Q/5x4OOoVYI2A6alYHRe+nnm1W695/rv/Q6dvAMIXTdNzuO+4W/UH5RZLcr5S5JcIqCApe4rr1fmVVMoYhofk4B/iNA90D9+uKaQe72rW5+cr2mC2eF/HE7alfR4d/Y5HUJfZ8Z6N03QYkZqHZfC4RuHxrec8gbFOBXS6yXa+8ITuLm3JA3nFdJ+sxsqCfTXJSSagjZCCOwhwRDHYZrGibXQ2dinrJKwl/EhM8fodRA+3DuI34xqCllz7ra1oAHouecHmRA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d90c06-5b54-4084-b7b7-08d724df3c8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 19:55:50.7247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wpDgipkIvCp2MljTjTo3eK8nfpjAJP1g8UiIpMrSEFQ4QLAoJYDYhx0jlbYBt2H7FEKNk+CVvYLS/iXoPOc8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2848
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMiwgMjAxOSAxOjUwIEFNDQo+IFRv
OiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MiAxLzddIEVEQUMvYW1kNjQ6IFN1cHBvcnQgbW9yZSB0aGFuIHR3byBj
b250cm9sbGVycyBmb3IgY2hpcCBzZWxlY3RzIGhhbmRsaW5nDQo+IA0KPiBPbiBUdWUsIEp1bCAw
OSwgMjAxOSBhdCAwOTo1Njo1NFBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBG
cm9tOiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4NCj4gPiBUaGUg
c3RydWN0IGNoaXBfc2VsZWN0IGFycmF5IHRoYXQncyB1c2VkIGZvciBzYXZpbmcgY2hpcCBzZWxl
Y3QgYmFzZXMNCj4gPiBhbmQgbWFza3MgaXMgZml4ZWQgYXQgbGVuZ3RoIG9mIHR3by4gVGhlcmUg
c2hvdWxkIGJlIG9uZSBzdHJ1Y3QNCj4gPiBjaGlwX3NlbGVjdCBmb3IgZWFjaCBjb250cm9sbGVy
LCBzbyB0aGlzIGFycmF5IHNob3VsZCBiZSBpbmNyZWFzZWQgdG8NCj4gPiBzdXBwb3J0IHN5c3Rl
bXMgdGhhdCBtYXkgaGF2ZSBtb3JlIHRoYW4gdHdvIGNvbnRyb2xsZXJzLg0KPiA+DQo+ID4gSW5j
cmVhc2UgdGhlIHNpemUgb2YgdGhlIHN0cnVjdCBjaGlwX3NlbGVjdCBhcnJheSB0byBlaWdodCwg
d2hpY2ggaXMgdGhlDQo+ID4gbGFyZ2VzdCBudW1iZXIgb2YgY29udHJvbGxlcnMgcGVyIGRpZSBj
dXJyZW50bHkgc3VwcG9ydGVkIG9uIEFNRA0KPiA+IHN5c3RlbXMuDQo+ID4NCj4gPiBGaXggbnVt
YmVyIG9mIERJTU1zIGFuZCBDaGlwIFNlbGVjdCBiYXNlcy9tYXNrcyBvbiBGYW1pbHkxN2gsIGJl
Y2F1c2UgQU1EDQo+ID4gRmFtaWx5IDE3aCBzeXN0ZW1zIHN1cHBvcnQgMiBESU1NcywgNCBDUyBi
YXNlcywgYW5kIDIgQ1MgbWFza3MgcGVyDQo+ID4gY2hhbm5lbC4NCj4gPg0KPiA+IEFsc28sIGNh
cnZlIG91dCB0aGUgRmFtaWx5IDE3aCsgcmVhZGluZyBvZiB0aGUgYmFzZXMvbWFza3MgaW50byBh
DQo+ID4gc2VwYXJhdGUgZnVuY3Rpb24uIFRoaXMgZWZmZWN0aXZlbHkgcmV2ZXJ0cyB0aGUgb3Jp
Z2luYWwgYmFzZXMvbWFza3MNCj4gPiByZWFkaW5nIGNvZGUgdG8gYmVmb3JlIEZhbWlseSAxN2gg
c3VwcG9ydCB3YXMgYWRkZWQuDQo+ID4NCj4gPiBUaGlzIGlzIGEgc2Vjb25kIHZlcnNpb24gb2Yg
YSBjb21taXQgdGhhdCB3YXMgcmV2ZXJ0ZWQuDQo+ID4NCj4gPiBGaXhlczogMDdlZDgyZWY5M2Q2
ICgiRURBQywgYW1kNjQ6IEFkZCBGYW0xN2ggZGVidWcgb3V0cHV0IikNCj4gPiBGaXhlczogOGRl
OTkzMGE0NjE4ICgiUmV2ZXJ0ICJFREFDL2FtZDY0OiBTdXBwb3J0IG1vcmUgdGhhbiB0d28gY29u
dHJvbGxlcnMgZm9yIGNoaXAgc2VsZWN0IGhhbmRsaW5nIiIpDQo+IA0KPiBJJ20gbm90IHN1cmUg
YWJvdXQgdGhvc2UgRml4ZXM6IHRhZ3MgeW91J3JlIHNsYXBwaW5nIGV2ZXJ5d2hlcmUuIEZpcnN0
DQo+IG9mIGFsbCwgOGRlOTkzMGE0NjE4IGlzIGEgcmV2ZXJ0IHNvIGhvdyBjYW4gdGhpcyBiZSBm
aXhpbmcgYSByZXZlcnQ/IElmDQo+IGFueXRoaW5nLCBpdCBzaG91bGQgYmUgZml4aW5nIHRoZSBv
cmlnaW5hbCBjb21taXQNCj4gDQo+ICAgMGEyMjdhZjUyMWQ2ICgiRURBQy9hbWQ2NDogU3VwcG9y
dCBtb3JlIHRoYW4gdHdvIGNvbnRyb2xsZXJzIGZvciBjaGlwIHNlbGVjdCBoYW5kbGluZyIpDQo+
IA0KPiB3aGljaCB0cmllZCB0aGUgbW9yZS10aGFuLTItbWVtb3J5LWNvbnRyb2xsZXJzIHRoaW5n
Lg0KPiANCj4gQnV0LCBpdCBpcyBub3QgcmVhbGx5IGEgZml4IGZvciB0aGF0IGNvbW1pdCBidXQg
YSBzZWNvbmQgYXR0ZW1wdCBhdCBpdC4NCj4gV2hpY2ggaXMgbm90IHJlYWxseSBhIGZpeCBidXQg
aHcgZW5hYmxlbWVudC4NCj4gDQo+IFNvIEknbSBkcm9wcGluZyB0aG9zZSB0YWdzIGhlcmUuIElm
IHlvdSB3YW50IHRoZW0gaW4gc3RhYmxlLCBwbHMNCj4gYmFja3BvcnQgdGhlbSBwcm9wZXJseSBh
bmQgdGVzdCB0aGVtIG9uIHRoZSByZXNwZWN0aXZlIHN0YWJsZSBrZXJuZWxzDQo+IGJlZm9yZSBz
ZW5kaW5nIHRoZW0gdG8gc3RhYmxlLg0KPiANCg0KT2theSwgbm8gcHJvYmxlbS4NCg0KU2hvdWxk
IEkgZHJvcCB0aGUgRml4ZXMgdGFncyBvbiBhbnkgb3RoZXIgb2YgdGhlIHBhdGNoZXMgaW4gdGhp
cyBzZXQ/DQoNClRoYW5rcywNCllhemVuDQo=
