Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8D9B34C
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394081AbfHWP3D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 11:29:03 -0400
Received: from mail-eopbgr730065.outbound.protection.outlook.com ([40.107.73.65]:15283
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389036AbfHWP3D (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 23 Aug 2019 11:29:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOWlfRTxbzNrQ8anJzWzg/UmMYbSW8hTG2CqRj64QmNG1DyJI4mzUWhdRW2HRFPpzi7KPEVfouNWRSiQMRF4uKEimbFBKj9H21/Li6qGZioBy7Tnk6wiCCzGSHYPsCzd2bCXLVJT14pkalCLk6QI6MraGC2+flTkt8UiZ6tDOmvNQ2FycYNRMRWb3luGmCDxwkYb4zvKjsp8hpaU7ryCag/7rTSaSJRwehdhZK0fDAUqg6Pe55S6Gs2+ntFDizUWhhjMcKcxZQ2fsmF7KOkD5ExC6egJOvHh8lRNBHEm8A951lDNm5WWCf3lP5U7RqEedv932Ql9ghYugY+MNresAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmHy3LgmcYBdlztvGldameLGulfet5esRkLPNyPMLM=;
 b=e6kICTArPesb1WG3NqIkvYGvbyuHNrJvvGmFf/UbZ9o4lGLXG6MsfpVaaTAK1gzYWOIVYrEPs2q/s3OxTeprBDoW1sE6mhNt04KqtSj8BzHqDdGM56mcnS4+yfDpOTe6S5Ap18/2k5QLGh/uasP5q1caxtafJQO3ZvpcclTF4c0esQ1E+mFfOQ4OnRliJvHHO1PfdQSl/wnjfUE+dLM28Zk1x7qsSwPrN3DmR1euAlvBmiP9T8A8kqYbgzBA8p1DX2lC+nVbqGZM1Pq6W6MGcME+6YUfvfkzi+7cxogv7Me4EQ2ASeuo5BgptaFmEwyVTjswYPRosDBwX1rEdaqscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmHy3LgmcYBdlztvGldameLGulfet5esRkLPNyPMLM=;
 b=da27oLYBt2klYCBcD0Lt7kKX2AK9Wpv+RK08W4u0/PdHqAFzvOk52EFLBwKkw6bpLNe2Co8IyOoF5LPlWMZO2Ewz3Z2jHM+BUZs7gzk9KB0bfL/knulTVHiYSY6cZKIAXutmdYihw//vr8vyIEzFA9PrYw4uzJGhTA7QU/kND0w=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2718.namprd12.prod.outlook.com (52.135.103.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 23 Aug 2019 15:28:59 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d0b4:a849:c22b:3b53%2]) with mapi id 15.20.2178.020; Fri, 23 Aug 2019
 15:28:59 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        Adam Borowski <kilobyte@angband.pl>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: RE: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Topic: [PATCH v3 0/8] AMD64 EDAC fixes
Thread-Index: AQHVWHyGkq5ZZJpNOUKXQmjNKGyrbqcGViwAgAEuRFCAAVZ98A==
Date:   Fri, 23 Aug 2019 15:28:59 +0000
Message-ID: <SN6PR12MB263989CCDCC0F74138B6B747F8A40@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190822005020.GA403@angband.pl>
 <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
In-Reply-To: <SN6PR12MB2639CD6D755B6FFCF5C4B756F8A50@SN6PR12MB2639.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 143d61c0-3b16-4622-e088-08d727de9eef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2718;
x-ms-traffictypediagnostic: SN6PR12MB2718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2718944C156F380545D05B7BF8A40@SN6PR12MB2718.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(189003)(199004)(54094003)(13464003)(76116006)(33656002)(66946007)(71190400001)(71200400001)(52536014)(486006)(6436002)(99286004)(9686003)(66556008)(64756008)(66446008)(446003)(7696005)(4326008)(25786009)(53936002)(26005)(11346002)(66476007)(6246003)(6506007)(186003)(476003)(102836004)(53546011)(229853002)(2906002)(66066001)(256004)(74316002)(76176011)(55016002)(305945005)(5660300002)(8936002)(316002)(110136005)(54906003)(6116002)(3846002)(478600001)(86362001)(14454004)(14444005)(7736002)(81156014)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2718;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ePi4iM7cuGDr/RKkflGZnD9hcXb1a8l3Qh/KB1eYYBBFk9x18TzuttXp1UAwRO7x+FpLymOOmoicUBdVjKqd63ASUfRgQzKYL8T1Nums2ktE1lPhiHj8uOf1UczXQo5sJOA+ynC82Rg/QEOv3peotsefPhOf5NPXN+c5yi+xjlCfJFoPaBZOALFIMUs4kHHNlMd/YdnCDuAOIyFJFbIgfIOSkC9EeIfou4Rn+7ShjycwuhaX2juTTVuJeHSo8roh1ZPCmdx7oUQFGWdAQDxKZ5b67rfiTBPChrrAqYr8PzwPzk2U+4BPoMzwnX9uiA5QiBFxH7l1JF6elNbXH+KSyDfmGPog2zggCUw9juvN1XCm3x+6AtI2JR0f24A+bR1BU4LNi4sC5E7H+WeHBb9BY2VWK9XLLmaM1Ajie/IQUus=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 143d61c0-3b16-4622-e088-08d727de9eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 15:28:59.8118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nH6JzKvZ76wfbXmkrlfNJ9cKTeNlwEnnSpwKTiuD/+x6wPqW7wiVco3YAepB4HkgOUjwz2H/KQfGABt7iQYQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBHaGFubmFtLCBZYXplbg0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIyLCAyMDE5IDE6
NTQgUE0NCj4gVG86IEFkYW0gQm9yb3dza2kgPGtpbG9ieXRlQGFuZ2JhbmQucGw+DQo+IENjOiBs
aW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
YnBAYWxpZW44LmRlDQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjMgMC84XSBBTUQ2NCBFREFDIGZp
eGVzDQo+IA0KLi4uDQo+IEkgd29uZGVyIGlmIHRoZSBtb2R1bGUgaXMgYmVpbmcgbG9hZGVkIG11
bHRpcGxlIHRpbWVzLiBJJ2xsIHRyeSB0byByZXByb2R1Y2UgdGhpcyBhbmQgdHJhY2sgaXQgZG93
bi4NCj4gDQoNCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIGEgc2ltaWxhciBmYWlsdXJlLiBJIGRv
IHNlZSB0aGF0IHRoZSBtb2R1bGUgaXMgYmVpbmcgbG9hZGVkIG11bHRpcGxlIHRpbWVzIG9uIGZh
aWx1cmUuDQoNCkhlcmUncyBhIGNhbGwgdHJhY2UgZnJvbSBvbmUgZHVtcF9zdGFjaygpIG91dHB1
dDoNClsgICswLjAwNDk2NF0gQ1BVOiAxMzIgUElEOiAyNjgwIENvbW06IHN5c3RlbWQtdWRldmQg
Tm90IHRhaW50ZWQgNC4yMC4wLWVkYWMtZGVidWcrICMzNg0KWyAgKzAuMDA5ODAyXSBDYWxsIFRy
YWNlOg0KWyAgKzAuMDAyNzI3XSAgZHVtcF9zdGFjaysweDYzLzB4ODUNClsgICswLjAwMzY5Nl0g
IGFtZDY0X2VkYWNfaW5pdCsweDIxNjMvMHgzMDAwIFthbWQ2NF9lZGFjX21vZF0NClsgICswLjAw
NjIxNl0gID8gX193YWtlX3VwKzB4MTMvMHgyMA0KWyAgKzAuMDAzNzkwXSAgPyAweGZmZmZmZmZm
YzEyMGQwMDANClsgICswLjAwMzY5NF0gIGRvX29uZV9pbml0Y2FsbCsweDRhLzB4MWM5DQpbICAr
MC4wMDQyNzddICA/IF9jb25kX3Jlc2NoZWQrMHgxOS8weDQwDQpbICArMC4wMDQxNzhdICA/IGtt
ZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHgxNWMvMHgxZDANClsgICswLjAwNTI0NF0gIGRvX2luaXRf
bW9kdWxlKzB4NWYvMHgyMTYNClsgICswLjAwNDE4MF0gIGxvYWRfbW9kdWxlKzB4MjFkNS8weDJh
YzANClsgICswLjAwNDE3OV0gID8gd2FpdF93b2tlbisweDgwLzB4ODANClsgICswLjAwMzg4OV0g
IF9fZG9fc3lzX2Zpbml0X21vZHVsZSsweGZjLzB4MTIwDQpbICArMC4wMDQ4NThdICA/IF9fZG9f
c3lzX2Zpbml0X21vZHVsZSsweGZjLzB4MTIwDQpbICArMC4wMDUwNTJdICBfX3g2NF9zeXNfZmlu
aXRfbW9kdWxlKzB4MWEvMHgyMA0KWyAgKzAuMDA0ODU3XSAgZG9fc3lzY2FsbF82NCsweDVhLzB4
MTIwDQpbICArMC4wMDQwODFdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8w
eGE5DQoNCg0KU28gaXQgc2VlbXMgdGhhdCB1c2Vyc3BhY2UgKHN5c3RlbWQtdWRldmQpIGtlZXBz
IHRyeWluZyB0byBsb2FkIHRoZSBtb2R1bGUuIEknbSBub3Qgc3VyZSBob3cgdG8gcHJldmVudCB0
aGlzIGZyb20gd2l0aGluIHRoZSBtb2R1bGUuDQoNCkJvcmlzLA0KRG8geW91IHRoaW5rIGl0J2Qg
YmUgYXBwcm9wcmlhdGUgdG8gY2hhbmdlIHRoZSByZXR1cm4gdmFsdWVzIGZvciBzb21lIGNhc2Vz
Pw0KDQpGb3IgZXhhbXBsZSwgRUNDIGRpc2FibGVkIGlzIGEgaGFyZHdhcmUgY29uZmlndXJhdGlv
bi4gVGhpcyBkb2Vzbid0IG1lYW4gdGhhdCB0aGUgbW9kdWxlIGZhaWxlZCBhbnkgb3BlcmF0aW9u
cyBpbiB0aGlzIGNhc2UuDQoNCkluIG90aGVyIHdvcmRzLCB0aGUgbW9kdWxlIGNoZWNrcyBmb3Ig
YSBmZWF0dXJlLiBJZiB0aGUgZmVhdHVyZSBpcyBub3QgcHJlc2VudCwgdGhlbiByZXR1cm4gd2l0
aG91dCBmYWlsdXJlIChhbmQgbWF5YmUgZ2l2ZSBhIG1lc3NhZ2UpLg0KDQpUaGFua3MsDQpZYXpl
bg0K
