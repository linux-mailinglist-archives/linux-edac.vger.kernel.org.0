Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8763644DEE
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbfFMU6T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 16:58:19 -0400
Received: from mail-eopbgr690042.outbound.protection.outlook.com ([40.107.69.42]:10373
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfFMU6T (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 16:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEtLsnveu7G429RaEa6OtI7KRLpZ0lnLLT55Fv9di+k=;
 b=dWZO2oeJl5KXgFJMAtxYX3eq2IHVElp6SeuS+KUygvkiQ3+YWR2S3ZBui/j3pUVulLAlCtRPtt9RH9LG6rZJv2zOmjYU9KUlkq6OxrkPODOZMhWy7y1G9AKhmwZSJJSs4hIaBwyoUYOzv/WwTnrLfGU1ivnGWZt3lLacDWRZNok=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2816.namprd12.prod.outlook.com (52.135.107.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.17; Thu, 13 Jun 2019 20:58:16 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::69b5:19ac:b63d:2b82%3]) with mapi id 15.20.1965.017; Thu, 13 Jun 2019
 20:58:16 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Topic: [PATCH 2/8] EDAC/amd64: Support more than two controllers for
 chip selects handling
Thread-Index: AQHVGArjP8ASCZySEUyWj7FP348Ui6aZtVCAgABvqsA=
Date:   Thu, 13 Jun 2019 20:58:16 +0000
Message-ID: <SN6PR12MB263987AAB225A09527C4D736F8EF0@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-3-Yazen.Ghannam@amd.com>
 <20190613141715.GD11598@zn.tnic>
In-Reply-To: <20190613141715.GD11598@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e463edb3-a304-47c3-77aa-08d6f041db85
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR12MB2816;
x-ms-traffictypediagnostic: SN6PR12MB2816:
x-microsoft-antispam-prvs: <SN6PR12MB2816DDC460B7DA5DEF163938F8EF0@SN6PR12MB2816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(346002)(39860400002)(396003)(189003)(199004)(13464003)(11346002)(6246003)(4326008)(86362001)(76176011)(68736007)(26005)(99286004)(229853002)(186003)(3846002)(2906002)(25786009)(6436002)(6116002)(478600001)(6506007)(74316002)(7696005)(53546011)(72206003)(102836004)(33656002)(66066001)(316002)(476003)(53936002)(486006)(76116006)(66556008)(66946007)(71200400001)(73956011)(71190400001)(66446008)(5660300002)(8936002)(256004)(81156014)(66476007)(8676002)(55016002)(52536014)(9686003)(305945005)(6916009)(14454004)(7736002)(81166006)(64756008)(54906003)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2816;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IlW6yMaDGFvTbGe43ZHTZUKBnYlJcXVJiDH7H5q8ooN93BcomXd/fSplZvnnCZqv0j6aWtKScS45WhK8IfJ8lFsLAoZlcUwcUX+ftH21McZIVDiGGBaik5kd4SvCHcctk+mCa99PnlhyHf5BpKdOXa+QIY4Vuk853y4HdXtpCQl+13mstiXVBg7rjCemZfUQMvG5CWN6raD3xdm1qztBw+ZQR0/rFUI5eowCAq9ph0qay6TPTVXYlsbJWIAX1rNxdpyS3TY8/DxQdjkQ/ukw3Lw0QtWOfo+wjfZpUIgerC42tV/I6s1wThwquXa1qZCEJn5+5EleI0eTeuk2qJ68z1HYw5nWqZ5uKyioyn/vdZiST+WLdr1mAbekhXlH1HEOUCkWmoeV2uwKPgSVpTVMC0Ho+WHXQO1NDMJJJac0YK4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e463edb3-a304-47c3-77aa-08d6f041db85
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 20:58:16.4712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yghannam@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2816
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMTMsIDIwMTkgOToxNyBBTQ0KPiBU
bzogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gQ2M6IGxpbnV4LWVk
YWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMi84XSBFREFDL2FtZDY0OiBTdXBwb3J0IG1vcmUgdGhhbiB0d28gY29u
dHJvbGxlcnMgZm9yIGNoaXAgc2VsZWN0cyBoYW5kbGluZw0KPiANCj4gT24gRnJpLCBNYXkgMzEs
IDIwMTkgYXQgMTE6NDU6MTJQTSArMDAwMCwgR2hhbm5hbSwgWWF6ZW4gd3JvdGU6DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZWRhYy9hbWQ2NF9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvYW1kNjRf
ZWRhYy5jDQo+ID4gaW5kZXggOWZhMmYyMDVmMDVjLi5kZDYwY2Y1YTNkOTYgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9lZGFjL2FtZDY0X2VkYWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZWRhYy9h
bWQ2NF9lZGFjLmMNCj4gPiBAQCAtOTQzLDkxICs5NDMsMTAxIEBAIHN0YXRpYyB2b2lkIHByZXBf
Y2hpcF9zZWxlY3RzKHN0cnVjdCBhbWQ2NF9wdnQgKnB2dCkNCj4gPiAgCQlwdnQtPmNzZWxzWzBd
LmJfY250ID0gcHZ0LT5jc2Vsc1sxXS5iX2NudCA9IDQ7DQo+ID4gIAkJcHZ0LT5jc2Vsc1swXS5t
X2NudCA9IHB2dC0+Y3NlbHNbMV0ubV9jbnQgPSAyOw0KPiA+ICAJfSBlbHNlIGlmIChwdnQtPmZh
bSA+PSAweDE3KSB7DQo+ID4gLQkJcHZ0LT5jc2Vsc1swXS5iX2NudCA9IHB2dC0+Y3NlbHNbMV0u
Yl9jbnQgPSA0Ow0KPiA+IC0JCXB2dC0+Y3NlbHNbMF0ubV9jbnQgPSBwdnQtPmNzZWxzWzFdLm1f
Y250ID0gMjsNCj4gPiArCQlpbnQgdW1jOw0KPiA+ICsNCj4gPiArCQlmb3JfZWFjaF91bWModW1j
KSB7DQo+ID4gKwkJCXB2dC0+Y3NlbHNbdW1jXS5iX2NudCA9IDQ7DQo+ID4gKwkJCXB2dC0+Y3Nl
bHNbdW1jXS5tX2NudCA9IDI7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gDQo+IFdoYXQgaXMgdGhlIHB1
cnBvc2Ugb2YgdGhlIHByZXZpb3VzIGNvbW1pdCBpZiB5b3UncmUgY2hhbmdpbmcgaXQgaGVyZSBp
bg0KPiB0aGUgbmV4dCBvbmU/DQo+IA0KDQpUaGUgZmlyc3QgcGF0Y2ggaXMgbWVhbnQgYXMgYSBm
aXggZm9yIGV4aXN0aW5nIHN5c3RlbXMsIGFuZCB0aGlzIHBhdGNoIGlzIHRvIGFkZCBuZXcgZnVu
Y3Rpb25hbGl0eS4NCg0KSSBjYW4gbWVyZ2UgdGhlbSB0b2dldGhlciBpZiB5b3UgdGhpbmsgdGhh
dCdzIG1vcmUgYXBwcm9wcmlhdGUuDQoNClRoYW5rcywNCllhemVuDQo=
