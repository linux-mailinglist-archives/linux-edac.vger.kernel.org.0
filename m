Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89AC59B0ED
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 15:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393246AbfHWN2d (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 09:28:33 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:3226
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393266AbfHWN2c (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Aug 2019 09:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0XbUPBqI8G1xSDjEB3BuF6208lelOqa24zPONtoxvzd40G/5bwk/dtevOqfPBOriXrOHMIRc1uPxOmN9AbdV/CoVZW56y7ilgczrot8/qwhQnPS+MuCKqPlCsxHYG1J61Zj62kAs5M7QsH3PeNGMNynQ08xypxTdhmeKWMPPVM1o48os2bOyM6pzxXA5K749yrM/aJen9zbhmpEYtdbbqUAiR6WVueEDvfyZ3MHOLkeQbEDi5oCfbO0Spl6YE/DwLVDR/uf2H4+UHjXcwuSjecFURNjd8+ynykP5Q2CG65CUcXsPChiD0hZhUO+CLn6tTIrNlTZ1euXP4pQa6U8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R7yn9MhA63S3RCSov7lGqbN08slbBTKRRHVJo1Pnmk=;
 b=GZEQbsGRh/iCo9Jxtl8emNmnzp+DrpJCq+utdyXw34T4T+aURRIN6QYtc0H2Z5++xP+W7JfhYo5azMERXOtGxreYbHCFhH97ivnqtrY5AKepdAnk6TFCpWp446LEAyWPIZtroATgDk9PuF2PW97V0qujR3SkKGwatgiknzd3FPopl/5pqyZDLXKGVY0agYkLtPSe67e9LaPgdAaLEVyyGjLNmXTY+Ive4zqC0EA1e6eue2EtzYOx/HhoJiJpq+VEKhGo3vWBKLIT2xzYfTqrZ1u5wmwPCUkovxYbffaPKQEyq7DRulVVElpl7K4HV5pEtwRPWKmGh50DyvKqUcYBiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2R7yn9MhA63S3RCSov7lGqbN08slbBTKRRHVJo1Pnmk=;
 b=3tyJ12x4FUAUngQkviMh24pTRw7w6PvjxzqwazLNEZXvv8S3+Vel+cjEpfv/TJnL6nM+La5WdyVcYRMrBBrwBsQc6QAOkI0zCCPIOqmyNPvJKK6SUyn5YkHV3SXd68BBlfeaNZHBL9QhYbqDHSVwgRVD65CS2zdUMmjcaGnLjWg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2653.namprd12.prod.outlook.com (52.135.103.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 13:27:50 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 13:27:50 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Topic: [PATCH v3 7/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Index: AQHVWHyLNIgg0pPI/0SnSpoL9D1KY6cImjwAgAAhtmA=
Date:   Fri, 23 Aug 2019 13:27:50 +0000
Message-ID: <SN6PR12MB2639B5F8445D90154BA8860AF8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-8-Yazen.Ghannam@amd.com>
 <20190823112628.GA28379@zn.tnic>
In-Reply-To: <20190823112628.GA28379@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4976d744-2f80-4f1d-c89a-08d727cdb1d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR12MB2653;
x-ms-traffictypediagnostic: SN6PR12MB2653:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB265319C0CE2A8F5083E153C9F8A40@SN6PR12MB2653.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(199004)(13464003)(189003)(8676002)(53936002)(66556008)(52536014)(66946007)(5660300002)(186003)(76176011)(14454004)(102836004)(99286004)(6506007)(26005)(53546011)(446003)(256004)(25786009)(966005)(11346002)(6306002)(7696005)(66066001)(55016002)(8936002)(486006)(6436002)(476003)(54906003)(9686003)(66476007)(66446008)(76116006)(229853002)(305945005)(6916009)(71190400001)(71200400001)(74316002)(316002)(86362001)(3846002)(7736002)(6116002)(478600001)(33656002)(6246003)(81156014)(81166006)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2653;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V5ElYAGlvmLqJyucTBRVfpu9l9gIDi355fqDJRJuD31SjEbEkdfRPAEF2e6VygiKHerfNDGvMfe+EQTJWYY6VDXye0s3cKR0LdQJOadhnE0TsUmV+4xFJixJhOtslrXV4gSGL/i0AON2QuVH1rQC+Owoi9IzasmVpSIHiVk5fikbWxnZvrUshw1F47C9Vho/JJ5u/XvvbNzxwk8eG1LJApBGYVl63lGbzFM/PX7KHxsqAg1TMeMSV+OTJt1DKgk6wKbHGp7KsMUg8y+oMmBKYgE4gxXHoV4xNaRksxKd4UxrCqqjA7KzIejLFafXjtkI/RmKjIvO9IqBjiLaHfSvExN3zL9Af5xyeh+hCLa5fRov6nYL0NQwNZ8Ma5mXN3KDhwAiX3XM/45xWiMxtPRmMLYPUDCFSFncNgLAsIdpqWU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4976d744-2f80-4f1d-c89a-08d727cdb1d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 13:27:50.1077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4e2WiYW2rSHEkglepAC01jQEo5zxL2V0r9V6b4DZPtcXEOyjqeTgxP73XwtCyIzspc8tqtZdGP6udsZ2+mpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjMsIDIwMTkgNjoy
NiBBTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6
IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNy84XSBFREFDL2FtZDY0OiBTdXBwb3J0IEFzeW1t
ZXRyaWMgRHVhbC1SYW5rIERJTU1zDQo+IA0KPiBPbiBUaHUsIEF1ZyAyMiwgMjAxOSBhdCAxMjow
MDowMkFNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBGcm9tOiBZYXplbiBHaGFu
bmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQo+ID4NCj4gPiBGdXR1cmUgQU1EIHN5c3RlbXMg
d2lsbCBzdXBwb3J0ICJBc3ltbWV0cmljIiBEdWFsLVJhbmsgRElNTXMuIFRoZXNlIGFyZQ0KPiA+
IERJTU1zIHdoZXJlIHRoZSByYW5rcyBhcmUgb2YgZGlmZmVyZW50IHNpemVzLg0KPiA+DQo+ID4g
VGhlIGV2ZW4gcmFuayB3aWxsIHVzZSB0aGUgUHJpbWFyeSBFdmVuIENoaXAgU2VsZWN0IHJlZ2lz
dGVycyBhbmQgdGhlDQo+ID4gb2RkIHJhbmsgd2lsbCB1c2UgdGhlIFNlY29uZGFyeSBPZGQgQ2hp
cCBTZWxlY3QgcmVnaXN0ZXJzLg0KPiA+DQo+ID4gUmVjb2duaXplIGlmIGEgU2Vjb25kYXJ5IE9k
ZCBDaGlwIFNlbGVjdCBpcyBiZWluZyB1c2VkLiBVc2UgdGhlDQo+ID4gU2Vjb25kYXJ5IE9kZCBB
ZGRyZXNzIE1hc2sgd2hlbiBjYWxjdWxhdGluZyB0aGUgY2hpcCBzZWxlY3Qgc2l6ZS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1AYW1kLmNvbT4N
Cj4gPiAtLS0NCj4gPiBMaW5rOg0KPiA+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTA3
MDkyMTU2NDMuMTcxMDc4LTgtWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQo+ID4NCj4gPiB2Mi0+djM6
DQo+ID4gKiBBZGQgY2hlY2sgb2YgY3Nyb3dfbnIgYmVmb3JlIHVzaW5nIHNlY29uZGFyeSBtYXNr
Lg0KPiA+DQo+ID4gdjEtPnYyOg0KPiA+ICogTm8gY2hhbmdlLg0KPiA+DQo+ID4gIGRyaXZlcnMv
ZWRhYy9hbWQ2NF9lZGFjLmMgfCAxOCArKysrKysrKysrKysrKystLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFj
LmMNCj4gPiBpbmRleCAyNmNlNDhmY2FmMDAuLjRkMWU2ZGFhN2VjNCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQo+ID4gKysrIGIvZHJpdmVycy9lZGFjL2FtZDY0
X2VkYWMuYw0KPiA+IEBAIC03OTAsOSArNzkwLDEzIEBAIHN0YXRpYyB2b2lkIGRlYnVnX2R1bXBf
ZHJhbWNmZ19sb3coc3RydWN0IGFtZDY0X3B2dCAqcHZ0LCB1MzIgZGNsciwgaW50IGNoYW4pDQo+
ID4NCj4gPiAgI2RlZmluZSBDU19FVkVOX1BSSU1BUlkJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIENT
X09ERF9QUklNQVJZCQlCSVQoMSkNCj4gPiArI2RlZmluZSBDU19FVkVOX1NFQ09OREFSWQlCSVQo
MikNCj4gPiArI2RlZmluZSBDU19PRERfU0VDT05EQVJZCUJJVCgzKQ0KPiA+DQo+ID4gLSNkZWZp
bmUgQ1NfRVZFTgkJCUNTX0VWRU5fUFJJTUFSWQ0KPiA+IC0jZGVmaW5lIENTX09ERAkJCUNTX09E
RF9QUklNQVJZDQo+ID4gKyNkZWZpbmUgQ1NfRVZFTgkJCShDU19FVkVOX1BSSU1BUlkgfCBDU19F
VkVOX1NFQ09OREFSWSkNCj4gPiArI2RlZmluZSBDU19PREQJCQkoQ1NfT0REX1BSSU1BUlkgfCBD
U19FVkVOX1NFQ09OREFSWSkNCj4gDQo+IFRoYXQncyBqdXN0IG15IHVyZ2UgdG8gaGF2ZSBzdHVm
ZiBiYWxsYW5jZWQgYnV0IHNob3VsZG4ndCB0aGF0IGxhc3QgbGluZSBiZToNCj4gDQo+ICNkZWZp
bmUgQ1NfT0RECQkJKENTX09ERF9QUklNQVJZIHwgQ1NfT0REX1NFQ09OREFSWSkNCj4gDQo+IGku
ZS4sIG5vdCBoYXZlICJldmVuIiBhcyBpbiBDU19FVkVOX1NFQ09OREFSWSBpbiB0aGVyZSBidXQg
b25seSAib2RkInM/IDopDQo+IA0KDQpZZXMsIHNvcnJ5IEkgbWlzc2VkIHRoYXQuDQoNCj4gPiAr
I2RlZmluZSBjc3Jvd19zZWNfZW5hYmxlZChpLCBkY3QsIHB2dCkJKChwdnQpLT5jc2Vsc1soZGN0
KV0uY3NiYXNlc19zZWNbKGkpXSAmIERDU0JfQ1NfRU5BQkxFKQ0KPiANCj4gSSBtb3ZlZCB0aGF0
IHRvIHRoZSBoZWFkZXIsIHVuZGVyIGNzcm93X2VuYWJsZWQoKS4NCj4gDQoNCk9rYXksIHRoYW5r
IHlvdS4NCg0KLVlhemVuDQo=
