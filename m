Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658DB25707
	for <lists+linux-edac@lfdr.de>; Tue, 21 May 2019 19:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfEURwt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 May 2019 13:52:49 -0400
Received: from mail-eopbgr690043.outbound.protection.outlook.com ([40.107.69.43]:34048
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEURwt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 21 May 2019 13:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/pClZy0EjSqnXLwz19lmcEC4A/dWyUxWqRKSy4E4Ac=;
 b=D/4OBuWJ0CoQPMEQ12URtZsYabxAkAPKCXgau7viW1NDStd5xaL9sI5831vmSblemKJIy3GWVm1x75FBV6WCVvID1VxnKV6TA7oxRzPNa2KO73cmkdYY7UMOc0oq0Aq56qKVneHZaBAR3XDdz6P72xjCFpC1gNgfi/mN6wueluU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2656.namprd12.prod.outlook.com (52.135.103.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Tue, 21 May 2019 17:52:42 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 17:52:42 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Thread-Topic: [PATCH v3 4/6] x86/MCE: Make number of MCA banks per_cpu
Thread-Index: AQHU/5PPM7ZBD2KPAEGkkqngr+ktbaZw2aaAgAT1zzA=
Date:   Tue, 21 May 2019 17:52:42 +0000
Message-ID: <SN6PR12MB2639571E33EBC7342A0607F8F8070@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190430203206.104163-1-Yazen.Ghannam@amd.com>
 <20190430203206.104163-5-Yazen.Ghannam@amd.com>
 <20190518112530.GA26276@zn.tnic>
In-Reply-To: <20190518112530.GA26276@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b60b98b3-f265-4e8f-c6e3-08d6de151fb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2656;
x-ms-traffictypediagnostic: SN6PR12MB2656:
x-microsoft-antispam-prvs: <SN6PR12MB2656065392E10E6D71AA71DFF8070@SN6PR12MB2656.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(136003)(346002)(189003)(199004)(13464003)(86362001)(6436002)(15650500001)(305945005)(68736007)(72206003)(54906003)(53936002)(14454004)(55016002)(9686003)(7736002)(73956011)(33656002)(256004)(81166006)(81156014)(8936002)(2906002)(71190400001)(71200400001)(8676002)(186003)(26005)(6916009)(446003)(76116006)(14444005)(229853002)(11346002)(478600001)(66946007)(486006)(476003)(74316002)(4326008)(76176011)(7696005)(64756008)(66446008)(66476007)(66556008)(6116002)(102836004)(25786009)(316002)(99286004)(52536014)(66066001)(5660300002)(6506007)(3846002)(53546011)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2656;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Ea0dr0cFUp1wHVSk1cZ1SG+ctdIJVPYM0gIxumL3w6G1bi1/BqcLv8osu3jO4rUMNpGkW1M6l7fNXWIavmekjnK3+fF4ld+Z+1Os+CI86MwLX4KtscYIRkYlztNf7EaWzm57Rwkt5FoIROD/T9IagEwl4EpqW1s1+f2A5nDKHxayqF67b2PJ1+9aduUntjlZLMv7it8lH3br8XUj8WVgMLw/bskXryfhpHTQ8Oo4/MrY9tlDLlokg5qGsWh58p5iYNRkwWCauscKKqJL1vmm8gMimwUavLMq2GsolToCQdn5JYX/bt5kP2GIlaVVD/TecVshfNTxg4cV9AlDO8OvbvyFq4u39Vpk1h0kumo/7zZTR0alIPCfWZN7DuttiElakiAzb45MCi+sV/8mh2aTXujLIw7EWb05LSDbohVFf4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60b98b3-f265-4e8f-c6e3-08d6de151fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 17:52:42.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2656
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogU2F0dXJkYXksIE1heSAxOCwgMjAxOSA2OjI2IEFNDQo+IFRv
OiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGJwQHN1c2Uu
ZGU7IHRvbnkubHVja0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjMgNC82XSB4ODYvTUNFOiBNYWtlIG51bWJlciBvZiBNQ0EgYmFua3MgcGVyX2NwdQ0K
PiANCj4gDQo+IE9uIFR1ZSwgQXByIDMwLCAyMDE5IGF0IDA4OjMyOjIwUE0gKzAwMDAsIEdoYW5u
YW0sIFlhemVuIHdyb3RlOg0KPiA+IEZyb206IFlhemVuIEdoYW5uYW0gPHlhemVuLmdoYW5uYW1A
YW1kLmNvbT4NCj4gPg0KPiA+IFRoZSBudW1iZXIgb2YgTUNBIGJhbmtzIGlzIHByb3ZpZGVkIHBl
ciBsb2dpY2FsIENQVS4gSGlzdG9yaWNhbGx5LCB0aGlzDQo+ID4gbnVtYmVyIGhhcyBiZWVuIHRo
ZSBzYW1lIGFjcm9zcyBhbGwgQ1BVcywgYnV0IHRoaXMgaXMgbm90IGFuDQo+ID4gYXJjaGl0ZWN0
dXJhbCBndWFyYW50ZWUuIEZ1dHVyZSBBTUQgc3lzdGVtcyBtYXkgaGF2ZSBNQ0EgYmFuayBjb3Vu
dHMNCj4gPiB0aGF0IHZhcnkgYmV0d2VlbiBsb2dpY2FsIENQVXMgaW4gYSBzeXN0ZW0uDQo+ID4N
Cj4gPiBUaGlzIGlzc3VlIHdhcyBwYXJ0aWFsbHkgYWRkcmVzc2VkIGluDQo+ID4NCj4gPiAwMDZj
MDc3MDQxZGMgKCJ4ODYvbWNlOiBIYW5kbGUgdmFyeWluZyBNQ0EgYmFuayBjb3VudHMiKQ0KPiA+
DQo+ID4gYnkgYWxsb2NhdGluZyBzdHJ1Y3R1cmVzIHVzaW5nIHRoZSBtYXhpbXVtIG51bWJlciBv
ZiBNQ0EgYmFua3MgYW5kIGJ5DQo+ID4gc2F2aW5nIHRoZSBtYXhpbXVtIE1DQSBiYW5rIGNvdW50
IGluIGEgc3lzdGVtIGFzIHRoZSBnbG9iYWwgY291bnQuIFRoaXMNCj4gPiBtZWFucyB0aGF0IHNv
bWUgZXh0cmEgc3RydWN0dXJlcyBhcmUgYWxsb2NhdGVkLiBBbHNvLCB0aGlzIG1lYW5zIHRoYXQN
Cj4gPiBDUFVzIHdpbGwgc3BlbmQgbW9yZSB0aW1lIGluIHRoZSAjTUMgYW5kIG90aGVyIGhhbmRs
ZXJzIGNoZWNraW5nIGV4dHJhDQo+ID4gTUNBIGJhbmtzLg0KPiANCj4gLi4uDQo+IA0KPiA+IEBA
IC0xNDgwLDE0ICsxNDgyLDE1IEBAIEVYUE9SVF9TWU1CT0xfR1BMKG1jZV9ub3RpZnlfaXJxKTsN
Cj4gPg0KPiA+ICBzdGF0aWMgaW50IF9fbWNoZWNrX2NwdV9tY2VfYmFua3NfaW5pdCh2b2lkKQ0K
PiA+ICB7DQo+ID4gKyAgICAgdTggbl9iYW5rcyA9IHRoaXNfY3B1X3JlYWQobWNlX251bV9iYW5r
cyk7DQo+ID4gICAgICAgc3RydWN0IG1jZV9iYW5rICptY2VfYmFua3M7DQo+ID4gICAgICAgaW50
IGk7DQo+ID4NCj4gPiAtICAgICBtY2VfYmFua3MgPSBrY2FsbG9jKE1BWF9OUl9CQU5LUywgc2l6
ZW9mKHN0cnVjdCBtY2VfYmFuayksIEdGUF9LRVJORUwpOw0KPiA+ICsgICAgIG1jZV9iYW5rcyA9
IGtjYWxsb2Mobl9iYW5rcywgc2l6ZW9mKHN0cnVjdCBtY2VfYmFuayksIEdGUF9LRVJORUwpOw0K
PiANCj4gU29tZXRoaW5nIGNoYW5nZWQgaW4gbW0gbGFuZCBvciBtYXliZSB3ZSB3ZXJlIGx1Y2t5
IGFuZCBnb3QgYXdheSB3aXRoIGFuDQo+IGF0b21pYyBHRlBfS0VSTkVMIGFsbG9jYXRpb24gdW50
aWwgbm93IGJ1dDoNCj4gDQo+IFsgICAgMi40NDc4MzhdIHNtcDogQnJpbmdpbmcgdXAgc2Vjb25k
YXJ5IENQVXMgLi4uDQo+IFsgICAgMi40NTY4OTVdIHg4NjogQm9vdGluZyBTTVAgY29uZmlndXJh
dGlvbjoNCj4gWyAgICAyLjQ1NzgyMl0gLi4uLiBub2RlICAjMCwgQ1BVczogICAgICAgICMxDQoN
ClRoZSBpc3N1ZSBzZWVtcyB0byBiZSB0aGF0IHRoZSBhbGxvY2F0aW9uIGlzIG5vdyBoYXBwZW5p
bmcgb24gQ1BVcyBvdGhlciB0aGFuIENQVTAuDQoNClBhdGNoIDIgaW4gdGhpcyBzZXQgaGFzIHRo
ZSBzYW1lIGlzc3VlLiBJIGRpZG4ndCBzZWUgaXQgdW50aWwgSSB0dXJuZWQgb24gdGhlICJMb2Nr
IERlYnVnZ2luZyIgY29uZmlnIG9wdGlvbnMuDQoNCj4gWyAgICAxLjM0NDI4NF0gQlVHOiBzbGVl
cGluZyBmdW5jdGlvbiBjYWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQgYXQgbW0vc2xhYi5oOjQx
OA0KDQpUaGlzIG1lc3NhZ2UgY29tZXMgZnJvbSBfX19taWdodF9zbGVlcCgpIHdoaWNoIGNoZWNr
cyB0aGUgc3lzdGVtX3N0YXRlLg0KDQpPbiBDUFUwLCBzeXN0ZW1fc3RhdGU9U1lTVEVNX0JPT1RJ
TkcuDQoNCk9uIGV2ZXJ5IG90aGVyIENQVSwgc3lzdGVtX3N0YXRlPVNZU1RFTV9TQ0hFRFVMSU5H
LCBhbmQgdGhhdCdzIHRoZSBvbmx5IHN5c3RlbV9zdGF0ZSB3aGVyZSB0aGUgbWVzc2FnZSBpcyBz
aG93bi4NCg0KQ2hhbmdpbmcgR0ZQX0tFUk5FTCB0byBHRlBfQVRPTUlDIHNlZW1zIHRvIGJlIGEg
Zml4LiBJcyB0aGlzIGFwcHJvcHJpYXRlPyBPciBkbyB5b3UgdGhpbmsgdGhlcmUncyBzb21ldGhp
bmcgZWxzZSB3ZSBjb3VsZCB0cnk/DQoNClRoYW5rcywNCllhemVuDQoNCg==
