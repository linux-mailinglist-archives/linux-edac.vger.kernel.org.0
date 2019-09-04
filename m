Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A84C1A9643
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2019 00:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfIDWVx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Sep 2019 18:21:53 -0400
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:35845
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727722AbfIDWVw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 4 Sep 2019 18:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmhvZYBCKPNBhLvLG0LuvJ0LYorbQUZGhtpXU3Sjh8fDbO9Kj9dLZiXyghPt8WmAK9L62xwSE6Y22IlgtK0cpH4LEn3Ebateyk+y9Nv2qEzz/Imou2qNR11oFikl6pXLqIxiaP/SdZNc9bqKtuZuexiGrd5t5XB4yBcZ36a2r3xKQnd8+YCYmJ6cfclF7BU5EZ83NiMh14uskLlRSY6xLs186EV5C6Xja4GzKlXH1vPKRuKijZwDENi9p7ZzZrO1ywCs4u2DMKQmTmvYDZEXx1xHUPGHw34PGcD4ipCjq/mMbnlNykWVwpUfmuSMWBXpgXjT+UyzI4uIBrYM65yW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmkGFFYdoJtLRwrMl/scnqgMg1llICyImxc3iKFnknY=;
 b=WpUxySnnJBXZGE21qRYJ2n+LhYxFvAAo2SMd/afP8cs/MflhU03kqroHktZjOpmSlVH4rtaEgIHgJKR8xY2SJzBl6WcEoRZ1PMWpYPiM0N5o9vtoEq5qGNveCEgQQQEhnhxHn+avZWQlwJ/WOeH/YqvXlPFhl/Hwx7Lf/80NU/6/iUDtVf+7oY+RgXvCaXMLoevNzNCGQiOEMcSivTkdLhnB/SPqE7wTPaQYyeRD4FgPUW4Ak5RK1PHu2E+HL5Tu6iyllb6MxRBURu/A/L6/zh+Vmk37pfzCRKt2ZG/E1/20XH0Ly7gE7dk/kfH42AXOAVGnqAk/H2vqotbuclwjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmkGFFYdoJtLRwrMl/scnqgMg1llICyImxc3iKFnknY=;
 b=RxJuO/wjl570YFgM852tzkiMF4F/7BXXKm4mM+ACJiR1iFrOodKBNBiacdbU83TqHkcs3TwEpYYnTNdGd59wvu+PXYVwgzxa6IOzx1l1TRvf9qv+SriZ+hccNZy/nZX42kT4lHIjr1U36dTxnNW1RexwVrj7ufBhfYRwpTtFVm8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2717.namprd12.prod.outlook.com (52.135.103.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 4 Sep 2019 22:21:49 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::307c:a378:f96e:690%7]) with mapi id 15.20.2220.020; Wed, 4 Sep 2019
 22:21:49 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
