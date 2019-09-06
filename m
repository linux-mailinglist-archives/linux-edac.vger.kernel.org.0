Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A6AC19D
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2019 22:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391129AbfIFUt4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Sep 2019 16:49:56 -0400
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:35554
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390989AbfIFUtz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Sep 2019 16:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Diu82E9tqGbDtKbMnIEqUADx/exV6cmsLIMRznx0ljiNEivw0UWkq4VWGAzE7IPGCcrSggXPrn7zpji686ppFJ1Y/Iw1RICOSDgAzI9FC7E520fpZR0CxUpsgW7DTN3jnAiVtXc/V9nQJDBgPbY+FcUO2ihHbINLwkxS2/x0cugGZWpCl1aPYxxJCw3JteL4L8+SurQvTLhamVVUrdw2/dnM9L0pDCctl9EtKARRZh7LO9cGbvT+c706pWxaoyY2NE8yEYn53sFtgsgxskpqZK4vn1g1y28OjeUcBct5fYF2U92USU6lpcF4m5okk2REkIy5+yuhezGFIE5CAKXkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43mP6q8nsAAmnNlgcLe4zVPQWZvk8jwFyPKnGf+XNFw=;
 b=NQaeR3cK4p//mIRaM6VOLP4ipUP7fNKEnowxKwsyyyPPfmSd4MK/4TdXqrJokcWmnGCm4RT42NrsWci2BBkTZ+CSe9YPl+g//E4up8QkgLUAzB0X5j7+xI8+geayW/MBRVMysZ946TXs0prEX6cqobllowDwVDjHGyx31w9NUKcFydPmXAj34IX5EWDuOjTzL/+of3SIrrBxGGjOQ2KDVCQhDhaw6mEiLpH1haTTst2Cn6wsoWJDTPlRgbCOJR+CeHJVVFCzbzUdOxfQ2LukhkpeDoiXdLpnMU6v5wuwEoaYe5xuz7bYvTANXMuoUYeqvdP0m4KIatoScDZ4BIhBRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43mP6q8nsAAmnNlgcLe4zVPQWZvk8jwFyPKnGf+XNFw=;
 b=1+4Krb8QeOLCQIuB8zIPZS64xay9hLd7OPqJOVtSPBuVvBFCeFU5nqXAfCv1EovgSq9ETj/Mi8lJDEB0Iqx9SzFWfyuNXldXApZIZTYJvkQisJWBODswEZBBlI+ZC4sOZ0UkNSDDyxh9/y9UBs0m30x0qhQWDLKYWIhk56OWrWE=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2735.namprd12.prod.outlook.com (52.135.107.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 6 Sep 2019 20:49:52 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690%7]) with mapi id 15.20.2220.020; Fri, 6 Sep 2019
 20:49:52 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Thread-Topic: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Thread-Index: AQHVWHyM0yWTJ6Qnuku4Pj6P3bApxacR5aOAgA03aPCAABcugIAAAtag
Date:   Fri, 6 Sep 2019 20:49:52 +0000
Message-ID: <SN6PR12MB2639232DF612AD2B02CFAAA4F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-9-Yazen.Ghannam@amd.com>
 <20190829092241.GB1312@zn.tnic>
 <SN6PR12MB26393DDA0F1818DCDD2D7953F8BA0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190906203519.GN19008@zn.tnic>
In-Reply-To: <20190906203519.GN19008@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.77.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81eb16da-921d-408c-6d3c-08d7330bc40c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2735;
x-ms-traffictypediagnostic: SN6PR12MB2735:
x-microsoft-antispam-prvs: <SN6PR12MB2735655A14AA337017C4C744F8BA0@SN6PR12MB2735.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(189003)(199004)(13464003)(256004)(8676002)(7736002)(74316002)(305945005)(81166006)(6436002)(6916009)(81156014)(55016002)(8936002)(229853002)(33656002)(2906002)(54906003)(316002)(6116002)(3846002)(76116006)(9686003)(486006)(476003)(11346002)(446003)(86362001)(4326008)(25786009)(66066001)(76176011)(5660300002)(66476007)(52536014)(4744005)(7696005)(102836004)(53546011)(6506007)(186003)(66556008)(53936002)(66946007)(64756008)(66446008)(6246003)(71190400001)(71200400001)(99286004)(26005)(478600001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2735;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OS9LL9fJbStUiSXAhXvd5Di1hGioqlUfXVhz1E9Z43eN27Yd8Uhu/tiLSBgWtePngtFEopZGgBda9se9aTskhD4l+3CmQvVRvRUNkB5v0pdPEZYlxs2tzSrPTtrwX5M63KLMVuOHC9WwolwQxzpuyeL8HI8FBIzpiE7nsD9+VypIGwHp8KTJQ80qs+isYCwu4JIvWPTgTaizrplI087kabv3+8nc4TBs9TJKcV3Ei29A5y0Z1gcX7bUvKk+Y1X440Y0WN7JVhXVRl7N5ZJxEpb8E0fV3v0uXM9xbm+vRMxAWslV4b9koJHOOMLbBWLRBsAXqMrr7nJQnJ+mmp6536p2AOPL+DZSjbub7KmkUCQ5KFV1VLCDgwYwVPhlUgDb9D03ej6c7hxJRZlwai3OdKUIYLEqXH13FEJp/23Lkck8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eb16da-921d-408c-6d3c-08d7330bc40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 20:49:52.1500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZehiIMUy564QOuX4qJi/tCOMCbTvOYfCst1CIv1i2zsNzor5pC94t39Vt0FKWWoPn/hQPeX7wlTgFbitWG5WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2735
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgNiwgMjAxOSAz
OjM1IFBNDQo+IFRvOiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBD
YzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMDgvMTBdIEVEQUMvYW1kNjQ6IEdhdGhl
ciBoYXJkd2FyZSBpbmZvcm1hdGlvbiBlYXJseQ0KPiANCj4gT24gRnJpLCBTZXAgMDYsIDIwMTkg
YXQgMDc6MTQ6NTdQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gVGhpcyBzdHJ1
Y3QgaXMgdXNlZCBwZXIgY2hhbm5lbCwgc28gd2UgbWF5IGhhdmUgMi04IHBlciBzeXN0ZW0uDQo+
IA0KPiBBaCwgdHJ1ZS4NCj4gDQo+ID4gV2UgY291bGQgZml4IGl0IGF0IHRoZSBtYXggKDgpLiBX
aGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IEFueXRoaW5nIGluIHN0cnVjdCBhbWQ2NF91bWMgdGhh
dCBpcyBzaGFyZWQgYmV0d2VlbiB0aG9zZSBjaGFubmVscyBvcg0KPiBhbGwgbWF4IDggb2YgdGhl
bSBjYW4gYmUgZGlzdGluY3Q/DQo+IA0KDQoNCkFsbCB0aGUgZmllbGRzIGFyZSByZWdpc3RlciB2
YWx1ZXMsIGFuZCB0aGVyZSBhcmUgdW5pcXVlIGluc3RhbmNlcyBmb3IgZWFjaCBjaGFubmVsLiBU
aGV5IGNhbg0KcG90ZW50aWFsbHkgYWxsIGJlIGRpZmZlcmVudC4NCg0KVGhhbmtzLA0KWWF6ZW4N
Cg==
