Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420F4504AF4
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 04:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbiDRCaF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 17 Apr 2022 22:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbiDRCaC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 17 Apr 2022 22:30:02 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02993186C9;
        Sun, 17 Apr 2022 19:27:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgZooobD9+jh0TFomIVM6rFYuOtxX0hJYurG+Nm+2VKG9JxZ0HXDGiAxaQ+ht3r0f/onc83OSyAx90d5RAMyFzOjfzSKQTXoOl5IJh9/1rOnPyUYtVC/Jn9hob45iZnVaMV32QR0WObJMB+whlgW7rmJKMxrfC2S4/XjNOQWVBzsufguSBMCpHySgFqhBQvRZlQ2xM9FfdHSU1V6+b8fTkQHXEh/m2XuOAIYBaH+b2OSYyM+y/QI4Tx72jy8M6+R6hK0HYKYgKrLYPEZJ8f4cGGWDM9QOVlPTGFKa6gKJ77uutqxU18E/lHQsxrLfhP+JEjjSuOOhr+SmY9mxw3qnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVuH+O6tTfqGxHfYRMQjSkA8LzXSRYChAdhk6Pkq9Ts=;
 b=ByZjt00wPUyKt7J/gHdq3tOgIuCaRdCy5TQDnSTt7JMA/nraXZE3srAIA3djKNR/wYODkJ5pUxb3R14AzPQMc0ciRaJJKwBg8FzFW7HE1YfsVUIJSqXxLhIHrwiJevd23a8PkfaMrZ5FY+rLl+MInjnnNjFh9CNhrQzBFVEmpn1wcP2fnOOvG854pNbhT8rEsfadFcHEN6AfIVLJMFnx3qv6aggCdux2zygPJ90UYL4gVRczh1qgkItsQnHerpXoXBIhAeUOvVJCtr1jQ7vPPe/Es7KigxTbSD/0NSABm5oj6oWQApRHkcP9CRmqJsJMgpoQZYQn+b2Fjqo1MwV6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVuH+O6tTfqGxHfYRMQjSkA8LzXSRYChAdhk6Pkq9Ts=;
 b=gMqGCcldg0rwc3n7XfAcO/ytycHITH2J6U8kdEh1xdCMwlAbi1CFDuS4NelQVePnUHC7n1ak0UbM55E14ZZrpjRsl+0fhYtUcYCnIsHGLKjxwytiMx0hLP3mjGQEdSDxt7jYIbiwhpVFd6+30PNAxZlBfdN/x01IqZQvYZiyQ88=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 02:27:21 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::7df0:c9b1:13f9:f712%5]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 02:27:21 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rric@kernel.org" <rric@kernel.org>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver 