CC:     "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Topic: [PATCH] amd64_edac - Add Family 17h Model 70h PCI IDs
Thread-Index: AQHVY2RbCb5+3YDIEkuYe/75JNXLCKccD30AgAAFNoA=
Date:   Wed, 4 Sep 2019 22:21:49 +0000
Message-ID: <SN6PR12MB2639900DEABC70E0AD0CB8D5F8B80@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
In-Reply-To: <20190904215308.GA12374@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e199dd6-c196-4e85-7956-08d7318647fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2717;
x-ms-traffictypediagnostic: SN6PR12MB2717:
x-microsoft-antispam-prvs: <SN6PR12MB271796844F0221836464A718F8B80@SN6PR12MB2717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(13464003)(199004)(189003)(64756008)(5660300002)(76176011)(2906002)(66556008)(8676002)(66476007)(102836004)(66946007)(76116006)(53546011)(6506007)(8936002)(81156014)(81166006)(66446008)(26005)(52536014)(186003)(99286004)(7736002)(229853002)(305945005)(478600001)(110136005)(74316002)(25786009)(54906003)(71200400001)(9686003)(33656002)(66066001)(316002)(71190400001)(3846002)(86362001)(55016002)(256004)(2171002)(6116002)(6246003)(476003)(486006)(4744005)(7696005)(446003)(11346002)(14454004)(53936002)(6436002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2717;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XMoLwJKYgyBQXxpnME3KLINL0ytNbrbxbI8BDhHDIzT6Nfi9euyO6UXfws4u5JMGl3K51Tt9GZnviAd9yulfrDzmoaL2pjJzQKdZuJw3nez7AW2UUFbkTRo8yST5x0k77H9rjOVNduIpZcvGzWJ1WSCmxg8xCWOv6r56ZmjKZ5slBitAzF3McwBXpo5DvuQ4AV76UTETlqwFkuKylG8OxvpSNjbC+MLqkqx35mekkZdMGYwhhoCBFRmcaROZx8kfnU9yXlJnR1XXjbHmx1pahuaPUaLUoG0EBPatQb+u0EUyRP3b5SuJMqtAT1CS35C7HpmNPY8wNEZ6odGS3bh5+pN6vNCgDcUJFjqAT3+TBS5FGI7wMlKGsDWsUXa5Pn+23BpB65t+10fQFrdhMX0zW/HxbobqFSNkmk7iEIPuSEA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e199dd6-c196-4e85-7956-08d7318647fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 22:21:49.8720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LnvDDGRb9nukWanqlmhEmRLoK5ReDyB1CdrgO2M4GO2gzOH3Zw2eTW0iPMlyK9hyDF8Rn9RlPpFx387f+TKRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2717
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgNCwgMjAx
OSA0OjUzIFBNDQo+IFRvOiBJc2FhYyBWYXVnaG4gPGlzYWFjLnZhdWdobkBLbmlnaHRzLnVjZi5l
ZHU+OyBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogdHJpdmlh
bEBrZXJuZWwub3JnOyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBhbWQ2NF9lZGFjIC0gQWRkIEZhbWlseSAxN2ggTW9kZWwgNzBoIFBDSSBJRHMNCj4g
DQo+IEhpIElzYWFjLA0KPiANCj4gT24gV2VkLCBTZXAgMDQsIDIwMTkgYXQgMDk6MTM6NDdQTSAr
MDAwMCwgSXNhYWMgVmF1Z2huIHdyb3RlOg0KPiA+IEkgbm90aWNlZCB0aGUgY3VycmVudCBFREFD
IGRyaXZlciBkb2Vzbid0IHN1cHBvcnQgdGhlIG5ldyBaZW4gMiAobW9kZWwNCj4gPiA3MGgpIHBy
b2Nlc3NvcnMsIHNvIEkgcGF0Y2hlZCB0aGUgbmV3IGRldmljZSBpZHMgaW4uIFRoZSBjaGFuZ2Vz
IGFyZQ0KPiA+IG1pbmltYWwsIEkgbWVyZWx5IGV4dGVuZGVkIHRoZSBleGlzdGluZyBlbnVtcyB3
aXRoIGluZm9ybWF0aW9uIGZyb20NCj4gPiB0aGUgbmV3IG1vZGVscy4NCj4gDQo+IE1ha2VzIHNl
bnNlIHRvIG1lLg0KPiANCj4gQFlhemVuLCBBQ0s/DQoNClRoZSBuZXcgUENJIElEcyBhcmUgY29y
cmVjdC4gSG93ZXZlciwgd2UgYWxzbyBuZWVkIERldmljZSAxOGggRnVuY3Rpb24gMw0KZm9yIGFt
ZDY0X2VkYWNfbW9kIHRvIGZ1bmN0aW9uLiBJIGRvbid0IHNlZSBhIGNvbW1pdCB1cHN0cmVhbSB0
aGF0IGFkZHMNCnRoaXMuDQoNCklzYWFjLA0KQ291bGQgeW91IHBsZWFzZSBhZGQgdGhlIEZ1bmN0
aW9uIDMgYXMgd2VsbD8gUGxlYXNlIHNlZSB0aGUgZm9sbG93aW5nIGZvcg0KcmVmZXJlbmNlLg0K
DQpiZTM1MThhMTZlZjIgKCJ4ODYvYW1kX25iOiBBZGQgUENJIGRldmljZSBJRHMgZm9yIGZhbWls
eSAxN2gsIG1vZGVsIDMwaCIpDQoNClRoYW5rIHlvdSENCg0KLVlhemVuDQoNCg==
