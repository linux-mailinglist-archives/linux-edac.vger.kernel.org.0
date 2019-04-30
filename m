Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F074E100E6
	for <lists+linux-edac@lfdr.de>; Tue, 30 Apr 2019 22:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfD3Uci (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Apr 2019 16:32:38 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:6224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfD3Uci (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Apr 2019 16:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dYmnx3H7+lXDH6q8fX8CcsqiFi0vaT1sQfxgrSwpaM=;
 b=hc/d7DcmUkpFKx75uFyJbw3bCq0fzNz7GoYMgpLQokhhujsW/1YbnXJbgzghjkkwTLQT2gmuNopKNTEmQ6BLXExm6qqYdPyaf/qr9gkgfQMKo46opC58UqNyVZemsIF2Wx45RieMPgooBFTFWT/OBkb4whA4dUYrmLKqKxp15K0=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 20:32:22 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 20:32:22 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v3 6/6] x86/MCE: Treat MCE bank as initialized if control bits
 set in hardware
Thread-Topic: [PATCH v3 6/6] x86/MCE: Treat MCE bank as initialized if control
 bits set in hardware
Thread-Index: AQHU/5PPZD8NxJboU0yoOUX0Kl4RKw==
Date:   Tue, 30 Apr 2019 20:32:21 +0000
Message-ID: <20190430203206.104163-7-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 3ed68d6f-1d90-4ae9-1575-08d6cdaaf22c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB26409BC38F6AF2D378F2022FF83A0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(14454004)(53936002)(4326008)(50226002)(1076003)(478600001)(6116002)(3846002)(97736004)(5640700003)(26005)(8676002)(66946007)(66476007)(6512007)(73956011)(2501003)(8936002)(316002)(6436002)(6306002)(66446008)(71200400001)(86362001)(81156014)(36756003)(71190400001)(81166006)(66556008)(64756008)(66066001)(6916009)(54906003)(486006)(15650500001)(68736007)(5660300002)(6506007)(76176011)(305945005)(25786009)(256004)(52116002)(7736002)(966005)(476003)(2906002)(446003)(72206003)(11346002)(2616005)(2351001)(386003)(102836004)(186003)(99286004)(6486002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNGh8+9jQZp1/skTwVjcS1dThXqEstDxT0BP8EM/7V+65nahM7HGy12OpqA2eUoWuJ7ecruPFBBmD0ZiFFotjMuCDlaUwVDljJQiv8EUAMiSXRUDweGP3XQKQVlY/pf7e5Z1ohH9+GE2aeWc27YvgyOABq892sNA5XABrTux4itojksSG+jy6NSQSqsA6B501NW3V2BppwpCZDc5c9vAPzCAaAy28UtDrjZY0T5xUfypMf/3/XeA6GncKCq4NF8MPA4MbwpxOR1/PBBI5gOrX58wyuDNjdY/DYup3kcGqo440s4oiisAu/W4Yy3GYrU+z/YeV9LVQ0024d7wipemRccH1j1UTPk3S+uBZoQ9z9cblMXPKnGKS00b32vgc9TTXI0JK8wphoxoRYUhvbRslQ+rD2aZCX4FdC60xawV6Fg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed68d6f-1d90-4ae9-1575-08d6cdaaf22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:32:21.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgT1MgaXMg
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgdG8gTUNBX0NUTCBmb3IgZWFjaCBiYW5rLiBIb3dl
dmVyLA0Kc29tZSBiYW5rcyBtYXkgYmUgdW51c2VkIGluIHdoaWNoIGNhc2UgdGhlIHJlZ2lzdGVy
cyBmb3Igc3VjaCBiYW5rcyBhcmUNClJlYWQtYXMtWmVyby9Xcml0ZXMtSWdub3JlZC4gQWxzbywg
dGhlIE9TIG1heSBub3Qgd3JpdGUgYW55IGNvbnRyb2wgYml0cw0KYmVjYXVzZSBvZiBxdWlya3Ms
IGV0Yy4NCg0KQSBiYW5rIGNhbiBiZSBjb25zaWRlcmVkIHVuaW5pdGlhbGl6ZWQgaWYgdGhlIE1D
QV9DVEwgcmVnaXN0ZXIgcmV0dXJucw0KemVyby4gVGhpcyBpcyBiZWNhdXNlIGVpdGhlciB0aGUg
T1MgZGlkIG5vdCB3cml0ZSBhbnl0aGluZyBvciBiZWNhdXNlDQp0aGUgaGFyZHdhcmUgaXMgZW5m
b3JjaW5nIFJBWi9XSSBmb3IgdGhlIGJhbmsuDQoNClNldCBhIGJhbmsncyBpbml0IHZhbHVlIGJh
c2VkIG9uIGlmIHRoZSBjb250cm9sIGJpdHMgYXJlIHNldCBvciBub3QgaW4NCmhhcmR3YXJlLg0K
DQpSZXR1cm4gYW4gZXJyb3IgY29kZSBpbiB0aGUgc3lzZnMgaW50ZXJmYWNlIGZvciB1bmluaXRp
YWxpemVkIGJhbmtzLg0KDQpTaWduZWQtb2ZmLWJ5OiBZYXplbiBHaGFubmFtIDx5YXplbi5naGFu
bmFtQGFtZC5jb20+DQotLS0NCkxpbms6DQpodHRwczovL2xrbWwua2VybmVsLm9yZy9yLzIwMTkw
NDExMjAxNzQzLjQzMTk1LTctWWF6ZW4uR2hhbm5hbUBhbWQuY29tDQoNCnYyLT52MzoNCiogTm8g
Y2hhbmdlLg0KDQp2MS0+djI6DQoqIE5ldyBpbiB2Mi4NCiogQmFzZWQgb24gZGlzY3Vzc2lvbiBm
cm9tIHYxIHBhdGNoIDIuDQoNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgfCA5ICsr
KysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNl
L2NvcmUuYw0KaW5kZXggNTUxMzY2YzE1NWVmLi5lNTk5NDdlMTBlZTAgMTAwNjQ0DQotLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUv
bWNlL2NvcmUuYw0KQEAgLTE1NzQsNiArMTU3NCw5IEBAIHN0YXRpYyB2b2lkIF9fbWNoZWNrX2Nw
dV9pbml0X2NsZWFyX2JhbmtzKHZvaWQpDQogDQogCQkvKiBTYXZlIGJpdHMgc2V0IGluIGhhcmR3
YXJlLiAqLw0KIAkJcmRtc3JsKG1zcl9vcHMuY3RsKGkpLCBiLT5jdGwpOw0KKw0KKwkJLyogQmFu
ayBpcyBpbml0aWFsaXplZCBpZiBiaXRzIGFyZSBzZXQgaW4gaGFyZHdhcmUuICovDQorCQliLT5p
bml0ID0gISFiLT5jdGw7DQogCX0NCiB9DQogDQpAQCAtMjA5OCw2ICsyMTAxLDkgQEAgc3RhdGlj
IHNzaXplX3Qgc2hvd19iYW5rKHN0cnVjdCBkZXZpY2UgKnMsIHN0cnVjdCBkZXZpY2VfYXR0cmli
dXRlICphdHRyLA0KIA0KIAliID0gJnBlcl9jcHUobWNlX2JhbmtzX3BlcmNwdSwgcy0+aWQpW2Jh
bmtdOw0KIA0KKwlpZiAoIWItPmluaXQpDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCiAJcmV0dXJu
IHNwcmludGYoYnVmLCAiJWxseFxuIiwgYi0+Y3RsKTsNCiB9DQogDQpAQCAtMjExNiw2ICsyMTIy
LDkgQEAgc3RhdGljIHNzaXplX3Qgc2V0X2Jhbmsoc3RydWN0IGRldmljZSAqcywgc3RydWN0IGRl
dmljZV9hdHRyaWJ1dGUgKmF0dHIsDQogDQogCWIgPSAmcGVyX2NwdShtY2VfYmFua3NfcGVyY3B1
LCBzLT5pZClbYmFua107DQogDQorCWlmICghYi0+aW5pdCkNCisJCXJldHVybiAtRU5PREVWOw0K
Kw0KIAliLT5jdGwgPSBuZXc7DQogCW1jZV9yZXN0YXJ0KCk7DQogDQotLSANCjIuMTcuMQ0KDQo=
