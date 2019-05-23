Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C662F28B2B
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbfEWUAn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 16:00:43 -0400
Received: from mail-eopbgr810059.outbound.protection.outlook.com ([40.107.81.59]:10472
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387469AbfEWUAm (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 16:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzQ+C5BNyZQblp4VqwVeiJfPTis+U4556bS/MxPh8gg=;
 b=Syl3x+UbzpnXM2A2ndiJ0Z5oKg78RzMIEMoJ/4XYXEMgZsPfG0FDWW+Gk45C81ZJA31eHrqoT6p8TjCcPFvYbwvEM82Bltg85kMuBZjSyL+1dprSWEi59R+s0lSPoLvOsj0WnW+/FanS3amOViTazpQWi/3LS6GSxUQvixm8RPs=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2783.namprd12.prod.outlook.com (52.135.107.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 20:00:33 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 20:00:33 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUwgAAal4CAAA3JgIAABf+AgAAE/ICAABizgIAAAygAgAAEo4CACWuboA==
Date:   Thu, 23 May 2019 20:00:33 +0000
Message-ID: <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190516203456.GD21857@zn.tnic>
 <20190516205943.GA3299@agluck-desk> <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic> <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic> <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
In-Reply-To: <20190517200225.GK13482@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5eff128d-c393-4ce4-3b69-08d6dfb950cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2783;
x-ms-traffictypediagnostic: SN6PR12MB2783:
x-microsoft-antispam-prvs: <SN6PR12MB2783CF61966CCBCF52B9D07AF8010@SN6PR12MB2783.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(199004)(13464003)(189003)(102836004)(53546011)(6506007)(14454004)(76176011)(316002)(229853002)(6916009)(478600001)(72206003)(486006)(55016002)(74316002)(2906002)(68736007)(66476007)(66556008)(64756008)(66946007)(66446008)(5660300002)(73956011)(54906003)(26005)(9686003)(11346002)(446003)(476003)(33656002)(186003)(76116006)(52536014)(86362001)(6246003)(25786009)(53936002)(8936002)(81166006)(256004)(81156014)(71200400001)(7696005)(305945005)(6116002)(66066001)(71190400001)(4326008)(8676002)(6436002)(7736002)(3846002)(99286004)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2783;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Xj5idhx/G5cFM/dpm2raYHZfV1XqGkmRxCC+1/09bnqT4XcYrkd8htmODtAkp9xbk9mwwb6FXBju/1w93f15EkPFafJTKuTZHd2UxW+5bWqlGd9uwR9YWoGaAHeXLrbg5KqxVD93grgJRW7exV3Sr+7XW1qC9BUvOZKIhYq/kdpXa3ssDHFNFiFf7kuVFip3toxb9Odw4sdrBoD3LqK4M3Dcn03ADSRcO6hzdgDj6/oG4Ou917RAn6sAMSpCfKHx4caRoy/g1Fowruv/N98jPy2e2NAaC+Kw9vIqlgoDtLOYr/AhLgKt9KRIF2gCouScyBhrPZHGAo0UPH1kNZ9HMMRD6B6NFJDXe6OcIFXsveU2Ix6yLVTG6SXpigeIROnddDquEmFxdZwd/hgZgThYXTy0GQhX6JDjGCveu31x4xc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eff128d-c393-4ce4-3b69-08d6dfb950cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 20:00:33.6275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2783
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMTkgMzowMiBQTQ0KPiBUbzog
R2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IEx1Y2ssIFRvbnkg
PHRvbnkubHVja0BpbnRlbC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0IGdldCBzZXQg
aW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBPbiBGcmksIE1heSAxNywgMjAxOSBhdCAwNzo0OToxMFBN
ICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiA+IEBAIC0xNTY5LDcgKzE1NzUsMTMg
QEAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfY2xlYXJfYmFua3Modm9pZCkNCj4gPiA+
DQo+ID4gPiAgICAgICAgICAgICAgICAgaWYgKCFiLT5pbml0KQ0KPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgY29udGludWU7DQo+ID4gPiArDQo+ID4gPiArICAgICAgICAgICAgICAgLyog
Q2hlY2sgaWYgYW55IGJpdHMgYXJlIGltcGxlbWVudGVkIGluIGgvdyAqLw0KPiA+ID4gICAgICAg
ICAgICAgICAgIHdybXNybChtc3Jfb3BzLmN0bChpKSwgYi0+Y3RsKTsNCj4gPiA+ICsgICAgICAg
ICAgICAgICByZG1zcmwobXNyX29wcy5jdGwoaSksIG1zcnZhbCk7DQo+ID4gPiArDQo+ID4gPiAr
ICAgICAgICAgICAgICAgYi0+aW5pdCA9ICEhbXNydmFsOw0KPiA+ID4gKw0KPiA+IEp1c3QgYSBt
aW5vciBuaXQsIGJ1dCBjYW4gd2UgZ3JvdXAgdGhlIGNvbW1lbnQsIFJETVNSLCBhbmQgY2hlY2sN
Cj4gPiB0b2dldGhlcj8gVGhlIFdSTVNSIGlzIHBhcnQgb2Ygbm9ybWFsIG9wZXJhdGlvbiBhbmQg
aXNuJ3QgdGllZCB0byB0aGUNCj4gPiBjaGVjay4NCj4gDQo+IE9mIGNvdXJzZSBpdCBpcyAtIHRo
YXQncyB0aGUgInRocm93IGFsbCAxcyBhdCBpdCIgcGFydCA6KQ0KPiANCg0KSSBkaWQgYSBiaXQg
bW9yZSB0ZXN0aW5nIGFuZCBJIG5vdGljZWQgdGhhdCB3cml0aW5nICIwIiBkaXNhYmxlcyBhIGJh
bmsgd2l0aCBubyB3YXkgdG8gcmVlbmFibGUgaXQuDQoNCkZvciBleGFtcGxlOg0KMSkgUmVhZCBi
YW5rMTAuDQoJYSkgU3VjY2VlZHM7IHJldHVybnMgImZmZmZmZmZmZmZmZmZmZiIuDQoyKSBXcml0
ZSAiMCIgdG8gYmFuazEwLg0KCWEpIFN1Y2NlZWRzOyBoYXJkd2FyZSByZWdpc3RlciBpcyBzZXQg
dG8gIjAiLg0KCWIpIEhhcmR3YXJlIHJlZ2lzdGVyIGlzIGNoZWNrZWQsIGFuZCBiLT5pbml0PTAu
DQozKSBSZWFkIGJhbmsxMC4NCglhKSBGYWlscywgYmVjYXVzZSBiLT5pbml0PTAuDQo0KSBXcml0
ZSBub24temVybyB2YWx1ZSB0byBiYW5rMTAgdG8gcmVlbmFibGUgaXQuDQoJYSkgRmFpbHMsIGJl
Y2F1c2UgYi0+aW5pdD0wLg0KNSkgUmVib290IG5lZWRlZCB0byByZXNldCBiYW5rLg0KDQpJcyB0
aGF0IG9rYXk/DQoNClRoYW5rcywNCllhemVuDQo=
