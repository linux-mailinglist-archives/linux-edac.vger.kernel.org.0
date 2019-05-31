Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9711C31858
	for <lists+linux-edac@lfdr.de>; Sat,  1 Jun 2019 01:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfEaXpf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 May 2019 19:45:35 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:10724
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfEaXpe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 31 May 2019 19:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AHbAOqyUxkTfamrhlKq0EqfSFutAizdMRM3MFc1cW4=;
 b=J8uRoLNdlPj7UheODfAKIoSn0oB0hSPHV9qHNxoYgddvoI6OTMQ0rnoKGWe4Os/sTsGlwvXivoibRshL7dWfdyOOpK191F8QYgVW1RE/Q0xIuF58qiYt9lr1CnfGsRUY65ywZTo4y3MkIABqTuWvp4SCrJ3qhO08CK4hQVZrwZo=
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
Subject: [PATCH 7/8] EDAC/amd64: Cache secondary Chip Select registers
Thread-Topic: [PATCH 7/8] EDAC/amd64: Cache secondary Chip Select registers
Thread-Index: AQHVGArlcjfuo3OMoE+405TQCHUuDw==
Date:   Fri, 31 May 2019 23:45:14 +0000
Message-ID: <20190531234501.32826-8-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: eab5eb61-92d0-4d8c-21ec-08d6e6220760
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2671;
x-ms-traffictypediagnostic: SN6PR12MB2671:
x-microsoft-antispam-prvs: <SN6PR12MB2671407F29FE7BE2C4B89719F8190@SN6PR12MB2671.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(136003)(366004)(396003)(189003)(199004)(5640700003)(25786009)(6506007)(256004)(72206003)(2906002)(54906003)(6512007)(14454004)(186003)(86362001)(3846002)(6116002)(486006)(2501003)(71200400001)(6486002)(386003)(76176011)(2351001)(478600001)(71190400001)(52116002)(36756003)(6436002)(26005)(68736007)(6916009)(99286004)(446003)(66476007)(476003)(73956011)(66066001)(66946007)(2616005)(81156014)(305945005)(81166006)(1076003)(8936002)(316002)(7736002)(4326008)(8676002)(66446008)(64756008)(50226002)(53936002)(11346002)(5660300002)(66556008)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2671;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Z8x1/DLL48sGzDQ70dHw/zpt5dgLPFQ0He6G2EXBb7zYRGzFM9kdjqmWH3Q+HZHA8bZWOF4rvIsgsBBcASEwAq3omdJD3QVaZiJ18LeFMmtq//nslN3b8kgNQB8yH4V7ITUJifjRZ4zEEMRCbUBjLWOV0tK4UK1oM6vrTO55KOL02itjlu12mudRpbRoVGk2IRWn0dofhZc8LoM1CTkcraZPpkFKhPlg1FSC1TUULAvZB9ZZfDoS+EiFivKJwPFBMn03pCmpMkHkFe4vKDJ+rHJse0lf90GukIhcrjeqDQtvpGVekdPXzl5X8wLgLX27gxeLR60T3Xm6ely8d7xhupG7nFxeJa57/reiGbEPF97NmkoLS99KbjDjXOuLeQZPtmvKEogpRi0HJoRW+AMfJO0ursyt+ZtKC6nyO9xJFnQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab5eb61-92d0-4d8c-21ec-08d6e6220760
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 23:45:14.9319
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
IDE3aCBzeXN0ZW1zIGhhdmUgYSBzZXQgb2Ygc2Vjb25kYXJ5IENoaXAgU2VsZWN0IEJhc2UNCkFk
ZHJlc3NlcyBhbmQgQWRkcmVzcyBNYXNrcy4gVGhlc2UgZG8gbm90IHJlcHJlc2VudCB1bmlxdWUg
Q2hpcA0KU2VsZWN0cywgcmF0aGVyIHRoZXkgYXJlIHVzZWQgaW4gY29uanVuY3Rpb24gd2l0aCB0
aGUgcHJpbWFyeQ0KQ2hpcCBTZWxlY3QgcmVnaXN0ZXJzIGluIGNlcnRhaW4gdXNlIGNhc2VzLg0K
DQpDYWNoZSB0aGVzZSBzZWNvbmRhcnkgQ2hpcCBTZWxlY3QgcmVnaXN0ZXJzIGZvciBmdXR1cmUg
dXNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFubmFtQGFtZC5j
b20+DQotLS0NCiBkcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jIHwgMjMgKysrKysrKysrKysrKysr
KysrKystLS0NCiBkcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5oIHwgIDQgKysrKw0KIDIgZmlsZXMg
Y2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5jDQpp
bmRleCA0MDU4YjI0YjhlMDQuLjAwNjQxN2NiNzlkYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRh
Yy9hbWQ2NF9lZGFjLmMNCisrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMNCkBAIC05NDMs
MzQgKzk0Myw1MSBAQCBzdGF0aWMgdm9pZCBwcmVwX2NoaXBfc2VsZWN0cyhzdHJ1Y3QgYW1kNjRf
cHZ0ICpwdnQpDQogDQogc3RhdGljIHZvaWQgcmVhZF91bWNfYmFzZV9tYXNrKHN0cnVjdCBhbWQ2
NF9wdnQgKnB2dCkNCiB7DQotCXUzMiB1bWNfYmFzZV9yZWcsIHVtY19tYXNrX3JlZzsNCi0JdTMy
IGJhc2VfcmVnLCBtYXNrX3JlZzsNCi0JdTMyICpiYXNlLCAqbWFzazsNCisJdTMyIHVtY19iYXNl
X3JlZywgdW1jX2Jhc2VfcmVnX3NlYzsNCisJdTMyIHVtY19tYXNrX3JlZywgdW1jX21hc2tfcmVn
X3NlYzsNCisJdTMyIGJhc2VfcmVnLCBiYXNlX3JlZ19zZWM7DQorCXUzMiBtYXNrX3JlZywgbWFz
a19yZWdfc2VjOw0KKwl1MzIgKmJhc2UsICpiYXNlX3NlYzsNCisJdTMyICptYXNrLCAqbWFza19z
ZWM7DQogCWludCBjcywgdW1jOw0KIA0KIAlmb3JfZWFjaF91bWModW1jKSB7DQogCQl1bWNfYmFz
ZV9yZWcgPSBnZXRfdW1jX2Jhc2UodW1jKSArIFVNQ0NIX0JBU0VfQUREUjsNCisJCXVtY19iYXNl
X3JlZ19zZWMgPSBnZXRfdW1jX2Jhc2UodW1jKSArIFVNQ0NIX0JBU0VfQUREUl9TRUM7DQogDQog
CQlmb3JfZWFjaF9jaGlwX3NlbGVjdChjcywgdW1jLCBwdnQpIHsNCiAJCQliYXNlID0gJnB2dC0+
Y3NlbHNbdW1jXS5jc2Jhc2VzW2NzXTsNCisJCQliYXNlX3NlYyA9ICZwdnQtPmNzZWxzW3VtY10u
Y3NiYXNlc19zZWNbY3NdOw0KIA0KIAkJCWJhc2VfcmVnID0gdW1jX2Jhc2VfcmVnICsgKGNzICog
NCk7DQorCQkJYmFzZV9yZWdfc2VjID0gdW1jX2Jhc2VfcmVnX3NlYyArIChjcyAqIDQpOw0KIA0K
IAkJCWlmICghYW1kX3Ntbl9yZWFkKHB2dC0+bWNfbm9kZV9pZCwgYmFzZV9yZWcsIGJhc2UpKQ0K
IAkJCQllZGFjX2RiZygwLCAiICBEQ1NCJWRbJWRdPTB4JTA4eCByZWc6IDB4JXhcbiIsDQogCQkJ
CQkgdW1jLCBjcywgKmJhc2UsIGJhc2VfcmVnKTsNCisNCisJCQlpZiAoIWFtZF9zbW5fcmVhZChw
dnQtPm1jX25vZGVfaWQsIGJhc2VfcmVnX3NlYywgYmFzZV9zZWMpKQ0KKwkJCQllZGFjX2RiZygw
LCAiICAgIERDU0JfU0VDJWRbJWRdPTB4JTA4eCByZWc6IDB4JXhcbiIsDQorCQkJCQkgdW1jLCBj
cywgKmJhc2Vfc2VjLCBiYXNlX3JlZ19zZWMpOw0KIAkJfQ0KIA0KIAkJdW1jX21hc2tfcmVnID0g
Z2V0X3VtY19iYXNlKHVtYykgKyBVTUNDSF9BRERSX01BU0s7DQorCQl1bWNfbWFza19yZWdfc2Vj
ID0gZ2V0X3VtY19iYXNlKHVtYykgKyBVTUNDSF9BRERSX01BU0tfU0VDOw0KIA0KIAkJZm9yX2Vh
Y2hfY2hpcF9zZWxlY3RfbWFzayhjcywgdW1jLCBwdnQpIHsNCiAJCQltYXNrID0gJnB2dC0+Y3Nl
bHNbdW1jXS5jc21hc2tzW2NzXTsNCisJCQltYXNrX3NlYyA9ICZwdnQtPmNzZWxzW3VtY10uY3Nt
YXNrc19zZWNbY3NdOw0KIA0KIAkJCW1hc2tfcmVnID0gdW1jX21hc2tfcmVnICsgKGNzICogNCk7
DQorCQkJbWFza19yZWdfc2VjID0gdW1jX21hc2tfcmVnX3NlYyArIChjcyAqIDQpOw0KIA0KIAkJ
CWlmICghYW1kX3Ntbl9yZWFkKHB2dC0+bWNfbm9kZV9pZCwgbWFza19yZWcsIG1hc2spKQ0KIAkJ
CQllZGFjX2RiZygwLCAiICBEQ1NNJWRbJWRdPTB4JTA4eCByZWc6IDB4JXhcbiIsDQogCQkJCQkg
dW1jLCBjcywgKm1hc2ssIG1hc2tfcmVnKTsNCisNCisJCQlpZiAoIWFtZF9zbW5fcmVhZChwdnQt
Pm1jX25vZGVfaWQsIG1hc2tfcmVnX3NlYywgbWFza19zZWMpKQ0KKwkJCQllZGFjX2RiZygwLCAi
ICAgIERDU01fU0VDJWRbJWRdPTB4JTA4eCByZWc6IDB4JXhcbiIsDQorCQkJCQkgdW1jLCBjcywg
Km1hc2tfc2VjLCBtYXNrX3JlZ19zZWMpOw0KIAkJfQ0KIAl9DQogfQ0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmggYi9kcml2ZXJzL2VkYWMvYW1kNjRfZWRhYy5oDQppbmRl
eCA0ZGNlNmEyYWM3NWYuLjY4ZjEyZGU2ZTY1NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZWRhYy9h
bWQ2NF9lZGFjLmgNCisrKyBiL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmgNCkBAIC0yNTksNyAr
MjU5LDkgQEANCiANCiAvKiBVTUMgQ0ggcmVnaXN0ZXIgb2Zmc2V0cyAqLw0KICNkZWZpbmUgVU1D
Q0hfQkFTRV9BRERSCQkJMHgwDQorI2RlZmluZSBVTUNDSF9CQVNFX0FERFJfU0VDCQkweDEwDQog
I2RlZmluZSBVTUNDSF9BRERSX01BU0sJCQkweDIwDQorI2RlZmluZSBVTUNDSF9BRERSX01BU0tf
U0VDCQkweDI4DQogI2RlZmluZSBVTUNDSF9BRERSX0NGRwkJCTB4MzANCiAjZGVmaW5lIFVNQ0NI
X0RJTU1fQ0ZHCQkJMHg4MA0KICNkZWZpbmUgVU1DQ0hfVU1DX0NGRwkJCTB4MTAwDQpAQCAtMzEy
LDkgKzMxNCwxMSBAQCBzdHJ1Y3QgZHJhbV9yYW5nZSB7DQogLyogQSBEQ1QgY2hpcCBzZWxlY3Rz
IGNvbGxlY3Rpb24gKi8NCiBzdHJ1Y3QgY2hpcF9zZWxlY3Qgew0KIAl1MzIgY3NiYXNlc1tOVU1f
Q0hJUFNFTEVDVFNdOw0KKwl1MzIgY3NiYXNlc19zZWNbTlVNX0NISVBTRUxFQ1RTXTsNCiAJdTgg
Yl9jbnQ7DQogDQogCXUzMiBjc21hc2tzW05VTV9DSElQU0VMRUNUU107DQorCXUzMiBjc21hc2tz
X3NlY1tOVU1fQ0hJUFNFTEVDVFNdOw0KIAl1OCBtX2NudDsNCiB9Ow0KIA0KLS0gDQoyLjE3LjEN
Cg0K
