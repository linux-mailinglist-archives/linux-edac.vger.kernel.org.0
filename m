Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E6262600
	for <lists+linux-edac@lfdr.de>; Wed,  9 Sep 2020 05:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIID5A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Sep 2020 23:57:00 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:22433
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726111AbgIID47 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Sep 2020 23:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfd3DQbEGrWW46FJJI2UbVwKGU7ruR9XnmIMMMqbuM/oQraVU2JV3ozVVfN3/D3ubLanshCpOFzJfrzMG/fDA3A3qziMZIpPZHkFgApemK3xguBcN4Ahwy+IxicJtXIOwbSH49ip2vVXhqlSFTtBNKk737SgrzsoOJfvw7iJusEypP/C3Febq6De9O1xzLxitwBX5JLeP0RVVfqdg6JG5UADx3WSxxxjBYNmPLUd+R5PJ9TqgJ0nZiR61YLqMTHIQiVPBdCz/HU7qNONAz6VXJqT1fkk6c6ig+rPn7eO54GiKoKZS0vRfIfaZXtLJHIttrYeksIl0AZJzNAWWimasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9gWSJZFNjnRMs+ZLnKwA++lLplS/mJ53gaBpvWcd74=;
 b=lVQcxT9WacjpqJW7MeXB/bLWw/pulDfz39xWRkl5Ka5YoxmxbhVVCHK0g7pbYhhqZXdht+292UoVxcUF85uK45WTgzo4U29KW4JczUUMNfvV0EbUJVM4ZpfcrcksfJtCu0lKDnzaEqAALIzCbJR3IkgZ6vfCx6Ekp7vuPc6Ii4XAsriz9tQBgMArPxw6Zge7IKSQRW1anF3ZUAdvlCy8ShYihXSPZjAfYlKPyhg76lgvU5mTmQQEdjfZgZwke6fH+FkSB99l4CT11exHKe95m3iOImGa72u4D5L8R6J054bDPi/GpkJk2IB5KbqR5atHlVlemJs12oN9rIfW0A1Kqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9gWSJZFNjnRMs+ZLnKwA++lLplS/mJ53gaBpvWcd74=;
 b=ToT0B9IAQx7fYzXQp4InteiHeq20gqbk10MKSzYsd46Okx5oMJUznLPu5usjPzDbW4MM0hgAqsqEWNc/zq7TaCcqXTz+N9dFrtmcm2nQO8pUobi3eY/RYD29hRRReSmbQ3mJ16n4Dk48VO2skY5pkQ160GbtZ2NPGh61/23ikzQ=
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 (2603:10b6:405:34::34) by BN6PR13MB1105.namprd13.prod.outlook.com
 (2603:10b6:404:73::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7; Wed, 9 Sep
 2020 03:56:54 +0000
Received: from BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea]) by BN6PR1301MB2020.namprd13.prod.outlook.com
 ([fe80::4596:33b0:db2c:dea%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 03:56:54 +0000
From:   Yash Shah <yash.shah@openfive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Christoph Hellwig <hch@infradead.org>,
        "dkangude@cadence.com" <dkangude@cadence.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@openfive.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Thread-Topic: [PATCH v2 2/3] soc: sifive: Add SiFive specific Cadence DDR
 controller driver
Thread-Index: AQHWhNqGRYMAfY+EgEGaHPHMq7eq5KlcsboAgALymwCAAAe0MA==
Date:   Wed, 9 Sep 2020 03:56:54 +0000
Message-ID: <BN6PR1301MB20201D1CF5DE19A48306D28182260@BN6PR1301MB2020.namprd13.prod.outlook.com>
References: <20200907061126.GA14999@infradead.org>
 <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-d2a95187-c772-4c5d-b30b-b053a3195177@palmerdabbelt-glaptop1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dabbelt.com; dkim=none (message not signed)
 header.d=none;dabbelt.com; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [103.109.13.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bf693a7-e990-49cc-ff77-08d85474640c
x-ms-traffictypediagnostic: BN6PR13MB1105:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR13MB11059F37B4DEDB69B5873A9082260@BN6PR13MB1105.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pIZX6Hhg8EijYwEEjbARnvMBcHiEJ8Ns67WbG/d2hpH5UnrKkzPReG8LlMW4pQWQtrE5KxLYT9mHxvAHjVQdZbC72KoOappw6f6f1ZFYqnexL0W29BS6DRjCIwHU8RH8w3KOXSVIh7jgQgmI8sCEOw7/qfupQiaeSQfljjMuxgChmcms17oeIDkEoN9x2eFEk5JMD8J5pPTjq264RvfbKODPYZ2oyvQJQyvu8n/8C+CMUgkbKSraCD1NUSuzhMC700df6KoOfRCWi6zoe4OMF6vsni577dulVimEzzGDwnH1SFkx95DqBUBVMOrwNRvX9xHmQ/nACbIJAEkb4Ph2nLbKgFhNbm2h/5cyn6pV4+4VG14DX2KGFvkosw3g+Vkz6TPxBFQHECIG8OSN1wh7iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1301MB2020.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(39840400004)(396003)(366004)(136003)(376002)(346002)(83380400001)(86362001)(8936002)(66476007)(2906002)(316002)(71200400001)(52536014)(66446008)(66556008)(64756008)(9686003)(26005)(478600001)(76116006)(7696005)(33656002)(5660300002)(44832011)(966005)(66946007)(7416002)(4326008)(8676002)(110136005)(54906003)(6506007)(186003)(55016002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vwuLzI8WIjkcy34Mwb53SpIeNvNwqSWBP7TR1QDhD8Wd3gaAM6Oevd1lCwQvWuC11ALCpt4jyCRF93vXEBCJasgZOvLeCDpKTGB/L99GPIs658FMIqz0kavY3fObwlvy+8RbY76vjkE5X93lqDqQT2ymyMMLjRLsCdIzyyvcjp6fVocnlXJS7rgg1QWD6HP8pwZrLhXwNx4Sa/UUcXGPgr/q4WBKWFvw+APNnMHQRa8jEUIVJFtqpbYI/YHcR4OW99VtD+pR6sL3Y+nmbBwAxAWgGJ83e+76+k/1+Ee8fCpBuFupH/mu4t567Nh3j+tWnK+QhNyOkZoj0+WcoKDpJyMKDqRO1BV/XI7FKjP5T5GTr+ee9rjxDxcEqAh4CFgdTt/QKTo7UBg1EAauR9GXkdu9VT0rrrbZZsIn81WdI03sbXNmDhRy4bBEA3QPZfbcsNf9qClR2Fd4Dsc603UzG7RwnPuzy/9XENSkFgrDJVK/XHmgbcEd+mF+Es91tWruVCt7DCdAU7g5cnzXjO20u9RPyTxw0WFhB5k7uJxcolK7zjU8rSq7H9eL08GmZFamkI80/7L/QdCLy+b3LKFyuPbbsXfoNwWRHpvvPUCjiy5WvkEl1IBIM/ZkT6Ue/oNBf+cPd1wIZu10VhmG8Nxi0A==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1301MB2020.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf693a7-e990-49cc-ff77-08d85474640c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2020 03:56:54.2859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5mHb/xEW+yRb4vuj3QmpRYJsd+zT4SS8oClweJQoBSzhdSbQhJUD49kYeAqQ8h7tmT76S+Zbe9xbhiCY1j7KuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR13MB1105
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYWxtZXIgRGFiYmVsdCA8cGFs
bWVyQGRhYmJlbHQuY29tPg0KPiBTZW50OiAwOSBTZXB0ZW1iZXIgMjAyMCAwODo0Mg0KPiBUbzog
Q2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgZGthbmd1ZGVAY2FkZW5jZS5j
b20NCj4gQ2M6IFlhc2ggU2hhaCA8eWFzaC5zaGFoQG9wZW5maXZlLmNvbT47IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgUGF1bA0KPiBXYWxtc2xleSAoIFNpZml2ZSkgPHBhdWwud2FsbXNsZXlAc2lmaXZl
LmNvbT47IGJwQGFsaWVuOC5kZTsNCj4gbWNoZWhhYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50
ZWwuY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gYW91QGVlY3MuYmVya2VsZXku
ZWR1OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTYWNoaW4gR2hhZGkNCj4gPHNhY2hp
bi5naGFkaUBvcGVuZml2ZS5jb20+OyBycmljaHRlckBtYXJ2ZWxsLmNvbTsNCj4gamFtZXMubW9y
c2VAYXJtLmNvbTsgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGVk
YWNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBzb2M6IHNp
Zml2ZTogQWRkIFNpRml2ZSBzcGVjaWZpYyBDYWRlbmNlIEREUg0KPiBjb250cm9sbGVyIGRyaXZl
cg0KPiANCj4gW0V4dGVybmFsIEVtYWlsXSBEbyBub3QgY2xpY2sgbGlua3Mgb3IgYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlDQo+IHNlbmRlciBhbmQga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+IA0KPiBPbiBTdW4sIDA2IFNlcCAyMDIwIDIzOjExOjI2IFBEVCAoLTA3MDAp
LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gPiBPbiBNb24sIFNlcCAwNywgMjAyMCBhdCAx
MToxNzo1OEFNICswNTMwLCBZYXNoIFNoYWggd3JvdGU6DQo+ID4+IEFkZCBhIGRyaXZlciB0byBt
YW5hZ2UgdGhlIENhZGVuY2UgRERSIGNvbnRyb2xsZXIgcHJlc2VudCBvbiBTaUZpdmUNCj4gPj4g
U29DcyBBdCBwcmVzZW50IHRoZSBkcml2ZXIgbWFuYWdlcyB0aGUgRURBQyBmZWF0dXJlIG9mIHRo
ZSBERFINCj4gY29udHJvbGxlci4NCj4gPj4gQWRkaXRpb25hbCBmZWF0dXJlcyBtYXkgYmUgYWRk
ZWQgdG8gdGhlIGRyaXZlciBpbiBmdXR1cmUgdG8gY29udHJvbA0KPiA+PiBvdGhlciBhc3BlY3Rz
IG9mIHRoZSBERFIgY29udHJvbGxlci4NCj4gPg0KPiA+IFNvIGlmIHRoaXMgaXMgYSBnZW5lcmlj
KGlzaCkgQ2FkZW5jZSBJUCBibG9jayBzaG91bGRuJ3QgaXQgYmUgbmFtZWQNCj4gPiBDYWRlbmNl
IGFuZCBtYWRlIGdlbmVyaWM/ICBPciBpcyB0aGUgZnJvbnRlbmQgc29tZWhvdyBTaUZpdmUgc3Bl
Y2lmaWM/DQo+IA0KPiBGb3Igc29tZSByZWFzb24gSSB0aG91Z2h0IHdlIGhhZCBhIFNpRml2ZS1z
cGVjaWZpYyBpbnRlcmZhY2UgdG8gdGhpcywgYnV0IEkgbWF5DQo+IGhhdmUgZ290dGVuIHRoYXQg
Y29uZnVzZWQgd2l0aCBzb21ldGhpbmcgZWxzZSBhcyBpdCdzIGJlZW4gYSB3aGlsZS4gIFNvbWVv
bmUNCj4gZnJvbSBTaUZpdmUgd291bGQgcHJvYmFibHkgaGF2ZSBhIGJldHRlciBpZGVhLCBidXQg
aXQgbG9va3MgbGlrZSB0aGUgcGVyc29uIEknZA0KPiBhc2sgaXNuJ3QgdGhlcmVhbnkgbW9yZSBz
byBJJ20gYWxsIG91dCBvZiBvcHRpb25zIDspDQo+IA0KPiBJdCBsb29rcyBsaWtlIHRoZXJlIHdh
cyBhIHZlcnkgc2ltaWxhciBkcml2ZXIgcG9zdGVkIGJ5IERoYW5hbmpheSBLYW5ndWRlDQo+IGZy
b20gQ2FkZW5jZSBpbiBBcHJpbDogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNC82LzM1OCAu
ICBTb21lIG9mIHRoZQ0KPiByZWdpc3RlciBkZWZpbml0aW9ucyBzZWVtIHRvIGJlIGRpZmZlcmVu
dCwgYnV0IHRoZSBjb2RlIEkgbG9va2VkIGF0IGlzIHZlcnkNCj4gc2ltaWxhciBzbyB0aGVyZSdz
IGF0IGxlYXN0IHNvbWUgYml0cyB0aGF0IGNvdWxkIGJlIHNoYXJlZC4gIEkgZm91bmQgYSB2NCBv
ZiB0aGF0DQo+IHBhdGNoIHNldCwgYnV0IHRoYXQgd2FzIGJhY2sgaW4gTWF5OiBodHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC81LzExLzkxMiAuICBJdA0KPiBhbGx1ZGVzIHRvIGEgdjUsIGJ1dCBJ
IGNhbid0IGZpbmQgb25lLiAgSSd2ZSBhZGRlZCBEaGFuYW5qYXksIG1heWJlIGhlIGtub3dzDQo+
IHdoYXQncyB1cD8NCj4gDQoNCkkgY29uc3VsdGVkIHdpdGggRGhhbmFuamF5IGJlZm9yZSBwb3N0
aW5nIHRoaXMgcGF0Y2guIEZyb20gd2hhdCBJIHVuZGVyc3Rvb2QsIENhZGVuY2UgcHJvdmlkZSBo
aWdobHkgY29uZmlndXJhYmxlIGFuZCBjdXN0b21pc2VkIEREUiBJUCBibG9ja3MgYmFzZWQgb24g
dGhlIFNvQyB2ZW5kb3IncyBuZWVkLiBUaGlzIGltcGFjdHMgdGhlIHJlZ2lzdGVyIGNvbmZpZ3Vy
YXRpb24gYW5kIHByb2JhYmx5IHRoZSBvZmZzZXRzIHRvby4NCkkgaGFkIGFsc28gcmVmZXIgdGhl
IHY0IHBhdGNoIHBvc3RlZCBieSBEaGFuYW5qYXkgbWVudGlvbmVkIGFib3ZlIGFuZCBmb3VuZCB0
aGF0IHRoZSByZWdpc3RlcnMgb2Zmc2V0cyBhcmUgbm90IG1hdGNoaW5nIHdpdGggdGhhdCBvZiBD
YWRlbmNlIEREUiBJUCBpbiBTaUZpdmUgU29DLiBUaGVyZWZvcmUgaXQgc2VlbXMgdGhpcyBERFIg
SVAgYmxvY2sgaGFzIFNpRml2ZSBzcGVjaWZpYyBjb25maWd1cmF0aW9ucyBhbmQgaGVuY2UgdGhp
cyBTaWZpdmUgc3BlY2lmaWMgZHJpdmVyLg0KDQo+IEkgZG9uJ3Qga25vdyBlbm91Z2ggYWJvdXQg
dGhlIGJsb2NrIHRvIGtub3cgaWYgdGhlIHN1YnRsZSBkaWZmZXJlbmNlIGluDQo+IHJlZ2lzdGVy
IG5hbWVzL29mZnNldHMgbWVhbnMuICBUaGV5IGxvb2sgcHJvcGVybHkganVtYmxlZCB1cCAoaWUs
IG5vdCBqdXN0IGFuDQo+IG9mZnNldCksIHNvIG1heWJlIHRoZXJlJ3MganVzdCBkaWZmZXJlbnQg
dmVyc2lvbnMgb3IgdGhhdCdzIHRoZSBTaUZpdmUtc3BlY2lmaWMNCj4gcGFydCBJIGhhZCBib3Vu
Y2luZyBhcm91bmQgbXkgaGVhZD8gIEVpdGhlciB3YXksIGl0IHNlZW1zIGxpa2Ugb25lIGRyaXZl
cg0KPiB3aXRoIHNvbWUgc2ltcGxlIGNvbmZpZ3VyYXRpb24gY291bGQgaGFuZGxlIGJvdGggb2Yg
dGhlc2UgLS0gZWl0aGVyIHN0aWNraW5nDQo+IHRoZSBvZmZzZXRzIGluIHRoZSBEVCAoaWYgdGhl
eSdyZSBnb2luZyB0byBiZSBkaWZmZXJlbnQgZXZlcnl3aGVyZSkgb3IgYnkNCj4gY29taW5nIHVw
IHdpdGggc29tZSB2ZXJzaW9uIHNvcnQgb2YgdGhpbmcgKGlmIHRoZXJlJ3MgYSBoYW5kZnVsIG9m
IHRoZXNlKS4NCj4gDQo+IEknbSBub3cgYWxzbyBhIGJpdCB3b3JyaWVkIGFib3V0IHRoZSBwcm92
ZW5hY2Ugb2YgdGhpcyBjb2RlLiAgVGhlIHR3byBkcml2ZXJzDQo+IGFyZSBlcnJpbHkgc2ltaWxh
ciAtLSBmb3IgZXhhbXBsZSwgdGhlIHZhcmlhYmxlIGRlZmluaXRpb25zIGluIGhhbmRsZV9jZSgp
DQo+IA0KPiAgICAgICAgdTY0IGVycl9jX2FkZHIgPSAweDA7DQo+ICAgICAgICB1NjQgZXJyX2Nf
ZGF0YSA9IDB4MDsNCj4gICAgICAgIHUzMiBlcnJfY19zeW5kLCBlcnJfY19pZDsNCj4gICAgICAg
IHUzMiBzaWdfdmFsX2wsIHNpZ192YWxfaDsNCj4gDQo+IGFyZSBleGFjdGx5IHRoZSBzYW1lLg0K
DQpJIGFwb2xvZ2l6ZWQsIEkgZm9yZ290IHRvIG1lbnRpb24gaXQgaW4gY292ZXItbGV0dGVyLiBJ
IGhhdmUgYmFzZWQgbXkgd29yayBvbiBEaGFuYW5qYXkncyB2NCBwYXRjaFswXS4gDQoNCi0gWWFz
aA0KDQpbMF06IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzQvMjQvMTgzDQo=
