Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05084E6BFA
	for <lists+linux-edac@lfdr.de>; Fri, 25 Mar 2022 02:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiCYBaM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Mar 2022 21:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357293AbiCYBaL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Mar 2022 21:30:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B113F3B;
        Thu, 24 Mar 2022 18:28:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITBUb5X2IM1xZAMlipiMaG4QmXiykaxtuHvoEluqz4Y7ifn/tnz0MBDjv6NjOrU42p5yxyYs3Tgef7OqsCnv1N41h8gZ1luv/UYGny9hssbjxL7IvAFFqew7ZyvGDA5BmYPoiWeL5slgRnJ9J6Y61RqUtg/9hz4rHdO/45zZ7k7xv06v8nGI5GDJgDP/Rc9Y/QuUtditzpPtxzcBaC4TGH1ieJ0YassREPpwWIOhOQ6NONTWNV1sB6Wtd1G0eblwCSA2D/Kui0h5PICN58POxEZ7Fgrps8ChYOR2ySju6Aio/25eMP9UEWl29+cO1uO87TDiItp3pPDIAn7jFnqQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESPpRDTrNvCKNjmLb8Grnj+CQu76xBJWLVjDYFhPbQ0=;
 b=CrKcN1d1/yQN9dx+CNUjrtV92R5O/vW6XBJ3dRg4SOf18SX311EnZstFD4V+xz98jYOsIGG5JK7yKaDCxqgBKlFLUSLclWMEVxFTiN/wgHRFFT4lKh5FZP7fp8Wg+hK0MuO8E4o8Ain5doiLamSTOG02qS/YvxY4fhlM6IGu1C/TQJdPzQ1X0wmVRZH1KDsO55MNWrnW5MJ0PZKdQIImgdllHWrp7t9o3pcY4F1v4gYIXiQ9mTIDq30xC6rys2Th5eVuOiLqxhWvhxDh1fVGUopD7u4OX/WKctcZlei2DX0HYJcwF0BT0gL0WQ9jgGLdB/Q7ss+smgbAFxRe08yLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESPpRDTrNvCKNjmLb8Grnj+CQu76xBJWLVjDYFhPbQ0=;
 b=F9PFm99wJAop9Cqq6MuTJ9UndFLSo83WkZ8zKYxxCObbnYAVmi0jMaBZ2ZWMX8a5Nx/h9ZwnpOTKNWhNEVMuKi0VMM7t1vN6zGsiGY06qFgjNUAYgVbie3mGrOgBkWZ190US2bkLlHbLVowE6WFmFVx3+U/T9X0WpBAXmt4FyY8=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR0402MB3794.eurprd04.prod.outlook.com (2603:10a6:208:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 01:28:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 01:28:36 +0000
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
Thread-Index: AQHYOrrT+pNZglVnSEewY829Fe+WWKzPWcPA
Date:   Fri, 25 Mar 2022 01:28:35 +0000
Message-ID: <AS8PR04MB8404DB6972832049F43FD065921A9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318112231.15828-1-sherry.sun@nxp.com>
In-Reply-To: <20220318112231.15828-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39945d57-8148-40a3-93fe-08da0dfec859
x-ms-traffictypediagnostic: AM0PR0402MB3794:EE_
x-microsoft-antispam-prvs: <AM0PR0402MB379450499B5118278366B1D0921A9@AM0PR0402MB3794.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gp4NkhNIdezR4yoxt9UW4DQhPRCilsbbKcZhtnpKhax5yi7754/8p8DjbhLdlwauAnnLJeaOsleAq3AVVeWG8MZENUZSgN/vNB0fNs7IhXITdj/Xl4KwTdVIp8KWDHQ7IawXWeaIfdU9kyJ+lKfP6qO1c22zdOPNJ+DWgY/nVFD69t3R9i4ZHN3VsM+ZAX5L7DK6JhyvVKu+Bi7Oym9NSHj10rCrdNu86nwWJBAF85Jphds71+KETlaADPu2m8T/dZX6Bs6Zc6Hsqj50ds0AELqVcuLriFNSTCO1sfWeLsuCsZn+o/xTMXkhKO91bpy7wkF/s73STywMqo2rkz6Fkwg/gd5XlR1RQXShlFctOELM53xkwilQhqURlbQRJ51Ju6expKUXfn29JtPhnoX2FgIA1rmZz6eyMiJl5vUaqs7GrwaxxPQF0VXB1aqHK1KSs8BhgGoj6CfW+bU9wOWiatbPWHB46pwarAAbebAJliHgphk1fFWv3xeRVIlz+9oz48LuK1QBzAlIFoFthm4EzaqqTa+t/6MOhhFoFaparqRodrz6m+646XHNbO9GuAmHPrwkSZI2T+HeYoSwyqeOYt2su69a1sL8gtxCp20s7Bd2sdjHGEmediDCtbQI3EOCUIejAel5e7UNWTPyT6XRTqIoFvHfGSy0Dy0KdTWNPTxObhZrrmBaxUVs/XJRWgxxPubsRoh5KLVd8RCKbc+Pyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52536014)(38100700002)(122000001)(8936002)(33656002)(53546011)(44832011)(71200400001)(508600001)(5660300002)(54906003)(110136005)(86362001)(83380400001)(55016003)(9686003)(186003)(38070700005)(26005)(66556008)(64756008)(66446008)(7696005)(6506007)(2906002)(76116006)(66946007)(66476007)(316002)(4326008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?dytIOFVUODE1bDgybjF5c0ZBUG9mcE1DS3gxSXdiaWpqM1VTOHhZUllHUjIr?=
 =?gb2312?B?ajlsaUpFaGNqYzlmc1VEOXo3dHQ0UE52WkdtQ2Z5RFBmNk9nTzdXRStKNU1a?=
 =?gb2312?B?V05qYWI3VG9ZQ2JnWmIxTEgvT1FqekpIYkZXT2EvVDRxa3JUNkVoblVuYmZG?=
 =?gb2312?B?T0JaeDgybGlxeFk3dGFuS2ZjVlh6czZvaEE3ekZQQTlBRk5IS2JYMm95b3pn?=
 =?gb2312?B?OEFmWlVLdDB6aGZraXZXUUZOcjdSRUZUZ0M5SDI0dWphaWFCaVYxVHRFcTRj?=
 =?gb2312?B?aUJWZjkzNGx4WFBvMnZCbzkxVzFiWW81RGlpbUNkYURnRmZ3d3ZmaVYrdVhn?=
 =?gb2312?B?OEtrVzNIdTJLNjZLc0F5NUFUSGYxeHI0QlBoU3F0S3E1c3Y1bUNzdTFLRTZH?=
 =?gb2312?B?MnpXUDA5TUo2Y1dBKzl3bEg2K3dQRDM0a25pNnlUVm5zZmVZbXg3bmtsa1pQ?=
 =?gb2312?B?UHNlZXIrS2oydkxFZWY2K3NldnB5TEF0SWZSWDNackxnUVRKN0pFMy9hZkNC?=
 =?gb2312?B?emtjRVJWU2JtQmVjL1I0REtPTnd0WXBTR0h6N0c3TnFaZlpVc2xGSnBwNER6?=
 =?gb2312?B?MXZqVUFIYTN1SDZYUDI2Y3BRRDFNWVZ3djFCbEdaWE1KTW9vSGdlaUtxUzBR?=
 =?gb2312?B?cGg5eUhKbzBIRG5VQVlaTllFa3dYU2NWMjc2QitSNXhFV1U5bjZxcFRrS1ZJ?=
 =?gb2312?B?N21TSmdJcXZyUHlFajVSbFdET1prbFh4WnAxV3dia3A4L1RJMGl2bWY2eGJP?=
 =?gb2312?B?bjdOWVZBMkhSK0ZkQ1ZwbXF4MzUrYnBIakd5ejZaY0VkdHY0c0pId1pwc3Nl?=
 =?gb2312?B?eE13SjJldTFZZzVwVjdQUDdmRVZVdzdUSjhHN2VDM1ZoNE8zZE5ZTys4Zk1O?=
 =?gb2312?B?bXBoQkFZdThzZU9WanpqeS9TVVdPSnhHTGw0UTVCSDBjVWJDajcxeUFXanVN?=
 =?gb2312?B?Sk03V2M3cVJUMXN5dXRDMXVtMHBaVllLb0RoWW1PcmpPMTAwRHpUb0hSZGVz?=
 =?gb2312?B?UW03SnhkSjd6dzNLK2tnV3B5QzF5bS8wcGNiYnM1dzdUaVBxbGxPR2F3dVZ2?=
 =?gb2312?B?ZElQT0VqOXYxdEJHYkVEbm9XOWJucjlqellUZDZtUENDUEo4amNZTytJR0tO?=
 =?gb2312?B?NU8yZnY1MG5icTBYNXkzR2tIdzFtTUpVcGdtTCtSWWtjT1NOM0NORTRIRzkw?=
 =?gb2312?B?aFRKbUdVZSs3ZEhJNHpQRDBoQ0ZseXdkWDJFWnltbjg0V0tlODVtTzRVWGRC?=
 =?gb2312?B?MmkvcUpkc3FmNEFDc09ubjM3UGtCYlVmU2pIQ0ZnRFpDMkJOYkR1dTVpL0py?=
 =?gb2312?B?MEl5YkZwZEFkZWFrSUdMRUpicW5nNU1MOEpiR3RtVmF4V3BKeGZOV2tyMFN4?=
 =?gb2312?B?a3EyRTFzWFF1NmlDRDJLVVVsK2l6VWcyZllYY1pRNjZzSTluU056U25LQkRp?=
 =?gb2312?B?bGtWUU50NDFhZE92clZOOXB6SUMzUGVXN0lyWk1NNFhzQjJTSitrVVhCQU9Z?=
 =?gb2312?B?Um95UGRZOEUzR1ZyMEVFS1VLU3pXbHRsajhTNVRQaS9OS2xpZ0lxUGttYzVw?=
 =?gb2312?B?b0F0UnRVdVZBRzZlZnB3bHNoWXZhUC84dTF4TnpMQjIxSExxTUUxVWVYOTR3?=
 =?gb2312?B?S0puSjN3eENqWTlzZWVKYjQyWWlrS3pLaFRqZVRLZjB3WnlwbXhLUjEvUjBF?=
 =?gb2312?B?OC9DbG1sQ3dsS2NUcnF5NWpRUE04THZ5YllVS2lBNHVMN1dGZ053T0ZoNkND?=
 =?gb2312?B?UEwxZnhZUnM3M3JuWVgxc1krUDJrZjRkQ3U3RmhES0ZOc0MzblRqL09zQmc4?=
 =?gb2312?B?Qmw3QzBEMkovTEZ4MHB4N0o4NFIrZGU5WWM3OXVOakpJQWRsMllUb3FWMFkw?=
 =?gb2312?B?TllLYVNXWEwrMGJhK21KN2xzS3dsYUVuNnByYTUzOEY4QkVpOXdUemtVSHR0?=
 =?gb2312?Q?Ocogqzyrp82QwpRdldTiUn8OYx4tdmvZ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39945d57-8148-40a3-93fe-08da0dfec859
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 01:28:35.9577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FU2rV21aibEwX63FrIJzt4S2OArWkYJys/ab4ZCwiat0nbkdejhNFSXLJZWKecFxySyEQ2Bs1Eq+8dsgoxnwPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3794
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBT
aGVycnkgU3VuDQo+IFNlbnQ6IDIwMjLE6jPUwjE4yNUgMTk6MjUNCj4gVG86IGJwQGFsaWVuOC5k
ZTsgbWNoZWhhYkBrZXJuZWwub3JnOyB0b255Lmx1Y2tAaW50ZWwuY29tOw0KPiBqYW1lcy5tb3Jz
ZUBhcm0uY29tOyBycmljQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIEVEQUM6IHN5bm9wc3lzOiBBZGQgZWRh
YyBkcml2ZXIgc3VwcG9ydCBmb3IgaS5NWCBwbGF0Zm9ybXMNCj4gDQo+IGkuTVg4TVAgdXNlIHN5
bm9wc3lzIFYzLjcwYSBkZHIgY29udHJvbGxlciBJUCwgc28gYWRkIGVkYWMgc3VwcG9ydCBmb3IN
Cj4gaS5NWDhNUCBiYXNlZCBvbiAic25wcyxkZHJjLTMuODBhIiBzeW5vcHN5cyBlZGFjIGRyaXZl
ci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2VkYWMvS2NvbmZpZyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZWRhYy9LY29uZmlnIGIvZHJpdmVycy9lZGFjL0tjb25maWcgaW5kZXgNCj4gNThhYjYzNjQy
ZTcyLi45ZGQ3NWM5YmJiM2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+
ICsrKyBiL2RyaXZlcnMvZWRhYy9LY29uZmlnDQo+IEBAIC00ODQsNyArNDg0LDcgQEAgY29uZmln
IEVEQUNfQVJNQURBX1hQDQo+IA0KPiAgY29uZmlnIEVEQUNfU1lOT1BTWVMNCj4gIAl0cmlzdGF0
ZSAiU3lub3BzeXMgRERSIE1lbW9yeSBDb250cm9sbGVyIg0KPiAtCWRlcGVuZHMgb24gQVJDSF9a
WU5RIHx8IEFSQ0hfWllOUU1QIHx8DQo+IEFSQ0hfSU5URUxfU09DRlBHQQ0KPiArCWRlcGVuZHMg
b24gQVJDSF9aWU5RIHx8IEFSQ0hfWllOUU1QIHx8DQo+IEFSQ0hfSU5URUxfU09DRlBHQSB8fCBB
UkNIX01YQw0KPiAgCWhlbHANCj4gIAkgIFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBhbmQg
Y29ycmVjdGlvbiBvbiB0aGUgU3lub3BzeXMgRERSDQo+ICAJICBtZW1vcnkgY29udHJvbGxlci4N
Cj4gLS0NCj4gMi4xNy4xDQoNCg==
