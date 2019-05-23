Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35E928830
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 21:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389969AbfEWTXL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 15:23:11 -0400
Received: from mail-eopbgr760043.outbound.protection.outlook.com ([40.107.76.43]:61504
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389460AbfEWTXL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 15:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCDZMuUUil3qAfa90IjUvYGWAyiWyFtz2Vh79mKPCEY=;
 b=owBfUmO4vJCtIW9ZxVGi51BClxsfOYoQha8VC24d1KatBkyBtaNZFnZb48UjqkavJsWYECdqy8NPWy5WujLooAWcnMTTL+sX8hfHo9KWy6NLYYQbJCnnuO/Ya+17CAZE2Ba3J36Avjj0ZlrpQX1PlZMrYdLEpzBhOhPxsNU5tTQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2622.namprd12.prod.outlook.com (52.135.103.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Thu, 23 May 2019 19:23:09 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1922.017; Thu, 23 May 2019
 19:23:09 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/MCE: Statically allocate mce_banks_array
Thread-Topic: [PATCH] x86/MCE: Statically allocate mce_banks_array
Thread-Index: AQHVEXi9HxUns8k6CEy4muazlWUkLKZ5KSmA///sF1A=
Date:   Thu, 23 May 2019 19:23:08 +0000
Message-ID: <SN6PR12MB2639AAC20E9F01D1DE810E17F8010@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190523150345.42906-1-Yazen.Ghannam@amd.com>
 <20190523202754.GA3980@cz.tnic>
In-Reply-To: <20190523202754.GA3980@cz.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c366881-2c4e-41be-8d7f-08d6dfb416da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2622;
x-ms-traffictypediagnostic: SN6PR12MB2622:
x-microsoft-antispam-prvs: <SN6PR12MB2622B8090E57BD9E581DEB28F8010@SN6PR12MB2622.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(376002)(346002)(136003)(13464003)(189003)(199004)(55016002)(9686003)(25786009)(53936002)(476003)(256004)(14444005)(6436002)(33656002)(446003)(11346002)(99286004)(486006)(4326008)(74316002)(26005)(81166006)(81156014)(66066001)(6246003)(54906003)(8676002)(229853002)(316002)(6916009)(76116006)(8936002)(73956011)(66946007)(64756008)(305945005)(7736002)(68736007)(186003)(66556008)(76176011)(66446008)(66476007)(86362001)(53546011)(6506007)(71200400001)(71190400001)(52536014)(72206003)(2906002)(478600001)(3846002)(7696005)(6116002)(102836004)(14454004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2622;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ffLrzcdapK9OXTBNjozjlg0oSOYAesCUwzqUOiZHjuq6MpoglCprfPhwoiHyvmYN88m1dTtgfp8W/7srnK9pkrgfLfr+E+cKDo6QHoFDS4hiijvJakX/6Y3oxav4C4IV0uzMMdJIL7ipfl5ZFkrQPpNhDTFNnXSSDQmX5IB9aL998NZCav1cU6fCcbaqsKWbTjSaJ0T+zYcZh0LRiO+rwpUUNa9gkieBF3S5YNEU65MH9oqnOuwq94ApumAiAw+2Str2xY70Doy1g5rjSxgvi2isp7EpXsPyE1JHFFSwRgo1BrVxRDCAL9507G5dUauwd49l787BuXan/pAABADLr8CBQdRrU5iSHgV3GwH6fmi4FY/zmXR1GchhT2gGd2ObGEA8krPOhxgq/Z6Wruj0/Wma/0fSd9lUwtMKFj4/RSI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c366881-2c4e-41be-8d7f-08d6dfb416da
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 19:23:08.8573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2622
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIE1heSAyMywgMjAxOSAzOjI4IFBNDQo+IFRv
OiBHaGFubmFtLCBZYXplbiA8WWF6ZW4uR2hhbm5hbUBhbWQuY29tPg0KPiBDYzogbGludXgtZWRh
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHRvbnkubHVj
a0BpbnRlbC5jb207IHg4NkBrZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHg4Ni9N
Q0U6IFN0YXRpY2FsbHkgYWxsb2NhdGUgbWNlX2JhbmtzX2FycmF5DQo+IA0KPiANCj4gT24gVGh1
LCBNYXkgMjMsIDIwMTkgYXQgMDM6MDM6NTVQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6
DQo+ID4gRnJvbTogWWF6ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+DQo+
ID4gVGhlIE1DRSBjb250cm9sIGRhdGEgaXMgc3RvcmVkIGluIGFuIGFycmF5IG9mIHN0cnVjdCBt
Y2VfYmFua3MuIFRoaXMNCj4gPiBhcnJheSBoYXMgaGlzdG9yaWNhbGx5IGJlZW4gc2hhcmVkIGJ5
IGFsbCBDUFVzIGFuZCBpdCB3YXMgYWxsb2NhdGVkDQo+ID4gZHluYW1pY2FsbHkgZHVyaW5nIHRo
ZSBmaXJzdCBDUFUncyBpbml0IHNlcXVlbmNlLg0KPiA+DQo+ID4gSG93ZXZlciwgc3RhcnRpbmcg
d2l0aA0KPiA+DQo+ID4gICAgICAgNWIwODgzZjVjN2JlICgieDg2L01DRTogTWFrZSBtY2VfYmFu
a3MgYSBwZXItQ1BVIGFycmF5IikNCj4gPg0KPiA+IHRoZSBhcnJheSB3YXMgY2hhbmdlZCB0byBi
ZWNvbWUgYSBwZXItQ1BVIGFycmF5LiBFYWNoIENQVSB3b3VsZA0KPiA+IGR5bmFtaWNhbGx5IGFs
bG9jYXRlIHRoZSBhcnJheSBkdXJpbmcgaXRzIG93biBpbml0IHNlcXVlbmNlLg0KPiA+DQo+ID4g
VGhpcyBzZWVtcyBiZW5pZ24gZXhwZWN0IHdoZW4gIkxvY2sgRGVidWdnaW5nIiBjb25maWcgb3B0
aW9ucyBhcmUNCj4gPiBlbmFibGVkIGluIHdoaWNoIGNhc2UgdGhlIGZvbGxvd2luZyBtZXNzYWdl
IGFwcGVhcnMuDQo+ID4NCj4gPiAgICAgICBCVUc6IHNsZWVwaW5nIGZ1bmN0aW9uIGNhbGxlZCBm
cm9tIGludmFsaWQgY29udGV4dCBhdCBtbS9zbGFiLmg6NDE4DQo+ID4NCj4gPiBUaGUgbWVzc2Fn
ZSBhcHBlYXJzIGR1cmluZyB0aGUgc2Vjb25kYXJ5IENQVXMnIGluaXQgc2VxdWVuY2VzLiBUaGlz
IHNlZW1zDQo+ID4gdG8gYmUgYmVjYXVzZSB0aGVzZSBDUFVzIGFyZSBpbiBzeXN0ZW1fc3RhdGU9
U1lTVEVNX1NDSEVEVUxJTkcgY29tcGFyZWQNCj4gPiB0byB0aGUgcHJpbWFyeSBDUFUgd2hpY2gg
aXMgaW4gc3lzdGVtX3N0YXRlPVNZU1RFTV9CT09USU5HLg0KPiA+DQo+ID4gQWxsb2NhdGUgdGhl
IG1jZV9iYW5rc19hcnJheSBzdGF0aWNhbGx5IHNvIHRoYXQgdGhpcyBpc3N1ZSBjYW4gYmUNCj4g
PiBhdm9pZGVkLg0KPiA+DQo+ID4gQWxzbywgcmVtb3ZlIHRoZSBub3cgdW5uZWNlc3NhcnkgcmV0
dXJuIHZhbHVlcyBmcm9tDQo+ID4gX19tY2hlY2tfY3B1X21jZV9iYW5rc19pbml0KCkgYW5kIF9f
bWNoZWNrX2NwdV9jYXBfaW5pdCgpLg0KPiA+DQo+ID4gRml4ZXM6IDViMDg4M2Y1YzdiZSAoIng4
Ni9NQ0U6IE1ha2UgbWNlX2JhbmtzIGEgcGVyLUNQVSBhcnJheSIpDQo+ID4gUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxyb25nLmEuY2hlbkBpbnRlbC5jb20+DQo+ID4gU3VnZ2VzdGVk
LWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogWWF6
ZW4gR2hhbm5hbSA8eWF6ZW4uZ2hhbm5hbUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4
Ni9rZXJuZWwvY3B1L21jZS9jb3JlLmMgfCAzOSArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlv
bnMoLSkNCj4gDQo+IENhbiB5b3UgcmVkaWZmIHRoaXMgcGF0Y2ggYWdhaW5zdCB0aXAvbWFzdGVy
IHBsZWFzZT8NCj4gDQo+IEl0IGZpeGVzIGEgcGF0Y2ggd2hpY2ggaXMgYWxyZWFkeSBpbiAtcmMx
IHNvIGl0IG5lZWRzIHRvIGdvIGZpcnN0LCBpbnRvDQo+IHVyZ2VudCwgYmVmb3JlIHlvdXIgcGF0
Y2hzZXQuDQo+IA0KDQpTdXJlLCBidXQgd2hpY2ggcGF0Y2ggYXJlIHlvdSByZWZlcnJpbmcgdG8/
DQoNClRoaXMgc2VlbXMgdG8gZml4IGEgcGF0Y2ggaW4gdGhlIHNldCBpbiBicC9yYzArMy1yYXMu
DQoNClRoYW5rcywNCllhemVuDQo=
