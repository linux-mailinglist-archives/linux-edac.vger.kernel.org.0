Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4911211CF
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 18:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfLPRfY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 12:35:24 -0500
Received: from mail-eopbgr770050.outbound.protection.outlook.com ([40.107.77.50]:52612
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbfLPRfY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 12:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7yAmvreFS95238v126hDMJkU8CD9cl1m8RL28bx5V4EX3rFtUqQrfkceJ5otQe3xPDE8oKkfuZfePzKfQvx9v8zQ6v1egiNvCDwhExhUfYRVnIPOyU4aTjcixdcE3RY4tapcpsB/vERKRWnRuPJgwmrvQbdP/xUK695XVIcF41ZC48PSs7Pq+kk56v8uvgSg1Dt8pbRcqe2olOc/hjCYmGKTBB0DWpWO2oFBEODBa0OoYNyh8qgOvN9JII89yC8+lKdHHMf0fKo/PUvcFt+fPs4/0rHO67a8Nz5D/sFGkdDnXxuwNDDsuM4ouWQtjPJCZ+89wT2NcQQ0NJ6M4VT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40GoBwhK0VPMhLKLO5sAsjYnU3eClRDh0oV0VgF6AU4=;
 b=akyCsTp0FumhHDVhC9pxjPCSupEEvmMXZ3ufPUe2ji6t3HJF75pNuukH3bL9qjP2uED1UR0mHfkfHJIct19NaO5pulZzE3MNDJi0GlwPpiQKFRuhEvs56WlQz8AdyUiVDvMelLWxBQ7JryTz+lQExFBB3QRKI6P1PbwyWvZBz1BEtzto6YmtRi90QbEaXa8/wVAJFAQ/S7TdDU+q9zbSi2eDZ1uu+DpCPFIAMyTo3IsKRDTPYhJdA3fGh4xIuDHC5DxPsBR829eijSbyivqpi9tagGf7GwWljR+FZvQ9FInDp6peMFP7EtNL0mxEZ/3I9XaR8kwjlUGC3zSI8LkU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40GoBwhK0VPMhLKLO5sAsjYnU3eClRDh0oV0VgF6AU4=;
 b=n+pm9pQE1io+IV/o8gccOGnN7nuP4R3hludka6ng9/kWfPFK/d3fbzCCVMf6r64LqebxIbaDRMP6gcj12c6uL0c5NBgvftWfre5VrxBk2LMvw6TFUZmFaCrNsqybsq3MfiMW2PdoL4zaF+qMK7KUjOe8Kd1cpOv4Yxs/c9IzBo8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.106.25) by
 SN6PR12MB2703.namprd12.prod.outlook.com (52.135.106.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.20; Mon, 16 Dec 2019 17:35:19 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::137:38a3:4901:29eb%3]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 17:35:19 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        =?utf-8?B?SmFuIEguIFNjaMO2bmhlcnI=?= <jschoenh@amazon.de>
CC:     Tony Luck <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH 3/6] x86/mce: Fix possibly incorrect severity calculation
 on AMD
Thread-Topic: [PATCH 3/6] x86/mce: Fix possibly incorrect severity calculation
 on AMD
