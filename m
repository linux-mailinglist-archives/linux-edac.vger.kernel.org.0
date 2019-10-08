Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C4CD0151
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 21:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfJHTmw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 15:42:52 -0400
Received: from mail-eopbgr800081.outbound.protection.outlook.com ([40.107.80.81]:51025
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728465AbfJHTmv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 15:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKCqfwRAoTSaBuQYUM3eT/KAiTB03kar7kvlFIkn7azStTmE0qbawAnXUaam9QlgsiOu3RPMu98CuJpjbqppPiYO9xLe4vfN+hogTBgOa4JA+Z4fScu0rCgA0KRpsKprfgjp3bK4c0AziX9GfGxz5LXLllKHrBfhF8TKqr1A/vrSOFv8jgifgW9oUAzXFtTitZw6ExlGMIToRRymUaZQYMw9atCBSvbwpzRmpbzCqtf1rOmPpcfkX/Wnon4Cqtz0F3ZqkCKw971c2kERyk4vboCnVyeJ7npnpqV2p5PF/YSlKot3shVXgMTT2a0qrsI9mjSKsz6To6iixE3QdUuc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IXb6kAy+R6xx7cA4tzw1pArQoUo2ubn4VDUf2b4Zlw=;
 b=dx5xm6ErkNTHpG/1nmO7cBwHbfMzoGdVfcZ4MvPzB7yS2qPFjy6VjSk0hXC4dxbEMXGaggGg3JbvQB8YOrVTejXV44uh9syv06erQJ7yj1ddiOfM7H7FFwYjliWOZV5EKs8RQbrCDVB+vlbB4D5J0EeHIfSG0pWpY5W4odSEuCWDSvpzUpP/lcPoZNuKvHokXDaJC0WUVGiUz3iOe8YNVY7ZMsz1l6LcEvVFJS6itpO7jpMcoPklcc2G20fUpkRQP0FAQOoUDYIS2iuw3PVEMzzw9v9FtL7lYYBGYdPYgO4ykZJwGeEsBHtp/LL9XNWIpvk1BMKxg5+55uKMyqrX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/IXb6kAy+R6xx7cA4tzw1pArQoUo2ubn4VDUf2b4Zlw=;
 b=r26vHVPCeWyh86wR+5ikIkpVLc+bvLPqomPTn2FICCIXHSUKgeqfpaES6VnSNjvCEzJH0WbzUwgA8FPbUKZYriudpFBotovSCRJcJOTLT3qTkogmwJ2phna8viPK117m/k0wKnPI3KG6QuItzkTLYxamAFgE8zmWNLvo8UW3VGw=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 19:42:09 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::ac86:15de:e8d6:61c8%7]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 19:42:09 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Jeff God <jfgaudreault@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h support
Thread-Topic: [GIT PULL] EDAC pile for 5.4 -> AMD family 17h, model 70h
 support
Thread-Index: AQHVe51JKTDxmyKbykahkp73y8AC1qdOxx+AgABffACAAX9igIAAg6EA
Date:   Tue, 8 Oct 2019 19:42:09 +0000
Message-ID: <678ba7d1-cf3d-4101-1819-29b291cf236d@amd.com>
References: <CAEVokG7TeAbmkhaxiTpsxhv1pQzqRpU=mR8gVjixb5kXo3s2Eg@mail.gmail.com>
 <20190924092644.GC19317@zn.tnic>
 <CAEVokG7UmudOALmeTBq2NgFSiZyGq_6b58nHt2UUHAM2Mzbw+Q@mail.gmail.com>
 <20191007071502.GA24289@zn.tnic>
 <CAEVokG51DtL1g+9YFK6RE=3m-wtjV1VN=vV56b5-3=K21=Jmrw@mail.gmail.com>
 <20191008115041.GD14765@zn.tnic>
