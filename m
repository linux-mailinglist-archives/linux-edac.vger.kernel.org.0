Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5640F38D7
	for <lists+linux-edac@lfdr.de>; Thu,  7 Nov 2019 20:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfKGTlk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Nov 2019 14:41:40 -0500
Received: from mail-eopbgr820072.outbound.protection.outlook.com ([40.107.82.72]:36192
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbfKGTlk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Nov 2019 14:41:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gK1WxUC0IS9zZaaccinKs1efktIKSHP+1+z1KWZN8fNkss/soCDrxTZvQ0F0y7km4OGWJKYwKLJTMAVcbjQ5AvHzTJkVjwFexVeLjjC/7I6n8lzuE6Y8knH/klyy+Fr9jG/W8QIIfNXIid57MehVpV/dJhJ/N+owC7h+xF3dbhqANxmxGkfWIztDMdYU/tuf9jTnTRtIh9ji1ZRB6Y+zAG6Vrm4tSOmFuxt97ZNFuBzWu66w2tllH0K8QOL9bKgD64YI7/rRq7/ITpufaPi+zTchBjhKZsY4NOs0oaDRQHQril58p2oUommpWJTh3+OEh6WWvnBex0Lc7Cnwe2SUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rKh1W0yIjamrWzezcgn2w5gcE54uNCwEuqSg2Uop3A=;
 b=EH6BOWv5ycCg9zeaL0AM90vra2xa4AEcd9IN9Lqak3CHG6RTaKn9PtBsezHUGM1aHD16Tu3Rv5AtOV/7FkrlKYSZteRdXnSvNIKjvJAikKGxKq+3fnZH3/Do2wwyoPQci4O3Y/yaxCEBuuaoTUbgbMNY+124JghKqGIbbIV46MfOx5SCwM5u1UEPq1YlvgrIcVc7LVQ+fGGvFbATtQFwX81mISNjYoBdG5sltrAVKBWEtJmj2K8h90I2Z98v0/gfd0QkSZC5KN8RWT0sDTbC2FVPjNz3ulDYnFDw4kXei5HD5L8fc+F+yvPCElMhUAVijYzxLqOrkKKqchLpBOr9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rKh1W0yIjamrWzezcgn2w5gcE54uNCwEuqSg2Uop3A=;
 b=fiLNYes6dETpzPpg/vFgTYxycr5LIt5eQzr92qOgviu+ew/DqlsQmW9yWeeWrp1QDMiT/yNwU9R7KUUuMEXdYH/v+Xi6mWGX1X3X1VayBYY+WlIirPMp2fFoDTGputkSTC6jfacaLiKuMUCnQ1rSKgMAv9I1XIvuVqtb+Y5iLlQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2687.namprd12.prod.outlook.com (52.135.103.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Thu, 7 Nov 2019 19:41:38 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::2819:e697:4314:56ba%3]) with mapi id 15.20.2408.028; Thu, 7 Nov 2019
 19:41:38 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Topic: [PATCH v3 0/5] AMD64 EDAC: Check for nodes without memory, etc.
Thread-Index: AQHVlEEBkkiHg8UvLEKx+Q/uzElWBqd+T6+AgAAi68CAABzVgIAA9yyAgAAyaVCAACG7AIAAO3twgAAGAoCAAADjwA==
Date:   Thu, 7 Nov 2019 19:41:38 +0000
Message-ID: <SN6PR12MB26395B751A59D86EFF3A77EBF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20191106012448.243970-1-Yazen.Ghannam@amd.com>
 <20191106160607.GC28380@zn.tnic>
 <SN6PR12MB26398D9E617DF8C0ABE0252CF8790@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191106195417.GF28380@zn.tnic> <20191107103857.GC19501@zn.tnic>
 <SN6PR12MB263984026F57EC7F3B33B2BFF8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107154006.GF19501@zn.tnic>
 <SN6PR12MB263925E6F18C3EDC8D398932F8780@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20191107193429.GI19501@zn.tnic>
In-Reply-To: <20191107193429.GI19501@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [2603:9001:1a05:3100:9de1:18ac:4797:8053]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e5f07c5-76fa-4e7f-d9e3-08d763ba8160
x-ms-traffictypediagnostic: SN6PR12MB2687:
x-microsoft-antispam-prvs: <SN6PR12MB2687F28BB1590439F5542388F8780@SN6PR12MB2687.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(13464003)(199004)(189003)(256004)(186003)(81166006)(5660300002)(46003)(81156014)(52536014)(8676002)(33656002)(25786009)(8936002)(229853002)(6116002)(6916009)(102836004)(7696005)(4326008)(71190400001)(71200400001)(55016002)(14454004)(6246003)(476003)(99286004)(66476007)(66946007)(305945005)(6506007)(86362001)(486006)(54906003)(66556008)(64756008)(66446008)(53546011)(76116006)(316002)(446003)(76176011)(11346002)(478600001)(74316002)(6436002)(2906002)(7736002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2687;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39sEz6oQqTEIyCd/MDipaoNbfDyhkk/1KvsEtIOsdDbE6EWDZT7fSeNQ2JaBwX8R0+jz+O2Dvk+B6RP2vNAAQFp22TwZCKZYOWq+JPVp51canhp1qQ1fnN4y/bARkPmMAZHGVUbSRNsRH68TKljUcAYsjkyRJUGyc/nNzL4kti/QpFnBt86UD5JqVyYFbRJz922pM67UClvqyuYk1sma6WX92sahkeLp55j5RbRDgU9z7N544vqHXQGht6pu+Wvc6RsgSwT6cIUcr2Cq8r8apcUgLiHlWhoVFdeMQEHtp3GzX+IPTal15531TNycepQ8r/i/htcYmD/E34ebJWqf8/sFh/66Xz2tZcqzQQOOz0feAT/xZIg2PN0pjd3RufibsoiPUK+P2vPE9ovLw7CU/bFljtGuGYd9ZMsYtjUOUVk2AVxZvcj59eblL7ALjwLp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f07c5-76fa-4e7f-d9e3-08d763ba8160
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 19:41:38.0380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1D7NpZ3m/ZRKUSHTa+6n5gZ49Poug9LKqXg/jJVv5E2fhbRx6pG46GO/XV+u7zmtpuNH0WVKPHIk52QsLCQLSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2687
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDcsIDIwMTkg
MjozNCBQTQ0KPiBUbzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4g
Q2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC81XSBBTUQ2NCBFREFDOiBDaGVjayBmb3Ig
bm9kZXMgd2l0aG91dCBtZW1vcnksIGV0Yy4NCj4gDQo+IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0
IDA3OjIwOjI1UE0gKzAwMDAsIEdoYW5uYW0sIFlhemVuIHdyb3RlOg0KPiA+IFllcywgdGhhdCdz
IHJpZ2h0LiBCdXQgaXQgbG9va3MgbGlrZSBmdXR1cmUgc3lzdGVtcyB3aWxsIHJlLXVzZSBQQ0kg
SURzIGV2ZW4NCj4gPiBhY3Jvc3MgZmFtaWxpZXMgYW5kIG1vZGVscy4gQW5kIHRoZSBQQ0kgSURz
IHdpbGwgYmUgbW9yZSBjbG9zZWx5IHJlbGF0ZWQgdG8NCj4gPiBoYXJkd2FyZSBjYXBhYmlsaXRp
ZXMgdGhhbiBmYW1pbHkgYW5kIG1vZGVsLg0KPiA+DQo+ID4gSW4gYW55IGNhc2UsIHdlIGNhbiBh
ZGRyZXNzIHRoYXQgd2hlbiB3ZSBnZXQgdGhlcmUuDQo+IA0KPiBJJ2QgYmUgZmluZSB3aXRoIGl0
IGlmIHRoaXMgcmVhbGx5IGlzIHRoZSBjYXNlIGFuZCB3ZSBkb24ndCBlbmQgdXANCj4gaGF2aW5n
IHRvIGtlZXAgYWRkaW5nIFBDSSBJRHMgbGlrZSBjcmF6eSBhZ2Fpbi4gVGhhdCB3YXMgYSBtb2Rl
cmF0ZQ0KPiBQSVRBLCBBRkFJUiwgZXNwZWNpYWxseSBmb3IgZGlzdHJvIGtlcm5lbHMgaGF2aW5n
IHRvIGNvbnN0YW50bHkgcGljayB1cA0KPiBlbmFibGVtZW50IHBhdGNoZXMgYW5kIHBlb3BsZSBj
b21wbGFpbmluZyBhYm91dCBpdC4NCj4gDQo+IFNvIHlvdSBuZWVkIHRvIG1ha2Ugc3VyZSB0aGUg
UENJIElEcyB3aWxsIHJlYWxseSBnZXQgcmV1c2VkIGJlZm9yZQ0KPiBjb252ZXJ0aW5nIGJhY2su
Li4NCj4gDQoNCldpbGwgZG8uDQoNCj4gPiA+ICAgICAgICAgaWYgKCFlY2NfZW4gfHwgIW5iX21j
ZV9lbikNCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gPiAgICAgICAg
IGVsc2UNCj4gPg0KPiA+IFJpZ2h0LCBJIG1lYW50IHlvdSBjYW4gZHJvcCB0aGlzIGVsc2UgYW5k
IGp1c3QgcmV0dXJuIHRydWUuDQo+ID4NCj4gPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1
ZTsNCj4gDQo+IEkgcHJlZmVyIHRoZSByZWd1bGFyIGlmLWVsc2Ugd2F5IGJlY2F1c2UgaXQgcmVh
ZHMgZmFzdGVyIGFuZCBpdCBpcw0KPiBzdHJhaWdodC1mb3J3YXJkIHdoZW4gb25lIHNraW1zIG92
ZXIgdGhlIGNvZGUuDQo+IA0KPiBCdXQgSSBjYW4gZHJvcCBpZiBpZiB5b3UgaW5zaXN0LiA6LSkN
Cj4gDQoNCk5vLCBJIGRvbid0IG1pbmQuDQoNClRoYW5rcywNCllhemVuDQo=
