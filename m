Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB97100ED
	for <lists+linux-edac@lfdr.de>; Tue, 30 Apr 2019 22:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfD3Uc5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Apr 2019 16:32:57 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:6224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfD3Uce (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Apr 2019 16:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajA3phzfBzziXcsTtcQRPYJIvProQtFTD+/XZD5gZSs=;
 b=IEydgZNELtloluvm+VM0I4v+ITuT3LnKK5/wOQIsUIL2lcwkmW0azLb5QFtJ2/Q9BmtnOooaGSqm7boabY8SVoPe3ceBZYDIirYqgNuiWQSbHxi4IxHfa7/jNX1Nnpqmn09+zwel0NR9UOZqHjcjQreN49i+oaV63Yib6iNNyqg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 20:32:18 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 20:32:18 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v3 1/6] x86/MCE: Make struct mce_banks[] static
Thread-Topic: [PATCH v3 1/6] x86/MCE: Make struct mce_banks[] static
Thread-Index: AQHU/5PNiCmFDXTB+kS8BtJtg1e8mQ==
Date:   Tue, 30 Apr 2019 20:32:17 +0000
Message-ID: <20190430203206.104163-2-Yazen.Ghannam@amd.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:805:a2::32) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38db1fda-dbbc-403d-c627-08d6cdaaf022
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2640C7DD8507B988CBFC85C8F83A0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(14454004)(53936002)(4326008)(50226002)(1076003)(478600001)(6116002)(3846002)(97736004)(5640700003)(26005)(8676002)(66946007)(66476007)(6512007)(73956011)(2501003)(8936002)(316002)(6436002)(6306002)(66446008)(71200400001)(86362001)(81156014)(36756003)(71190400001)(81166006)(66556008)(64756008)(66066001)(6916009)(54906003)(486006)(68736007)(5660300002)(6506007)(76176011)(305945005)(25786009)(256004)(14444005)(52116002)(7736002)(966005)(476003)(2906002)(446003)(72206003)(11346002)(2616005)(2351001)(386003)(102836004)(186003)(99286004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QefohHrgn66qU0PJcNkwAxMilZIrbDYB2UtLIjlfjy2SaMWYJZEy4JcjwjmeDRoG0syla8N6MBFlvdnM7AvbL1AQBuHc6dtVpEyXmimFY9EL/sN67TxbFF3yr6Ksdg7MSRzAnEWABD1zR6YoyJ+5xp7bd1r3Q/LgtIoER40zkppTdFWcy71dJG0MX0H9fQKSkttqpTJIL4KhxVPlgTuUphxcW6BibY0cuQkvOGwtZZLEg9qEy/5lKwy06BQJI2TU2gwQ5Mvd9er3j99LbIUNT7jkHlJV3EqF+KlT6AZoXnPKhxbwuUn4PmThrmoU5YQoYkRVVg32f2ZBhN62YBJiuy3aMT7EDHJdWJB8N2494ZnHNbww+rd2yn0xuX6fVme37gQrzmUutL7C7dczK0F8PCkMOlaJcGcdeF7FlyGZK8Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38db1fda-dbbc-403d-c627-08d6cdaaf022
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:32:18.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgc3RydWN0
IG1jZV9iYW5rc1tdIGFycmF5IGlzIG9ubHkgdXNlZCBpbiBtY2UvY29yZS5jIHNvIG1vdmUgdGhl
DQpkZWZpbml0aW9uIG9mIHN0cnVjdCBtY2VfYmFuayB0byBtY2UvY29yZS5jIGFuZCBtYWtlIHRo
ZSBhcnJheSBzdGF0aWMuDQoNCkFsc28sIGNoYW5nZSB0aGUgImluaXQiIGZpZWxkIHRvIGJvb2wg
dHlwZS4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQu
Y29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQxMTIwMTc0
My40MzE5NS0yLVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQp2Mi0+djM6DQoqIE5vIGNoYW5nZXMN
Cg0KdjEtPnYyOg0KKiBObyBjaGFuZ2VzDQoNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3Jl
LmMgICAgIHwgMTEgKysrKysrKysrKy0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5h
bC5oIHwgMTAgLS0tLS0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9j
b3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCmluZGV4IDUxMTJhNTBlNjQ4
Ni4uYmE1NzY3ZGQ1NTM4IDEwMDY0NA0KLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29y
ZS5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCkBAIC02NCw3ICs2NCwx
NiBAQCBzdGF0aWMgREVGSU5FX01VVEVYKG1jZV9zeXNmc19tdXRleCk7DQogDQogREVGSU5FX1BF
Ul9DUFUodW5zaWduZWQsIG1jZV9leGNlcHRpb25fY291bnQpOw0KIA0KLXN0cnVjdCBtY2VfYmFu
ayAqbWNlX2JhbmtzIF9fcmVhZF9tb3N0bHk7DQorI2RlZmluZSBBVFRSX0xFTiAgICAgICAgICAg
ICAgIDE2DQorLyogT25lIG9iamVjdCBmb3IgZWFjaCBNQ0UgYmFuaywgc2hhcmVkIGJ5IGFsbCBD
UFVzICovDQorc3RydWN0IG1jZV9iYW5rIHsNCisJdTY0CQkJY3RsOwkJCS8qIHN1YmV2ZW50cyB0
byBlbmFibGUgKi8NCisJYm9vbAkJCWluaXQ7CQkJLyogaW5pdGlhbGlzZSBiYW5rPyAqLw0KKwlz
dHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZQlhdHRyOwkJCS8qIGRldmljZSBhdHRyaWJ1dGUgKi8NCisJ
Y2hhcgkJCWF0dHJuYW1lW0FUVFJfTEVOXTsJLyogYXR0cmlidXRlIG5hbWUgKi8NCit9Ow0KKw0K
K3N0YXRpYyBzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9iYW5rcyBfX3JlYWRfbW9zdGx5Ow0KIHN0cnVj
dCBtY2VfdmVuZG9yX2ZsYWdzIG1jZV9mbGFncyBfX3JlYWRfbW9zdGx5Ow0KIA0KIHN0cnVjdCBt
Y2FfY29uZmlnIG1jYV9jZmcgX19yZWFkX21vc3RseSA9IHsNCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5hbC5oIGIvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvaW50
ZXJuYWwuaA0KaW5kZXggYTM0YjU1YmFhN2FhLi4zNWIzZTVjMDJjMWMgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9pbnRlcm5hbC5oDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9pbnRlcm5hbC5oDQpAQCAtMjIsMTcgKzIyLDggQEAgZW51bSBzZXZlcml0eV9sZXZl
bCB7DQogDQogZXh0ZXJuIHN0cnVjdCBibG9ja2luZ19ub3RpZmllcl9oZWFkIHg4Nl9tY2VfZGVj
b2Rlcl9jaGFpbjsNCiANCi0jZGVmaW5lIEFUVFJfTEVOCQkxNg0KICNkZWZpbmUgSU5JVElBTF9D
SEVDS19JTlRFUlZBTAk1ICogNjAgLyogNSBtaW51dGVzICovDQogDQotLyogT25lIG9iamVjdCBm
b3IgZWFjaCBNQ0UgYmFuaywgc2hhcmVkIGJ5IGFsbCBDUFVzICovDQotc3RydWN0IG1jZV9iYW5r
IHsNCi0JdTY0CQkJY3RsOwkJCS8qIHN1YmV2ZW50cyB0byBlbmFibGUgKi8NCi0JdW5zaWduZWQg
Y2hhciBpbml0OwkJCQkvKiBpbml0aWFsaXNlIGJhbms/ICovDQotCXN0cnVjdCBkZXZpY2VfYXR0
cmlidXRlIGF0dHI7CQkJLyogZGV2aWNlIGF0dHJpYnV0ZSAqLw0KLQljaGFyCQkJYXR0cm5hbWVb
QVRUUl9MRU5dOwkvKiBhdHRyaWJ1dGUgbmFtZSAqLw0KLX07DQotDQogc3RydWN0IG1jZV9ldnRf
bGxpc3Qgew0KIAlzdHJ1Y3QgbGxpc3Rfbm9kZSBsbG5vZGU7DQogCXN0cnVjdCBtY2UgbWNlOw0K
QEAgLTQ3LDcgKzM4LDYgQEAgc3RydWN0IGxsaXN0X25vZGUgKm1jZV9nZW5fcG9vbF9wcmVwYXJl
X3JlY29yZHModm9pZCk7DQogZXh0ZXJuIGludCAoKm1jZV9zZXZlcml0eSkoc3RydWN0IG1jZSAq
YSwgaW50IHRvbGVyYW50LCBjaGFyICoqbXNnLCBib29sIGlzX2V4Y3ApOw0KIHN0cnVjdCBkZW50
cnkgKm1jZV9nZXRfZGVidWdmc19kaXIodm9pZCk7DQogDQotZXh0ZXJuIHN0cnVjdCBtY2VfYmFu
ayAqbWNlX2JhbmtzOw0KIGV4dGVybiBtY2VfYmFua3NfdCBtY2VfYmFua3NfY2VfZGlzYWJsZWQ7
DQogDQogI2lmZGVmIENPTkZJR19YODZfTUNFX0lOVEVMDQotLSANCjIuMTcuMQ0KDQo=
