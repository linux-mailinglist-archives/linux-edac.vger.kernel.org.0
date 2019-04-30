Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D271100E0
	for <lists+linux-edac@lfdr.de>; Tue, 30 Apr 2019 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfD3UcZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Apr 2019 16:32:25 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:6224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbfD3UcZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 30 Apr 2019 16:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD3ugQJfSVQzD/52J6H9Em1T3JKtEV0Ci3cv4LcqBCc=;
 b=RTuMomPYoxprHyk4AthUKe/JCxZWwMBP2Oq9uP8BMrVDgTsJJ6AXbrPxiiKkqLO6Pr6MZj1yuNmsnvyOHbna+SQQ1YCILrGYoaGEL4bo2lBTZ8agfikUiMegceecwuTKaTJDy0vVQRfjF7iDHXzqg4m1Zcmp8iFVCwVP3Kuq8ow=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2640.namprd12.prod.outlook.com (52.135.103.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Tue, 30 Apr 2019 20:32:17 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d8ec:7415:96b0:afe0%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 20:32:17 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v3 0/6] Handle MCA banks in a per_cpu way
Thread-Topic: [PATCH v3 0/6] Handle MCA banks in a per_cpu way
Thread-Index: AQHU/5PNJFCEbWZlGkyIe/J7fxLz2g==
Date:   Tue, 30 Apr 2019 20:32:17 +0000
Message-ID: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 6c15f6df-0961-4ee6-e9d3-08d6cdaaefd2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2640;
x-ms-traffictypediagnostic: SN6PR12MB2640:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB2640F3D43A0E46DA3D623312F83A0@SN6PR12MB2640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(346002)(396003)(136003)(51444003)(199004)(189003)(14454004)(53936002)(4326008)(50226002)(1076003)(478600001)(6116002)(3846002)(97736004)(5640700003)(26005)(8676002)(66946007)(66476007)(6512007)(73956011)(2501003)(8936002)(316002)(6436002)(6306002)(66446008)(71200400001)(86362001)(81156014)(36756003)(71190400001)(81166006)(66556008)(64756008)(66066001)(6916009)(54906003)(486006)(15650500001)(68736007)(5660300002)(6506007)(305945005)(25786009)(256004)(14444005)(52116002)(7736002)(966005)(476003)(2906002)(72206003)(2616005)(2351001)(386003)(102836004)(186003)(99286004)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2640;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UCXQXh+o7uVYftdY912hjfg7zc5oRClPMQX3ozZ1sx0s4bzCRhnM3zTAFpfzmUmiJ7GF6xm/lDXkJOouQazy3PFejPkgZLM/fJbgR1mFJYDW1zaoQoYTrspdeiLH5WNJ+yLOHc1eFFfkUShqTKL/Xt9wVLuHlUNl97ZPEDldyYmIfSOS+xNXAkW3RL+r1MnpyeTJbjTEY4f+5p65LmPvKrAe//u1EZZgUlztn9yIDZUbDhR4yAnQQbp46GmIp9ir5ZAEClYfqBQ6WPYD3TqArdJCtAA7zVfH1O+97BIvIqzuHZrH5DXfyQ0SjqNAqSMVBEIMtwtMrDmLYDtPTs1fW+z6p4AOsSHzOoJPw9DynnbfBMSuqrzhJHrWREaj2XRPORFhwnX+o3JI7XfB5bXT0u05Df9KOuFxBD7EA0IdFp4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c15f6df-0961-4ee6-e9d3-08d6cdaaefd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 20:32:17.3927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2640
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

RnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KDQpUaGUgZm9jdXMg
b2YgdGhpcyBwYXRjaHNldCBpcyBkZWZpbmUgYW5kIHVzZSB0aGUgTUNBIGJhbmsgc3RydWN0dXJl
cw0KYW5kIGJhbmsgY291bnQgcGVyIGxvZ2ljYWwgQ1BVLg0KDQpXaXRoIHRoZSBleGNlcHRpb24g
b2YgcGF0Y2ggNCwgdGhpcyBzZXQgYXBwbGllcyB0byBzeXN0ZW1zIGluIHByb2R1Y3Rpb24NCnRv
ZGF5Lg0KDQpQYXRjaCAxOg0KTW92ZXMgdGhlIGRlY2xhcmF0aW9uIG9mIHN0cnVjdCBtY2VfYmFu
a3NbXSB0byB0aGUgb25seSBmaWxlIGl0J3MgdXNlZC4NCg0KUGF0Y2ggMjoNClNwbGl0cyBzdHJ1
Y3QgbWNlX2JhbmsgaW50byBhIHN0cnVjdHVyZSBmb3IgZmllbGRzIGNvbW1vbiB0byBNQ0EgYmFu
a3MNCm9uIGFsbCBDUFVzIGFuZCBhbm90aGVyIHN0cnVjdHVyZSB0aGF0IGNhbiBiZSB1c2VkIHBl
cl9jcHUuDQoNClBhdGNoIDM6DQpCcmluZ3MgZnVsbCBjaXJjbGUgdGhlIHNhZ2Egb2YgdGhlIHRo
cmVzaG9sZCBibG9jayBhZGRyZXNzZXMgb24gU01DQQ0Kc3lzdGVtcy4gQWZ0ZXIgdGFraW5nIGEg
c3RlcCBiYWNrIGFuZCByZXZpZXdpbmcgdGhlIEFNRCBkb2N1bWVudGF0aW9uLCBJDQp0aGluayB0
aGF0IHRoaXMgaW1wbGltZW50YXRpb24gaXMgdGhlIHNpbXBsZXN0IGFuZCBtb3JlIHJvYnVzdCB3
YXkgdG8NCmZvbGxvdyB0aGUgc3BlYy4NCg0KUGF0Y2ggNDoNClNhdmVzIGFuZCB1c2VzIHRoZSBN
Q0EgYmFuayBjb3VudCBhcyBhIHBlcl9jcHUgdmFyaWFibGUuIFRoaXMgaXMgdG8NCnN1cHBvcnQg
c3lzdGVtcyB0aGF0IGhhdmUgTUNBIGJhbmsgY291bnRzIHRoYXQgYXJlIGRpZmZlcmVudCBiZXR3
ZWVuDQpsb2dpY2FsIENQVXMuDQoNClBhdGNoIDU6DQpNYWtlcyBzdXJlIHRoYXQgc3lzZnMgcmVw
b3J0cyB0aGUgTUNBX0NUTCB2YWx1ZSBhcyBzZXQgaW4gaGFyZHdhcmUuIFRoaXMNCmlzIG5vdCBz
b21ldGhpbmcgcmVsYXRlZCB0byBtYWtpbmcgdGhpbmdzIHBlcl9jcHUgYnV0IHJhdGhlciBqdXN0
DQpzb21ldGhpbmcgSSBub3RpY2VkIHdoaWxlIHdvcmtpbmcgb24gdGhlIG90aGVyIHBhdGNoZXMu
DQoNClBhdGNoIDY6DQpQcmV2ZW50cyBzeXNmcyBhY2Nlc3MgZm9yIE1DQSBiYW5rcyB0aGF0IGFy
ZSB1bmluaXRpYWxpemVkLg0KDQpMaW5rOg0KaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5
MDQxMTIwMTc0My40MzE5NS0xLVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0KDQpUaGFua3MsDQpZYXpl
bg0KDQpZYXplbiBHaGFubmFtICg2KToNCiAgeDg2L01DRTogTWFrZSBzdHJ1Y3QgbWNlX2Jhbmtz
W10gc3RhdGljDQogIHg4Ni9NQ0U6IEhhbmRsZSBNQ0EgY29udHJvbHMgaW4gYSBwZXJfY3B1IHdh
eQ0KICB4ODYvTUNFL0FNRDogRG9uJ3QgY2FjaGUgYmxvY2sgYWRkcmVzc2VzIG9uIFNNQ0Egc3lz
dGVtcw0KICB4ODYvTUNFOiBNYWtlIG51bWJlciBvZiBNQ0EgYmFua3MgcGVyX2NwdQ0KICB4ODYv
TUNFOiBTYXZlIE1DQSBjb250cm9sIGJpdHMgdGhhdCBnZXQgc2V0IGluIGhhcmR3YXJlDQogIHg4
Ni9NQ0U6IFRyZWF0IE1DRSBiYW5rIGFzIGluaXRpYWxpemVkIGlmIGNvbnRyb2wgYml0cyBzZXQg
aW4gaGFyZHdhcmUNCg0KIGFyY2gveDg2L2tlcm5lbC9jcHUvbWNlL2FtZC5jICAgICAgfCAgOTAg
KysrKysrKysrKy0tLS0tLS0tLS0NCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgICAg
IHwgMTMxICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQogYXJjaC94ODYva2VybmVsL2Nw
dS9tY2UvaW50ZXJuYWwuaCB8ICAxMiArLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDE0MiBpbnNlcnRp
b25zKCspLCA5MSBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
