Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4526341653E
	for <lists+linux-edac@lfdr.de>; Thu, 23 Sep 2021 20:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242757AbhIWSgI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Sep 2021 14:36:08 -0400
Received: from mail-bn8nam08on2072.outbound.protection.outlook.com ([40.107.100.72]:53248
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242738AbhIWSgH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Sep 2021 14:36:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqJ6OJxg1FZsOf8QB4b9K3Agye3Z3l0ALvJIcCkSW42B8/9afqQA6qY7gFnJuipn78rLhpfAcflWc4nOYSbPeK3Fp/11kwyB8pxvvDB+PE+dcW5yxWYQ0c8Em31Flji0MXNJ/DSfx2gC5NS6m9puLMTf2+RFGsSd+lWWpIQXTZFm/oMMzGfZb3vTzbAk288ywJ4gCS9LY/BO8nMrztFI4dhByJRamoBjxN8ptlfRnOlVoGgANNu0nBz/VzvwGUc1gE2L411xFFP31KJbZa1Ihs0j0g/k1RyJONbE1PZtojeg7k6Y2AlGQxT3CzFJEIYJQCL5E1lb7WjYX1t7q9nGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kvtZanqlS87ZzKTGhF2SRVBybCrYoPX0wSglTsUnZmY=;
 b=bdx7PAI6goYxNllxZB4D3b29dL7b1lGQIxtclMZGY9HNyP0CtLja692TwtpiQAhC/1kc3YlOc8mFukrFvZEreCs5oucojp2eQAnm9SI/coFGLxgsfe3qQz0N6usIS+MWi7G1OGCfz1AIFgXkpfaI9Ym8wZbw2PYzncNS+fUfrx1NENhUYph0mLYeS7OG95G8VuInkRzHfYiYQKEMdyicLpoJHhdBGM8mYAxoVoehou3sXDdVWOBszpGB4e3/6wEyfowNYiZwrjCauVgcZSm262vYiIdAIxl3agUWjcn7LCACQ+YPuF/Lari6FtRbeus4UxkpZhlCVEmjMLlkvhrcXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvtZanqlS87ZzKTGhF2SRVBybCrYoPX0wSglTsUnZmY=;
 b=fIjOfxcibm6a+k42bEXaNvB0VJ0nd+QFCSWEnmsC4CcMy6zYB7FCRmWFinrp4mIehk6+qBZFokYW3+dVy5gbgigYDB0xjxy5mvPIyHsI1XHS2/4Rv5QFSLIP0ijS7nS+S15jZnKojMFvlFONclXpSSFkzvqVvLpYKDjcuvjOmCs=
Received: from DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 18:34:33 +0000
Received: from DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f]) by DM4PR12MB5263.namprd12.prod.outlook.com
 ([fe80::90b2:e7f6:c5e5:c80f%7]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 18:34:33 +0000
From:   "Joshi, Mukul" <Mukul.Joshi@amd.com>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Thread-Topic: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran
 RAS
Thread-Index: AQHXr+ktpJldbvXsiEi/xMi8ZoJNQKuxrumAgAAF1YCAACrZgIAACx5A
Date:   Thu, 23 Sep 2021 18:34:33 +0000
Message-ID: <DM4PR12MB526304DAB4B0DB5F79CE10E3EEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com> <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu>
In-Reply-To: <YUy4CdcUWJzQfM4N@yaz-ubuntu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-23T18:34:32Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=475d601a-01fa-4967-9eb4-b214cfc2850f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 567ece31-cdd5-4fe1-c669-08d97ec0ca0e
x-ms-traffictypediagnostic: DM4PR12MB5263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB52631BEAF67A2867AAA49B59EEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eALd5M54uqUBKoNWk5mvLU1i3sFAYAWVHNXQUFHDhB15mqZF3qSbHwE4DS/hqH51lv3wSxQGO9rK2MQqZImEN3+giX14JDTSwWsDaT//PU2THKP19Jf9I5Gvw/xxjDfjAjBv/32IDeTpN9pVRSn682ruTBLBrP+Mom5Mtpd9WYnl2ejnmXA7rCeLZldpVSOc/76C+2xNNb9MOqSCx89EzV6Q4i0X1fPhbCPwWcV8VwuRR3qEWpqwLkwmBVjo8h0zMdpU+mTOVQkfobpiBZVhdJx9CopBdIp25gZlG4cZKwuW0oK7dFbeX8mCQgLPTT++7Jmbc44a4vxX67xZrkRe/MzySLK5TzEqDbe0aAJSYZ+8vXDtuCrsmtpCgXmUdmELjswndJvcZxH58+85Ejq6kh0UhtPuiEStih4DlNMOZ41twFFte76yGLIQQXNm5tXdAVY0iN2wvGpjNKt7yuBLLgdKhbsXAG+lA43k7JtWwlLZChjfGXlBzwQCC+FvfnfNmzLCKIdDFUX4ALjUQrb0GBQP9N8VDCshdxj49HKfQEHyE8UmMW0Cv9m3JEqBN9fl4I3KSO6v/avp4Tj7IiW2fzbpbDMauMNPz3z/DeWtQ6aR2iA/tknhVctEygTGRvOaMmK4Q+NDhUtBaQ7AJaInks6Khl89grWNA6b3sLaNlhbS3jDnoIUl6gr4Majxpc9QiLRzfCy9tPfrVgMv6gXCsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66446008)(5660300002)(38070700005)(64756008)(66946007)(6862004)(66476007)(7696005)(186003)(9686003)(76116006)(26005)(2906002)(38100700002)(122000001)(33656002)(52536014)(55016002)(86362001)(71200400001)(6636002)(83380400001)(53546011)(8676002)(316002)(6506007)(508600001)(4326008)(8936002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE1nOEhDbk9HSUdvUlRlZWR6dmE4TkhuS0lyTkk2QzJoZ1lxaUNWTERLUkY0?=
 =?utf-8?B?QXZ0dUg3dE1VMXFndWR5VktRTVlEQ2pPSkJqSUYrRUhLdG1nY3FjWURGbGc1?=
 =?utf-8?B?alFqRmswQVRLL2kzN0Y2K3RKUEtwZ1RXWkJSN1pUelplMWFkK2hSd1NrS1Jz?=
 =?utf-8?B?MTRqQTRsZ0tiSHRlT2tuak10Rk9KV2cyOHFJMUtzZkFEelRpVEpPQVJkYmFm?=
 =?utf-8?B?K1hTSUF5QS9sWjNNZkcwNHduN2xPR3hER2hibzd3bUlZWmhUVW9OY0E1aXBi?=
 =?utf-8?B?VGIyQzlJcFdLdGRxT2pMTFk4bnRRcjdTNFBEaEcreWIzaGhGRFJhL2NxOCsx?=
 =?utf-8?B?cmpCTVliTksxSzBQM3BHSVVlczJSbjJmNnQrTGx4SVRIM3Bmd1FwN3d0V1o4?=
 =?utf-8?B?K2o0cU05TTJVK1NiZDVGTlUwUHc1cVZ2YjRwaTZMRHFqUk5ZQkpzZ0lqSksv?=
 =?utf-8?B?bGZhOU9PMUtjaWtwaVVQTGpXZjBVNWNraDdoTmdMaVp4ZDFPd21EY3hBMzAw?=
 =?utf-8?B?U0lVNUpQYU91WUFZSXVNbnlrVWUxc28zVDFxazBTL0taU0x3UFNkcTZ2bUxz?=
 =?utf-8?B?OVgvcmF6cTdhUkNjWHN1dDdrVTdRZHpaT25lTFo1dFoyMkhpMWpDcXZhZmJ3?=
 =?utf-8?B?UUxuZlRSTEVUb3U3K3ZNNjE0NVAzTXJDbDkrM2s1Z01yaW1Sa2Urc0FDcDNC?=
 =?utf-8?B?dGNMaFpMc1hXODgwVjkzOEdHQlhmVjNGbmxmTkFHOGZCL2IreXpNZlFjcnBm?=
 =?utf-8?B?OHpqRE9QMFM4ZlluZWtScEQyVHRqSUgzZVRnZHRKNG5MZkFoYWhSZE9FeG95?=
 =?utf-8?B?UXBGRklYRkVMbEJGS3owUlFFVkh3bit4Y3lmWjZWaXhINXBGS0h3Q3RTUmtl?=
 =?utf-8?B?RE5Ra2Z1N2IvMlRReVJzcy91VHFtYk5WTjNVMUc3ZU9tVlVnS0g5MVp5RXBZ?=
 =?utf-8?B?VDJjMWFUbE8wTldWamtmMTJVMkJRdGVmUUdOQWN0L2ZaTmRRVkxhODJRU3RM?=
 =?utf-8?B?N01IYklLRFZYekpQZ3FKLzZyWVZnVC9zSW9IemRrV0hHOWRWYmZnQWw1cnpU?=
 =?utf-8?B?MjZCL0Y5UjJTMTloYXJxT0hnUGtkNnorcW9aZDlUWlNWeXlSUjl0dFRZekxF?=
 =?utf-8?B?TXRtVEEyZ1FaMlo1aDNNcTA2VldCbitYUTJtMGlYNVdraW44SVZGTlFNaHNy?=
 =?utf-8?B?UnFRUXBwZmlRblpwT0RFQ1UyMlBSa09TZEIxR2pudzFTOW5YY3FKNmZQeVFj?=
 =?utf-8?B?bG1XM05MSnV0Unp6ZVRzOHoxRFc4UmJlRTFmVTNTT0tZNFBPaEtjQzJYektC?=
 =?utf-8?B?RGRYNFdpcEJhTk5KaHYvcXdSaERCblVSWHVrSDV5TVpEUFl6QllRTWRiU3A4?=
 =?utf-8?B?aDkyQ3pJWXpSUDJaYSt6Rm5EOHczVjhUZHpKdHFMMXRJRnJhNncxeHFjUHVU?=
 =?utf-8?B?a3VxTmUzWnFkNU1HYTRLTzd2Ym93WjFjSm5yRHNBOE1Pbi9OUk1ZbzF3RHlx?=
 =?utf-8?B?OXpBRWtRVmZBSHNWRXVjSld2QXpoS1BZNlV4WGtlOElkWFZaZnFvU1MzdWIx?=
 =?utf-8?B?RDZRRVVGZ1JUc0l3ZHB4Z0ZxUnJzN0NFKzFVenBlRzMzRDNmTDhFZ042RjZT?=
 =?utf-8?B?UmRENnFEWlN4UGhFaTdtTHI2cFlLanRYWlhGVyswaEpnSWZCVzlFM2hNMkVl?=
 =?utf-8?B?bGtVVlNJSFB1cUtqRnJmY1FJZEpac2FvelM0aVY5TXM1UDlDZXJVMGY3SEhO?=
 =?utf-8?Q?Vms8NNOvLQI+JXg0Qo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567ece31-cdd5-4fe1-c669-08d97ec0ca0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2021 18:34:33.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udZ940dF8OZFU1ujtkmG7QoAvI98pPrMv0xRWpAug+sNgjyZtCILs/++xdYHNSi4z7G9ju8k4gWlYm1jbpaUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogR2hhbm5hbSwgWWF6ZW4gPFlhemVuLkdoYW5uYW1AYW1kLmNvbT4NCj4gU2Vu
dDogVGh1cnNkYXksIFNlcHRlbWJlciAyMywgMjAyMSAxOjIzIFBNDQo+IFRvOiBKb3NoaSwgTXVr
dWwgPE11a3VsLkpvc2hpQGFtZC5jb20+DQo+IENjOiBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9y
ZzsgeDg2QGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJwQGFs
aWVuOC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgbWNoZWhhYkBrZXJuZWwub3JnOyBhbWQtDQo+IGdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSHYzIDIvMl0gZHJt
L2FtZGdwdTogUmVnaXN0ZXIgTUNFIG5vdGlmaWVyIGZvciBBbGRlYmFyYW4NCj4gUkFTDQo+IA0K
PiBPbiBUaHUsIFNlcCAyMywgMjAyMSBhdCAxMTozMDo1NUFNIC0wNDAwLCBKb3NoaSwgTXVrdWwg
d3JvdGU6DQo+IC4uLg0KPiA+ID4gPiArCQlyZXR1cm4gTk9USUZZX0RPTkU7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwkvKg0KPiA+ID4gPiArCSAqIElmIGl0IGlzIGNvcnJlY3RhYmxlIGVycm9yLCBy
ZXR1cm4uDQo+ID4gPiA+ICsJICovDQo+ID4gPiA+ICsJaWYgKG1jZV9pc19jb3JyZWN0YWJsZSht
KSkNCj4gPiA+ID4gKwkJcmV0dXJuIE5PVElGWV9PSzsNCj4gPiA+DQo+ID4gPiBTaG91bGRuJ3Qg
dGhpcyBiZSAiTk9USUZZX0RPTkUiIGlmICJkb24ndCBjYXJlIiBhYm91dCB0aGlzIGVycm9yPw0K
PiA+DQo+ID4gVGhlIHRoaW5raW5nIGlzIHdlIHdhbnQgdG8gc3RvcCBjYWxsaW5nIGZ1cnRoZXIg
Y29uc3VtZXJzIHNpbmNlIGl0J3MgYQ0KPiBjb3JyZWN0YWJsZSBlcnJvciBpbiBHUFUgVU1DIGFu
ZCB3ZSBhcmUgbm90IHRha2luZyBhbnkgYWN0aW9uIGFib3V0IHRoZQ0KPiBjb3JyZWN0YWJsZSBl
cnJvcnMuDQo+IA0KU29ycnkgSSBoYXZlIHRvIHJldHJhY3QgdGhpcyBiYWNrIGEgYml0LiBJIHJl
bWVtYmVyZWQgSSBzdGFydGVkIHdpdGggdGhlIGludGVudGlvbg0KT2YgdXNpbmcgTk9USUZZX1NU
T1AgYnV0IHJlYWxpemVkIHRoYXQgd2Ugd291bGQgbm90IGJlIGRvaW5nIGFueSBhY2NvdW50aW5n
IGluIHRoaXMgZnVuY3Rpb24uDQoNCj4gU2hvdWxkbid0IHRoZSBlcnJvciBzdGlsbCBiZSByZXBv
cnRlZCB0byBFREFDIGZvciBkZWNvZGluZyBhbmQgY291bnRpbmc/IEkgdGhpbmsNCj4gdXNlcnMg
d2FudCB0aGlzLg0KPiANCj4gQnV0IGl0IGxvb2tzIHRvIG1lIHRoYXQgZWl0aGVyIE5PVElGWV9P
SyBvciBOT1RJRllfRE9ORSB3aWxsIGFsbG93IHRoaXMsIHNvIGl0J3MNCj4gbm90IGEgYmlnIGRl
YWwuIFdhcyB0aGlzIGludGVuZGVkIHRvIGJlIE5PVElGWV9TVE9QPw0KPiANCg0KU29ycnkgSSBo
YXZlIHRvIHJldHJhY3QgbXkgcHJldmlvdXMgY29tbWVudCBhYm91dCBzdG9wcGluZyBmdXJ0aGVy
IGNvbnN1bWVycyBhIGJpdC4NCkkgcmVtZW1iZXJlZCBJIHN0YXJ0ZWQgd2l0aCB0aGUgaW50ZW50
aW9uIHRvIHVzZSBOT1RJRllfU1RPUCBidXQgcmVhbGl6ZWQgd2Ugd2VyZSBub3QgZG9pbmcgYW55
IGFjY291bnRpbmcgaW4gdGhpcyBmdW5jdGlvbi4NCkxhdGVyIEkgZ3Vlc3MgSSB3ZW50IGJ5IHRo
ZSBjb21tZW50cyBwdXQgYWdhaW5zdCBOT1RJRllfT0sgaW4gbm90aWZpZXIuaDoNCiNkZWZpbmUg
Tk9USUZZX0RPTkUJCTB4MDAwMAkJLyogRG9uJ3QgY2FyZSAqLw0KI2RlZmluZSBOT1RJRllfT0sJ
CTB4MDAwMQkJLyogU3VpdHMgbWUgKi8NCg0KQmVjYXVzZSB0aGlzIHdhcyBhIGNvcnJlY3RhYmxl
IGVycm9yIG9uIEdQVSBVTUMsIE5PVElGWV9PSyAoIlN1aXRzIG1lIikgd2FzIHByb2JhYmx5IG1v
cmUgc3VpdGVkIHRvIHRoaXMgY29uZGl0aW9uLA0KZXZlbiB0aG91Z2ggd2Ugd2VyZSBub3QgdGFr
aW5nIGFueSBhY3Rpb24gb24gdGhlIGNvcnJlY3RhYmxlIGVycm9ycy4gDQoNClRoYW5rcywNCk11
a3VsDQoNCj4gVGhhbmtzLA0KPiBZYXplbg0K
