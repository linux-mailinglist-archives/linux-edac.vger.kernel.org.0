Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B163926A
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 18:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfFGQo1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 12:44:27 -0400
Received: from mail-eopbgr720070.outbound.protection.outlook.com ([40.107.72.70]:59104
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729577AbfFGQo1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 12:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODySeoQ0sWFxmrsl5aaxmy1G2bi5zPmJukPXGqdENYA=;
 b=RrIGWtttli3Sz/vSadBVnCj9mPrqTJ31S+p2RARJGQHBovs0YTBf4DPsTUs0GxY+3Hc/iPsLYqFwRxYva/fqPTEolf/38rFG773V09jufXNTSD0Yqb7ooDQZtRi8qAaE39EsspQhq0KJyXU17l8I5LOkLIRJI50njwVmzp97AiQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2797.namprd12.prod.outlook.com (52.135.102.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Fri, 7 Jun 2019 16:44:24 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 16:44:24 +0000
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
Thread-Index: AQHU/5PPbonhoiIaT0+tpMBUt0fOpKZt/3MAgAAEtbCAAA1jAIAAAELggAAGlYCAADB8kIAABZ8AgAAG7YCAANzUAIAAUaUwgAAal4CAAA3JgIAABf+AgAAE/ICAABizgIAAAygAgAAEo4CACWuboIAGhWIAgBC3iXCAAB8mgIAAANXg
Date:   Fri, 7 Jun 2019 16:44:24 +0000
Message-ID: <SN6PR12MB263968DE0DD98EBE14450698F8100@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190517163729.GE13482@zn.tnic>
 <20190517172648.GA18164@agluck-desk> <20190517174817.GG13482@zn.tnic>
 <20190517180607.GA21710@agluck-desk> <20190517193431.GI13482@zn.tnic>
 <SN6PR12MB2639C5427366AC3004C35CC0F80B0@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190517200225.GK13482@zn.tnic>
 <SN6PR12MB26390759DB43763D3A482918F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190527232849.GC8209@cz.tnic>
 <SN6PR12MB263998ECCDF1E345FEB0869AF8100@SN6PR12MB2639.namprd12.prod.outlook.com>
 <20190607163723.GG20269@zn.tnic>
In-Reply-To: <20190607163723.GG20269@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9603f73-4b25-4e7d-356e-08d6eb676621
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2797;
x-ms-traffictypediagnostic: SN6PR12MB2797:
x-microsoft-antispam-prvs: <SN6PR12MB2797BD682C427319F63D4621F8100@SN6PR12MB2797.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(136003)(346002)(39860400002)(199004)(189003)(13464003)(81156014)(3846002)(5660300002)(7736002)(81166006)(6116002)(8936002)(52536014)(486006)(74316002)(8676002)(478600001)(305945005)(6506007)(53546011)(102836004)(476003)(11346002)(446003)(186003)(26005)(6916009)(256004)(99286004)(66066001)(54906003)(64756008)(55016002)(6436002)(66946007)(73956011)(6246003)(4326008)(229853002)(71190400001)(71200400001)(76116006)(53936002)(9686003)(2906002)(68736007)(76176011)(7696005)(86362001)(66446008)(66556008)(66476007)(25786009)(316002)(33656002)(14454004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2797;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3DcVa6DiSImPiYmfDivIr7kg7yti3CVHHqr8m7i2VqIYBfA8rUUJMw09kguv0k0DYB/v3+cqH6km4hTiH5awg2NzoYTgPOybd+vn2stujE21KWlT8mVOfE87mLmm4fLH0mFw1ORT3Sora4Qx8Ne7mdMrlXC2VnS/LfD0bUWQXNZnfJ/sw+bCR524J7+OvH3IheI+ce33K1lg6LVwWEuichoeyVTrnJkaiKnzl5DZEZAmB42UT7TeKSY54YTa7HSlBY4RWweVuvy2IB+pP9xTUFQ+DoeZkcxVMVy0GJyMyoWsjlG66zgKx1I7D36Ubm/TFhyBc6OrEMZ0IW2ZAJcQxxcNI6S2NKBYtJgiRMCKALeGU2YsaDMTgMFYGqBvdd5+C3a/UM7IrHKwnbMur+upuLvirvBcXHdAnJv1Re+cvNY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9603f73-4b25-4e7d-356e-08d6eb676621
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 16:44:24.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2797
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1lZGFjLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtZWRhYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFs
ZiBPZiBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogRnJpZGF5LCBKdW5lIDcsIDIwMTkgMTE6Mzcg
QU0NCj4gVG86IEdoYW5uYW0sIFlhemVuIDxZYXplbi5HaGFubmFtQGFtZC5jb20+DQo+IENjOiBM
dWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPjsgbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgNS82XSB4ODYvTUNFOiBTYXZlIE1DQSBjb250cm9sIGJpdHMgdGhh
dCBnZXQgc2V0IGluIGhhcmR3YXJlDQo+IA0KPiBPbiBGcmksIEp1biAwNywgMjAxOSBhdCAwMjo0
OTo0MlBNICswMDAwLCBHaGFubmFtLCBZYXplbiB3cm90ZToNCj4gPiBXb3VsZCB5b3UgbWluZCBp
ZiB0aGUgZnVuY3Rpb24gbmFtZSBzdGF5ZWQgdGhlIHNhbWU/IFRoZSByZWFzb24gaXMNCj4gPiB0
aGF0IE1DQV9DVEwgaXMgd3JpdHRlbiBoZXJlLCB3aGljaCBpcyB0aGUgImluaXQiIHBhcnQsIGFu
ZCBNQ0FfU1RBVFVTDQo+ID4gaXMgY2xlYXJlZC4NCj4gPg0KPiA+IEkgY2FuIHVzZSBhbm90aGVy
IG5hbWUgZm9yIHRoZSBjaGVjaywgZS5nLiBfX21jaGVja19jcHVfY2hlY2tfYmFua3MoKQ0KPiA+
IG9yIF9fbWNoZWNrX2NwdV9iYW5rc19jaGVja19pbml0KCkuDQo+IA0KPiBOZXZlcm1pbmQsIGxl
YXZlIGl0IGFzIGlzLiBJJ2xsIGZpeCBpdCB1cCBvbnRvcC4gSSBkb24ndCBsaWtlIHRoYXQNCj4g
Il9fbWNoZWNrX2NwdV9pbml0IiBwcmVmaXhpbmcgdGhlcmUgd2hpY2ggaXMgYSBtb3V0aGZ1bCBh
bmQgc2hvdWxkDQo+IHNpbXBseSBiZSAibWNlX2NwdV88ZG9fc3R1ZmY+IiB0byBkZW5vdGUgdGhh
dCBpdCBpcyBhIGZ1bmN0aW9uIHdoaWNoIGlzDQo+IHJ1biBvbiBhIENQVSB0byBzZXR1cCBzdHVm
Zi4NCj4gDQoNClllYWgsIEkgYWdyZWUuDQoNCkkgaGF2ZSBhbm90aGVyIHZlcnNpb24gb2YgdGhp
cyBzZXQgdGhhdCBJIGNhbiBzZW5kIHRvZGF5LiBJdCBpbmNsdWRlcyB0aGUgY2hhbmdlcyBmb3Ig
dGhpcyBwYXRjaCBhbmQgYWxzbyBpbmNsdWRlcyB0aGUgZml4IGZvciB0aGUgbG9ja2luZyBidWcg
bWVzc2FnZS4NCg0KU2hvdWxkIEkgc2VuZCBvdXQgdGhlIG5ldyB2ZXJzaW9uPyBPciBkbyB5b3Ug
d2FudCBtZSB0byB3YWl0IGZvciBhbnkgZml4ZXMgb24gdG9wIG9mIHRoZSBjdXJyZW50IHZlcnNp
b24/DQoNClRoYW5rcywNCllhemVuDQo=
