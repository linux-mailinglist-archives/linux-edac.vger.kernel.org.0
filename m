Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54516504AFE
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiDRCae (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 17 Apr 2022 22:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiDRCad (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 17 Apr 2022 22:30:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130089.outbound.protection.outlook.com [40.107.13.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4476186CD;
        Sun, 17 Apr 2022 19:27:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBowXfaLza3FtOOBsvxtjqnZPhKT9HfX5Y+LsFlF0T86a9zzPyeTLeA82oM5AXu+BhOqUTaIRqrURMNqPTu8MDhTOqWNh2Vn7IUREUlrOu3xwYoT7kq3WiFEuUJLpU2YfHnFbzaY8NQP5V7y2/Hu7826DAlyVEIVMLducLqf4WnKZRxXyqjlWAVsq2cAgeUq/z90F+sAtQMCKLw0HspKiY7G/3mvS4hCWM5F3i488gokBK7ku8l9GjsX1K3ELosVsaiQezyXnIgPWGyhBDofOdtN+ob5zVnx6dgzBbjeNr5RCAX90n8p5FCJFH1vxitCi75JehBzkr1R6TVwETO7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3h2N4tkD6rCMmDj4vVly584/dOvR7wCvTEmAwu4MSY=;
 b=k7cCcanaGKJHX9dvwNpe1uX52qeyCAx+lQUID+XwvgyhPCU45frRKIqx3MhkAEftscIymlZQL0RVx5mygm+ZM6WtRiTlnOyjcKeKw0De4AzzwaMFn/xRqqtm/sApiS2UYtRYglAYWx0K7dxj2SNN0GZ3ZYA+BNYIjt9WjzeUW4TADIDPoodn+Hvb76lau+NQ0HafNbaQShEMBvC3WybGdNAeJtNOkS4REGIUoGgiiSn5wk7S2CSCXBzdlu7eJqXpjdkuIqZxldYEa3/pDsYX/Dgf48KIZMYulkamoEURjRwUC/SyMYoe75aT0Eddb49DVKMTH1exHOqR/Hd62VLxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3h2N4tkD6rCMmDj4vVly584/dOvR7wCvTEmAwu4MSY=;
 b=HeLHfO5TqWQC/O/dfFh2nm4+DGReTW4HmpFlsndOntpXv3MBfJzW7MatIA4fcfIo4mD/10iyqYFhBeOjatRaYC8NvrS0eSZwBS0BtG7IL9yt8lWvi/T6o6w+PgnvLm2qzxv8t/5f9ApBY1MnmgcnYNeTUwmwIlDqtleJg8rAijU=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:27:50 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:27:50 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] EDAC: synopsys: Add edac driver support for i.MX
 platforms
Thread-Topic: [PATCH] EDAC: synopsys: Add edac driver support for i.MX
 platforms
Thread-Index: AQHYOrrT+pNZglVnSEewY829Fe+WWKz1IjsQ
Date:   Mon, 18 Apr 2022 02:27:50 +0000
Message-ID: <AS8PR04MB8404347060A9CAD8B092FCFF92F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318112231.15828-1-sherry.sun@nxp.com>
In-Reply-To: <20220318112231.15828-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b83df971-e46f-4a94-b063-08da20e308da
x-ms-traffictypediagnostic: DB9PR04MB8377:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8377DC987A4E79C1D5FA75F192F39@DB9PR04MB8377.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McSFqV9pHTq9y5Md4x/KWUwxZF9p/ToInJKx5j1vgd3NBONwAfpqaGCJbBChtv2b2Mqe9z5Jp32xdUCmsu52SnPlyVX3LLVJFwJuQGjMGtMivI/DShkI1BUQCWuusPAc6NWbBADFBdMZ3nrVdC10fUyJXmdcqYNfKw+yunAMw73FJXUJDHmI3Tlod8rA7jTC5aymma2/UCa9Kj6U1x8VuLaEqBbFxLaeMxLjzGb54VsJRi2M9pHUH7P34cNfLu1hQHci1tITCIsycpYFpqYQKOC8YmWhmJ60I5AC6Y0V93acYxYyjJc9PvNT9K3hEe7doIDiNsYMrycty4C4+2/ExNVknpvST4zc8p+ZQYeFlcSzvaqBv+Rq56X68y8bzIippYyPJTQERQMBBqEuhcchLJRdloHum9IuVvJnUTuA18+I/p7pIXtyc9TLBfNJKBtO5/pk51DHuHdynOfYtCxwh4wVdBOFjljdNXMb6WkO7IW/h9hRTFrNbJh7QxGoS7cKlooViFa4yQAmrMJcyY//xlDsL+SjrtJ8OexMB/AxhTJKgHFjM0M6DAUaEePQHJvh1xTNDUx8TzUpOch9g24eYJY1mUNEFt30PQso78GFkQH+CXGZsOzkcziwCXgHSGTBBPYPZASVsYkgVWgS+PJXQq59OxdDmyWGpVf+kb7BMhrIfoP4NC5hZjeZIwnEqodVOiEFe+aGul4lcftChKaehg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(7696005)(5660300002)(9686003)(6506007)(83380400001)(38100700002)(38070700005)(86362001)(110136005)(52536014)(66946007)(66446008)(66556008)(66476007)(76116006)(54906003)(8676002)(33656002)(186003)(64756008)(122000001)(4326008)(8936002)(316002)(26005)(55016003)(44832011)(71200400001)(508600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YmRLN0o1QTE3TDJUOTdPa1RtZHJ2KzZ2RVd1blpNUXptc2p1RnE1bzNMSFE1?=
 =?gb2312?B?cHQyR2Z6MkJnTGZmU3p3Y2VvdGhBQXBHY1R6M1pzb0tLU3lSc2Jka083WG5h?=
 =?gb2312?B?MldHSEF1SVo1T2xYdmh0WEVDdWp6SmVkN0VBTjlZbktTRitVemVNdjJ1Nngw?=
 =?gb2312?B?SWorZ0tpNnNPSCtiT1cvS1cwbjBBblZYeVBBWXdnWU43RWRyVkQwSCtFQ2Jp?=
 =?gb2312?B?YTFzQjd1ODFNQnZIZU91UTQwZzB2Z2JzNzlFZjBaMUFjNFdwU1JKRklLVVUz?=
 =?gb2312?B?UGRKUElnRmpDOW1DaFRWRzVDblRIcE5ycmRTZHVhYjBTdjNBMVJ5NG1tdVRC?=
 =?gb2312?B?UDFDMi9nNTJUa1E2ZytnM09GTFZEWXpNdmcwNU5Fc2JWZWFNU2V4UHVqSGJ4?=
 =?gb2312?B?MG9OVHRKbnZNRjRNSXQ1R0U4YzhmRUpVRkdsWktYYjF1UTVvakhGU21pS0N2?=
 =?gb2312?B?OXZYTVN5SjhMRTZQOHh3Szhsb2ZSdENtcUZ1NUg4eVN1TW1tZmFTRDB3NkFE?=
 =?gb2312?B?SktQTUdXbnBwY1UvdFFqS01uSk9QRm1KSWxRUlc4d3dndzIzc2lTbk56Q1N3?=
 =?gb2312?B?WElmKzlBQmVGRkhIaGhuNXpiOG5tVHdSUFFCM2YzajFUTlpqRWFDY2hDcGY4?=
 =?gb2312?B?QTl4dkwySHR0NVZIWjJmVXVhUXZVNmRicERCZEEyY0lYTWRscTZiWWl0Vkhn?=
 =?gb2312?B?emtrc0NvS3FDcnJGY2lFczU0UUZVUnJ1VHhHRWVmVW5Gd0F3VGdDUHF5dXNX?=
 =?gb2312?B?Nm5seXBRTk92RDJoNjFKVG5MZndEV1pEQ0tCeFFpSmZISERka1NwdlNLMkw3?=
 =?gb2312?B?VDZ0RDNvU1NSSE1oelFEdE95QjlOUmI5RjFPWEFoOFRLMUVSVGtoSGcwbnNp?=
 =?gb2312?B?QVV6dGxQZ1ZQV0libXJOcENaQUl4ODl4VkdFV1hKdEYxUExQMXdOemZLVkJP?=
 =?gb2312?B?ekpvT2I0S3NWZVlzbkdyOFg1RC9ZK2xwVFhRSU1zWUkrZFZkUWtsQUZwU3BH?=
 =?gb2312?B?clhMczJ3NG1qdndORXRwbE1NNEZraUFWNWRFc1VOTXE2MVR3UFBVTzU1ZWFX?=
 =?gb2312?B?aXExcnU5d2NWaGVObUJ2N3R3R05iOU4yYzJDTDVpNS9mYjBPck1hekxYOHFY?=
 =?gb2312?B?MmdTK3VSSW10OXBpTUF5aU1BdGcrTmt6ZU44bmlGK1BSTzV4UmdOb0YxaFh1?=
 =?gb2312?B?NFRpNldQeVJSak8yNDZSY0NHVGJxUGRVT1B5Z21lVDBBQXgvYlNSeVJlOW5F?=
 =?gb2312?B?ZjZNTU9ZVmlFVHpuYVBrVTAzSTg2Yy83VHpIay9ZSzFXOWdjakIvK1dXeDVZ?=
 =?gb2312?B?MTNhekF4ZWVhRlFqNUZmNktObVJDUnpZbDUyNlg4b28rWkpLWDVmWk12RS9o?=
 =?gb2312?B?T0l5ZEhhYTlSVHpjcnNSOTBPRUhoTVdLOFRZV1NnZk15S0R2M1VhMXhPUDRy?=
 =?gb2312?B?K3pWNTdsM2J1d0JIVGZZN1grZmFqc0R6eDFlTnhFNUZvSURRc0JvVCtDWjFC?=
 =?gb2312?B?Vy8wVFhaMGlpOFMrbElKMUpoNlU0UzcvSTBnbVVJRVFONnIrNnZTVXIxK0hD?=
 =?gb2312?B?cWYvUzhJL2U3VWM4SzE2SmR6eTQzYjhEOHRLSmlZUEhURTlVWlg4SDNid3k1?=
 =?gb2312?B?TGRMN0VDWmI1VmtyVlo4NG1FcDlISXRpMy9OdkYzcXQxKzN5K0FmaFFPeUh3?=
 =?gb2312?B?a1g4T1lCQWt1SXJRS1IxcjY5YW9mS05ldWx5UnNsYVVpRWFRUEtvTWdSb1kz?=
 =?gb2312?B?V3Z1VnZvRld0UWxEbTNlenVpL09HaVNENjRxaXIveDVRbkR6QzVqcSs1SE1Z?=
 =?gb2312?B?N3czTU5wb1pubk1haFo4YkRPak1YdmxiNXFEbjJMRFFHWkh0UTU2cWlyWVZZ?=
 =?gb2312?B?b0tYeXc3QWZqVHZFT3NsSncxTmhaMkovTXlmanNGaXpuR29jTndBZ084RVBN?=
 =?gb2312?B?QUNtZHFycjg3ZnBhQnNOUWZTUVJ5ODIrR3Rzbkx1UXF3VmpmL2hvMXp4clY5?=
 =?gb2312?B?TndGeXYrb2hsYkJzU0tTT3g4MVJEWEtxSTY5MklxL0xMemkvY0U4ZXFoeXI5?=
 =?gb2312?B?QVBtV0xoUWxyV3UxSkFyYUVNWENZcitpMkM3em05TmlRMW54bDdXcWR5VXN3?=
 =?gb2312?B?WXluWVlzc2ovYXprYXJqTXF6WUx3RDZZNlJ3WXBhR0kwWFJXVE1mRXcvWm9k?=
 =?gb2312?B?Z2E5YWpSZ1F5d2tncWRYQ1YxY1hXSEtpNURyTXN5Z0xSOCtMR1Q1NlZ5RDZL?=
 =?gb2312?B?UzMzR3lKdEk0WHNxQS9lY0laSGplYWJjbjJYMzFZNVdUZ29HaGNFdzZuaVR5?=
 =?gb2312?Q?xmJByzMAoJ/CELwPvM?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83df971-e46f-4a94-b063-08da20e308da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:27:50.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gUb8HYEryBTj//6pf8Mqo9mZfM+PxE4c0MwOhtvTpq9IXq7SRxblSIjeQ5TvHqneoJ9xre7zfwelPl5xnbSp7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

SGkgQm9yaXNsYXYsIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyByZWdhcmRpbmcgdGhpcyBwYXRj
aD8NCg0KQmVzdCByZWdhcmRzDQpTaGVycnkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBTaGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jPUwjE4yNUgMTk6MjUNCj4gVG86
IGJwQGFsaWVuOC5kZTsgbWNoZWhhYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0K
PiBqYW1lcy5tb3JzZUBhcm0uY29tOyBycmljQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWVkYWNA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1p
bXgNCj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIEVEQUM6IHN5bm9w
c3lzOiBBZGQgZWRhYyBkcml2ZXIgc3VwcG9ydCBmb3IgaS5NWCBwbGF0Zm9ybXMNCj4gDQo+IGku
TVg4TVAgdXNlIHN5bm9wc3lzIFYzLjcwYSBkZHIgY29udHJvbGxlciBJUCwgc28gYWRkIGVkYWMg
c3VwcG9ydCBmb3INCj4gaS5NWDhNUCBiYXNlZCBvbiAic25wcyxkZHJjLTMuODBhIiBzeW5vcHN5
cyBlZGFjIGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5z
dW5AbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2VkYWMvS2NvbmZpZyB8IDIgKy0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZWRhYy9LY29uZmlnIGIvZHJpdmVycy9lZGFjL0tjb25maWcgaW5kZXgN
Cj4gNThhYjYzNjQyZTcyLi45ZGQ3NWM5YmJiM2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRh
Yy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+IEBAIC00ODQsNyArNDg0
LDcgQEAgY29uZmlnIEVEQUNfQVJNQURBX1hQDQo+IA0KPiAgY29uZmlnIEVEQUNfU1lOT1BTWVMN
Cj4gIAl0cmlzdGF0ZSAiU3lub3BzeXMgRERSIE1lbW9yeSBDb250cm9sbGVyIg0KPiAtCWRlcGVu
ZHMgb24gQVJDSF9aWU5RIHx8IEFSQ0hfWllOUU1QIHx8DQo+IEFSQ0hfSU5URUxfU09DRlBHQQ0K
PiArCWRlcGVuZHMgb24gQVJDSF9aWU5RIHx8IEFSQ0hfWllOUU1QIHx8DQo+IEFSQ0hfSU5URUxf
U09DRlBHQSB8fCBBUkNIX01YQw0KPiAgCWhlbHANCj4gIAkgIFN1cHBvcnQgZm9yIGVycm9yIGRl
dGVjdGlvbiBhbmQgY29ycmVjdGlvbiBvbiB0aGUgU3lub3BzeXMgRERSDQo+ICAJICBtZW1vcnkg
Y29udHJvbGxlci4NCj4gLS0NCj4gMi4xNy4xDQoNCg==
