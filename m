Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707422807E
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbfEWPD7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 11:03:59 -0400
Received: from mail-eopbgr720065.outbound.protection.outlook.com ([40.107.72.65]:26016
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730853AbfEWPD7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 11:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nClkYGHWoSVjsJDkSneGbDvlDARlbV0sgn9pdL73fBI=;
 b=MqDHKgnH+0c361EOwpj9LIkeivi3SLTKY2UaeBxBhMchp7jBjROYzIUlug+sFNVgUcMVZn2hZL47SVoN9HyVYggVjqHtThEGw2WPgwPDzSYmEBzNoDkJe060Wtwqt92OfaMmMiTK+MENVjyY3748waZitIAVDhqOZa47idCMTBs=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.107.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 23 May 2019 15:03:55 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 15:03:55 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH] x86/MCE: Statically allocate mce_banks_array
Thread-Topic: [PATCH] x86/MCE: Statically allocate mce_banks_array
Thread-Index: AQHVEXi9HxUns8k6CEy4muazlWUkLA==
Date:   Thu, 23 May 2019 15:03:55 +0000
Message-ID: <20190523150345.42906-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0105.namprd05.prod.outlook.com
 (2603:10b6:803:42::22) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5efe0b3a-8a70-4674-e317-08d6df8fe027
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2749;
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-microsoft-antispam-prvs: <SN6PR12MB2749EA7FE08F6034C787BD49F8010@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(6506007)(386003)(6512007)(486006)(6486002)(25786009)(14444005)(256004)(102836004)(5640700003)(186003)(316002)(86362001)(1076003)(305945005)(7736002)(26005)(14454004)(2616005)(5660300002)(99286004)(4326008)(476003)(53936002)(6436002)(52116002)(72206003)(66066001)(66946007)(73956011)(66556008)(6916009)(66476007)(36756003)(2906002)(66446008)(64756008)(2501003)(81166006)(71200400001)(2351001)(81156014)(8936002)(3846002)(54906003)(6116002)(68736007)(50226002)(478600001)(71190400001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: NgQG+/8EQ7+mLXD/cGu33RZUN8X8HjtFTozg3dvc1eZt8En2J/hLgX7n87+/UoivXdRigRyzy9ugRDdipEaTgo7jbGexDtxiSvCgZKXr0uQdbp/XotlY4tuAfeZzYQC/5ov+EpA0OU4NN8QNtFDWLd9Qgi+T9i+00jx9jDlVOmvY8mER64Eo8f64hL/WwXe3ptuqORzT0BKHj8Mp+pBs1kpyToLOl8h2nnm6NNOEuXspD7bn3sPme8VeLr/j70D1QXa7oZyMb/57a/C/WWcySGAG0Ab5VzM1LfG7AN7Gt2dKqLlI8ydDttFp31a+I/+NzOEuolIW9jPQcEu7QnC9OsDOoxtnHmb0HU6e/qT6GIcbyGKqRBGen2bOmgrSephGbdEgoCHZosO0Ttjty/qxIuuxfXj6cVJaBiHLp8SRNxo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efe0b3a-8a70-4674-e317-08d6df8fe027
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 15:03:55.6310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgTUNFIGNv
bnRyb2wgZGF0YSBpcyBzdG9yZWQgaW4gYW4gYXJyYXkgb2Ygc3RydWN0IG1jZV9iYW5rcy4gVGhp
cw0KYXJyYXkgaGFzIGhpc3RvcmljYWxseSBiZWVuIHNoYXJlZCBieSBhbGwgQ1BVcyBhbmQgaXQg
d2FzIGFsbG9jYXRlZA0KZHluYW1pY2FsbHkgZHVyaW5nIHRoZSBmaXJzdCBDUFUncyBpbml0IHNl
cXVlbmNlLg0KDQpIb3dldmVyLCBzdGFydGluZyB3aXRoDQoNCgk1YjA4ODNmNWM3YmUgKCJ4ODYv
TUNFOiBNYWtlIG1jZV9iYW5rcyBhIHBlci1DUFUgYXJyYXkiKQ0KDQp0aGUgYXJyYXkgd2FzIGNo
YW5nZWQgdG8gYmVjb21lIGEgcGVyLUNQVSBhcnJheS4gRWFjaCBDUFUgd291bGQNCmR5bmFtaWNh
bGx5IGFsbG9jYXRlIHRoZSBhcnJheSBkdXJpbmcgaXRzIG93biBpbml0IHNlcXVlbmNlLg0KDQpU
aGlzIHNlZW1zIGJlbmlnbiBleHBlY3Qgd2hlbiAiTG9jayBEZWJ1Z2dpbmciIGNvbmZpZyBvcHRp
b25zIGFyZQ0KZW5hYmxlZCBpbiB3aGljaCBjYXNlIHRoZSBmb2xsb3dpbmcgbWVzc2FnZSBhcHBl
YXJzLg0KDQoJQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRl
eHQgYXQgbW0vc2xhYi5oOjQxOA0KDQpUaGUgbWVzc2FnZSBhcHBlYXJzIGR1cmluZyB0aGUgc2Vj
b25kYXJ5IENQVXMnIGluaXQgc2VxdWVuY2VzLiBUaGlzIHNlZW1zDQp0byBiZSBiZWNhdXNlIHRo
ZXNlIENQVXMgYXJlIGluIHN5c3RlbV9zdGF0ZT1TWVNURU1fU0NIRURVTElORyBjb21wYXJlZA0K
dG8gdGhlIHByaW1hcnkgQ1BVIHdoaWNoIGlzIGluIHN5c3RlbV9zdGF0ZT1TWVNURU1fQk9PVElO
Ry4NCg0KQWxsb2NhdGUgdGhlIG1jZV9iYW5rc19hcnJheSBzdGF0aWNhbGx5IHNvIHRoYXQgdGhp
cyBpc3N1ZSBjYW4gYmUNCmF2b2lkZWQuDQoNCkFsc28sIHJlbW92ZSB0aGUgbm93IHVubmVjZXNz
YXJ5IHJldHVybiB2YWx1ZXMgZnJvbQ0KX19tY2hlY2tfY3B1X21jZV9iYW5rc19pbml0KCkgYW5k
IF9fbWNoZWNrX2NwdV9jYXBfaW5pdCgpLg0KDQpGaXhlczogNWIwODgzZjVjN2JlICgieDg2L01D
RTogTWFrZSBtY2VfYmFua3MgYSBwZXItQ1BVIGFycmF5IikNClJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdCA8cm9uZy5hLmNoZW5AaW50ZWwuY29tPg0KU3VnZ2VzdGVkLWJ5OiBCb3Jpc2xh
diBQZXRrb3YgPGJwQHN1c2UuZGU+DQpTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXpl
bi5naGFubmFtQGFtZC5jb20+DQotLS0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMg
fCAzOSArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94
ODYva2VybmVsL2NwdS9tY2UvY29yZS5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5j
DQppbmRleCAyNWU1MDFhODUzY2QuLmI4ZWViZWJiYzJmOCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29y
ZS5jDQpAQCAtNzAsNyArNzAsNyBAQCBzdHJ1Y3QgbWNlX2Jhbmsgew0KIAl1NjQJCQljdGw7CQkJ
Lyogc3ViZXZlbnRzIHRvIGVuYWJsZSAqLw0KIAlib29sCQkJaW5pdDsJCQkvKiBpbml0aWFsaXNl
IGJhbms/ICovDQogfTsNCi1zdGF0aWMgREVGSU5FX1BFUl9DUFVfUkVBRF9NT1NUTFkoc3RydWN0
IG1jZV9iYW5rICosIG1jZV9iYW5rc19hcnJheSk7DQorc3RhdGljIERFRklORV9QRVJfQ1BVX1JF
QURfTU9TVExZKHN0cnVjdCBtY2VfYmFuayBbTUFYX05SX0JBTktTXSwgbWNlX2JhbmtzX2FycmF5
KTsNCiANCiAjZGVmaW5lIEFUVFJfTEVOICAgICAgICAgICAgICAgMTYNCiAvKiBPbmUgb2JqZWN0
IGZvciBlYWNoIE1DRSBiYW5rLCBzaGFyZWQgYnkgYWxsIENQVXMgKi8NCkBAIC02OTAsNyArNjkw
LDcgQEAgREVGSU5FX1BFUl9DUFUodW5zaWduZWQsIG1jZV9wb2xsX2NvdW50KTsNCiAgKi8NCiBi
b29sIG1hY2hpbmVfY2hlY2tfcG9sbChlbnVtIG1jcF9mbGFncyBmbGFncywgbWNlX2JhbmtzX3Qg
KmIpDQogew0KLQlzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3JlYWQobWNl
X2JhbmtzX2FycmF5KTsNCisJc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlzX2NwdV9w
dHIobWNlX2JhbmtzX2FycmF5KTsNCiAJYm9vbCBlcnJvcl9zZWVuID0gZmFsc2U7DQogCXN0cnVj
dCBtY2UgbTsNCiAJaW50IGk7DQpAQCAtMTEzOCw3ICsxMTM4LDcgQEAgc3RhdGljIHZvaWQgX19t
Y19zY2FuX2JhbmtzKHN0cnVjdCBtY2UgKm0sIHN0cnVjdCBtY2UgKmZpbmFsLA0KIAkJCSAgICB1
bnNpZ25lZCBsb25nICp0b2NsZWFyLCB1bnNpZ25lZCBsb25nICp2YWxpZF9iYW5rcywNCiAJCQkg
ICAgaW50IG5vX3dheV9vdXQsIGludCAqd29yc3QpDQogew0KLQlzdHJ1Y3QgbWNlX2JhbmsgKm1j
ZV9iYW5rcyA9IHRoaXNfY3B1X3JlYWQobWNlX2JhbmtzX2FycmF5KTsNCisJc3RydWN0IG1jZV9i
YW5rICptY2VfYmFua3MgPSB0aGlzX2NwdV9wdHIobWNlX2JhbmtzX2FycmF5KTsNCiAJc3RydWN0
IG1jYV9jb25maWcgKmNmZyA9ICZtY2FfY2ZnOw0KIAlpbnQgc2V2ZXJpdHksIGk7DQogDQpAQCAt
MTQ4MCwxNiArMTQ4MCwxMiBAQCBpbnQgbWNlX25vdGlmeV9pcnEodm9pZCkNCiB9DQogRVhQT1JU
X1NZTUJPTF9HUEwobWNlX25vdGlmeV9pcnEpOw0KIA0KLXN0YXRpYyBpbnQgX19tY2hlY2tfY3B1
X21jZV9iYW5rc19pbml0KHZvaWQpDQorc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X21jZV9iYW5r
c19pbml0KHZvaWQpDQogew0KKwlzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1
X3B0cihtY2VfYmFua3NfYXJyYXkpOw0KIAl1OCBuX2JhbmtzID0gdGhpc19jcHVfcmVhZChtY2Vf
bnVtX2JhbmtzKTsNCi0Jc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3M7DQogCWludCBpOw0KIA0K
LQltY2VfYmFua3MgPSBrY2FsbG9jKG5fYmFua3MsIHNpemVvZihzdHJ1Y3QgbWNlX2JhbmspLCBH
RlBfS0VSTkVMKTsNCi0JaWYgKCFtY2VfYmFua3MpDQotCQlyZXR1cm4gLUVOT01FTTsNCi0NCiAJ
Zm9yIChpID0gMDsgaSA8IG5fYmFua3M7IGkrKykgew0KIAkJc3RydWN0IG1jZV9iYW5rICpiID0g
Jm1jZV9iYW5rc1tpXTsNCiANCkBAIC0xNTAxLDE1ICsxNDk3LDEyIEBAIHN0YXRpYyBpbnQgX19t
Y2hlY2tfY3B1X21jZV9iYW5rc19pbml0KHZvaWQpDQogCQliLT5jdGwgPSAtMVVMTDsNCiAJCWIt
PmluaXQgPSAxOw0KIAl9DQotDQotCXBlcl9jcHUobWNlX2JhbmtzX2FycmF5LCBzbXBfcHJvY2Vz
c29yX2lkKCkpID0gbWNlX2JhbmtzOw0KLQlyZXR1cm4gMDsNCiB9DQogDQogLyoNCiAgKiBJbml0
aWFsaXplIE1hY2hpbmUgQ2hlY2tzIGZvciBhIENQVS4NCiAgKi8NCi1zdGF0aWMgaW50IF9fbWNo
ZWNrX2NwdV9jYXBfaW5pdCh2b2lkKQ0KK3N0YXRpYyB2b2lkIF9fbWNoZWNrX2NwdV9jYXBfaW5p
dCh2b2lkKQ0KIHsNCiAJdTY0IGNhcDsNCiAJdTggYjsNCkBAIC0xNTI2LDExICsxNTE5LDcgQEAg
c3RhdGljIGludCBfX21jaGVja19jcHVfY2FwX2luaXQodm9pZCkNCiANCiAJdGhpc19jcHVfd3Jp
dGUobWNlX251bV9iYW5rcywgYik7DQogDQotCWlmICghdGhpc19jcHVfcmVhZChtY2VfYmFua3Nf
YXJyYXkpKSB7DQotCQlpbnQgZXJyID0gX19tY2hlY2tfY3B1X21jZV9iYW5rc19pbml0KCk7DQot
CQlpZiAoZXJyKQ0KLQkJCXJldHVybiBlcnI7DQotCX0NCisJX19tY2hlY2tfY3B1X21jZV9iYW5r
c19pbml0KCk7DQogDQogCS8qIFVzZSBhY2N1cmF0ZSBSSVAgcmVwb3J0aW5nIGlmIGF2YWlsYWJs
ZS4gKi8NCiAJaWYgKChjYXAgJiBNQ0dfRVhUX1ApICYmIE1DR19FWFRfQ05UKGNhcCkgPj0gOSkN
CkBAIC0xNTM4LDggKzE1MjcsNiBAQCBzdGF0aWMgaW50IF9fbWNoZWNrX2NwdV9jYXBfaW5pdCh2
b2lkKQ0KIA0KIAlpZiAoY2FwICYgTUNHX1NFUl9QKQ0KIAkJbWNhX2NmZy5zZXIgPSAxOw0KLQ0K
LQlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfZ2VuZXJp
Yyh2b2lkKQ0KQEAgLTE1NjYsNyArMTU1Myw3IEBAIHN0YXRpYyB2b2lkIF9fbWNoZWNrX2NwdV9p
bml0X2dlbmVyaWModm9pZCkNCiANCiBzdGF0aWMgdm9pZCBfX21jaGVja19jcHVfaW5pdF9jbGVh
cl9iYW5rcyh2b2lkKQ0KIHsNCi0Jc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlzX2Nw
dV9yZWFkKG1jZV9iYW5rc19hcnJheSk7DQorCXN0cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzID0g
dGhpc19jcHVfcHRyKG1jZV9iYW5rc19hcnJheSk7DQogCXU2NCBtc3J2YWw7DQogCWludCBpOw0K
IA0KQEAgLTE2MTcsNyArMTYwNCw3IEBAIHN0YXRpYyB2b2lkIHF1aXJrX3NhbmR5YnJpZGdlX2lm
dShpbnQgYmFuaywgc3RydWN0IG1jZSAqbSwgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQogLyogQWRk
IHBlciBDUFUgc3BlY2lmaWMgd29ya2Fyb3VuZHMgaGVyZSAqLw0KIHN0YXRpYyBpbnQgX19tY2hl
Y2tfY3B1X2FwcGx5X3F1aXJrcyhzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQogew0KLQlzdHJ1Y3Qg
bWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3JlYWQobWNlX2JhbmtzX2FycmF5KTsNCisJ
c3RydWN0IG1jZV9iYW5rICptY2VfYmFua3MgPSB0aGlzX2NwdV9wdHIobWNlX2JhbmtzX2FycmF5
KTsNCiAJc3RydWN0IG1jYV9jb25maWcgKmNmZyA9ICZtY2FfY2ZnOw0KIA0KIAlpZiAoYy0+eDg2
X3ZlbmRvciA9PSBYODZfVkVORE9SX1VOS05PV04pIHsNCkBAIC0xODU0LDcgKzE4NDEsOSBAQCB2
b2lkIG1jaGVja19jcHVfaW5pdChzdHJ1Y3QgY3B1aW5mb194ODYgKmMpDQogCWlmICghbWNlX2F2
YWlsYWJsZShjKSkNCiAJCXJldHVybjsNCiANCi0JaWYgKF9fbWNoZWNrX2NwdV9jYXBfaW5pdCgp
IDwgMCB8fCBfX21jaGVja19jcHVfYXBwbHlfcXVpcmtzKGMpIDwgMCkgew0KKwlfX21jaGVja19j
cHVfY2FwX2luaXQoKTsNCisNCisJaWYgKF9fbWNoZWNrX2NwdV9hcHBseV9xdWlya3MoYykgPCAw
KSB7DQogCQltY2FfY2ZnLmRpc2FibGVkID0gMTsNCiAJCXJldHVybjsNCiAJfQ0KQEAgLTE5ODgs
NyArMTk3Nyw3IEBAIGludCBfX2luaXQgbWNoZWNrX2luaXQodm9pZCkNCiAgKi8NCiBzdGF0aWMg
dm9pZCBtY2VfZGlzYWJsZV9lcnJvcl9yZXBvcnRpbmcodm9pZCkNCiB7DQotCXN0cnVjdCBtY2Vf
YmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVfcmVhZChtY2VfYmFua3NfYXJyYXkpOw0KKwlzdHJ1
Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3B0cihtY2VfYmFua3NfYXJyYXkpOw0K
IAlpbnQgaTsNCiANCiAJZm9yIChpID0gMDsgaSA8IHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5r
cyk7IGkrKykgew0KQEAgLTIzMzIsNyArMjMyMSw3IEBAIHN0YXRpYyB2b2lkIG1jZV9kaXNhYmxl
X2NwdSh2b2lkKQ0KIA0KIHN0YXRpYyB2b2lkIG1jZV9yZWVuYWJsZV9jcHUodm9pZCkNCiB7DQot
CXN0cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVfcmVhZChtY2VfYmFua3NfYXJy
YXkpOw0KKwlzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyA9IHRoaXNfY3B1X3B0cihtY2VfYmFu
a3NfYXJyYXkpOw0KIAlpbnQgaTsNCiANCiAJaWYgKCFtY2VfYXZhaWxhYmxlKHJhd19jcHVfcHRy
KCZjcHVfaW5mbykpKQ0KLS0gDQoyLjE3LjENCg0K
