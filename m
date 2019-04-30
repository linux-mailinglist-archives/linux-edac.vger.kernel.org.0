Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5CC100EA
	for <lists+linux-edac@lfdr.de>; Tue, 30 Apr 2019 22:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfD3Uct (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Apr 2019 16:32:49 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:6224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbfD3Uch (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Apr 2019 16:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5CKjJBrz2LHNKTV4PoytwaQ+HW4g42EXd2/V050jE8=;
 b=t29sUEsdPstrsRyxy8WtYL+MY5M6hftAcbZzR+u4VmpkWicDkbOn/EDn2ckOPIbG3gpJxKGjyfrFkwBuNi3HLzWfNpU5FXzbwehBAziD7IcrgDbZiLccl/4AUIDbauzGAkL4xaNGlvUWWMoyGLDdyhPS0RjhnJxBAPxLQRSa45M=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 20:32:21 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 20:32:21 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpA==
Date:   Tue, 30 Apr 2019 20:32:20 +0000
Message-ID: <20190430203206.104163-6-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 5575229e-bc3e-4f87-d579-08d6cdaaf1dc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2640F4174292B3824F6A21F7F83A0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(14454004)(53936002)(4326008)(50226002)(1076003)(478600001)(6116002)(3846002)(97736004)(5640700003)(26005)(8676002)(66946007)(66476007)(6512007)(73956011)(2501003)(8936002)(316002)(6436002)(6306002)(66446008)(71200400001)(86362001)(81156014)(36756003)(71190400001)(81166006)(66556008)(64756008)(66066001)(6916009)(54906003)(486006)(68736007)(5660300002)(6506007)(76176011)(305945005)(25786009)(256004)(52116002)(7736002)(966005)(476003)(2906002)(446003)(72206003)(11346002)(2616005)(2351001)(386003)(102836004)(186003)(99286004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rk3P/GnxWQNtTezWDyDbtwV8TtJo1vqXDjKZYqVhs73fN1BJ9ENXTMR1jjGOlnHwzpQvHFb5qXuIPsKewU8nXQ4pxXmbTGYpbmRfrD7SxIDhPqZaSE2HYhIJ33Trsj82wygLfuuhJggYWjlbF6/x7VWd1c6Icc64VeDRUvLnNeurnSWC9WjtTK5BsEcfSBR+D2M++Cf2CtDQtcso+stvwusR8oVl44oknZRhegTQp4Hj13N24SYHvyN96H8IP+/IGsFdrN6S1ZwgdFJ1xnxm3HKs9guTTiTJO9SFB3V8UuRpO6yoJttRrzXGdW9FLUZJoe6tEgKlQVqpaLIp7jTSyY3tw8AEIrgQiErsjt4As9k7wLcMZM8XIBnrIfCrxqhEhbK4dcWtwHWDO2m2Ecyh5msrhcUX5PTO5KjfSZLfNpU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5575229e-bc3e-4f87-d579-08d6cdaaf1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:32:20.8181
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
ZXhwZWN0ZWQgdG8gd3JpdGUgYWxsIGJpdHMgaW4gTUNBX0NUTC4gSG93ZXZlciwgb25seQ0KaW1w
bGVtZW50ZWQgYml0cyBnZXQgc2V0IGluIHRoZSBoYXJkd2FyZS4NCg0KUmVhZCBiYWNrIE1DQV9D
VEwgc28gdGhhdCB0aGUgdmFsdWUgaW4gdGhlIGhhcmR3YXJlIGlzIHNhdmVkIGFuZA0KcmVwb3J0
ZWQgdGhyb3VnaCBzeXNmcy4NCg0KU2lnbmVkLW9mZi1ieTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4u
Z2hhbm5hbUBhbWQuY29tPg0KLS0tDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8y
MDE5MDQxMTIwMTc0My40MzE5NS02LVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQp2Mi0+djM6DQoq
IE5vIGNoYW5nZS4NCg0KdjEtPnYyOg0KKiBObyBjaGFuZ2UuDQoNCiBhcmNoL3g4Ni9rZXJuZWwv
Y3B1L21jZS9jb3JlLmMgfCAxNSArKysrKysrKysrLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tl
cm5lbC9jcHUvbWNlL2NvcmUuYyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KaW5k
ZXggOTg2ZGU4MzBmMjZlLi41NTEzNjZjMTU1ZWYgMTAwNjQ0DQotLS0gYS9hcmNoL3g4Ni9rZXJu
ZWwvY3B1L21jZS9jb3JlLmMNCisrKyBiL2FyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0K
QEAgLTE1NjcsMTAgKzE1NjcsMTMgQEAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfY2xl
YXJfYmFua3Modm9pZCkNCiAJZm9yIChpID0gMDsgaSA8IHRoaXNfY3B1X3JlYWQobWNlX251bV9i
YW5rcyk7IGkrKykgew0KIAkJc3RydWN0IG1jZV9iYW5rICpiID0gJm1jZV9iYW5rc1tpXTsNCiAN
Ci0JCWlmICghYi0+aW5pdCkNCi0JCQljb250aW51ZTsNCi0JCXdybXNybChtc3Jfb3BzLmN0bChp
KSwgYi0+Y3RsKTsNCi0JCXdybXNybChtc3Jfb3BzLnN0YXR1cyhpKSwgMCk7DQorCQlpZiAoYi0+
aW5pdCkgew0KKwkJCXdybXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCisJCQl3cm1zcmwo
bXNyX29wcy5zdGF0dXMoaSksIDApOw0KKwkJfQ0KKw0KKwkJLyogU2F2ZSBiaXRzIHNldCBpbiBo
YXJkd2FyZS4gKi8NCisJCXJkbXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCiAJfQ0KIH0N
CiANCkBAIC0yMzI1LDggKzIzMjgsMTAgQEAgc3RhdGljIHZvaWQgbWNlX3JlZW5hYmxlX2NwdSh2
b2lkKQ0KIAlmb3IgKGkgPSAwOyBpIDwgdGhpc19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKTsgaSsr
KSB7DQogCQlzdHJ1Y3QgbWNlX2JhbmsgKmIgPSAmbWNlX2JhbmtzW2ldOw0KIA0KLQkJaWYgKGIt
PmluaXQpDQorCQlpZiAoYi0+aW5pdCkgew0KIAkJCXdybXNybChtc3Jfb3BzLmN0bChpKSwgYi0+
Y3RsKTsNCisJCQlyZG1zcmwobXNyX29wcy5jdGwoaSksIGItPmN0bCk7DQorCQl9DQogCX0NCiB9
DQogDQotLSANCjIuMTcuMQ0KDQo=