In-Reply-To: <20191008115041.GD14765@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:405:3a::31) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.25.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90efc417-ffe4-4f28-feea-08d74c279b63
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: SN6PR12MB2720:
x-microsoft-antispam-prvs: <SN6PR12MB2720391CF9A75162B88FECE9F89A0@SN6PR12MB2720.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(189003)(199004)(6246003)(110136005)(229853002)(476003)(11346002)(2616005)(256004)(478600001)(66946007)(71190400001)(66446008)(6436002)(71200400001)(64756008)(66476007)(66556008)(6486002)(316002)(25786009)(14454004)(6512007)(4326008)(76176011)(305945005)(6116002)(52116002)(26005)(86362001)(446003)(8936002)(7736002)(486006)(53546011)(6506007)(5660300002)(2906002)(386003)(36756003)(66066001)(31696002)(99286004)(186003)(8676002)(81166006)(102836004)(81156014)(31686004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2720;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8HgCVA1JJ/Ws3DVAz7dOXkA4KyBVwFtJ+Qy/TJea7XuN2VK3piwp69Q29DXGLkiBkJC89R9ZmVaeXmCWoRITxbXLup0e4+WUZRLG5G5ccTWbEH02MjteqrRzB41prMoWpvH+9yRl0ISy0vGI0iaIkfF4OjPVJHSTD4qLImTxpOtZMfLRVE8AFHhzePLzJinjsC1o8rXxS6uEirosTHt5culX8mL0aWO28O9pjhB0vSO0PC3953lJlrDI2rpKbyYlmDs1bCC4JAnv0KpptEIld2gXsBw4R7sQVAWHPhhqpY/SS6kKy5RCR0JhhB/GSMtG/rezzei+/PGXE2ujI4csMJuXpA3goTOUQPMPFSU2mZnOPhSajFKEAzic7Yq8RvaKIVT2Jh+TpJ0EsSw0Hb0mpy48z8iXX4ebIyPkZxtWHEY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A030390F3A143408106AB82AC2F4E50@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90efc417-ffe4-4f28-feea-08d74c279b63
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 19:42:09.2880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o5riXEiza6dhZRe9/SSVFgFe8gei4YH8Ox5mdS9uoJcfKe0bJROmm4NjWqxvLweS6NIUHozJlG5+qGRWKtiBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMTAvOC8yMDE5IDc6NTAgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gTW9uLCBP
Y3QgMDcsIDIwMTkgYXQgMDg6NTg6MzBBTSAtMDQwMCwgSmVmZiBHb2Qgd3JvdGU6DQo+PiBJIHdh
bnQgdG8gdGVzdCB0aGF0IHRoZSBFQ0MgcmVwb3J0aW5nIGlzIHdvcmtpbmcgb24gbXkgbWFjaGlu
ZSAoc28NCj4+IHRoYXQgd2hlbiByZWFsIGVycm9ycyB3aWxsIGhhcHBlbiBvbmUgZGF5IEkgd2ls
bCBnZXQgbm90aWZpZWQpDQo+Pg0KPj4gVGhlIG1ldGhvZCBJIGRlc2NyaWJlZCBwcmV2aW91c2x5
IHRvIGdlbmVyYXRlIGVycm9ycyBieSBvdmVyY2xvY2tpbmcNCj4+IG1lbW9yeSB3YXMgbXkgaW5p
dGlhbCBtZXRob2QgdG8gZ2VuZXJhdGUgcmVhbCBlcnJvcnMsIHdoaWNoIHByb3ZlZCB0bw0KPj4g
d29yayB3ZWxsIG9uIGFub3RoZXIgc3lzdGVtIHdpdGggYSBwcmV2aW91cyBnZW5lcmF0aW9uIEFN
RCBSeXplbiAyNzAweA0KPj4gYW5kIHNpbWlsYXIgbW90aGVyYm9hcmQgYW5kIHNhbWUgbWVtb3J5
LCBidXQgb24gdGhpcyBzeXN0ZW0gaXQgZG9lcw0KPj4gbm90IHJlcG9ydCBhbnkgZXJyb3IsIGFs
dGhvdWdoIHR1cm5pbmcgb2ZmIEVDQyBpbiB0aGUgYmlvcyBzaG93ZWQgdGhhdA0KPj4gbWVtb3J5
IGNvcnJ1cHRpb24gaXMgaGFwcGVuaW5nIGZhaXJseSBxdWlja2x5IGluIHRoaXMgY2FzZSwgaGVu
Y2UgdGhlDQo+PiBjb25jbHVzaW9uIHRoYXQgZXJyb3IgcmVwb3J0aW5nIHdhcyBwcm9iYWJseSBu
b3Qgd29ya2luZyBidXQgdGhlDQo+PiB1bmRlcmx5aW5nIG1lbW9yeSBlcnJvciBjb3JyZWN0aW9u
IHN5c3RlbSBtYXkgYmUgd29ya2luZy4NCj4gDQo+IFllYWgsIGlmIEkgaW5qZWN0IGFuICJzdyIg
dHlwZSBoZXJlLCBJIGdldCBpbW1lZGlhdGVseToNCj4gDQo+IFsgIDI2NC43NDA4NDBdIFtIYXJk
d2FyZSBFcnJvcl06IENvcnJlY3RlZCBlcnJvciwgbm8gYWN0aW9uIHJlcXVpcmVkLg0KPiBbICAy
NjQuNzQwOTQyXSBbSGFyZHdhcmUgRXJyb3JdOiBDUFU6MiAoMTc6MToyKSBNQzRfU1RBVFVTWy18
Q0V8TWlzY1Z8QWRkclZ8LXxTeW5kVnxDRUNDfC18LXxTY3J1Yl06IDB4OWM3ZDQxMDA5MjA4MDgx
Mw0KPiBbICAyNjQuNzQxMDc0XSBbSGFyZHdhcmUgRXJyb3JdOiBFcnJvciBBZGRyOiAweDAwMDAw
MDAwNmQzZDQ4M2INCj4gWyAgMjY0Ljc0MTE2OV0gW0hhcmR3YXJlIEVycm9yXTogSVBJRDogMHgw
MDAwMDAwMDAwMDAwMDAwLCBTeW5kcm9tZTogMHgwMDAwMDAwMDAwMDAwMDAwDQo+IFsgIDI2NC43
NDEyNzldIFtIYXJkd2FyZSBFcnJvcl06IEJhbmsgNCBpcyByZXNlcnZlZC4NCj4gWyAgMjY0Ljc0
MTM2OF0gW0hhcmR3YXJlIEVycm9yXTogY2FjaGUgbGV2ZWw6IEwzL0dFTiwgbWVtL2lvOiBNRU0s
IG1lbS10eDogUkQsIHBhcnQtcHJvYzogU1JDIChubyB0aW1lb3V0KQ0KPiANCj4gYnV0IGRvaW5n
IGEgaHcgaW5qZWN0aW9uIHNlZW1zIHRvIGRvIGFsbCB0aGF0IGl0IHNob3VsZCBkbzoNCj4gDQo+
IFsgIDI0NS42NTgxNzVdIG1jZTogZG9faW5qZWN0OiBDUElVMiwgdG9nZ2xpbmcuLi4NCj4gWyAg
MjQ1LjY1ODM3NV0gbWNlOiBwcmVwYXJlX21zcnMNCj4gWyAgMjQ1LjY1ODUwN10gbWNlOiB0cmln
Z2VyX21jZTogQ1BVMg0KPiANCj4gYnV0IG5vdGhpbmcgaGFwcGVucy4NCj4gDQo+IFlhemVuLCBh
cmUgd2UgbWlzc2luZyBzb21ldGhpbmcgaGVyZT8NCj4gDQo+IFNlZSB1cHRocmVhZCBmb3IgZGV0
YWlscyAtIHRocmVhZCBpcyBvbiBsaW51eC1lZGFjQC4NCj4gDQoNCkhpIGd1eXMsDQpUaGUgImh3
IiBvcHRpb24gcmVxdWlyZXMgYSBub24temVybywgdmFsaWQgTUNBX1NUQVRVUyB0byBiZSB1c2Vk
IHNvIHRoYXQgdGhlDQpNQ0EgaGFuZGxlcnMgd2lsbCBmaW5kIHRoZSBlcnJvciBpbiB0aGUgaGFy
ZHdhcmUgYW5kIHJlcG9ydCBpdC4NCg0KSmVhbi1GcmVkZXJpYywNCllvdSBvcmlnaW5hbGx5IGhh
ZCBzdGF0dXM9MCB3aGljaCBleHBsYWlucyB3aHkgbm90aGluZyB3YXMgcmVwb3J0ZWQuDQoNCkJv
cmlzLA0KWW91IHVzZWQgbm9uLXplcm8gdmFsdWVzLCBidXQgeW91IHRhcmdldHRlZCBiYW5rIDQu
IFRoaXMgYmFuayBpcw0KUmVhZC1hcy1aZXJvL1dyaXRlcy1JZ25vcmVkIG9uIEZhbWlseSAxN2gg
YW5kIGxhdGVyLiBTbyBldmVuIHRob3VnaCB5b3UgdXNlZA0KZ29vZCB2YWx1ZXMsIHRoZSBNQ0Eg
aGFuZGxlcnMgd29uJ3QgZmluZCBhbnl0aGluZyBiZWNhdXNlIGJhbmsgNCBpcyBSQVouDQoNCg0K
SGVyZSBhcmUgc29tZSB2YWx1ZXMgSSB0b29rIGZyb20gYSByZWFsIGNvcnJlY3RlZCBEUkFNIEVD
QyBlcnJvci4NCg0Kc3RhdHVzPTB4OWMyMDQxMDAwMDAwMDExYg0Kc3luZD0weDdjNzYwMDAxMGE4
MDAxMDANCg0KVGhlIG1lbW9yeSBjb250cm9sbGVyIGJhbmtzIGFyZSAxNyAoY2hhbm5lbCAwKSBh
bmQgMTggKGNoYW5uZWwgMSkgb24gRmFtaWx5DQoxN2ggTW9kZWwgN1hoLCBhbmQgdGhlc2UgYXJl
IG1hbmFnZWQgYnkgQ1BVIDAuDQoNClBsZWFzZSBnaXZlIHRoZXNlIHZhbHVlcyBhIHRyeSBhbmQg
bGV0IG1lIGtub3cgaG93IGl0IGdvZXMuDQoNClRoYW5rcywNCllhemVuDQoNCg==
