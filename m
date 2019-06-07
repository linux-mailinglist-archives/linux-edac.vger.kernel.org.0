Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1DD396A9
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 22:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfFGUSS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 16:18:18 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:26017
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730540AbfFGUSS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 16:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/prgjtkV9YQwnIe2mO3BqkqjxA2BoM+ncRlh29gSUq4=;
 b=xgBYFmKRV0icKItXKsN3A60c/lb2UTvL762THVmopkG02W16SXSB5NCGamb0FVM/0aGcU84IGgtXJBEmQFchvcxl7d+J0EHPFY/+PlgrBQ8kifpkHm6+1c60Z8cp9TTWuaNbbyHtyAzsICCmwEw0yQ/huhyTapgayjpmj3ZeJZM=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2704.namprd12.prod.outlook.com (52.135.103.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 20:18:05 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 20:18:05 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v4 3/5] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Thread-Topic: [PATCH v4 3/5] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Thread-Index: AQHVHW4dglWUhv8+g0OY36WjNWxHew==
Date:   Fri, 7 Jun 2019 20:18:04 +0000
Message-ID: <20190607201752.221446-4-Yazen.Ghannam@amd.com>
References: <20190607201752.221446-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190607201752.221446-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0109.namprd05.prod.outlook.com
 (2603:10b6:803:42::26) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a003a64-ea1c-46ab-8db5-08d6eb853f70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2704;
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB27044D74AA649081EE5DBCAEF8100@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(6486002)(6436002)(72206003)(5640700003)(316002)(966005)(186003)(26005)(478600001)(4326008)(6306002)(68736007)(66946007)(6512007)(446003)(25786009)(73956011)(64756008)(66476007)(66556008)(66446008)(486006)(53936002)(11346002)(2616005)(14454004)(476003)(66066001)(5660300002)(52116002)(14444005)(256004)(2501003)(305945005)(2351001)(102836004)(386003)(71190400001)(71200400001)(6506007)(3846002)(6116002)(7736002)(81166006)(36756003)(6916009)(81156014)(8676002)(8936002)(1076003)(50226002)(99286004)(76176011)(54906003)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IY2Eqx0OvIXEgLo3CRNfwoyrcr4uCPDa62qwnYS+Cz4JwXSPDYcYXm/e5s/WXmG7POt3DQ805WfPcUsZtP9l0BMqqd96xEXm6hIV/px2cdChiiIsiRTtS/MOxGaD/TmX1q8qFbz6AzgEYOEXsdhv3pMZDAlDKhJAU9xNvNFM/7dtdsXTlgVZRDydY5nfTDBMBhL9aepNRfa6OYCJTkmMAY7rrtq3/S0QIPktrviKDYldxHflpKEGwuPZ/l00fQAr9jt6V/vEY0alda1/Rv142naDmM+fTcTCdjGgI8XWmzZkBlzZBGPM53PVhCBzgtRLFxTyHDOwl1dBwPhFJISUrz1/bAfoPm+Q/JEtIAceM8bH0tR+P4WNJe8hl0qwrpTZE9ytZ3xvC5MGMDqIUiT7acoTn38xDuWgsDvbbQ686GE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a003a64-ea1c-46ab-8db5-08d6eb853f70
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 20:18:05.0140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2704
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpPbiBsZWdhY3kg
c3lzdGVtcywgdGhlIGFkZHJlc3NlcyBvZiB0aGUgTUNBX01JU0MqIHJlZ2lzdGVycyBuZWVkIHRv
IGJlDQpyZWN1cnNpdmVseSBkaXNjb3ZlcmVkIGJhc2VkIG9uIGEgQmxvY2sgUG9pbnRlciBmaWVs
ZCBpbiB0aGUgcmVnaXN0ZXJzLg0KDQpPbiBTY2FsYWJsZSBNQ0Egc3lzdGVtcywgdGhlIHJlZ2lz
dGVyIHNwYWNlIGlzIGZpeGVkLCBhbmQgcGFydGljdWxhcg0KYWRkcmVzc2VzIGNhbiBiZSBkZXJp
dmVkIGJ5IHJlZ3VsYXIgb2Zmc2V0cyBmb3IgYmFuayBhbmQgcmVnaXN0ZXIgdHlwZS4NClRoaXMg
Zml4ZWQgYWRkcmVzcyBzcGFjZSBpbmNsdWRlcyB0aGUgTUNBX01JU0MqIHJlZ2lzdGVycy4NCg0K
TUNBX01JU0MwIGlzIGFsd2F5cyBhdmFpbGFibGUgZm9yIGVhY2ggTUNBIGJhbmsuIE1DQV9NSVND
MSB0aHJvdWdoDQpNQ0FfTUlTQzQgYXJlIGNvbnNpZGVyZWQgYXZhaWxhYmxlIGlmIE1DQV9NSVND
MFtCbGtQdHJdPTEuDQoNCkNhY2hlIHRoZSB2YWx1ZSBvZiBNQ0FfTUlTQzBbQmxrUHRyXSBmb3Ig
ZWFjaCBiYW5rIGFuZCBwZXIgQ1BVLiBUaGlzDQpuZWVkcyB0byBiZSBkb25lIG9ubHkgZHVyaW5n
IGluaXQuIFRoZSB2YWx1ZXMgc2hvdWxkIGJlIHNhdmVkIHBlciBDUFUNCnRvIGFjY29tbW9kYXRl
IGhldGVyb2dlbmVvdXMgU01DQSBzeXN0ZW1zLg0KDQpSZWRvIHNtY2FfZ2V0X2Jsb2NrX2FkZHJl
c3MoKSB0byBkaXJlY3RseSByZXR1cm4gdGhlIGJsb2NrIGFkZHJlc3Nlcy4NCg0KU2lnbmVkLW9m
Zi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0K
aHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQzMDIwMzIwNi4xMDQxNjMtNC1ZYXplbi5H
aGFubmFtQGFtZC5jb20NCg0KdjMtPnY0Og0KKiBObyBjaGFuZ2UuDQoNCnYyLT52MzoNCiogQ2hh
bmdlIG5hbWUgb2YgbmV3IG1hcCB2YXJpYWJsZSB0byAic21jYV9taXNjX2JhbmtzX21hcCIuDQoq
IFVzZSAiQklUKCkiIHdoZXJlIGFwcHJvcHJpYXRlLg0KDQp2MS0+djI6DQoqIE5vIGNoYW5nZS4N
Cg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jIHwgNzMgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMzYg
ZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQu
YyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQppbmRleCBkOTA0YWFmZTY0MDkuLmQ0
ZDZlNGI3ZjlkYyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jDQor
KysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYw0KQEAgLTEwMSwxMSArMTAxLDYgQEAg
c3RhdGljIHN0cnVjdCBzbWNhX2JhbmtfbmFtZSBzbWNhX25hbWVzW10gPSB7DQogCVtTTUNBX1BD
SUVdCT0geyAicGNpZSIsCQkiUENJIEV4cHJlc3MgVW5pdCIgfSwNCiB9Ow0KIA0KLXN0YXRpYyB1
MzIgc21jYV9iYW5rX2FkZHJzW01BWF9OUl9CQU5LU11bTlJfQkxPQ0tTXSBfX3JvX2FmdGVyX2lu
aXQgPQ0KLXsNCi0JWzAgLi4uIE1BWF9OUl9CQU5LUyAtIDFdID0geyBbMCAuLi4gTlJfQkxPQ0tT
IC0gMV0gPSAtMSB9DQotfTsNCi0NCiBzdGF0aWMgY29uc3QgY2hhciAqc21jYV9nZXRfbmFtZShl
bnVtIHNtY2FfYmFua190eXBlcyB0KQ0KIHsNCiAJaWYgKHQgPj0gTl9TTUNBX0JBTktfVFlQRVMp
DQpAQCAtMTk5LDYgKzE5NCw5IEBAIHN0YXRpYyBjaGFyIGJ1Zl9tY2F0eXBlW01BWF9NQ0FUWVBF
X05BTUVfTEVOXTsNCiBzdGF0aWMgREVGSU5FX1BFUl9DUFUoc3RydWN0IHRocmVzaG9sZF9iYW5r
ICoqLCB0aHJlc2hvbGRfYmFua3MpOw0KIHN0YXRpYyBERUZJTkVfUEVSX0NQVSh1bnNpZ25lZCBp
bnQsIGJhbmtfbWFwKTsJLyogc2VlIHdoaWNoIGJhbmtzIGFyZSBvbiAqLw0KIA0KKy8qIE1hcCBv
ZiBiYW5rcyB0aGF0IGhhdmUgbW9yZSB0aGFuIE1DQV9NSVNDMCBhdmFpbGFibGUuICovDQorc3Rh
dGljIERFRklORV9QRVJfQ1BVKHUzMiwgc21jYV9taXNjX2JhbmtzX21hcCk7DQorDQogc3RhdGlj
IHZvaWQgYW1kX3RocmVzaG9sZF9pbnRlcnJ1cHQodm9pZCk7DQogc3RhdGljIHZvaWQgYW1kX2Rl
ZmVycmVkX2Vycm9yX2ludGVycnVwdCh2b2lkKTsNCiANCkBAIC0yMDgsNiArMjA2LDI4IEBAIHN0
YXRpYyB2b2lkIGRlZmF1bHRfZGVmZXJyZWRfZXJyb3JfaW50ZXJydXB0KHZvaWQpDQogfQ0KIHZv
aWQgKCpkZWZlcnJlZF9lcnJvcl9pbnRfdmVjdG9yKSh2b2lkKSA9IGRlZmF1bHRfZGVmZXJyZWRf
ZXJyb3JfaW50ZXJydXB0Ow0KIA0KK3N0YXRpYyB2b2lkIHNtY2Ffc2V0X21pc2NfYmFua3NfbWFw
KHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQgY3B1KQ0KK3sNCisJdTMyIGxvdywgaGln
aDsNCisNCisJLyoNCisJICogRm9yIFNNQ0EgZW5hYmxlZCBwcm9jZXNzb3JzLCBCTEtQVFIgZmll
bGQgb2YgdGhlIGZpcnN0IE1JU0MgcmVnaXN0ZXINCisJICogKE1DeF9NSVNDMCkgaW5kaWNhdGVz
IHByZXNlbmNlIG9mIGFkZGl0aW9uYWwgTUlTQyByZWdzIHNldCAoTUlTQzEtNCkuDQorCSAqLw0K
KwlpZiAocmRtc3Jfc2FmZShNU1JfQU1ENjRfU01DQV9NQ3hfQ09ORklHKGJhbmspLCAmbG93LCAm
aGlnaCkpDQorCQlyZXR1cm47DQorDQorCWlmICghKGxvdyAmIE1DSV9DT05GSUdfTUNBWCkpDQor
CQlyZXR1cm47DQorDQorCWlmIChyZG1zcl9zYWZlKE1TUl9BTUQ2NF9TTUNBX01DeF9NSVNDKGJh
bmspLCAmbG93LCAmaGlnaCkpDQorCQlyZXR1cm47DQorDQorCWlmIChsb3cgJiBNQVNLX0JMS1BU
Ul9MTykNCisJCXBlcl9jcHUoc21jYV9taXNjX2JhbmtzX21hcCwgY3B1KSB8PSBCSVQoYmFuayk7
DQorDQorfQ0KKw0KIHN0YXRpYyB2b2lkIHNtY2FfY29uZmlndXJlKHVuc2lnbmVkIGludCBiYW5r
LCB1bnNpZ25lZCBpbnQgY3B1KQ0KIHsNCiAJdW5zaWduZWQgaW50IGksIGh3aWRfbWNhdHlwZTsN
CkBAIC0yNDUsNiArMjY1LDggQEAgc3RhdGljIHZvaWQgc21jYV9jb25maWd1cmUodW5zaWduZWQg
aW50IGJhbmssIHVuc2lnbmVkIGludCBjcHUpDQogCQl3cm1zcihzbWNhX2NvbmZpZywgbG93LCBo
aWdoKTsNCiAJfQ0KIA0KKwlzbWNhX3NldF9taXNjX2JhbmtzX21hcChiYW5rLCBjcHUpOw0KKw0K
IAkvKiBSZXR1cm4gZWFybHkgaWYgdGhpcyBiYW5rIHdhcyBhbHJlYWR5IGluaXRpYWxpemVkLiAq
Lw0KIAlpZiAoc21jYV9iYW5rc1tiYW5rXS5od2lkKQ0KIAkJcmV0dXJuOw0KQEAgLTQ1NSw0MiAr
NDc3LDIxIEBAIHN0YXRpYyB2b2lkIGRlZmVycmVkX2Vycm9yX2ludGVycnVwdF9lbmFibGUoc3Ry
dWN0IGNwdWluZm9feDg2ICpjKQ0KIAl3cm1zcihNU1JfQ1VfREVGX0VSUiwgbG93LCBoaWdoKTsN
CiB9DQogDQotc3RhdGljIHUzMiBzbWNhX2dldF9ibG9ja19hZGRyZXNzKHVuc2lnbmVkIGludCBi
YW5rLCB1bnNpZ25lZCBpbnQgYmxvY2spDQorc3RhdGljIHUzMiBzbWNhX2dldF9ibG9ja19hZGRy
ZXNzKHVuc2lnbmVkIGludCBiYW5rLCB1bnNpZ25lZCBpbnQgYmxvY2ssDQorCQkJCSAgdW5zaWdu
ZWQgaW50IGNwdSkNCiB7DQotCXUzMiBsb3csIGhpZ2g7DQotCXUzMiBhZGRyID0gMDsNCi0NCi0J
aWYgKHNtY2FfZ2V0X2JhbmtfdHlwZShiYW5rKSA9PSBTTUNBX1JFU0VSVkVEKQ0KLQkJcmV0dXJu
IGFkZHI7DQotDQogCWlmICghYmxvY2spDQogCQlyZXR1cm4gTVNSX0FNRDY0X1NNQ0FfTUN4X01J
U0MoYmFuayk7DQogDQotCS8qIENoZWNrIG91ciBjYWNoZSBmaXJzdDogKi8NCi0JaWYgKHNtY2Ff
YmFua19hZGRyc1tiYW5rXVtibG9ja10gIT0gLTEpDQotCQlyZXR1cm4gc21jYV9iYW5rX2FkZHJz
W2JhbmtdW2Jsb2NrXTsNCi0NCi0JLyoNCi0JICogRm9yIFNNQ0EgZW5hYmxlZCBwcm9jZXNzb3Jz
LCBCTEtQVFIgZmllbGQgb2YgdGhlIGZpcnN0IE1JU0MgcmVnaXN0ZXINCi0JICogKE1DeF9NSVND
MCkgaW5kaWNhdGVzIHByZXNlbmNlIG9mIGFkZGl0aW9uYWwgTUlTQyByZWdzIHNldCAoTUlTQzEt
NCkuDQotCSAqLw0KLQlpZiAocmRtc3Jfc2FmZShNU1JfQU1ENjRfU01DQV9NQ3hfQ09ORklHKGJh
bmspLCAmbG93LCAmaGlnaCkpDQotCQlnb3RvIG91dDsNCi0NCi0JaWYgKCEobG93ICYgTUNJX0NP
TkZJR19NQ0FYKSkNCi0JCWdvdG8gb3V0Ow0KLQ0KLQlpZiAoIXJkbXNyX3NhZmUoTVNSX0FNRDY0
X1NNQ0FfTUN4X01JU0MoYmFuayksICZsb3csICZoaWdoKSAmJg0KLQkgICAgKGxvdyAmIE1BU0tf
QkxLUFRSX0xPKSkNCi0JCWFkZHIgPSBNU1JfQU1ENjRfU01DQV9NQ3hfTUlTQ3koYmFuaywgYmxv
Y2sgLSAxKTsNCisJaWYgKCEocGVyX2NwdShzbWNhX21pc2NfYmFua3NfbWFwLCBjcHUpICYgQklU
KGJhbmspKSkNCisJCXJldHVybiAwOw0KIA0KLW91dDoNCi0Jc21jYV9iYW5rX2FkZHJzW2Jhbmtd
W2Jsb2NrXSA9IGFkZHI7DQotCXJldHVybiBhZGRyOw0KKwlyZXR1cm4gTVNSX0FNRDY0X1NNQ0Ff
TUN4X01JU0N5KGJhbmssIGJsb2NrIC0gMSk7DQogfQ0KIA0KIHN0YXRpYyB1MzIgZ2V0X2Jsb2Nr
X2FkZHJlc3ModTMyIGN1cnJlbnRfYWRkciwgdTMyIGxvdywgdTMyIGhpZ2gsDQotCQkJICAgICB1
bnNpZ25lZCBpbnQgYmFuaywgdW5zaWduZWQgaW50IGJsb2NrKQ0KKwkJCSAgICAgdW5zaWduZWQg
aW50IGJhbmssIHVuc2lnbmVkIGludCBibG9jaywNCisJCQkgICAgIHVuc2lnbmVkIGludCBjcHUp
DQogew0KIAl1MzIgYWRkciA9IDAsIG9mZnNldCA9IDA7DQogDQpAQCAtNDk4LDcgKzQ5OSw3IEBA
IHN0YXRpYyB1MzIgZ2V0X2Jsb2NrX2FkZHJlc3ModTMyIGN1cnJlbnRfYWRkciwgdTMyIGxvdywg
dTMyIGhpZ2gsDQogCQlyZXR1cm4gYWRkcjsNCiANCiAJaWYgKG1jZV9mbGFncy5zbWNhKQ0KLQkJ
cmV0dXJuIHNtY2FfZ2V0X2Jsb2NrX2FkZHJlc3MoYmFuaywgYmxvY2spOw0KKwkJcmV0dXJuIHNt
Y2FfZ2V0X2Jsb2NrX2FkZHJlc3MoYmFuaywgYmxvY2ssIGNwdSk7DQogDQogCS8qIEZhbGwgYmFj
ayB0byBtZXRob2Qgd2UgdXNlZCBmb3Igb2xkZXIgcHJvY2Vzc29yczogKi8NCiAJc3dpdGNoIChi
bG9jaykgew0KQEAgLTYzNyw3ICs2MzgsNyBAQCB2b2lkIG1jZV9hbWRfZmVhdHVyZV9pbml0KHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCiAJCWRpc2FibGVfZXJyX3RocmVzaG9sZGluZyhjLCBiYW5r
KTsNCiANCiAJCWZvciAoYmxvY2sgPSAwOyBibG9jayA8IE5SX0JMT0NLUzsgKytibG9jaykgew0K
LQkJCWFkZHJlc3MgPSBnZXRfYmxvY2tfYWRkcmVzcyhhZGRyZXNzLCBsb3csIGhpZ2gsIGJhbmss
IGJsb2NrKTsNCisJCQlhZGRyZXNzID0gZ2V0X2Jsb2NrX2FkZHJlc3MoYWRkcmVzcywgbG93LCBo
aWdoLCBiYW5rLCBibG9jaywgY3B1KTsNCiAJCQlpZiAoIWFkZHJlc3MpDQogCQkJCWJyZWFrOw0K
IA0KQEAgLTEyNTQsNyArMTI1NSw3IEBAIHN0YXRpYyBpbnQgYWxsb2NhdGVfdGhyZXNob2xkX2Js
b2Nrcyh1bnNpZ25lZCBpbnQgY3B1LCB1bnNpZ25lZCBpbnQgYmFuaywNCiAJaWYgKGVycikNCiAJ
CWdvdG8gb3V0X2ZyZWU7DQogcmVjdXJzZToNCi0JYWRkcmVzcyA9IGdldF9ibG9ja19hZGRyZXNz
KGFkZHJlc3MsIGxvdywgaGlnaCwgYmFuaywgKytibG9jayk7DQorCWFkZHJlc3MgPSBnZXRfYmxv
Y2tfYWRkcmVzcyhhZGRyZXNzLCBsb3csIGhpZ2gsIGJhbmssICsrYmxvY2ssIGNwdSk7DQogCWlm
ICghYWRkcmVzcykNCiAJCXJldHVybiAwOw0KIA0KLS0gDQoyLjE3LjENCg0K
