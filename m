Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC5EFEC7
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 14:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbfKENiS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 08:38:18 -0500
Received: from mail-eopbgr820078.outbound.protection.outlook.com ([40.107.82.78]:2769
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389172AbfKENiS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 08:38:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJmmpaK6B5mwoL5xbqW2hPQX6CvM7iqapK9lEPBOdsISXunl5eoscybSvQQqgy9vhEd93WDiH21ibr9z4cJuvv/sSnCqaiUgFtuGrJezHDXOZ0vLAIqFKFyE6Gwq7YObeM6Rjy9T2krZnoAeO8X7FTyKWyAnu1ryFmsjbT9RGkNJRY+Q7k9UDxnE4Uo7/k2Zy5edoeFWq5og1yhI07pOl26g+Fl+DbjlRk/1K/7meaDGpLieODvHcz8x33l8TiEL3z/rpkbs7nFRDVMj0nBHMTlwCAnQgZKwG0BIXSIU7r+NYDVuY2LPl65/UUfJTSiPNrxuOkpSr01AMF01Fy4DRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOiDCrS83r/KivqRh138gIw7PcNqONNuUMjEL8AZvQI=;
 b=k9G6AlqOBe9DPkyK5gHczj0I8l70PmuC/XTiKXxqKlog5h+bFSMSsfBYT6e2amo4tZI4q5LCCSxcSQKHBr+L/44AkUHVRqyfBCMMACi71PbFQS4kz0ywwAfyQtizY/vrrP8i6FrdX5hMZCytMmoPvgdIaYmhfEBF64u0cVIhNuFErIDELOJh7lt87B1lJbrHnw6AkZ/+4thA5+yPrFKQnfgY1jWMZ/W5AZBSGGmeFxZMEQ9w0T/wlwyo8T3fxZRhLoZiXz/Y8YfowuozOs8GSJ+/5HbdNmn+wNmVOEVmL+1EhdPQZTDXR7AO3n+fACkCEnCInNLGfioUbTtwFdd1Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOiDCrS83r/KivqRh138gIw7PcNqONNuUMjEL8AZvQI=;
 b=fkbpd3srk+Jm7ANejaUnPh0PetiH7NaZ4Q8sRgbQbyZ8xE6pNW+uc3Nu44CNVCUq3dtn/PztxM2ydJuv5+Xpbi7QG7uCwcQsFA90zUA3oyIB9Cjk+Bq33KqOqbAfhwM0fCTLIP37kHd0V2ufeTOMU6alg0ySHzLqITcIQm1fK3Y=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2830.namprd12.prod.outlook.com (20.177.250.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 13:38:15 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 13:38:15 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v2 0/6] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHViRgxcQiEBlwrekGL67NfTPIxZqdrX8oAgAsY5vCAAA5UAIAGIw2A
Date:   Tue, 5 Nov 2019 13:38:15 +0000
Message-ID: <SN6PR12MB2639B236A40754633C8E67F5F87E0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191022203448.13962-1-Yazen.Ghannam@amd.com>
 <20191025133456.GA6483@zn.tnic>
 <BYAPR12MB2630ED1425A3F01727E1C45BF8620@BYAPR12MB2630.namprd12.prod.outlook.com>
 <20191101155412.GA2300@nazgul.tnic>
In-Reply-To: <20191101155412.GA2300@nazgul.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [184.90.133.239]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00235954-fb1c-4537-061c-08d761f56940
x-ms-traffictypediagnostic: SN6PR12MB2830:
x-microsoft-antispam-prvs: <SN6PR12MB28300645C2188DABE5C270C4F87E0@SN6PR12MB2830.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(13464003)(86362001)(4326008)(186003)(6506007)(8676002)(99286004)(55016002)(54906003)(229853002)(9686003)(6116002)(3846002)(66556008)(53546011)(14454004)(25786009)(486006)(11346002)(446003)(76116006)(81156014)(74316002)(6916009)(76176011)(305945005)(102836004)(52536014)(5660300002)(33656002)(7736002)(316002)(66946007)(26005)(64756008)(66066001)(2906002)(6246003)(81166006)(71200400001)(71190400001)(478600001)(6436002)(8936002)(256004)(14444005)(7696005)(66476007)(66446008)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2830;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTmwuwBk+OZoQN9YioBvebt9uTsLtJ8vj83tgS6w9lmf4dIkznQFlRLhhP5XDbjYZ9ouxsCxOhto6azVjsssh/TlA/uTa/G2n6fvBZDGWA1KVVKCCoCRwuqmmAZkKsPc/j2N75w9WXwLLvqYPjr72XWTQrkinOaHqa43hK+S/PsPSsFZ12kg6Yn0eSR7Q0JbKeMYynbtVlvBDtZoOWP40TOhbvhkSrLswIqDXj/R8NlrMsRoGWJ38NMkpWCt7JtyR7q8P9Q1jEI8MduO/Wp964QXGWbOZnEbNQj1BV7LAIocPBnCNqlp43zG7mJWStmRdqwcwUOTWhjgZPeb8GJF/4EiC4F2wCYNwTtZ54vsf5Wcib0xRP/pTI/yh2hzPt2z2iBp7pFeymSbTmVQb9GIJetZrr5+G79iXv+BLnWz5Wz8bAshRpbwfZeVl1Hn84a4
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00235954-fb1c-4537-061c-08d761f56940
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 13:38:15.5780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0a93zh1tgwvy/d6xVdHFvbYNbQNFIV1XqprVqpmYMKxKMrH+cDTFHvLKDqDXIOZBq1yDg/aBlkjTKMlbVCRXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJlciAxLCAyMDE5IDEx
OjU0IEFNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBD
YzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwLzZdIEFNRDY0IEVEQUM6IENoZWNrIGZvciBu
b2RlcyB3aXRob3V0IG1lbW9yeSwgZXRjLg0KPiANCj4gT24gRnJpLCBOb3YgMDEsIDIwMTkgYXQg
MDM6MTk6MzZQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gSXMgdGhlIG1vZHVs
ZSBiZWluZyBwcm9iZWQgdHdpY2U/IFdlIGhhdmUgdGhpcyBwcm9ibGVtIGluIGdlbmVyYWwsIGUu
Zy4gdGhlDQo+ID4gbW9kdWxlIGdldHMgbG9hZGVkIG11bHRpcGxlIHRpbWVzIG9uIGZhaWx1cmUu
DQo+IA0KPiBZYXAsIGl0IGxvb2tzIGxpa2UgaXQuDQo+IA0KPiA+IFRoZSBjbHVlIGZvciBtZSBp
cyB0aGF0IG5vZGUgMCBnZXRzIGRldGVjdGVkIHR3aWNlLiBUaGlzIGlzIGRvbmUgaW4NCj4gPiBw
ZXJfZmFtaWx5X2luaXQoKSBlYXJseSBpbiBwcm9iZV9vbmVfaW5zdGFuY2UoKS4NCj4gPg0KPiA+
IEluIGFueSBjYXNlLCBJIHRoaW5rIHdlIGNhbiBtYWtlICFlY2NfZW5hYmxlZChwdnQpIGluIHBy
b2JlX29uZV9pbnN0YW5jZSgpIGENCj4gPiBmYWlsdXJlIG5vdyB0aGF0IHdlIGhhdmUgYW4gZXhw
bGljaXQgY2hlY2sgZm9yIG1lbW9yeSBvbiBhIG5vZGUuIEluIG90aGVyDQo+ID4gd29yZHMsIGlm
IHdlIGhhdmUgbWVtb3J5IGFuZCBFQ0MgaXMgZGlzYWJsZWQgdGhlbiB0aGlzIGlzIGEgZmFpbHVy
ZSBmb3IgdGhlDQo+ID4gbW9kdWxlLg0KPiANCj4gWWVhaCwgZm9yIHRoYXQgY2FzZSB3ZSBzaG91
bGQgYmUgcHJpbnRpbmcgZWNjX21zZy4gTWFrZXMgc2Vuc2UuDQo+IA0KDQpEbyB5b3UgaGF2ZSBh
bnkgb3RoZXIgY29tbWVudHMgb24gdGhpcyBzZXQ/IFNob3VsZCBJIHNlbmQgYW5vdGhlciByZXZp
c2lvbg0Kd2l0aCB0aGlzIGNoYW5nZT8NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
