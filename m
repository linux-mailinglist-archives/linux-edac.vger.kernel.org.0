Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44970504EAE
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 12:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiDRKO5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 06:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiDRKO4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 06:14:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A10713CD7;
        Mon, 18 Apr 2022 03:12:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VAwGBIhTjgBzq+3DYJT6sJKE1QxLDxWchuYH2V2OypV4NbTdz02++cywOeM62UbRFUetAdVyzAhyjchLwF+/F5kU7wFKFauKWuKcvUTThL2e2aus8hIBWB8cj8dTE3MfgQtMog5sAA4eiOUZ3q8Lkxf2tlAlxjOPooihxbVo1XYUuC2lbzkBnpxSC1tMbGXhzmB/gjSln9JF2SPcso3dbjy1Xf7afXUjEqznFWCACJUxDuZg8Cz4056m9Jaa5alxMUDF9SAhMPm/y1/U5X761Ep1f9lPA1zDStwhgrbg8tFW2cIkWTay+1HnNYjTYcI/zZpK53ZtAHr4ddSE1dtwCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G1XfXRMOKVGFv4tbsD+7PJoXT5ZS10dqn6Tai2mAeo=;
 b=gw10HLCa8/VcaEzxny2zJAksqmGIcH6/v7gsX7fESC7C/Vv9zyIzud9hGWH0DUmNEo9zbv8fI9NCRHI9A0gzkB5v+knuevNcuVTKpgHBMmTsuNMLwUu+3CnYm5ztzMsfzI0DuTf80xWoVB9LQesa9nYbuhv/Oo52Oo+cc8OyfserN58PgWyH/1BKccKDUwgY3EhwM25qtFSI+c+X0A9u+k2ewl0iR1JCbPLn6twHrdsUD9j07IzfJAVBj/cHkIZtuP7GvPIHTvB9CYhVDWZh1W8Q1CsogOOJ8cch+Qa9NXRgVLvvxauCPwMLdDXdMi8y+1ueHR3k5T+ymuqMtTHkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G1XfXRMOKVGFv4tbsD+7PJoXT5ZS10dqn6Tai2mAeo=;
 b=iN5hBsXceQ36ieqHZl/rl7/6ZQClYibX7yy0E1IOa1ukT29yW1IfAMkz4c9qFU2Um1Vk/pfrEaKdjQoan8ZTQsyFSMEtTzfAW4fVul5IMNGD8Fv1PsaZuSLczVTMxrmGCfSumlbBo4t4qNVMPBQjM+dtMfv4H3DdL5lR0teL77M=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VI1PR0401MB2350.eurprd04.prod.outlook.com (2603:10a6:800:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 10:12:15 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 10:12:14 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Topic: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver
Thread-Index: AQHYOrogKpzqNHgd/0yorlVfqzVePKz1IMNQgABoHYCAABpVQA==
Date:   Mon, 18 Apr 2022 10:12:14 +0000
Message-ID: <AS8PR04MB840435F6BACFF0C7F9B6D90792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <AS8PR04MB84044DD3E5EC879F7C281B9792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
 <Yl0iqXnsFm8rMBms@zn.tnic>
In-Reply-To: <Yl0iqXnsFm8rMBms@zn.tnic>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c60eed-119b-4a80-ddb5-08da2123e936
x-ms-traffictypediagnostic: VI1PR0401MB2350:EE_
x-microsoft-antispam-prvs: <VI1PR0401MB2350573DC574CCBB4EFD868A92F39@VI1PR0401MB2350.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DUoeZzk07nFhVuPBurOCHl8Rf1xzE9MS7nCJKBpDgnl6ZvQzbh+DgoXJco9aqEiytgY/LJI7pwyGvNL3E52vSdf8o3zYZW6RJXCFBXMlonUcP6mxeCtjtdeSXDj9M98gPs7C2eS50t78q4AOk4QI+l8fkOEGjrD84e5KdBs+w2+MBw/6zW1DLjdY3o+iFNTnghfEL9EMrwypLHod22472q/mzt5iiSUKfVUuPqxXrsyBprYrgTa/U369b19Oopx68GEmC56EXdSPBo8sDoIlzwMPKlcJRwgNOrmxfGQQ8xWFywEnjfsD5zYRXP2lYtBKuTdlUVhM1S246d5QRkgqDEv4VPAXQYPNhzbzobL/hlyF5vfaOAw/ZoZDsZaqXWI4Uso5FjgThqeTA8O4RlRf7VUhW/dw5V/L+uZx/O9Ofe541OaU6kmYwhJKw9UTy/hCi1j0b96XccnBWKmhIGyj8V6JXGrOjkh7rCCm9+TW8Z0ix8sR8cGRQfBSMwjIJJHLob2ItbUqHmzkdPFTsO+2yorVsM4g2Ez8l5Fcmu2SkCAAAC0PA9JQd7VGqkOW/UQoXS6UfY2dP4oiZKkY3ZDiJA6jR+VhKXsB5lYB3lxlaIuu1teTSuxTwbPlQQiH14r3oqNERMcX2WX5AheuRuPBC3MYS/j9ouuhEB+4emx8dKO263FAbYHzVdNzcter3GdScIouyiJYUGETec8II3m8q4DD4lXbd7mtX11wH7LcL+0fEq6l1lqeeoaW77RBJm0ELcBhcgfMJ+tOPDd5Esm1z7s2cACk63SCy3bYdOZnLUQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(52536014)(71200400001)(26005)(966005)(38070700005)(38100700002)(122000001)(186003)(5660300002)(110136005)(83380400001)(66446008)(66946007)(66556008)(66476007)(64756008)(8676002)(4326008)(76116006)(45080400002)(7696005)(44832011)(8936002)(508600001)(55016003)(54906003)(316002)(53546011)(2906002)(6506007)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cmlHaXh5MURhWVI0eEdLWkFXRUpUT1BEN1B4SkFZRVJvaVRxRzV2THg4ekxZ?=
 =?gb2312?B?YW1iUzZObEJ0UlhUNktheTdDenhWUDM1RTJTU1dIayt4RGdGVnowZVFidkw1?=
 =?gb2312?B?ZjhieW95Y2tDYXVVbWdpNXIyNHJ3RzkwVUxFczBCM3FCMWg1VEVkcW0yQkxJ?=
 =?gb2312?B?N01MamJOV1VINTJSQzVQNDlteHcwRHJNWmZxdnBUQkwwQWp3bnhOTlN4SHVE?=
 =?gb2312?B?dXltSWtkYitaS2FHVG13RTErcnB2YnFqSHRMSHkxL1lEaEVsbXBQVDBFSUlJ?=
 =?gb2312?B?QktRYW54Wmd2SWRCODVTU1NXODZkZnNTanJVWUVqNlhVVGVxeVNya2JPaWhq?=
 =?gb2312?B?VmpSZVBHUlptV1JDMXFYcHVUWG1abkVRMFJjODhKMnA5T1VhVmVGVXNoRjBG?=
 =?gb2312?B?ZGZrQ1ZJYmlBMHdWVlo4MWVPRWNsYkdHcG1leHhKSWlBY2t3SGZVVENCMi85?=
 =?gb2312?B?NjZmcVFONHZoYzQ1OFV3Ly9kWWNDSTIrZ0tpVUwzd0RMeDlyVTJTOCtZeUFp?=
 =?gb2312?B?U3VQNTlvR3pxbU5mUEtHbkl2MEFVV0dBaDRlaXNrbDFJdGx5cCt2Smgwa2I5?=
 =?gb2312?B?L01DdWpTKzh3VlpjODN1dGwyMFRWWHdFeFFSak9tRW1rRXByeVIxZnhKS0ky?=
 =?gb2312?B?MWxXYWZ3ZSsxTk1BcCsyU3hmVkxQWWh3SFVQMVhEalZ2ZENuWk1VZ0VFcXFG?=
 =?gb2312?B?ZCs3b0JGa2ZmNnRnRzkydm1SY2xyWE9IYk9QZzlzY3N5cXVlZ1dVY2NESTdM?=
 =?gb2312?B?ZUFpeXAvZGtPYlR6cnZuNmZPdlRXenJUdzVHWWdrWFFVT2FkbVZ6VG43U2g0?=
 =?gb2312?B?MGNSNlRtUWNKVlJIcUNkZUY5bkZhdEtBc2FSOUhIc0d6L2hGcEJpZEtqS1BI?=
 =?gb2312?B?bGRRbFczQ0lYSThRazBZUkdJanIvdThxVGFjQi9Dell0NjZ2MHFEaW94QU1u?=
 =?gb2312?B?MjVLWVF6Ty85MVE5SHlQQlhyNjIrMG5JVE1WTkxFK2c3OHdISmFvcHNIaFV4?=
 =?gb2312?B?Ris5QXkyakNONFAwTXJWWEFxNW9mY1NTaXdwTDRzS1lkbEdJYnpOcEtmZENK?=
 =?gb2312?B?MS96Ui8rKzNiWFdQcUFKamEyQ1FaREwyTVA5YzFGYjlySzVpUlNyakVkbkVp?=
 =?gb2312?B?c1pLakV1R2ZzejZrbjZFYnRMdEY2dWFBTS9YdlJyNEdLVWxRM2wrRnl1Vllm?=
 =?gb2312?B?ck5PYnc5c01RK1lPN3h2dEI0YVM2S3VPYUd3UTd5M1JLWkZiUDVDMmZsMFNK?=
 =?gb2312?B?ZmI3QmhSbTI0Y0UwWWJBM1JZN01PWlZ3TGt3eHpZTERMRHJpbElKbVAwV1N6?=
 =?gb2312?B?d0FuOFROQlJGZDd2UnFwTURia08xSUFlMElLaGpJbjVIZm42NTJlYWpna3BJ?=
 =?gb2312?B?QnovcExhN0RLN1VKN3JUVnkzQ2dRYmVtSEFXM0RUM0RFWjUrU0xlMFZtaUxv?=
 =?gb2312?B?VUU3dndkdG9sNUpNNHM3UWRCd0JTbnZSZnY4MnUyeWJ4ckZDRzhnWlVNbytG?=
 =?gb2312?B?azhZSjlBZ1hpcEFqdVhPUExWM1U5TDRkN3hCK3AyTTV0SFQ5enlJWEV4MXJT?=
 =?gb2312?B?dmNodmYzRlpPdk1BSWNLZ3pLYUo1WWh4SEpTazdUeDR2dTV6VmRSeG5KaHJk?=
 =?gb2312?B?N0VJMDUvZFcxVWxyN04welBhWjNhWmJ4cTZhUkdmRFNlbE1aT1R0ZFJVcmsy?=
 =?gb2312?B?dXBPVldaZStKenpNQzNDYlV1Y0NPNGlQSEUyWlBCcCsvQ1Z2L0JCaDc1Nmk3?=
 =?gb2312?B?anhSMXNHKzlaS2RCekhQM3dBSUtVUWxPcWs1RVRSdFlXZmRkQnVnc1lnL3Ux?=
 =?gb2312?B?QzNUWVJZNVVaTTd4T2lneEVoNDkxRThHMlZLQ2g5cXdHaXBaNmNHNmdhbWUy?=
 =?gb2312?B?Q2haQ2FwNlY5OG9abXQ1VFN5aCtJZVM4NEUzaU51aWhacCtRSzdLSElCV2pO?=
 =?gb2312?B?WUIxWDIzUE9kRngvT3l2OTZTZENGeEZnT1FsdVorTGlSQnBPQkpRUUhkZ2Zp?=
 =?gb2312?B?dmtDemg1bklKUXhuVmpVQitnR0FheDBpS2N5R2RtUmxSOGRvQS9PZzNZK01p?=
 =?gb2312?B?b2Y1RTg3aTBYRUpiUGw5a0YySmsrNHFxT0ppUnExZVRZOVZ3Q2c2VnhFR3VD?=
 =?gb2312?B?UHJscWVYSllOSis0OHpRRGRaUDlnR0xPV2Zmcm9BWEJPRktXMG9yc0I4RWdS?=
 =?gb2312?B?SXhlQUhRaUFrR2ljQjVxenJ0TUVUdUZYSmdGVWJxdWhKTjhUWk8zdENCRjQw?=
 =?gb2312?B?ejkwaXFUT056citPak5wNUwwQUdrb3FncTRzTHJJNjh4TXgrZXlYeDVjcjZw?=
 =?gb2312?B?dHdZQ3ZjRTNYVEtXV1k2TktDM1NNTHF6TnNwbUJkUHJkK2JLL2U4dz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c60eed-119b-4a80-ddb5-08da2123e936
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 10:12:14.5824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD0GIraTWk6/DlhzFpsd5szhPaip2FwE7D3O6JbV6HLHXueZGpKzSPDJcF+itYEt2KVE1OHksWtlxszkeWMKpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2350
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXNsYXYsIHRoYW5rcyBmb3IgdGhlIGluZm8uIEhpIE1pY2hhbCwgd291bGQgeW91IHBs
ZWFzZSBoZWxwIHJldmlldyB0aGUgcGF0Y2ggc2V0PyBUaGFua3MgYSBsb3QhDQoNCkJlc3QgcmVn
YXJkcw0KU2hlcnJ5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9y
aXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+DQo+IFNlbnQ6IDIwMjLE6jTUwjE4yNUgMTY6MzUN
Cj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IG1pY2hhbC5zaW1la0B4aWxp
bnguY29tDQo+IENjOiBtY2hlaGFiQGtlcm5lbC5vcmc7IHRvbnkubHVja0BpbnRlbC5jb207IGph
bWVzLm1vcnNlQGFybS5jb207DQo+IHJyaWNAa2VybmVsLm9yZzsgbGludXgtZWRhY0B2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIGZpeCBzb21lIGJ1Z3MgaW4gVjMuWCBTeW5vcHN5
cyBFREFDIEREUiBkcml2ZXINCj4gDQo+IE9uIE1vbiwgQXByIDE4LCAyMDIyIGF0IDAyOjI3OjIx
QU0gKzAwMDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gSGkgQm9yaXNsYXYsIGRvIHlvdSBoYXZl
IGFueSBjb21tZW50cyByZWdhcmRpbmcgdGhpcyBwYXRjaCBzZXQ/DQo+IA0KPiBZZXMsIGZvciBF
REFDIGRyaXZlcnMgd2hpY2ggaGF2ZSBkZXNpZ25hdGVkIG1haW50YWluZXJzLCBJIHVzdWFsbHkg
d2FpdCBmaXJzdA0KPiBmb3IgdGhlbSB0byBoYXZlIGEgbG9vay4gSW4gdGhpcyBjYXNlLCBNaWNo
YWwuDQo+IA0KPiBUaHguDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMu
DQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZwZW9wbA0KPiBlLmtlcm5lbC5vcmclMkZ0Z2x4JTJGbm90ZXMtYWJv
dXQtDQo+IG5ldGlxdWV0dGUmYW1wO2RhdGE9MDQlN0MwMSU3Q3NoZXJyeS5zdW4lNDBueHAuY29t
JTdDY2VhMjc4NWU5MjkNCj4gZjQ0ZTU5YTRiMDhkYTIxMTY1MmI2JTdDNjg2ZWExZDNiYzJiNGM2
ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDDQo+IDAlN0M2Mzc4NTg2NzcwMDcxMjgxNTUlN0NVbmtu
b3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TA0KPiBqQXdNREFpTENKUUlqb2lWMmx1TXpJ
aUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAmYW1wDQo+IDtzZGF0YT1kN3pK
UzFrZ0VUWW5RWGtCTzRLM20xRDVjdkZsSjc1QklEJTJCOEZqeThhMEElM0QmYW1wO3Jlc2UNCj4g
cnZlZD0wDQo=
