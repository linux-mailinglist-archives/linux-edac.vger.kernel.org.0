Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB80396AC
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 22:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfFGUSY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 16:18:24 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:26017
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730142AbfFGUSV (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 16:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IkGeQC4RSCZF01NWnx+H4/dyDTi3a43TLFMiuC+GqiQ=;
 b=bpMjpWGEl5BinJvYYet/X5j2S8a7TqeSRnmz6qNTaGs9XVJSAqhTQntB4trNE5Utq31xaujM5VQQvuwUufZdvd5Il2T0/JMBpN5bCQJojj2m3P1oVqvL98ICcaiXtfD8C2pCyagPZ482qno6X3pmG/T2oRyKyXuKc/+/g2vr6LQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2704.namprd12.prod.outlook.com (52.135.103.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 20:18:06 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 20:18:06 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v4 5/5] x86/MCE: Determine MCA banks' init state properly
Thread-Topic: [PATCH v4 5/5] x86/MCE: Determine MCA banks' init state properly
Thread-Index: AQHVHW4dUR2uifZmu0uRrf4zYZRDWg==
Date:   Fri, 7 Jun 2019 20:18:06 +0000
Message-ID: <20190607201752.221446-6-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 6dc637d5-fa9a-4a21-bb89-08d6eb854013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2704;
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2704EE07B87087F6E0837714F8100@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(6486002)(6436002)(72206003)(5640700003)(316002)(966005)(186003)(15650500001)(26005)(478600001)(4326008)(6306002)(68736007)(66946007)(6512007)(446003)(25786009)(73956011)(64756008)(66476007)(66556008)(66446008)(486006)(53936002)(11346002)(2616005)(14454004)(476003)(66066001)(5660300002)(52116002)(14444005)(256004)(2501003)(305945005)(2351001)(102836004)(386003)(71190400001)(71200400001)(6506007)(3846002)(6116002)(7736002)(81166006)(36756003)(6916009)(81156014)(8676002)(8936002)(1076003)(50226002)(99286004)(76176011)(54906003)(86362001)(2906002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OrPRQ1PkHy5ZKCgHSu4dlZtTFfm85h7uybgm7RgW463Y/z+UvATJOho6qVsIUJHr7d4N21e+fphF+lM7mA4SzSIC6MV9V5gFANIsuLCFC9DbFdDgFDBP9N+5nTRdZViT7zIWzJKJHjvI8BdTDevZEOH8Pix59wCF3qo84K5oj1mzzyhL063kOSXNoPUiGqmEiL8MDf+YCyqhSxEyEBGmhHCYq6VJfsXs8dJLhA4NYe02RP+Pkpc/O1vMbRDIzg5OaMyjP3tSPetB4SRfPJmVWjIlpOJW/0lQ31/dnADZNMjsf1LuEaTQObCR24yc3d4oYqQgTsS8CCcsRVR9tMg3BntIvVnn4FYgE1u6JzY+vYWsctRMjPNRzWlEqNXsuN6Kergem6auA/P1U2cHOnF9HjAz1kOHy4oTbbEzG73UTBc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc637d5-fa9a-4a21-bb89-08d6eb854013
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 20:18:06.0774
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

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgT1MgaXMg
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgdG8gTUNBX0NUTCBmb3IgZWFjaCBiYW5rLA0KdGh1
cyBlbmFibGluZyBlcnJvciByZXBvcnRpbmcgaW4gYWxsIGJhbmtzLiBIb3dldmVyLCBzb21lIGJh
bmtzDQptYXkgYmUgdW51c2VkIGluIHdoaWNoIGNhc2UgdGhlIHJlZ2lzdGVycyBmb3Igc3VjaCBi
YW5rcyBhcmUNClJlYWQtYXMtWmVyby9Xcml0ZXMtSWdub3JlZC4gQWxzbywgdGhlIE9TIG1heSBh
dm9pZCBzZXR0aW5nIHNvbWUgY29udHJvbA0KYml0cyBiZWNhdXNlIG9mIHF1aXJrcywgZXRjLg0K
DQpBIGJhbmsgY2FuIGJlIGNvbnNpZGVyZWQgdW5pbml0aWFsaXplZCBpZiB0aGUgTUNBX0NUTCBy
ZWdpc3RlciByZXR1cm5zDQp6ZXJvLiBUaGlzIGlzIGJlY2F1c2UgZWl0aGVyIHRoZSBPUyBkaWQg
bm90IHdyaXRlIGFueXRoaW5nIG9yIGJlY2F1c2UNCnRoZSBoYXJkd2FyZSBpcyBlbmZvcmNpbmcg
UkFaL1dJIGZvciB0aGUgYmFuay4NCg0KU2V0IGEgYmFuaydzIGluaXQgdmFsdWUgYmFzZWQgb24g
aWYgdGhlIGNvbnRyb2wgYml0cyBhcmUgc2V0IG9yIG5vdCBpbg0KaGFyZHdhcmUuIFJldHVybiBh
biBlcnJvciBjb2RlIGluIHRoZSBzeXNmcyBpbnRlcmZhY2UgZm9yIHVuaW5pdGlhbGl6ZWQNCmJh
bmtzLg0KDQpEbyBhIGZpbmFsIGJhbmsgaW5pdCBjaGVjayBpbiBhIHNlcGFyYXRlIGZ1bmN0aW9u
IHdoaWNoIGlzIG5vdCBwYXJ0IG9mDQphbnkgdXNlci1jb250cm9sbGVkIGNvZGUgZmxvd3MuIFRo
aXMgaXMgc28gYSB1c2VyIG1heSBlbmFibGUvZGlzYWJsZSBhDQpiYW5rIGR1cmluZyBydW50aW1l
IHdpdGhvdXQgaGF2aW5nIHRvIHJlc3RhcnQgdGhlaXIgc3lzdGVtLg0KDQogWyBicDogTWFzc2Fn
ZSBhIGJpdC4gRGlzY292ZXIgYmFuayBpbml0IHN0YXRlIGF0IGJvb3QuIF0NCg0KU2lnbmVkLW9m
Zi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0K
aHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQzMDIwMzIwNi4xMDQxNjMtNi1ZYXplbi5H
aGFubmFtQGFtZC5jb20NCg0KdjMtPnY0Og0KKiBQYXRjaCA1IHZlcnNpb24gMyB3YXMgemFwcGVk
Lg0KKiBUaGlzIGlzIGJhc2VkIG9uIG5ldyBwYXRjaCBmcm9tIEJvcmlzIHdoaWNoIHdhcyBiYXNl
ZCBvbiBQYXRjaCA2IHZlcnNpb24gMy4NCiogUmV3b3JrZWQgbmV3IHBhdGNoIHRvIGZpeCBzeXNm
cyBpc3N1ZSB3aXRoIGRpc2FibGVkIGJhbmtzLg0KDQp2Mi0+djM6DQoqIE5vIGNoYW5nZS4NCg0K
djEtPnYyOg0KKiBObyBjaGFuZ2UuDQoNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMg
fCAzOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDM5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KaW5kZXggNjgxMzcxMmQ4
NjQ4Li5hZTc3MjNhOTQyZjYgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9j
b3JlLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KQEAgLTE0OTAsNiAr
MTQ5MCwxMSBAQCBzdGF0aWMgdm9pZCBfX21jaGVja19jcHVfbWNlX2JhbmtzX2luaXQodm9pZCkN
CiAJZm9yIChpID0gMDsgaSA8IG5fYmFua3M7IGkrKykgew0KIAkJc3RydWN0IG1jZV9iYW5rICpi
ID0gJm1jZV9iYW5rc1tpXTsNCiANCisJCS8qDQorCQkgKiBJbml0IHRoZW0gYWxsLCBfX21jaGVj
a19jcHVfYXBwbHlfcXVpcmtzKCkgaXMgZ29pbmcgdG8gYXBwbHkNCisJCSAqIHRoZSByZXF1aXJl
ZCB2ZW5kb3IgcXVpcmtzIGJlZm9yZQ0KKwkJICogX19tY2hlY2tfY3B1X2luaXRfY2xlYXJfYmFu
a3MoKSBkb2VzIHRoZSBmaW5hbCBiYW5rIHNldHVwLg0KKwkJICovDQogCQliLT5jdGwgPSAtMVVM
TDsNCiAJCWItPmluaXQgPSAxOw0KIAl9DQpAQCAtMTU2Miw2ICsxNTY3LDMzIEBAIHN0YXRpYyB2
b2lkIF9fbWNoZWNrX2NwdV9pbml0X2NsZWFyX2JhbmtzKHZvaWQpDQogCX0NCiB9DQogDQorLyoN
CisgKiBEbyBhIGZpbmFsIGNoZWNrIHRvIHNlZSBpZiB0aGVyZSBhcmUgYW55IHVudXNlZC9SQVog
YmFua3MuDQorICoNCisgKiBUaGlzIG11c3QgYmUgZG9uZSBhZnRlciB0aGUgYmFua3MgaGF2ZSBi
ZWVuIGluaXRpYWxpemVkIGFuZCBhbnkgcXVpcmtzIGhhdmUNCisgKiBiZWVuIGFwcGxpZWQuDQor
ICoNCisgKiBEbyBub3QgY2FsbCB0aGlzIGZyb20gYW55IHVzZXItaW5pdGlhbGVkIGZsb3dzLCBl
LmcuIENQVSBob3RwbHVnIG9yIHN5c2ZzLg0KKyAqIE90aGVyd2lzZSwgYSB1c2VyIHdobyBkaXNh
YmxlcyBhIGJhbmsgd2lsbCBub3QgYmUgYWJsZSB0byByZS1lbmFibGUgaXQNCisgKiB3aXRob3V0
IGEgc3lzdGVtIHJlYm9vdC4NCisgKi8NCitzdGF0aWMgdm9pZCBfX21jaGVja19jcHVfY2hlY2tf
YmFua3Modm9pZCkNCit7DQorCXN0cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzID0gdGhpc19jcHVf
cHRyKG1jZV9iYW5rc19hcnJheSk7DQorCXU2NCBtc3J2YWw7DQorCWludCBpOw0KKw0KKwlmb3Ig
KGkgPSAwOyBpIDwgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKTsgaSsrKSB7DQorCQlzdHJ1
Y3QgbWNlX2JhbmsgKmIgPSAmbWNlX2JhbmtzW2ldOw0KKw0KKwkJaWYgKCFiLT5pbml0KQ0KKwkJ
CWNvbnRpbnVlOw0KKw0KKwkJcmRtc3JsKG1zcl9vcHMuY3RsKGkpLCBtc3J2YWwpOw0KKwkJYi0+
aW5pdCA9ICEhbXNydmFsOw0KKwl9DQorfQ0KKw0KIC8qDQogICogRHVyaW5nIElGVSByZWNvdmVy
eSBTYW5keSBCcmlkZ2UgLUVQNFMgcHJvY2Vzc29ycyBzZXQgdGhlIFJJUFYgYW5kDQogICogRUlQ
ViBiaXRzIGluIE1DR19TVEFUVVMgdG8gemVybyBvbiB0aGUgYWZmZWN0ZWQgbG9naWNhbCBwcm9j
ZXNzb3IgKFNETQ0KQEAgLTE4NDksNiArMTg4MSw3IEBAIHZvaWQgbWNoZWNrX2NwdV9pbml0KHN0
cnVjdCBjcHVpbmZvX3g4NiAqYykNCiAJX19tY2hlY2tfY3B1X2luaXRfZ2VuZXJpYygpOw0KIAlf
X21jaGVja19jcHVfaW5pdF92ZW5kb3IoYyk7DQogCV9fbWNoZWNrX2NwdV9pbml0X2NsZWFyX2Jh
bmtzKCk7DQorCV9fbWNoZWNrX2NwdV9jaGVja19iYW5rcygpOw0KIAlfX21jaGVja19jcHVfc2V0
dXBfdGltZXIoKTsNCiB9DQogDQpAQCAtMjA4NSw2ICsyMTE4LDkgQEAgc3RhdGljIHNzaXplX3Qg
c2hvd19iYW5rKHN0cnVjdCBkZXZpY2UgKnMsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRy
LA0KIA0KIAliID0gJnBlcl9jcHUobWNlX2JhbmtzX2FycmF5LCBzLT5pZClbYmFua107DQogDQor
CWlmICghYi0+aW5pdCkNCisJCXJldHVybiAtRU5PREVWOw0KKw0KIAlyZXR1cm4gc3ByaW50Zihi
dWYsICIlbGx4XG4iLCBiLT5jdGwpOw0KIH0NCiANCkBAIC0yMTAzLDYgKzIxMzksOSBAQCBzdGF0
aWMgc3NpemVfdCBzZXRfYmFuayhzdHJ1Y3QgZGV2aWNlICpzLCBzdHJ1Y3QgZGV2aWNlX2F0dHJp
YnV0ZSAqYXR0ciwNCiANCiAJYiA9ICZwZXJfY3B1KG1jZV9iYW5rc19hcnJheSwgcy0+aWQpW2Jh
bmtdOw0KIA0KKwlpZiAoIWItPmluaXQpDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCiAJYi0+Y3Rs
ID0gbmV3Ow0KIAltY2VfcmVzdGFydCgpOw0KIA0KLS0gDQoyLjE3LjENCg0K