Thread-Topic: [PATCH 0/2] fix some bugs in V3.X Synopsys EDAC DDR driver 
Thread-Index: AQHYOrogKpzqNHgd/0yorlVfqzVePKz1IMNQ
Date:   Mon, 18 Apr 2022 02:27:21 +0000
Message-ID: <AS8PR04MB84044DD3E5EC879F7C281B9792F39@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
In-Reply-To: <20220318111742.15730-1-sherry.sun@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ef602cd-a1a4-421c-c7de-08da20e2f7ca
x-ms-traffictypediagnostic: DB9PR04MB8377:EE_
x-microsoft-antispam-prvs: <DB9PR04MB8377DF995993979C09541A6892F39@DB9PR04MB8377.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FjAZbzAu8uthmkU5gUZwwX+x6rTNYLbilGCj4jQJ21kx6fYZ8fGhy2i7u0m1Fi6YIUkjDqouUbHmBV6BtZyT0jZWXS38ebGHnngpIVrT2yY3N6ua4eaFi00ciMn0RSpWlGWGdGd+Fr4zX1lrr6310kIhxigKO1Mi4QLAhEP6b9lW3cs8xgNnqi4tuj30p7SJkWiM7dtZK5Xf4lNTi0jQiJZDjmjcsG3CcCU+ujtgv74oUVnu4mn5+MKeWdR/DZ569guoLNbPE2ObqMZ6NakAKYiycT72tukgZhySqlQRIfEQQpcbo3p115Ai0D03LsSwmnwZSC9srWzm0uLqJTPYsBC2Cz3188/Ca4HTR4rapQWZQYcbQqla/aFL9ZWaVT02W7hwWXCnXiI3B1fdXZuFt6mSSzGa6MAplGrVM2EYx2iq5fREU6gRIxprWSTUckW4fh8f8nq7Mow8RZ4y58HN1FKIcH/RNj1yWXLbujrbTcXwfVqLdsAAirqiGOCRcnYPJViuoAlWgbKtuBgDuJMMX3P4IJGVejsWzZKob4LKvt36N/sIuEfdRRGJAv7aQMSSoUoGS5ajV2Hyvs0gk3BtbZdayj/iG6+jbVuWNtvKcGCFkLbvEbUvursiyrVU0lWu7Id0qrGZk5OjPp4x/HtnvyamqayCd1c3wMJ6tYnvxaRX1oGYdbdotIGjS3Fr7ewwcV1oG1J7GZtx4h6V2ZqfAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(53546011)(7696005)(4743002)(5660300002)(9686003)(6506007)(83380400001)(38100700002)(38070700005)(4744005)(86362001)(110136005)(52536014)(66946007)(66446008)(66556008)(66476007)(76116006)(54906003)(8676002)(33656002)(186003)(64756008)(122000001)(4326008)(8936002)(316002)(26005)(55016003)(44832011)(71200400001)(508600001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VWtJZ2J3ang3aW43NFl2UERZQzk2b09VMkdnalgwNzRFckNLT0QyQ2hDZHQ0?=
 =?gb2312?B?ejgrbjJWd3hhTS9CMG1rOEY0Yi9ydmw5VWlTVVlhYnh5aDBpNW41UXhuWi9s?=
 =?gb2312?B?SEhFei91Zzl0dkhKblJJNkVQanZBYzYyQ0swTEdhOG00am9aL3ZxVHhSYXA4?=
 =?gb2312?B?ZkR4ZzRqK2FxV2J0bXpMeXI3Vk0zVFhsZi9vcm1ZRHVwV29FTjJabFVuVDBs?=
 =?gb2312?B?bXlha3Fna25ZTnF2dUZhcm9TYWZKTURVV1FSdjdmOERtQ2ljUUhxL2dsQklh?=
 =?gb2312?B?NVUrZ1JSaGVORmgzL0lNUDZtTDdkNExobno5dGtZSVBwRnBqNm90bFBxSkkr?=
 =?gb2312?B?aTVQNThKR2NxUzlueXNaZGdpMk93S2hJMXZibjZmSGJ3SmdReHQrTURqa1Rl?=
 =?gb2312?B?Q0V5L293L1lHY2dZSVkvelhTNytpc0Z0SWREdWM5eGtWaGNMYW1ZSGlCOUNv?=
 =?gb2312?B?M2Q0d2JvK2hEc09sUGxnektiUEk3a2dubmhmY3N6RElySHdBUzQvZFdUVTR1?=
 =?gb2312?B?N1hrUEFyWWIxSXZPa2MxUkFpVFdOOFczeXhwdW8rVXZhSzZ0cjgramhsWHlC?=
 =?gb2312?B?ditjTXpCTXg3OWNSVTNsSCtaWFcwSzN2elA5RWVBSFJZMVNaUlArYWE1emtk?=
 =?gb2312?B?Nmk3TWdXUW9xd1lld0duTDlQZ3ZVNkJqZnBkUWRUNHBra2hwcldyMnFzbUxW?=
 =?gb2312?B?clhycUlMS3ZaOVdTa213TnlQWTFJMWtaQWNBL01ERi91cFpmVmZ5d1NmVVEr?=
 =?gb2312?B?bmQwUUVqOUlHZDkrVTRKbXZPSlYyL3RhdDlJZXF3SnlpZGFnbHlwOUNKMCtU?=
 =?gb2312?B?MXE1VHQrTm9wRWE5VTFLT3NzUGFxTElZd1dGdmFnYkNFVVBSRldaZldRTzk3?=
 =?gb2312?B?WU92eTh4R3o3VjMrYXRvWDVHQWtSSVFQOXVJcnY5K0tUU2NXdmpEaDljaUJp?=
 =?gb2312?B?SHJseWpUUmRiYXk1WlEzWVlGZ0gxeGxBekxsZ2hrZjVobCtJeWgxb1ZSMnF1?=
 =?gb2312?B?c25oMUdwRnhwZ2NKMk12SUU0S0NvY1VYK1Zka2V2UCs0RkVXRlRidC9sM0t4?=
 =?gb2312?B?dVRiMHhUcTlub1hKdmUyc1kzK1dwUUtjQjZseERGTnNUdit1QW9QelZqOVpU?=
 =?gb2312?B?MXNnL2UzV090MnZBRWFKREtKOWlZRkRaQ0h5aHljS2tEcW8zbS9RK0FwZ3hZ?=
 =?gb2312?B?UHNmREZLYlRtL29JSjl1YnRtMEI1emo5cE1COUU0TWE0VmVSajdXRHFoWkVw?=
 =?gb2312?B?c3h3WWhJMHFPRUkrSjdSZm9yNy9tUGZwSzNuZHQ1Q1hqTEd0L3lsZkdoRUZn?=
 =?gb2312?B?OTNsaDZTWHArRVl3S3dlZzdwUHJvN3I4Vk1TaVRCb0FQU2tDU0U1NDErWXpG?=
 =?gb2312?B?YW5uU2RwSUNzZCs0a3NIeTBVV3h6NUFmQjB2d1MwQmgyVWFkN0JYcFZaQWQw?=
 =?gb2312?B?b1lPN0hTMTZaZFlUNHk4Unl3YUh5bnJxaEdleFFybmZNVER3eW9vd0k1L05o?=
 =?gb2312?B?Wk5XOVJSTlhRRE9wamp2ZUtwRHM2aFlMSXIxUmk3bEZJZ0k3aHNocHB0WjBm?=
 =?gb2312?B?Q3krWHp4aVhUblo2NGFzSDV6STJLUTR0RmkxNmQrOXZWT3FmTExHa29sOEo0?=
 =?gb2312?B?Yk9OZVhDQnhVcmtBcWNldDQwVjlZdkc1emdKMVdPUjJGa2JOdXBFWE4xVy9u?=
 =?gb2312?B?VUowV0pVS3E5cCtBSVRaN0FkaldiRVdlNGQ2ZXM3ZFAxLzZVdG8zMWNYbTc3?=
 =?gb2312?B?aVozU09KR0JrZ1dOaHBMNXVQZ3BzRW5jSEs2NzVaVGIvcGRHV1F5bkIreUVo?=
 =?gb2312?B?MjRudEwvTkFNU2tIaDNtdmFhV0pDdEFmeHlNeUJyNTMzaXk1UmRJNVRrU3lr?=
 =?gb2312?B?VnlURjR6TDEwaGE3ekE1L3ZwR2VIMWpUMnBIYzlVMDkreHZKN3BSWXh1NGVu?=
 =?gb2312?B?cS80Rk8rbmtwWC9sdGJUbFFJR2RoWUJ5SGRlZmtiN3VyYzFmNWFMNmNYcThy?=
 =?gb2312?B?WDBNL0RGNmVndEdnT1ZNY05ySUE3M0hMV2pGenBvWm1rRFhxQnlxVWV5SUZq?=
 =?gb2312?B?Z0xlRnM0eng0SW95ZHM3U215QnhCZHd5a05RTTZBSXhyZXUrZlArdmtLeTNN?=
 =?gb2312?B?WktKU1JJSFI0S2FyWE84QUkzNHNLdmFxckd3R1dsYTJpdHBwRUlLalhjRUVM?=
 =?gb2312?B?dUlDVkxzeHRZcGVvNEY5Tm5seTJ4THloUUdZYVdjaHVqK0ozczM4M280NU5D?=
 =?gb2312?B?ZjUwcUFFWExONFFWbDVhenZ0U2NYUyszUFR0cCtFYkRMRld0UDFZSVE1OXhE?=
 =?gb2312?B?bS85eDZVajF5SzViYldSMDI4RXdZRHZZcGhmUjRSbERTcTBYZ1p1dz09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef602cd-a1a4-421c-c7de-08da20e2f7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 02:27:21.7524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wacMajkVOld3eqgrPAHO8Kety+IFU2pyBXKDsP9Rh+3nuhLmTf7MdsaP6o+A+iW+01rHFxOt+CDxQ4Cxrawuag==
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
aCBzZXQ/DQoNCkJlc3QgcmVnYXJkcw0KU2hlcnJ5DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFNoZXJyeSBTdW4NCj4gU2VudDogMjAyMsTqM9TCMTjI1SAxOToyMA0KPiBU
bzogYnBAYWxpZW44LmRlOyBtY2hlaGFiQGtlcm5lbC5vcmc7IG1pY2hhbC5zaW1la0B4aWxpbngu
Y29tOw0KPiB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBhcm0uY29tOyBycmljQGtl
cm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC8y
XSBmaXggc29tZSBidWdzIGluIFYzLlggU3lub3BzeXMgRURBQyBERFIgZHJpdmVyDQo+IA0KPiBU
aGUgdHdvIHBhdGNoZXMgZml4IHNvbWUgaXNzdWVzIGZvciBWMy5YIFN5bm9wc3lzIEVEQUMgRERS
IGluDQo+IHN5bm9wc3lzX2VkYWMuYy4NCj4gRm9yIHRoZSBkZXRhaWxzLCBwbGVhc2UgY2hlY2sg
dGhlIHBhdGNoIGNvbW1pdCBsb2cuIFRoaXMgaGFzIGJlZW4gdmVyaWZpZWQgb24NCj4gaS5NWDhN
UCBwbGF0Zm9ybS4NCj4gDQo+IFNoZXJyeSBTdW4gKDIpOg0KPiAgIEVEQUM6IHN5bm9wc3lzOiBB
ZGQgZGlzYWJsZV9pbnRyIHN1cHBvcnQgZm9yIFYzLlggU3lub3BzeXMgRURBQyBERFINCj4gICBF
REFDOiBzeW5vcHN5czogcmUtZW5hYmxlIHRoZSBpbnRlcnJ1cHRzIGluIGludHJfaGFuZGxlciBm
b3IgVjMuWA0KPiAgICAgU3lub3BzeXMgRURBQyBERFINCj4gDQo+ICBkcml2ZXJzL2VkYWMvc3lu
b3BzeXNfZWRhYy5jIHwgMTEgKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiAyLjE3LjENCg0K
