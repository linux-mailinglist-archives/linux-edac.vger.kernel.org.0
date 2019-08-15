Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3344A8F559
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2019 22:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfHOUIn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Aug 2019 16:08:43 -0400
Received: from mail-eopbgr770043.outbound.protection.outlook.com ([40.107.77.43]:24576
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730338AbfHOUIn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 15 Aug 2019 16:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aw/lgCp5IeT3Sp2HUtGNvOLEXgMmRXOntu4EIvkIakl65yWY39XiSvb5r6P7+Gq0li4LnUH9UvoakEhzGyzt3ap8C4clyp02pJ81pxELJNsRgd+UtYWXYMIsrJyS1uhwWLlT6ZvtNZramu+1S+r9ZQbAZj3TaavPifCpp0OYPXRFqVAMqVMsT3q+LYWo7+o16BdB+WbKykh0EJKbi/rDHzDVyoUsFnUN607YuRFr+gDVOrAp8os3HlKzrXEn6QMrGYLEwhy0kaxsbpQt2CETkcuVZ+Ke4y1uOHdfuqu3s6yq0Ada05lbMYCOS4k/hqdUNB58zlWja4/m8l1kLmYqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxOBan3TMI9octjtkd7qVv65sqaqBxSNI/s2Zn7uQYU=;
 b=f4ZXsc62ilAs9j9d+1loyP8utX/WcwuXdqSZ4G4E+WrUE+8XnhjwhEX7m7IroZB27QYrke5A2oTDka2HQFj6o2+CNnMICwS6g9Dbx+mGrFem3lEnxYLHGJUIJRtLaxS4W1S+FM2zE/w566BOTfdZ2gzuvmyTQqkf0Inizd0IzhFsOklOBogubyDXWGFZ5Jw4scj5S3Kix7z2zbpRnC6ovy8ow8wOU1nNFgBTW1K7bQEo0OwpORqJXTdnphduH/mo8DUvCr4MyZUtQJjlbiQXyKvn2Snr2+xvylxjCzw7EqOBoCumRt6lvwr9imGFd033pucxdzjqjLv4h70wgGwdKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxOBan3TMI9octjtkd7qVv65sqaqBxSNI/s2Zn7uQYU=;
 b=Rblby2Tc5ezUm5dRwq5B8SjyfuEzVb2DeERtZ+m2kSw4NIbQM1atWuIa2Xk8BzGdbBOKWtKvulWpqFmiuF1ueUB2dR4EGYzd5hErznZAtkDFj4DoSr1gzBcgp1HOAvIWA9VHqqZj/BrtJW8hXqUI1V7qqKNpGefqUaGReyQl4Wo=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6SPR01MB0040.namprd12.prod.outlook.com (20.176.241.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 15 Aug 2019 20:08:39 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.016; Thu, 15 Aug 2019
 20:08:39 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/7] AMD64 EDAC fixes
Thread-Topic: [PATCH v2 0/7] AMD64 EDAC fixes
Thread-Index: AQHVNqE4C2hUM14zc0W5mv2Ndq5NW6boFNwAgBTFLzA=
Date:   Thu, 15 Aug 2019 20:08:39 +0000
Message-ID: <SN6PR12MB263968E448E4CCD4C6856288F8AC0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190802144626.GD30661@zn.tnic>
In-Reply-To: <20190802144626.GD30661@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8dec9fc0-2d30-4f1b-2c8a-08d721bc5d4b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6SPR01MB0040;
x-ms-traffictypediagnostic: SN6SPR01MB0040:
x-microsoft-antispam-prvs: <SN6SPR01MB0040F4140B5A9767D3AFB2BBF8AC0@SN6SPR01MB0040.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 01304918F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(13464003)(14444005)(71190400001)(71200400001)(54906003)(6246003)(4326008)(76176011)(256004)(53936002)(14454004)(99286004)(8936002)(478600001)(316002)(25786009)(7696005)(81166006)(81156014)(8676002)(66066001)(6916009)(74316002)(7736002)(6436002)(55016002)(305945005)(229853002)(5660300002)(9686003)(2906002)(86362001)(6116002)(3846002)(52536014)(66556008)(66476007)(66946007)(76116006)(64756008)(33656002)(102836004)(53546011)(6506007)(66446008)(186003)(26005)(486006)(476003)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6SPR01MB0040;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xCRvhN3/vEICxCGIiWxMalBUtqGqw/CFJyP/k19SpqhUZiC2O9nvLNYxsxKS3DV8/5Q8+WXZQJWm8zhdBQslmsM2yJNcdtv2hhbX5Rk7NQ4yqfPLP1eIS83HvTeDV2xZ8cKIcJ4aPdb1+W0e5Jt6qaZJi6kLTbMeMb820NErZNdoOJ5pOMwTZXcZAEutruha+eWC10nVSNM6pKgcKdXc+4heWDFEqTVtC1fLk2E/vrqBVrQEl5CpSjUCzEsSOBpdQd+rEAs9HSUt0UIVstBUdxm8qu9yV7EKFg8aaB55vBgwlW7TrmNiP8MJKRJnJ4niw1niHMk+bCf0WpG3JlzTQmU+Jr1ottOg/oDBXCv0bbkx1MmjVjfJLcru0lbU12edWn7i2WFe46Y7uFE9Z29AgbH5M0gEPgW3e8spYeLpJBQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dec9fc0-2d30-4f1b-2c8a-08d721bc5d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2019 20:08:39.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hks7pnSycFF/fSN2TkzUPUuRYzXBZFd3iss2N/0ckBSEkbx/O95COUg2ayB9Zbzsqkr5K/3qqjl1oTWFHmHCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6SPR01MB0040
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMiwgMjAxOSA5OjQ2
IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzog
bGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzddIEFNRDY0IEVEQUMgZml4ZXMNCj4gDQouLi4N
Cj4gDQo+IFNvIHRoaXMgc3RpbGwgaGFzIHRoaXMgY29uZnVzaW5nIHJlcG9ydGluZyBvZiB1bnBv
cHVsYXRlZCBub2RlczoNCj4gDQo+IFsgICAgNC4yOTE3NzRdIEVEQUMgTUMxOiBHaXZpbmcgb3V0
IGRldmljZSB0byBtb2R1bGUgYW1kNjRfZWRhYyBjb250cm9sbGVyIEYxN2g6IERFViAwMDAwOjAw
OjE5LjMgKElOVEVSUlVQVCkNCj4gWyAgICA0LjI5MjAyMV0gRURBQyBERUJVRzogZWNjX2VuYWJs
ZWQ6IE5vZGUgMjogTm8gZW5hYmxlZCBVTUNzLg0KPiBbICAgIDQuMjkyMjMxXSBFREFDIGFtZDY0
OiBOb2RlIDI6IERSQU0gRUNDIGRpc2FibGVkLg0KPiBbICAgIDQuMjkyNDA1XSBFREFDIGFtZDY0
OiBFQ0MgZGlzYWJsZWQgaW4gdGhlIEJJT1Mgb3Igbm8gRUNDIGNhcGFiaWxpdHksIG1vZHVsZSB3
aWxsIG5vdCBsb2FkLg0KPiBbICAgIDQuMjkyODU5XSBFREFDIERFQlVHOiBlY2NfZW5hYmxlZDog
Tm9kZSAzOiBObyBlbmFibGVkIFVNQ3MuDQo+IFsgICAgNC4yOTI5NjNdIEVEQUMgYW1kNjQ6IE5v
ZGUgMzogRFJBTSBFQ0MgZGlzYWJsZWQuDQo+IFsgICAgNC4yOTMwNjNdIEVEQUMgYW1kNjQ6IEVD
QyBkaXNhYmxlZCBpbiB0aGUgQklPUyBvciBubyBFQ0MgY2FwYWJpbGl0eSwgbW9kdWxlIHdpbGwg
bm90IGxvYWQuDQo+IFsgICAgNC4yOTMzNDddIEFNRDY0IEVEQUMgZHJpdmVyIHYzLjUuMA0KPiAN
Cj4gd2hpY2ggbmVlZHMgZml4aW5nLg0KPiANCg0KWWVzLCBJIGFncmVlLiBJIHdhcyBwbGFubmlu
ZyB0byBkbyBhIGZpeCBpbiBhIHNlcGFyYXRlIHNldC4gSXMgdGhhdCBva2F5PyBPciBzaG91bGQg
SSBhZGQgaXQgaGVyZT8NCg0KPiBSZWdhcmRsZXNzLCBzdGlsbCBub3QgZ29vZCBlbm91Z2guIFRo
ZSBzbm93eSBvd2wgYm94IEkgaGF2ZSBoZXJlIGhhcyAxNg0KPiBHQjoNCj4gDQo+ICQgaGVhZCAt
bjEgL3Byb2MvbWVtaW5mbw0KPiBNZW1Ub3RhbDogICAgICAgMTU3MTUzMjgga0INCj4gDQo+IGFu
ZCB5ZXQNCj4gDQo+IFsgICAgNC4yODIyNTFdIEVEQUMgTUM6IFVNQzAgY2hpcCBzZWxlY3RzOg0K
PiBbICAgIDQuMjgyMzQ4XSBFREFDIERFQlVHOiBmMTdfYWRkcl9tYXNrX3RvX2NzX3NpemU6IENT
MCBESU1NMCBBZGRyTWFza3M6DQo+IFsgICAgNC4yODI0NTVdIEVEQUMgREVCVUc6IGYxN19hZGRy
X21hc2tfdG9fY3Nfc2l6ZTogICBPcmlnaW5hbCBBZGRyTWFzazogMHgxZmZmZmZlDQo+IFsgICAg
NC4yODI1OTJdIEVEQUMgREVCVUc6IGYxN19hZGRyX21hc2tfdG9fY3Nfc2l6ZTogICBEZWludGVy
bGVhdmVkIEFkZHJNYXNrOiAweDFmZmZmZmUNCj4gWyAgICA0LjI4MjczMl0gRURBQyBERUJVRzog
ZjE3X2FkZHJfbWFza190b19jc19zaXplOiBDUzEgRElNTTAgQWRkck1hc2tzOg0KPiBbICAgIDQu
MjgyODM5XSBFREFDIERFQlVHOiBmMTdfYWRkcl9tYXNrX3RvX2NzX3NpemU6ICAgT3JpZ2luYWwg
QWRkck1hc2s6IDB4MWZmZmZmZQ0KPiBbICAgIDQuMjgzMDYwXSBFREFDIERFQlVHOiBmMTdfYWRk
cl9tYXNrX3RvX2NzX3NpemU6ICAgRGVpbnRlcmxlYXZlZCBBZGRyTWFzazogMHgxZmZmZmZlDQo+
IFsgICAgNC4yODMyODZdIEVEQUMgYW1kNjQ6IE1DOiAwOiAgODE5MU1CIDE6ICA4MTkxTUINCj4g
CQkJCSAgIF5eXl5eXl5eXl5eXl5eXl5eDQo+IA0KPiBbICAgIDQuMjgzNDU2XSBFREFDIGFtZDY0
OiBNQzogMjogICAgIDBNQiAzOiAgICAgME1CDQo+IA0KPiAuLi4NCj4gDQo+IFsgICAgNC4yODUz
NzldIEVEQUMgTUM6IFVNQzEgY2hpcCBzZWxlY3RzOg0KPiBbICAgIDQuMjg1NDc2XSBFREFDIERF
QlVHOiBmMTdfYWRkcl9tYXNrX3RvX2NzX3NpemU6IENTMCBESU1NMCBBZGRyTWFza3M6DQo+IFsg
ICAgNC4yODU1ODNdIEVEQUMgREVCVUc6IGYxN19hZGRyX21hc2tfdG9fY3Nfc2l6ZTogICBPcmln
aW5hbCBBZGRyTWFzazogMHgxZmZmZmZlDQo+IFsgICAgNC4yODU3MjFdIEVEQUMgREVCVUc6IGYx
N19hZGRyX21hc2tfdG9fY3Nfc2l6ZTogICBEZWludGVybGVhdmVkIEFkZHJNYXNrOiAweDFmZmZm
ZmUNCj4gWyAgICA0LjI4NTg2MF0gRURBQyBERUJVRzogZjE3X2FkZHJfbWFza190b19jc19zaXpl
OiBDUzEgRElNTTAgQWRkck1hc2tzOg0KPiBbICAgIDQuMjg1OTY3XSBFREFDIERFQlVHOiBmMTdf
YWRkcl9tYXNrX3RvX2NzX3NpemU6ICAgT3JpZ2luYWwgQWRkck1hc2s6IDB4MWZmZmZmZQ0KPiBb
ICAgIDQuMjg2MTA1XSBFREFDIERFQlVHOiBmMTdfYWRkcl9tYXNrX3RvX2NzX3NpemU6ICAgRGVp
bnRlcmxlYXZlZCBBZGRyTWFzazogMHgxZmZmZmZlDQo+IFsgICAgNC4yODYyNDRdIEVEQUMgYW1k
NjQ6IE1DOiAwOiAgODE5MU1CIDE6ICA4MTkxTUINCj4gCQkJCSAgIF5eXl5eXl5eXl5eXl5eXl5e
DQo+IA0KPiBbICAgIDQuMjg2MzQ1XSBFREFDIGFtZDY0OiBNQzogMjogICAgIDBNQiAzOiAgICAg
ME1CDQo+IA0KPiB3aGljaCBzaG93cyA0IGNoaXAgc2VsZWN0cyB4IDhHYiA9IDMyRy4NCj4gDQo+
IFNvIHNvbWV0aGluZydzIHN0aWxsIHdyb25nLiBCZWZvcmUgdGhlIHBhdGNoc2V0IGl0IHNheXM6
DQo+IA0KPiBFREFDIE1DOiBVTUMwIGNoaXAgc2VsZWN0czoNCj4gRURBQyBhbWQ2NDogTUM6IDA6
ICA4MTkyTUIgMTogICAgIDBNQg0KPiAuLi4NCj4gRURBQyBNQzogVU1DMSBjaGlwIHNlbGVjdHM6
DQo+IEVEQUMgYW1kNjQ6IE1DOiAwOiAgODE5Mk1CIDE6ICAgICAwTUINCj4gDQo+IHdoaWNoIGlz
IHRoZSBjb3JyZWN0IG91dHB1dC4NCj4gDQoNCkNhbiB5b3UgcGxlYXNlIHNlbmQgbWUgdGhlIGZ1
bGwga2VybmVsIGxvZyBhbmQgZG1pZGVjb2RlIG91dHB1dD8NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
