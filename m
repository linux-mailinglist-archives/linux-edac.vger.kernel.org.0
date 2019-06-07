Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF228396A2
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 22:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfFGUSJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 16:18:09 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:26017
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729577AbfFGUSH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 16:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s+B6dPx055R2aeTqOO8Qn+9lFGJxnpv9Ggz0/YD0PI=;
 b=QPT61IcUDTcWTbyvcHZ7oGpoP/Y/Q0G5QhE+WhCBTzJd8PazDA6xicBtdRrdwj/eB3eWpjcWgj82C4V7TCNfBi8WmKgFNo8ysCGb9/aB5wMU0DWwqw7eUZsuJcBQXRmbxDIQZHiiOssLB1x0TjjhRfhnphZdN1eLXD5ewlms2DI=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2704.namprd12.prod.outlook.com (52.135.103.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 20:18:04 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 20:18:04 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v4 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Topic: [PATCH v4 1/5] x86/MCE: Make struct mce_banks[] static
Thread-Index: AQHVHW4cZTJZ3kX4gk6o5PHSNP1O9Q==
Date:   Fri, 7 Jun 2019 20:18:03 +0000
Message-ID: <20190607201752.221446-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: de549861-6ed7-4bd6-9833-08d6eb853ece
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2704;
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2704D269B14E107D807E7D15F8100@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(199004)(6486002)(6436002)(72206003)(5640700003)(316002)(966005)(186003)(26005)(478600001)(4326008)(6306002)(68736007)(66946007)(6512007)(446003)(25786009)(73956011)(64756008)(66476007)(66556008)(66446008)(486006)(53936002)(11346002)(2616005)(14454004)(476003)(66066001)(5660300002)(52116002)(14444005)(256004)(2501003)(305945005)(2351001)(102836004)(386003)(71190400001)(71200400001)(6506007)(3846002)(6116002)(7736002)(81166006)(36756003)(6916009)(81156014)(8676002)(8936002)(1076003)(50226002)(99286004)(76176011)(54906003)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YD1OMsTZs+s/UbdNwcOUb6kmzl7Jqs7IWxG4LpNyUA/kXhtE3grIoMc0fNNtDdit3uP0eMWM0QOVAX7XYqReLjuuZpSHG3kD+y6w1vL+xVaD16GUpxBZDYtbjO1+meqkRb8Pnc/NBVhOZxOUS4YNZBaQddtamTr4txYMF+jyDOXidjXPW3gbiLMIirJfdMZGOlawON8uqJ+R6GfAKnswrXiJGR7YWMq8EYCralcd1P1m4RsWfWdN6Rg4ze5fE1Gae2qsKMgo5yDfrv1R7KcFnEWdRJHlKNu8UDYMlgXbGoikJUxGNuKSQl8HtLVVdSnAMjo+iSjsATd6/TBwR8lKi1Eu7cQ7LSlAPh+OHWSEbxE4iKq860nZ4PhEAnn2Sd8gYuNmcJpDjjEHKufwOTTohiFb3YOcKSjDek8gluEgS74=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de549861-6ed7-4bd6-9833-08d6eb853ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 20:18:03.8976
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

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc3RydWN0
IG1jZV9iYW5rc1tdIGFycmF5IGlzIG9ubHkgdXNlZCBpbiBtY2UvY29yZS5jIHNvIG1vdmUgaXRz
DQpkZWZpbml0aW9uIHRoZXJlIGFuZCBtYWtlIGl0IHN0YXRpYy4gQWxzbywgY2hhbmdlIHRoZSAi
aW5pdCIgZmllbGQgdG8NCmJvb2wgdHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5h
bSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5l
bC5vcmcvci8yMDE5MDQzMDIwMzIwNi4xMDQxNjMtMi1ZYXplbi5HaGFubmFtQGFtZC5jb20NCg0K
djMtPnY0Og0KKiBObyBjaGFuZ2VzDQoNCnYyLT52MzoNCiogTm8gY2hhbmdlcw0KDQp2MS0+djI6
DQoqIE5vIGNoYW5nZXMNCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyAgICAgfCAx
MSArKysrKysrKysrLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2ludGVybmFsLmggfCAxMCAt
LS0tLS0tLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2Fy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KaW5kZXggMjgyOTE2ZjNiOGQ4Li41NWJkYmVk
ZGUwYjggMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCisrKyBi
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KQEAgLTY1LDcgKzY1LDE2IEBAIHN0YXRp
YyBERUZJTkVfTVVURVgobWNlX3N5c2ZzX211dGV4KTsNCiANCiBERUZJTkVfUEVSX0NQVSh1bnNp
Z25lZCwgbWNlX2V4Y2VwdGlvbl9jb3VudCk7DQogDQotc3RydWN0IG1jZV9iYW5rICptY2VfYmFu
a3MgX19yZWFkX21vc3RseTsNCisjZGVmaW5lIEFUVFJfTEVOICAgICAgICAgICAgICAgMTYNCisv
KiBPbmUgb2JqZWN0IGZvciBlYWNoIE1DRSBiYW5rLCBzaGFyZWQgYnkgYWxsIENQVXMgKi8NCitz
dHJ1Y3QgbWNlX2Jhbmsgew0KKwl1NjQJCQljdGw7CQkJLyogc3ViZXZlbnRzIHRvIGVuYWJsZSAq
Lw0KKwlib29sCQkJaW5pdDsJCQkvKiBpbml0aWFsaXNlIGJhbms/ICovDQorCXN0cnVjdCBkZXZp
Y2VfYXR0cmlidXRlCWF0dHI7CQkJLyogZGV2aWNlIGF0dHJpYnV0ZSAqLw0KKwljaGFyCQkJYXR0
cm5hbWVbQVRUUl9MRU5dOwkvKiBhdHRyaWJ1dGUgbmFtZSAqLw0KK307DQorDQorc3RhdGljIHN0
cnVjdCBtY2VfYmFuayAqbWNlX2JhbmtzIF9fcmVhZF9tb3N0bHk7DQogc3RydWN0IG1jZV92ZW5k
b3JfZmxhZ3MgbWNlX2ZsYWdzIF9fcmVhZF9tb3N0bHk7DQogDQogc3RydWN0IG1jYV9jb25maWcg
bWNhX2NmZyBfX3JlYWRfbW9zdGx5ID0gew0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9j
cHUvbWNlL2ludGVybmFsLmggYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5hbC5oDQpp
bmRleCBhMzRiNTViYWE3YWEuLjM1YjNlNWMwMmMxYyAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2ludGVybmFsLmgNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2lu
dGVybmFsLmgNCkBAIC0yMiwxNyArMjIsOCBAQCBlbnVtIHNldmVyaXR5X2xldmVsIHsNCiANCiBl
eHRlcm4gc3RydWN0IGJsb2NraW5nX25vdGlmaWVyX2hlYWQgeDg2X21jZV9kZWNvZGVyX2NoYWlu
Ow0KIA0KLSNkZWZpbmUgQVRUUl9MRU4JCTE2DQogI2RlZmluZSBJTklUSUFMX0NIRUNLX0lOVEVS
VkFMCTUgKiA2MCAvKiA1IG1pbnV0ZXMgKi8NCiANCi0vKiBPbmUgb2JqZWN0IGZvciBlYWNoIE1D
RSBiYW5rLCBzaGFyZWQgYnkgYWxsIENQVXMgKi8NCi1zdHJ1Y3QgbWNlX2Jhbmsgew0KLQl1NjQJ
CQljdGw7CQkJLyogc3ViZXZlbnRzIHRvIGVuYWJsZSAqLw0KLQl1bnNpZ25lZCBjaGFyIGluaXQ7
CQkJCS8qIGluaXRpYWxpc2UgYmFuaz8gKi8NCi0Jc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgYXR0
cjsJCQkvKiBkZXZpY2UgYXR0cmlidXRlICovDQotCWNoYXIJCQlhdHRybmFtZVtBVFRSX0xFTl07
CS8qIGF0dHJpYnV0ZSBuYW1lICovDQotfTsNCi0NCiBzdHJ1Y3QgbWNlX2V2dF9sbGlzdCB7DQog
CXN0cnVjdCBsbGlzdF9ub2RlIGxsbm9kZTsNCiAJc3RydWN0IG1jZSBtY2U7DQpAQCAtNDcsNyAr
MzgsNiBAQCBzdHJ1Y3QgbGxpc3Rfbm9kZSAqbWNlX2dlbl9wb29sX3ByZXBhcmVfcmVjb3Jkcyh2
b2lkKTsNCiBleHRlcm4gaW50ICgqbWNlX3NldmVyaXR5KShzdHJ1Y3QgbWNlICphLCBpbnQgdG9s
ZXJhbnQsIGNoYXIgKiptc2csIGJvb2wgaXNfZXhjcCk7DQogc3RydWN0IGRlbnRyeSAqbWNlX2dl
dF9kZWJ1Z2ZzX2Rpcih2b2lkKTsNCiANCi1leHRlcm4gc3RydWN0IG1jZV9iYW5rICptY2VfYmFu
a3M7DQogZXh0ZXJuIG1jZV9iYW5rc190IG1jZV9iYW5rc19jZV9kaXNhYmxlZDsNCiANCiAjaWZk
ZWYgQ09ORklHX1g4Nl9NQ0VfSU5URUwNCi0tIA0KMi4xNy4xDQoNCg==