Thread-Index: AQHVtDXxisPqFm64aE2rcUcCCkI8vqe9Ba+w
Date:   Mon, 16 Dec 2019 17:35:19 +0000
Message-ID: <SN6PR12MB2639C17566A1654561E24484F8510@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-4-jschoenh@amazon.de> <20191216172609.GE17380@zn.tnic>
In-Reply-To: <20191216172609.GE17380@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [142.196.148.163]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: beb7861c-fbb6-411d-0994-08d7824e525e
x-ms-traffictypediagnostic: SN6PR12MB2703:
x-microsoft-antispam-prvs: <SN6PR12MB27034DDB90E5F87AFDF99C8DF8510@SN6PR12MB2703.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(189003)(199004)(13464003)(26005)(7696005)(4326008)(110136005)(5660300002)(81166006)(81156014)(53546011)(8676002)(316002)(54906003)(2906002)(8936002)(6506007)(478600001)(66946007)(66476007)(66556008)(64756008)(66446008)(33656002)(186003)(76116006)(9686003)(66574012)(55016002)(52536014)(71200400001)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2703;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVsFwJPUMEGjy8rYI8m+ql0YFyr7EbUpkx96t3/bQxjoTb3OApTAdn1JeekmWel2UCU9G5cxuCQTyTcPpJASwiJdzJwfWDa2w05qmLWFZJkYaDn/OBkRlpSGiV1WfCSwFaQLGm5ZT3cGHhQSWO0EPs/n7oQOXzmdpQcactg6TvY5R4fd1N2a1XLosZr4tFeUVgnQPxNLqWMb0C5p5RtZ+zluNYCTuHd5IuXp/ZjfLSSUkE/S2shALzvzMN5YS7OuUvas5l7PyTTc2vXFZ57An9yDMmqeaT/uIbYQ4SHK6JI0TfLbTip38wL5HJBo/II964i3zsh2QWwWDFNFH0R1Jb6KMZIHwGK8jfxKohJ4OR+jxbcP18Tzmsb8ZKJtsYnUHB4DYB1BX8c4K83QXo8GaVNpf+2PTjLjQv/Sc82sWkvQ2lvyN0ukfZBUQ6dTGMV/G0Yi7pHdEoL2kbBij8mNGtH0bZu9gJukq2uP43VLHQCagZjsDjVvDwiJ6ajBjfBs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb7861c-fbb6-411d-0994-08d7824e525e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 17:35:19.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45y8hegJRWzpFCiXP6AO2MXj1ARUdNuJ+8DeHN+XZa5GhsmFb54WJPO7h4XviiGA2ViukJi2Yyc6lZdTmKIpMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2703
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAxNiwgMjAxOSAxMjoyNiBQTQ0K
PiBUbzogSmFuIEguIFNjaMO2bmhlcnIgPGpzY2hvZW5oQGFtYXpvbi5kZT47IEdoYW5uYW0sIFlh
emVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBUb255IEx1Y2sgPHRvbnkubHVja0Bp
bnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgVGhvbWFzIEdsZWl4bmVyIDx0
Z2x4QGxpbnV0cm9uaXguZGU+OyBJbmdvIE1vbG5hcg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEgu
IFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtQQVRDSCAzLzZdIHg4Ni9tY2U6IEZpeCBwb3NzaWJseSBpbmNvcnJlY3Qgc2V2ZXJpdHkg
Y2FsY3VsYXRpb24gb24gQU1EDQo+IA0KPiBPbiBUdWUsIERlYyAxMCwgMjAxOSBhdCAwMTowNzoz
MEFNICswMTAwLCBKYW4gSC4gU2Now7ZuaGVyciB3cm90ZToNCj4gPiBUaGUgZnVuY3Rpb24gbWNl
X3NldmVyaXR5X2FtZF9zbWNhKCkgcmVxdWlyZXMgbS0+YmFuayB0byBiZSBpbml0aWFsaXplZA0K
PiA+IGZvciBjb3JyZWN0IG9wZXJhdGlvbi4gRml4IHRoZSBvbmUgY2FzZSwgd2hlcmUgbWNlX3Nl
dmVyaXR5KCkgaXMgY2FsbGVkDQo+ID4gd2l0aG91dCBkb2luZyBzby4NCj4gPg0KPiA+IEZpeGVz
OiA2YmRhNTI5ZWM0MmUgKCJ4ODYvbWNlOiBHcmFkZSB1bmNvcnJlY3RlZCBlcnJvcnMgZm9yIFNN
Q0EtZW5hYmxlZCBzeXN0ZW1zIikNCj4gPiBGaXhlczogZDI4YWYyNmZhYTBiICgieDg2L01DRTog
SW5pdGlhbGl6ZSBtY2UuYmFuayBpbiB0aGUgY2FzZSBvZiBhIGZhdGFsIGVycm9yIGluIG1jZV9u
b193YXlfb3V0KCkiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEphbiBILiBTY2jDtm5oZXJyIDxqc2No
b2VuaEBhbWF6b24uZGU+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2Nv
cmUuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29y
ZS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ID4gaW5kZXggODFhYjI1ZDUz
NTdhLi42YWZiOWRlMjUxZjIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9t
Y2UvY29yZS5jDQo+ID4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jDQo+ID4g
QEAgLTgwOSw4ICs4MDksOCBAQCBzdGF0aWMgaW50IG1jZV9ub193YXlfb3V0KHN0cnVjdCBtY2Ug
Km0sIGNoYXIgKiptc2csIHVuc2lnbmVkIGxvbmcgKnZhbGlkcCwNCj4gPiAgCQlpZiAocXVpcmtf
bm9fd2F5X291dCkNCj4gPiAgCQkJcXVpcmtfbm9fd2F5X291dChpLCBtLCByZWdzKTsNCj4gPg0K
PiA+ICsJCW0tPmJhbmsgPSBpOw0KPiA+ICAJCWlmIChtY2Vfc2V2ZXJpdHkobSwgbWNhX2NmZy50
b2xlcmFudCwgJnRtcCwgdHJ1ZSkgPj0gTUNFX1BBTklDX1NFVkVSSVRZKSB7DQo+ID4gLQkJCW0t
PmJhbmsgPSBpOw0KPiA+ICAJCQltY2VfcmVhZF9hdXgobSwgaSk7DQo+ID4gIAkJCSptc2cgPSB0
bXA7DQo+ID4gIAkJCXJldHVybiAxOw0KPiA+IC0tDQo+IA0KPiBHb29kIGNhdGNoLiBUaGlzIHNo
b3VsZCBnbyB0byBMaW51cyBub3cuDQo+IA0KPiBZYXplbiwgYW55IG9iamVjdGlvbnM/DQo+IA0K
DQpObyBvYmplY3Rpb25zLg0KDQpUaGFua3MsDQpZYXplbg0K
