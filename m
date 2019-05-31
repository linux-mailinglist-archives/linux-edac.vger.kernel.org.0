Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6431855
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEaXpc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:32 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbfEaXpa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7jJXETZ8Ip/FGib/Z9jHSP/TiLoaDUwxGlGxWKcTkI=;
 b=Kh4ZaSRSl9s43WybJh21O7tcHDp/O3e+dmbkAND8E3Vx7f3SH/sivuWl2rJXjI6XRKDYa0QUubr1Yf/GbYhsgM7YoKMvDJGGhYb7jUf9s0IWQJIh+J4G9Zlp+AxyDciEefHSp21bKuG+A4V8ZY/icxZGWFS0o6bILMW7IV5Oh+k=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:15 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:15 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 6/8] EDAC/amd64: Decode syndrome before translating address
Thread-Topic: [PATCH 6/8] EDAC/amd64: Decode syndrome before translating
 address
Thread-Index: AQHVGArkT/PmGQZhFkef940H2h6EmQ==
Date:   Fri, 31 May 2019 23:45:14 +0000
Message-ID: <20190531234501.32826-7-Yazen.Ghannam@amd.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:805:de::45) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67634999-74f7-474d-80eb-08d6e6220712
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671FA58497F67BBE3A14D92F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(14444005)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A98Mq7SVc5LiwuS48Z8E2k30aqDcGgjfny0UVzoypqBTwBtjDaA48hija1wy4kwfV1KoUEBDd4tCxdU0i9OVARQV3+wAY6B6m4lfByLRFAeiiTDAHMN05knGoHLPpbYq35JcnKJKnV2CjS4tIzjkqUeKvrSoYAXMInnztIok7YArnzNDuKibxzjELjazolQJUg6KkuSsDqrgbAk3UJsw6KcJzEs9bKUcGSwIZF5z0tKB+n2M7m5HTleuDNIDiVGzCHN5CYExIZJC96+4CSE1O78QW4gcOLNFeWknykVr2aYMUrFyFgrJDMVEetqYgXcfL3AIy6FQeG1ZMKvWgoA57LF86jAQhbdnlyr29gn4qYJhFkz60S8oEik8Y3fuZY1Hc2WpS6qNLMnENNj6SuYWdLv4h/IJT0MRw9smhdVbLAI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67634999-74f7-474d-80eb-08d6e6220712
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:14.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2671
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpBTUQgRmFtaWx5
IDE3aCBzeXN0ZW1zIGN1cnJlbnRseSByZXF1aXJlIGFkZHJlc3MgdHJhbnNsYXRpb24gaW4gb3Jk
ZXIgdG8NCnJlcG9ydCB0aGUgc3lzdGVtIGFkZHJlc3Mgb2YgYSBEUkFNIEVDQyBlcnJvci4gVGhp
cyBpcyBjdXJyZW50bHkgZG9uZQ0KYmVmb3JlIGRlY29kaW5nIHRoZSBzeW5kcm9tZSBpbmZvcm1h
dGlvbi4gVGhlIHN5bmRyb21lIGluZm9ybWF0aW9uIGRvZXMNCm5vdCBkZXBlbmQgb24gdGhlIGFk
ZHJlc3MgdHJhbnNsYXRpb24sIHNvIHRoZSBwcm9wZXIgRURBQyBjc3Jvdy9jaGFubmVsDQpyZXBv
cnRpbmcgY2FuIGZ1bmN0aW9uIHdpdGhvdXQgdGhlIGFkZHJlc3MuIEhvd2V2ZXIsIHRoZSBzeW5k
cm9tZQ0KaW5mb3JtYXRpb24gd2lsbCBub3QgYmUgZGVjb2RlZCBpZiB0aGUgYWRkcmVzcyB0cmFu
c2xhdGlvbiBmYWlscy4NCg0KRGVjb2RlIHRoZSBzeW5kcm9tZSBpbmZvcm1hdGlvbiBiZWZvcmUg
ZG9pbmcgdGhlIGFkZHJlc3MgdHJhbnNsYXRpb24uDQpUaGUgc3luZHJvbWUgaW5mb3JtYXRpb24g
aXMgYXJjaGl0ZWN0dXJhbGx5IGRlZmluZWQgaW4gTUNBX1NZTkQgYW5kIGNhbg0KYmUgY29uc2lk
ZXJlZCByb2J1c3QuIFRoZSBhZGRyZXNzIHRyYW5zbGF0aW9uIGlzIHN5c3RlbS1zcGVjaWZpYyBh
bmQgbWF5DQpmYWlsIG9uIG5ld2VyIHN5c3RlbXMgd2l0aG91dCBwcm9wZXIgdXBkYXRlcyB0byB0
aGUgdHJhbnNsYXRpb24NCmFsZ29yaXRobS4NCg0KRml4ZXM6IDcxM2FkNTQ2NzVmZCAoIkVEQUMs
IGFtZDY0OiBEZWZpbmUgYW5kIHJlZ2lzdGVyIFVNQyBlcnJvciBkZWNvZGUgZnVuY3Rpb24iKQ0K
U2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0t
DQogZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYyB8IDE0ICsrKysrKystLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQpp
bmRleCBmMDQyNGMxMGNhYzAuLjQwNThiMjRiOGUwNCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRh
Yy9hbWQ2NF9lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCkBAIC0yNTY3
LDEzICsyNTY3LDYgQEAgc3RhdGljIHZvaWQgZGVjb2RlX3VtY19lcnJvcihpbnQgbm9kZV9pZCwg
c3RydWN0IG1jZSAqbSkNCiANCiAJZXJyLmNoYW5uZWwgPSBmaW5kX3VtY19jaGFubmVsKG0pOw0K
IA0KLQlpZiAodW1jX25vcm1hZGRyX3RvX3N5c2FkZHIobS0+YWRkciwgcHZ0LT5tY19ub2RlX2lk
LCBlcnIuY2hhbm5lbCwgJnN5c19hZGRyKSkgew0KLQkJZXJyLmVycl9jb2RlID0gRVJSX05PUk1f
QUREUjsNCi0JCWdvdG8gbG9nX2Vycm9yOw0KLQl9DQotDQotCWVycm9yX2FkZHJlc3NfdG9fcGFn
ZV9hbmRfb2Zmc2V0KHN5c19hZGRyLCAmZXJyKTsNCi0NCiAJaWYgKCEobS0+c3RhdHVzICYgTUNJ
X1NUQVRVU19TWU5EVikpIHsNCiAJCWVyci5lcnJfY29kZSA9IEVSUl9TWU5EOw0KIAkJZ290byBs
b2dfZXJyb3I7DQpAQCAtMjU5MCw2ICsyNTgzLDEzIEBAIHN0YXRpYyB2b2lkIGRlY29kZV91bWNf
ZXJyb3IoaW50IG5vZGVfaWQsIHN0cnVjdCBtY2UgKm0pDQogDQogCWVyci5jc3JvdyA9IG0tPnN5
bmQgJiAweDc7DQogDQorCWlmICh1bWNfbm9ybWFkZHJfdG9fc3lzYWRkcihtLT5hZGRyLCBwdnQt
Pm1jX25vZGVfaWQsIGVyci5jaGFubmVsLCAmc3lzX2FkZHIpKSB7DQorCQllcnIuZXJyX2NvZGUg
PSBFUlJfTk9STV9BRERSOw0KKwkJZ290byBsb2dfZXJyb3I7DQorCX0NCisNCisJZXJyb3JfYWRk
cmVzc190b19wYWdlX2FuZF9vZmZzZXQoc3lzX2FkZHIsICZlcnIpOw0KKw0KIGxvZ19lcnJvcjoN
CiAJX19sb2dfZWNjX2Vycm9yKG1jaSwgJmVyciwgZWNjX3R5cGUpOw0KIH0NCi0tIA0KMi4xNy4x
DQoNCg==
