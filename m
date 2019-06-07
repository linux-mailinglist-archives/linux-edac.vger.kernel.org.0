Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4313396A0
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbfFGUSG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 16:18:06 -0400
Received: from mail-eopbgr800079.outbound.protection.outlook.com ([40.107.80.79]:26017
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729153AbfFGUSG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 16:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fkq2b4K2JVB93Su32TlmJp6P32s+wACtLQikYvy+1E4=;
 b=X60UPyi14POPxmyxjwzftCnf/V7q/XQ4Vaxd9YnBfpThmhzJMbZEXZ2R8P+oKIyGnEtONIeixKDcDbo6oQam5db8l+is3yYphAC4qex/Gi5Q5vaIQjsvDkbO2rH4oX1Fhx4DAu3TUkErqEpu/hKExSFsOrYKCdZqkzyYs25U3Z4=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2704.namprd12.prod.outlook.com (52.135.103.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Fri, 7 Jun 2019 20:18:03 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 20:18:03 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH v4 0/5] Handle MCA banks in a per_cpu way
Thread-Topic: [PATCH v4 0/5] Handle MCA banks in a per_cpu way
Thread-Index: AQHVHW4cjHX2z5/X4UaDgJ2Dfh4dxA==
Date:   Fri, 7 Jun 2019 20:18:03 +0000
Message-ID: <20190607201752.221446-1-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: 1fcf2f90-da48-4f4b-f3e3-08d6eb853e82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2704;
x-ms-traffictypediagnostic: SN6PR12MB2704:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <SN6PR12MB27042CD572D8116B5A8B7650F8100@SN6PR12MB2704.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(189003)(51444003)(199004)(6486002)(6436002)(72206003)(5640700003)(316002)(966005)(186003)(15650500001)(26005)(478600001)(4326008)(6306002)(68736007)(66946007)(6512007)(25786009)(73956011)(64756008)(66476007)(66556008)(66446008)(486006)(53936002)(2616005)(14454004)(476003)(66066001)(5660300002)(52116002)(256004)(2501003)(305945005)(2351001)(102836004)(386003)(71190400001)(71200400001)(6506007)(3846002)(6116002)(7736002)(81166006)(36756003)(6916009)(81156014)(8676002)(8936002)(1076003)(50226002)(99286004)(54906003)(86362001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2704;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: isl3y0/+9shq94dleqp9x0JbUaT6cb1oFWl7LKnkSEzKuPXtBWGriTnyHLvYH22mMnSKpkpWjbekQH/Hcz60SFpS7ltx1Mnw95FXpH/NFEvIwml9+yrM0QJvu5W2fOLXIKYyO2ifzrvnNicKviGRmcwRrk6xHO869kmK7pcXpoaoa0LdIvQcD3+Ei5zRIa8jam6QelK4iHMo5/sX8tvRgrkNN5F0NW2qa3TnydvrVfeyzRIw+IEqQRFQq6W6EzQIb/zuGyKKmyYrC+G08BYuPnoI6e0MjDbNu5xvStv3fzKb4bbDHDo5/NqevPSyqWaZ5zKdfBUZO57Kj1MQ41mrZCVmfDKVbv85To+vBpYYSLYVMNHZ7M9/FE9pR9K6NkHAoDG18TEm2vxdiCqvDUqgw+XYGb+7c5j/za5pOUcGHFo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcf2f90-da48-4f4b-f3e3-08d6eb853e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 20:18:03.3979
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
ZWVuDQpsb2dpY2FsIENQVXMuDQoNClBhdGNoIDU6DQpDaGVja3MgaWYgYW4gTUNBIGJhbmtzIGlz
IGVuYWJsZWQgYWZ0ZXIgaW5pdGlhbGl6YXRpb24uDQoNCkxpbms6DQpodHRwczovL2xrbWwua2Vy
bmVsLm9yZy9yLzIwMTkwNDMwMjAzMjA2LjEwNDE2My0xLVlhemVuLkdoYW5uYW1AYW1kLmNvbQ0K
DQpUaGFua3MsDQpZYXplbg0KDQpZYXplbiBHaGFubmFtICg1KToNCiAgeDg2L01DRTogTWFrZSBz
dHJ1Y3QgbWNlX2JhbmtzW10gc3RhdGljDQogIHg4Ni9NQ0U6IE1ha2UgbWNlX2JhbmtzIGEgcGVy
LUNQVSBhcnJheQ0KICB4ODYvTUNFL0FNRDogRG9uJ3QgY2FjaGUgYmxvY2sgYWRkcmVzc2VzIG9u
IFNNQ0Egc3lzdGVtcw0KICB4ODYvTUNFOiBNYWtlIHRoZSBudW1iZXIgb2YgTUNBIGJhbmtzIGEg
cGVyLUNQVSB2YXJpYWJsZQ0KICB4ODYvTUNFOiBEZXRlcm1pbmUgTUNBIGJhbmtzJyBpbml0IHN0
YXRlIHByb3Blcmx5DQoNCiBhcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9hbWQuYyAgICAgIHwgIDky
ICsrKysrKysrKy0tLS0tLS0tDQogYXJjaC94ODYva2VybmVsL2NwdS9tY2UvY29yZS5jICAgICB8
IDE2MSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGFyY2gveDg2L2tlcm5lbC9jcHUv
bWNlL2ludGVybmFsLmggfCAgMTIgKy0tDQogMyBmaWxlcyBjaGFuZ2VkLCAxNjUgaW5zZXJ0aW9u
cygrKSwgMTAwIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMTcuMQ0KDQo=
