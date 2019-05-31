Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3931859
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEaXph (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:37 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726708AbfEaXpg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vj7+lvXp8Grp9vMwsvN33PGOSoPH7PpHlU3lvENXiIs=;
 b=hNGLoylHr3L2z8bH8RR30SG7h4qyrgvG4Iu+5l9/lx0Btu4CM9vLtZWXTWaO2qkDQsj8mVybhlA1lZtm+nRrR320eIu+XGFZf12Swnn54jEegfBsWoK9fIb1vq9fUzGC7D6quW1PVHq556pfYAHEiFiEWzJXJcXaSES/KXqHBGc=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:16 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:16 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 8/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Topic: [PATCH 8/8] EDAC/amd64: Support Asymmetric Dual-Rank DIMMs
Thread-Index: AQHVGArl6HVXlauRPUqtJdJDCmz++w==
Date:   Fri, 31 May 2019 23:45:15 +0000
Message-ID: <20190531234501.32826-9-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: cb3aab3e-7200-4529-a4bd-08d6e62207a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671E65E5637DCA3F579EA96F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(14444005)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HDTpvaQ0IuGmW6DoAORjUkZkZ6lYIsgqxDuiw+PJYSI++BXBzLfcYc2xdSPMSAQFDaV0pnyrLM6FOxKHrOTBovz1JhxHnjLvRz76jeorZt9eIa6yccrUZP2x9xQoYSHw9AX45BFhxFqxrQsji4m+IppcczEu7GA2d6P/h1q+6D7FMzABZcl01XqlJaIpSMad7zzgoB2anhWA/hJy8GinBZ4xdcOS5tnV5G1kHrBnnSblGrb3KfJFkh3qKvqz7gSogqswlYvrxPa8AyabC/zsw09nBPYkSK7wk58fBEG3Ddgq8HgpBPDkkaEbVNcxTChznAoW0v11gcFzU06eHDrfNylG2SSH1SUFdHZl5IpDJQfvrA1hBTxbIz69EZz58zvTYmD3lwyGTJhT97vIJk4Mi83ItXZku0ZJlHX793l/O9A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3aab3e-7200-4529-a4bd-08d6e62207a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:15.5066
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

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpGdXR1cmUgQU1E
IHN5c3RlbXMgd2lsbCBzdXBwb3J0ICJBc3ltbWV0cmljIiBEdWFsLVJhbmsgRElNTXMuIFRoZXNl
IGFyZQ0KRElNTXMgd2VyZSB0aGUgcmFua3MgYXJlIG9mIGRpZmZlcmVudCBzaXplcy4NCg0KVGhl
IGV2ZW4gcmFuayB3aWxsIHVzZSB0aGUgUHJpbWFyeSBFdmVuIENoaXAgU2VsZWN0IHJlZ2lzdGVy
cyBhbmQgdGhlDQpvZGQgcmFuayB3aWxsIHVzZSB0aGUgU2Vjb25kYXJ5IE9kZCBDaGlwIFNlbGVj
dCByZWdpc3RlcnMuDQoNClJlY29nbml6ZSBpZiBhIFNlY29uZGFyeSBPZGQgQ2hpcCBTZWxlY3Qg
aXMgYmVpbmcgdXNlZC4gVXNlIHRoZQ0KU2Vjb25kYXJ5IE9kZCBBZGRyZXNzIE1hc2sgd2hlbiBj
YWxjdWxhdGluZyB0aGUgY2hpcCBzZWxlY3Qgc2l6ZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4g
R2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9lZGFjL2FtZDY0
X2VkYWMuYyB8IDEzICsrKysrKysrKysrKy0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2FtZDY0X2Vk
YWMuYyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCmluZGV4IDAwNjQxN2NiNzlkYy4uNmMy
ODRhNGY5ODBjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KKysrIGIv
ZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KQEAgLTc5MCw2ICs3OTAsOSBAQCBzdGF0aWMgdm9p
ZCBkZWJ1Z19kdW1wX2RyYW1jZmdfbG93KHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCwgdTMyIGRjbHIs
IGludCBjaGFuKQ0KIA0KICNkZWZpbmUgQ1NfRVZFTl9QUklNQVJZCQlCSVQoMCkNCiAjZGVmaW5l
IENTX09ERF9QUklNQVJZCQlCSVQoMSkNCisjZGVmaW5lIENTX09ERF9TRUNPTkRBUlkJQklUKDIp
DQorDQorI2RlZmluZSBjc3Jvd19zZWNfZW5hYmxlZChpLCBkY3QsIHB2dCkJKChwdnQpLT5jc2Vs
c1soZGN0KV0uY3NiYXNlc19zZWNbKGkpXSAmIERDU0JfQ1NfRU5BQkxFKQ0KIA0KIHN0YXRpYyBp
bnQgZjE3X2dldF9jc19tb2RlKGludCBkaW1tLCB1OCBjdHJsLCBzdHJ1Y3QgYW1kNjRfcHZ0ICpw
dnQpDQogew0KQEAgLTgwMSw2ICs4MDQsMTAgQEAgc3RhdGljIGludCBmMTdfZ2V0X2NzX21vZGUo
aW50IGRpbW0sIHU4IGN0cmwsIHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCiAJaWYgKGNzcm93X2Vu
YWJsZWQoMiAqIGRpbW0gKyAxLCBjdHJsLCBwdnQpKQ0KIAkJY3NfbW9kZSB8PSBDU19PRERfUFJJ
TUFSWTsNCiANCisJLyogQXN5bW1ldHJpYyBEdWFsLVJhbmsgRElNTSBzdXBwb3J0LiAqLw0KKwlp
ZiAoY3Nyb3dfc2VjX2VuYWJsZWQoMiAqIGRpbW0gKyAxLCBjdHJsLCBwdnQpKQ0KKwkJY3NfbW9k
ZSB8PSBDU19PRERfU0VDT05EQVJZOw0KKw0KIAlyZXR1cm4gY3NfbW9kZTsNCiB9DQogDQpAQCAt
MTU5MCw3ICsxNTk3LDExIEBAIHN0YXRpYyBpbnQgZjE3X2FkZHJfbWFza190b19jc19zaXplKHN0
cnVjdCBhbWQ2NF9wdnQgKnB2dCwgdTggdW1jLA0KIAkgKi8NCiAJZGltbSA9IGNzcm93X25yID4+
IDE7DQogDQotCWFkZHJfbWFza19vcmlnID0gcHZ0LT5jc2Vsc1t1bWNdLmNzbWFza3NbZGltbV07
DQorCS8qIEFzeW1tZXRyaWMgRHVhbC1SYW5rIERJTU0gc3VwcG9ydC4gKi8NCisJaWYgKGNzX21v
ZGUgJiBDU19PRERfU0VDT05EQVJZKQ0KKwkJYWRkcl9tYXNrX29yaWcgPSBwdnQtPmNzZWxzW3Vt
Y10uY3NtYXNrc19zZWNbZGltbV07DQorCWVsc2UNCisJCWFkZHJfbWFza19vcmlnID0gcHZ0LT5j
c2Vsc1t1bWNdLmNzbWFza3NbZGltbV07DQogDQogCS8qDQogCSAqIFRoZSBudW1iZXIgb2YgemVy
byBiaXRzIGluIHRoZSBtYXNrIGlzIGVxdWFsIHRvIHRoZSBudW1iZXIgb2YgYml0cw0KLS0gDQoy
LjE3LjENCg0K
