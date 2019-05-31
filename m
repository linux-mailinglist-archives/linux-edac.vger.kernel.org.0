Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16831851
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfEaXpW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:22 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbfEaXpV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwic/Z/wNIrV3TCyA0L0H4C2oMzRh86EvVzt2FPuxmY=;
 b=rqEjjorpdCLwQel7/MASebCjZMYealeHhoJg8lrseiTpInL6hzfXpsVKBCL3cgBy4XO3JAUuk4oEzzbjzdfeohMUYqvUl2Ml/jzo7hoXivMRjuhow1UJFZD48CIyBXU+ZfWm6MKstD9cF3Z3hPHMjz/EgfiGGRbD8yCULzOmaLQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2671.namprd12.prod.outlook.com (52.135.103.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Fri, 31 May 2019 23:45:13 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.021; Fri, 31 May 2019
 23:45:13 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 3/8] EDAC/amd64: Recognize DRAM device type with EDAC_CTL_CAP
Thread-Topic: [PATCH 3/8] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Thread-Index: AQHVGArjkmy9441CE06+lohPwhgtjA==
Date:   Fri, 31 May 2019 23:45:12 +0000
Message-ID: <20190531234501.32826-4-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 8f4178c9-2c00-4842-77be-08d6e6220617
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB26711E9311DB6A010DE65146F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ci/W4dJroe49pkfyyy4SvEzhHod6XjrZD7BB1Yw6V+AmnoAIbTqiK7jHW1wCQvFCfQqZ1fQY+5Jj7z14LWY1RryRnqZNLpevb0/eiWPZDdZ/xD+hHMqQwW0m+9VGf55zUnV7v8bP0ELLCl6Pw/Aiy9YqBKBIXNYYWXlMkEPUr/Bf9MVv2UomJkgSaZ9jRmjPFb58GOVKfAYyPSGfX0xZppOT//ux3iuBxRh4PkoU07yyw+pxxa/d/9LKO0Cd/HUQT7WiKLdDiKV9nJwoUxzWjOlX2ISqMCbWJhDPGneooQQDB2b/U9nv5RhWv8wsKGmCYs7rqsxHKv02LoaqcDE3cyKDAP72385UGQbGOdF06DF2p/JvH0M+qzkGI+wmv7NoRYcPjhXk2lUmfKSl643rn16FTzlmATu5OCLh4QPPjSg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4178c9-2c00-4842-77be-08d6e6220617
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:12.7360
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
IDE3aCBzeXN0ZW1zIHN1cHBvcnQgeDQgYW5kIHgxNiBEUkFNIGRldmljZXMuIEhvd2V2ZXIsIHRo
ZQ0KZGV2aWNlIHR5cGUgaXMgbm90IGNoZWNrZWQgd2hlbiBzZXR0aW5nIEVEQUNfQ1RMX0NBUC4N
Cg0KU2V0IHRoZSBhcHByb3ByaWF0ZSBFREFDX0NUTF9DQVAgZmxhZyBiYXNlZCBvbiB0aGUgZGV2
aWNlIHR5cGUuDQoNCkZpeGVzOiAyZDA5ZDhmMzAxZjUgKCJFREFDLCBhbWQ2NDogRGV0ZXJtaW5l
IEVEQUMgTUMgY2FwYWJpbGl0aWVzIG9uIEZhbTE3aCIpDQpTaWduZWQtb2ZmLWJ5OiBZYXplbiBH
aGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5jb20+DQotLS0NCiBkcml2ZXJzL2VkYWMvYW1kNjRf
ZWRhYy5jIHwgMTMgKysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL2FtZDY0X2Vk
YWMuYyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCmluZGV4IGRkNjBjZjVhM2Q5Ni4uMTI1
ZDZlMmE4MjhlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KKysrIGIv
ZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KQEAgLTMxNTAsMTIgKzMxNTAsMTUgQEAgc3RhdGlj
IGJvb2wgZWNjX2VuYWJsZWQoc3RydWN0IHBjaV9kZXYgKkYzLCB1MTYgbmlkKQ0KIHN0YXRpYyBp
bmxpbmUgdm9pZA0KIGYxN2hfZGV0ZXJtaW5lX2VkYWNfY3RsX2NhcChzdHJ1Y3QgbWVtX2N0bF9p
bmZvICptY2ksIHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCiB7DQotCXU4IGksIGVjY19lbiA9IDEs
IGNwa19lbiA9IDE7DQorCXU4IGksIGVjY19lbiA9IDEsIGNwa19lbiA9IDEsIGRldl94NCA9IDEs
IGRldl94MTYgPSAxOw0KIA0KIAlmb3JfZWFjaF91bWMoaSkgew0KIAkJaWYgKHB2dC0+dW1jW2ld
LnNkcF9jdHJsICYgVU1DX1NEUF9JTklUKSB7DQogCQkJZWNjX2VuICY9ICEhKHB2dC0+dW1jW2ld
LnVtY19jYXBfaGkgJiBVTUNfRUNDX0VOQUJMRUQpOw0KIAkJCWNwa19lbiAmPSAhIShwdnQtPnVt
Y1tpXS51bWNfY2FwX2hpICYgVU1DX0VDQ19DSElQS0lMTF9DQVApOw0KKw0KKwkJCWRldl94NCAm
PSAhIShwdnQtPnVtY1tpXS5kaW1tX2NmZyAmIEJJVCg2KSk7DQorCQkJZGV2X3gxNiAmPSAhIShw
dnQtPnVtY1tpXS5kaW1tX2NmZyAmIEJJVCg3KSk7DQogCQl9DQogCX0NCiANCkBAIC0zMTYzLDgg
KzMxNjYsMTIgQEAgZjE3aF9kZXRlcm1pbmVfZWRhY19jdGxfY2FwKHN0cnVjdCBtZW1fY3RsX2lu
Zm8gKm1jaSwgc3RydWN0IGFtZDY0X3B2dCAqcHZ0KQ0KIAlpZiAoZWNjX2VuKSB7DQogCQltY2kt
PmVkYWNfY3RsX2NhcCB8PSBFREFDX0ZMQUdfU0VDREVEOw0KIA0KLQkJaWYgKGNwa19lbikNCi0J
CQltY2ktPmVkYWNfY3RsX2NhcCB8PSBFREFDX0ZMQUdfUzRFQ0Q0RUQ7DQorCQlpZiAoY3BrX2Vu
KSB7DQorCQkJaWYgKGRldl94NCkNCisJCQkJbWNpLT5lZGFjX2N0bF9jYXAgfD0gRURBQ19GTEFH
X1M0RUNENEVEOw0KKwkJCWVsc2UgaWYgKGRldl94MTYpDQorCQkJCW1jaS0+ZWRhY19jdGxfY2Fw
IHw9IEVEQUNfRkxBR19TMTZFQ0QxNkVEOw0KKwkJfQ0KIAl9DQogfQ0KIA0KLS0gDQoyLjE3LjEN
Cg0K
