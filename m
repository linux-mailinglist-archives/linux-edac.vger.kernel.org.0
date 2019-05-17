Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2C621EC4
	for <lists+linux-edac@lfdr.de>; Fri, 17 May 2019 21:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfEQTtQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 May 2019 15:49:16 -0400
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:44221
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727183AbfEQTtP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 May 2019 15:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHUI0wqEuX71E/sEHHAQ7A+pgNmrLELpCmC7T5NorFU=;
 b=hU7nDQHhYM2Bntb0drr+tGDxb1mk3YU5wGGjlc35TraZR1/tQDDLSUXFgfCkrSPNuL6cHnqdLVqTWwsO9/2lbF/pSXXogk3RvbzoYcYhKRKz0hyYAak0zNr1Q+x80fIesnaLhPUWsZNtCg0ZUcaI0uHTX6x+WELDGqlyiYeuceg=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2685.namprd12.prod.outlook.com (52.135.103.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 19:49:10 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1900.010; Fri, 17 May 2019
 19:49:10 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Topic: [PATCH v3 5/6] x86/MCE: Save MCA control bits that get set in
 hardware
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUwgAAal4CAAA3JgIAABf+AgAAE/ICAABizgIAAAygA
Date:   Fri, 17 May 2019 19:49:10 +0000
Message-ID: <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190516172117.GC21857@zn.tnic>
 <SN6PR12MB26394CD4E1BAC068B0B1AEF6F80A0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190516203456.GD21857@zn.tnic> <20190516205943.GA3299@agluck-desk>
 <20190517101006.GA32065@zn.tnic>
 <SN6PR12MB26391A0C3979030082EE38F8F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517163729.GE13482@zn.tnic> <20190517172648.GA18164@agluck-desk>
 <20190517174817.GG13482@zn.tnic> <20190517180607.GA21710@agluck-desk>
 <20190517193431.GI13482@zn.tnic>
In-Reply-To: <20190517193431.GI13482@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [75.66.99.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c981d21-edb2-4126-53d1-08d6db00bb2a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2685;
x-ms-traffictypediagnostic: SN6PR12MB2685:
x-microsoft-antispam-prvs: <SN6PR12MB26850E65E74615FD9C9E0B9DF80B0@SN6PR12MB2685.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39850400004)(366004)(13464003)(189003)(199004)(54906003)(110136005)(66446008)(68736007)(99286004)(66946007)(76176011)(256004)(64756008)(66556008)(76116006)(66476007)(73956011)(7696005)(7736002)(229853002)(9686003)(55016002)(81166006)(8936002)(33656002)(71190400001)(71200400001)(81156014)(305945005)(8676002)(6436002)(316002)(6116002)(486006)(476003)(25786009)(11346002)(446003)(6246003)(14454004)(52536014)(53936002)(3846002)(4326008)(74316002)(102836004)(53546011)(6506007)(66066001)(478600001)(26005)(186003)(5660300002)(2906002)(72206003)(86362001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2685;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: INIoVFAeS9+T25pDhCZU1G5zNCtVS+kFhUXk5KgH+il622lg+hU5+Lwzsj+BQ6gXz0hAtp29utRqWX383NtBDGl/aPNzDF80eBCv6DeCQyoZYgAPqw+yynvEaoOI65Akpe47BG3g8N1PTXWGWfXgc2wxV1/INFwbZUYY3cBa9oGrpn6ovTW0h8tqwwNkFXtbMCpKQAZ4/NOrN5k+dwWD6uZQPIKzuAzfuDhLdl4y3AdQzLMRl7BP4BO9rqvmX8p2feZE6QJqzn5MLnfDiQl6ZJ3LNwDepLLiQisGA0oVjnDPQMQtqX6YCO473PGj6rVg3h4M9zHw5PEuDLjXCg+uP3sMUDRtE7XLcNHo6LatvQ48GYXtkemc1yMZeWpnppAyiBMOPUk498UADsZVabEQ/yqGEEaYcYiUfv/qmd5FNAI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c981d21-edb2-4126-53d1-08d6db00bb2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 19:49:10.4690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2685
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBNYXkgMTcsIDIwMTkgMjozNSBQ
TQ0KPiBUbzogTHVjaywgVG9ueSA8dG9ueS5sdWNrQGludGVsLmNvbT4NCj4gQ2M6IEdoYW5uYW0s
IFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+OyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2MyA1LzZdIHg4Ni9NQ0U6IFNhdmUgTUNBIGNvbnRyb2wgYml0cyB0aGF0
IGdldCBzZXQgaW4gaGFyZHdhcmUNCj4gDQo+IA0KPiBPbiBGcmksIE1heSAxNywgMjAxOSBhdCAx
MTowNjowN0FNIC0wNzAwLCBMdWNrLCBUb255IHdyb3RlOg0KPiA+IGFuZCB0aHVzIGVuZCB1cCB3
aXRoIHRoYXQgZXh0cmEgbGV2ZWwgb24gaW5kZW50IGZvciB0aGUgcmVzdA0KPiA+IG9mIHRoZSBm
dW5jdGlvbi4NCj4gDQo+IE9rOg0KPiANCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L21jZS9jb3JlLmMgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMNCj4g
aW5kZXggNWJjZWNhZGNmNGQ5Li4yNWU1MDFhODUzY2QgMTAwNjQ0DQo+IC0tLSBhL2FyY2gveDg2
L2tlcm5lbC9jcHUvbWNlL2NvcmUuYw0KPiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS9j
b3JlLmMNCj4gQEAgLTE0OTMsNiArMTQ5MywxMSBAQCBzdGF0aWMgaW50IF9fbWNoZWNrX2NwdV9t
Y2VfYmFua3NfaW5pdCh2b2lkKQ0KPiAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBuX2JhbmtzOyBp
KyspIHsNCj4gICAgICAgICAgICAgICAgIHN0cnVjdCBtY2VfYmFuayAqYiA9ICZtY2VfYmFua3Nb
aV07DQo+IA0KPiArICAgICAgICAgICAgICAgLyoNCj4gKyAgICAgICAgICAgICAgICAqIEluaXQg
dGhlbSBhbGwsIF9fbWNoZWNrX2NwdV9hcHBseV9xdWlya3MoKSBpcyBnb2luZyB0byBhcHBseQ0K
PiArICAgICAgICAgICAgICAgICogdGhlIHJlcXVpcmVkIHZlbmRvciBxdWlya3MgYmVmb3JlDQo+
ICsgICAgICAgICAgICAgICAgKiBfX21jaGVja19jcHVfaW5pdF9jbGVhcl9iYW5rcygpIGRvZXMg
dGhlIGZpbmFsIGJhbmsgc2V0dXAuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gICAgICAgICAg
ICAgICAgIGItPmN0bCA9IC0xVUxMOw0KPiAgICAgICAgICAgICAgICAgYi0+aW5pdCA9IDE7DQo+
ICAgICAgICAgfQ0KPiBAQCAtMTU2Miw2ICsxNTY3LDcgQEAgc3RhdGljIHZvaWQgX19tY2hlY2tf
Y3B1X2luaXRfZ2VuZXJpYyh2b2lkKQ0KPiAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRf
Y2xlYXJfYmFua3Modm9pZCkNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgbWNlX2JhbmsgKm1jZV9i
YW5rcyA9IHRoaXNfY3B1X3JlYWQobWNlX2JhbmtzX2FycmF5KTsNCj4gKyAgICAgICB1NjQgbXNy
dmFsOw0KPiAgICAgICAgIGludCBpOw0KPiANCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdGhp
c19jcHVfcmVhZChtY2VfbnVtX2JhbmtzKTsgaSsrKSB7DQo+IEBAIC0xNTY5LDcgKzE1NzUsMTMg
QEAgc3RhdGljIHZvaWQgX19tY2hlY2tfY3B1X2luaXRfY2xlYXJfYmFua3Modm9pZCkNCj4gDQo+
ICAgICAgICAgICAgICAgICBpZiAoIWItPmluaXQpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBDaGVjayBpZiBhbnkgYml0cyBh
cmUgaW1wbGVtZW50ZWQgaW4gaC93ICovDQo+ICAgICAgICAgICAgICAgICB3cm1zcmwobXNyX29w
cy5jdGwoaSksIGItPmN0bCk7DQo+ICsgICAgICAgICAgICAgICByZG1zcmwobXNyX29wcy5jdGwo
aSksIG1zcnZhbCk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGItPmluaXQgPSAhIW1zcnZhbDsN
Cj4gKw0KDQpKdXN0IGEgbWlub3Igbml0LCBidXQgY2FuIHdlIGdyb3VwIHRoZSBjb21tZW50LCBS
RE1TUiwgYW5kIGNoZWNrIHRvZ2V0aGVyPyBUaGUgV1JNU1IgaXMgcGFydCBvZiBub3JtYWwgb3Bl
cmF0aW9uIGFuZCBpc24ndCB0aWVkIHRvIHRoZSBjaGVjay4NCg0KVGhhbmtzLA0KWWF6ZW4NCg==
