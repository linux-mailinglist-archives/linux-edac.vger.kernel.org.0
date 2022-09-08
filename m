Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375B5B25D2
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 20:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIHSeD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiIHSeC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 14:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F0AF22C3;
        Thu,  8 Sep 2022 11:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662662041; x=1694198041;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=WpNBB0mNH759eu18Cp65fXQey7sw+vHUobWLStXXQ5g=;
  b=TVbel1zD8pip+rY4ZjpILLH0hZZTsesXWvZ7sapLEPHfcKNKva5Vs9wm
   QAhYSola2qLwYPbyyvDDiz3FiLlOEozLdurpj6rxDe1kQ3rHNW69h9RF1
   hT+wfqCyV/hy7pHaOZGUoFYOexT7c12GpY1V7mhxpjKPQqUX7++QWoTAk
   axei770/YGQebDz1mbjJLrQngudJtZmtgaIhfHOZBupWJurd/JeGq2PEX
   RBltrwqT0za4UVtuOOF7vdl5NFP915DwDK+S3sdu5ceC2QaVapxw434a0
   103H6sybfMKGcB5u9JpRpqQgJ74MWfQWUGbG0WlblUQlJvcRXU0Nzlx8E
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="173014858"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 11:34:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 11:33:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Thu, 8 Sep 2022 11:33:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEta2lqTgYxfp6Jq+0Roob5hniMncgP5pZFeWY1JexVlHMAanoup7f3RxytOOTY27JcVpmvucsg3fLRAs63i/pmoto3fvb4G+lLTXRnBJ5BZw+DSESVXXlibh+z8BRaT3nWGzOch88wOLMS6tu6h6/uRceqbjFqbb1zcO2OXiVOaIG2M8pdEgnKmIXVHMsGfsnOMk5g8yPVY/9bi0npbG+eT48yESqarfDULUi1SPqzCtM6P9mWZ+I8Cy4Atqq7+0jLGJgvyB+j4S8JUz+9p7mO1nP6ONCwEFHhZjhfBtBezZDGdU1/St7+77QcuV3niko2ZaXdAwccyMY8pj29H6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpNBB0mNH759eu18Cp65fXQey7sw+vHUobWLStXXQ5g=;
 b=cr7TIwqBabCb6QvJJOKylWGs/Z7SGwo6AChJ2gPBgpVo4lqnC9DT3vCkrLqNJxlE+FuQ05JUgZuonxgXRlpUSTR4XsdBpmCkoQt4SfyOMsCDXMH2Ydkucc52fD9Mijxs1/Zn4XiUvwgjfGIx4c/ED1iEfIZ+UvJOXSagKDVZk7iYO3IFFefTxyAdIKQ3NzxZ/j+KCVZ/uvnGa0rWMCUfZD3lObE4z1ZpYovaWJ9LfHuN5e7QlH1UKVhp39LAdmuMZ/hwi2fYhWPMQf2HAoG/Yi6P6JkyyWXjLi0Aso7KAsTWrLfssDV1oFTaKVr3+8+JtZUF+L8XX3cKt66LMsN6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpNBB0mNH759eu18Cp65fXQey7sw+vHUobWLStXXQ5g=;
 b=pWmTRFrE8fUsU1hFPBLEUUwonQMF4MLbY+xcKp6ouUhnjTA1wqfBzVqQhe+YVERyh9Fs6k7IXA+aFttvjKljrritShfAWiK0jj+rwtTr+FNjez3M34Ew+EHvfISGpjIWQn58Iigbo+OjC6WEH+TegJN2RDorOblufWfxNM0g+Kg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 18:33:52 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 18:33:52 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] soc: sifive: ccache: rename SiFive L2 cache to
 Composable cache.
Thread-Topic: [PATCH v3 2/6] soc: sifive: ccache: rename SiFive L2 cache to
 Composable cache.
Thread-Index: AQHYw5GLSuwf3vpMk0+woCQmPL6nIa3V2/MA
Date:   Thu, 8 Sep 2022 18:33:52 +0000
Message-ID: <ca7d8e75-1823-05d9-6196-1d0ae14e2ec9@microchip.com>
References: <20220908144424.4232-1-zong.li@sifive.com>
 <20220908144424.4232-3-zong.li@sifive.com>
In-Reply-To: <20220908144424.4232-3-zong.li@sifive.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5154:EE_|CO1PR11MB4915:EE_
x-ms-office365-filtering-correlation-id: 1a94ce92-e506-4837-5b11-08da91c8ae19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q5Ausmg0q18xSoneWff6JN9LY2ffofVOeVm2p87E9FNKC6Ss7VyaRpfmblXM1XCHVtRg9BZIjJJxeOjsfgXJz8vPAd1EJ3AktWnowDSt3ttzAwwgHBuhql1WkBun8Uy8RvK0dt4p5uFmeceBmE5spaK6d60o6Vw0SmYFjbMvQXSv+VwyVeaZTHuxsxCZ27qpn6HsvL15cTldpppl5f4OCrQBa2GM0XiOkO6aoduZSDBs041/mAB02ImqgcHcM8DoL+LuOgefUwSplhoau22ytemWrCmZ0EZ8z6+MrNnvUh/f4tWc04yd0Dsmd1OiojFGu5Zq5R0wBGjRtVDW8gm6uQbCuOTK9Ymzq3GWeOU+yiW+7RiVL7G8guske5ANbR6fTG4Y6sSXEIYOQ58Bo/CkFW6ZOQsV8IZ61GNE56FJto2fcSLghoqzoh+fflkzC7OktLcxDgFvk+7GaurAY58H6jmPAMHPx1D+fBG9XjsvCpEk6nAWUGrPv+Sd1IPV7fHZnEDBZO2D4KXba1R2SrIUZjAIZ07tWmkMBzCP3eUwu7pOMgD1fYt3B0pRG6WhVPHCFVZLsuCPUzWW1LlZOTRj8g9GYf6YKCQFxfmaiZHyt7JJEOXO6jKB54iAAd83SXYD/83PYwfz4DcldAKQy32xSLZnTuD+K9xxMHAEOhbvbb2/+IFPDTTrSrwmSs7Q84EY15i+XuYMmZLkifa4yCsT0RPusyq5S/n6SEpoB0cO5TGCx70DRZJSBGmiW1URFmOrfuXoIaO5C757lUdn+EZa8Q0JUjg66UH7kBpFCSHN0mOH4xoT+hbSRyEnutyiU3nknal2SR0TtBiQR9uhAyw3wo6ginbTuh1dfvVHTy8taGw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(396003)(376002)(346002)(136003)(39860400002)(366004)(91956017)(36756003)(8936002)(76116006)(7416002)(66446008)(64756008)(8676002)(31686004)(2906002)(110136005)(66476007)(316002)(30864003)(66946007)(66556008)(5660300002)(71200400001)(41300700001)(53546011)(478600001)(83380400001)(2616005)(186003)(6512007)(921005)(26005)(122000001)(31696002)(86362001)(6486002)(38100700002)(6506007)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUJ3cnFiYTVXSklralVJV1V3cG92MllzT1lnbE4rNkw0d0VLbTM5VG9xWk55?=
 =?utf-8?B?UjR2OXR4TVRiZnVkN3Z1aEZVVkRkVmt2UFdZb2VMc2x4eTlSSDMvLzNKNTda?=
 =?utf-8?B?eGVQenhkVkR6anVBWVFrNjltQ3lXWEdzNVNWYUJuTW94cFVBYWs3VXJoYTFa?=
 =?utf-8?B?OGl4dC9uVCtwNDZOcGJSTmlhcHZ5LzhoM0ptNE1lWlZJRmQxdk9CNzI2VVZs?=
 =?utf-8?B?K3hJNTZPSURoRDlPY1RETjdvVUdsRnF5Zk9lQ2I2M29nR3VKS0Eya3Ftdm9I?=
 =?utf-8?B?VmVBWU91STg5S0ZlZG5uS2o2RHBET2RrclZuS09BeXNMbm9UQkh0SEZrVW5D?=
 =?utf-8?B?SVpNZVg5Z2dYMmtYLzArZ2hpTDh0OC94WkN5eU9SNk1JcXpIT3k1eTlJajI5?=
 =?utf-8?B?cGUvVGREcTJsNXh2WUVtR29NU0hRUDJpRFRMSkhoUmxxUEtjajdweVI4L2Yy?=
 =?utf-8?B?WU9FWkhmWEdmbzVDOHNMV1BhUmFWZDdBVHMzdWRRNWVPL2NYb3NRSXNOSHhX?=
 =?utf-8?B?ZWZ2bXNwMU9rSTZLU1ZZNUgvQWFwaWtrSUtKTVAzNXFZTEdyQk5NRHpwc2Fr?=
 =?utf-8?B?UWRXdjRKTGxNeEJJSjFPcG1JeW9MZnpjRTBTUk1ONE15ZE5vY0lOSXZUejM1?=
 =?utf-8?B?d1FoM1loZFVIaXNOL3dZOHh3UUYrdUNUMmlvMUM5aU51elJiL1l6dzF4OUFR?=
 =?utf-8?B?cnJqZk13WDdZMnhtSkJ6b0hreko1MGorLzBkUG9saXZiYlpsT1ZtckVvS2E1?=
 =?utf-8?B?bS9iRjBaRksvZWRaNXVmVE5zc1o0UnZ6VWFrS2M4Y3BuM1BEWEZSUmZQdmlW?=
 =?utf-8?B?U1hUMnZoOEpSeFlsaUJCTDUxazlnMmVVbXhlYjNGaVF5Um9NYzF2SlYxc2V5?=
 =?utf-8?B?ellvOHVoSm51ejB1ZWJzblk5WDVST0UxRmZsRDdvckpDcHFIQ1NCT0ZZNkNt?=
 =?utf-8?B?V09GeWo5SWNjUXNYM2tlWEJ3R0hsN3d2bWVveE9EbTMzS09tVWJEcVZiZ1B5?=
 =?utf-8?B?VVp6ZXBtRzU2eXpUMU1qc21MQnI4cVJqbi9mWkpKUXlLcHVwRUNBOHdweTRv?=
 =?utf-8?B?bzVnQVFmNVpkM2hkNVdDM2h1c2JNUGFKcThVNTMvN2hoclpCemloeEx4YVRU?=
 =?utf-8?B?bHdrRVZQL1NPV2NxWCtyUWFHOS9icDQzVWtpR2Q0RmFiSHY3YlZPQTJXMHNK?=
 =?utf-8?B?Rkw5WkkxbWRtK3M0eEs4dDNsYnVzZXUwWG1YMkJKSDRaM1N3SkZSZFhWTk4z?=
 =?utf-8?B?ZVArYk96TkJCRnFMZUhkZ3l3djVNUXRaV3lwbzdPUkJCSU5SZFZQTHZlelp6?=
 =?utf-8?B?MktFR2dRYi9wS3dINWFIV2xsSFdsZDE2MytscTc0ZVZzRCtWcWwwYVV5RlFl?=
 =?utf-8?B?ZEV0MDNLWEpGWHZMWXNLWlNjYVpzMVZPV1ozdFRQQVU1OTB4L2Ntd09XZVVz?=
 =?utf-8?B?SC9DU0N6K2R6TWVwRDk2bU9tVFlZcnorcWFqNURXS3lRZ3REcS9uZXBOWG9o?=
 =?utf-8?B?Y1BHU3JqNE1kaFo5TVRsSFByM2N1a2haSWtMZVpPQzRpZFNJeU5NRTJhdVNQ?=
 =?utf-8?B?b2xkMEFzYW9xTkdwTHROK2RIajFKc1dqMDlpalNMT1g1WStQdks2YzVnSGp0?=
 =?utf-8?B?RHBLV3dUOTcraWVnMjZJTGJwYkhlUTNrWWo1dzFTd0lFVFZETHlEZHZHajBO?=
 =?utf-8?B?dExML2FpWWhFN243YndoMDBrT2p5Y2lFNmdRbmMrd2lucEdYa2FScSs0REgx?=
 =?utf-8?B?cVFDdHZ3WEdqMDdlL2VqenZSVVlGR0FJRHNDdThYTEVQeFMrMm9zckZRTXJH?=
 =?utf-8?B?eTBkOWtrY050aEtyMXZPRGRJRUZFZEM4eng3UWVxV29uUTZBTEJHeGkrNk05?=
 =?utf-8?B?VEpuWm9DcTNBQWdCejIyTFYyYnlOdy9NQ2UyNUJKU2o0TTJka3NXTXZpUzM5?=
 =?utf-8?B?OURkUE9RcjZyOC9MSjllNmthamdqcjVrR0VvNlFLQXdVRkh6d1VkS0VnbDlC?=
 =?utf-8?B?c0JPT3J6NHRxejR4azAxdHpDZDlJckVkZVc0STRPbVl5NFR0cWJJekxaVHE5?=
 =?utf-8?B?SG5UUC9nM2VWMkVwR0FXQzlPZDZqMWNwMWdwUjRvZzJYOFVqcTJiWCtOZE1a?=
 =?utf-8?B?Q0krM0hKVWt1dW12RTltRElzRVEyZGt4Y3VvM25VK0JpWEZOMTVsK01IZjcy?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62412CFB906D78469A02724923065680@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a94ce92-e506-4837-5b11-08da91c8ae19
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 18:33:52.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZBAJjViFPNPIkymdm6+1cCm1Fm+C9C792pedz9BEWvLgMRV/8+2nzFffNQDuvn/5DIuM2jpA5g8FjZseRqPnFMLy5o4Zvo4jC38ztBxo+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDgvMDkvMjAyMiAxNTo0NCwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBTaW5jZSBjb21wb3NhYmxlIGNhY2hlIG1heSBiZSBMMyBj
YWNoZSBpZiB0aGVyZSBpcyBhIEwyIGNhY2hlLCB3ZSBzaG91bGQNCj4gdXNlIGl0cyBvcmlnaW5h
bCBuYW1lIGNvbXBvc2FibGUgY2FjaGUgdG8gcHJldmVudCBjb25mdXNpb24uDQo+IA0KPiBBcGFy
dCBmcm9tIHJlbmFtaW5nLCB3ZSBhbHNvIGFkZCB0aGUgY29tcGF0aWJsZSAic2lmaXZlLGNjYWNo
ZTAiIGludG8gSUQNCj4gdGFibGUuDQo+IA0KPiBUaGUgc2lmaXZlIEwyIGhhcyBiZWVuIHJlbmFt
ZWQgdG8gc2lmaXZlIENDQUNIRSwgRURBQyBkcml2ZXIgbmVlZHMgdG8NCj4gYXBwbHkgdGhlIGNo
YW5nZSBhcyB3ZWxsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR3JlZW50aW1lIEh1IDxncmVlbnRp
bWUuaHVAc2lmaXZlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5saUBzaWZp
dmUuY29tPg0KDQpTb0IgY2hhaW4gaGVyZSBpcyBvZGQgc3RpbGwsIGlmIEdyZWVudGltZSBjby1h
dXRob3JlZCB0aGV5IG5lZWQgdG8gaGF2ZQ0KYSBDby1kZXZlbG9wZWQtYnkgdGFnLg0KDQpPdGhl
cndpc2U6DQpSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlw
LmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvZWRhYy9LY29uZmlnICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgMiArLQ0KPiAgZHJpdmVycy9lZGFjL3NpZml2ZV9lZGFjLmMgICAgICAgICAg
ICAgICAgICAgIHwgIDEyICstDQo+ICBkcml2ZXJzL3NvYy9zaWZpdmUvS2NvbmZpZyAgICAgICAg
ICAgICAgICAgICAgfCAgIDYgKy0NCj4gIGRyaXZlcnMvc29jL3NpZml2ZS9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgLi4uL3tzaWZpdmVfbDJfY2FjaGUuYyA9PiBzaWZp
dmVfY2NhY2hlLmN9ICAgIHwgMTc0ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgLi4uL3tzaWZpdmVf
bDJfY2FjaGUuaCA9PiBzaWZpdmVfY2NhY2hlLmh9ICAgIHwgIDE2ICstDQo+ICA2IGZpbGVzIGNo
YW5nZWQsIDExMCBpbnNlcnRpb25zKCspLCAxMDIgZGVsZXRpb25zKC0pDQo+ICByZW5hbWUgZHJp
dmVycy9zb2Mvc2lmaXZlL3tzaWZpdmVfbDJfY2FjaGUuYyA9PiBzaWZpdmVfY2NhY2hlLmN9ICgz
NCUpDQo+ICByZW5hbWUgaW5jbHVkZS9zb2Mvc2lmaXZlL3tzaWZpdmVfbDJfY2FjaGUuaCA9PiBz
aWZpdmVfY2NhY2hlLmh9ICgxMiUpDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9lZGFjL0tj
b25maWcgYi9kcml2ZXJzL2VkYWMvS2NvbmZpZw0KPiBpbmRleCAxNzU2MmNmMWZlOTcuLjQ1NjYw
MmQzNzNiNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9lZGFjL0tjb25maWcNCj4gKysrIGIvZHJp
dmVycy9lZGFjL0tjb25maWcNCj4gQEAgLTQ3Myw3ICs0NzMsNyBAQCBjb25maWcgRURBQ19BTFRF
UkFfU0RNTUMNCj4gDQo+ICBjb25maWcgRURBQ19TSUZJVkUNCj4gICAgICAgICBib29sICJTaWZp
dmUgcGxhdGZvcm0gRURBQyBkcml2ZXIiDQo+IC0gICAgICAgZGVwZW5kcyBvbiBFREFDPXkgJiYg
U0lGSVZFX0wyDQo+ICsgICAgICAgZGVwZW5kcyBvbiBFREFDPXkgJiYgU0lGSVZFX0NDQUNIRQ0K
PiAgICAgICAgIGhlbHANCj4gICAgICAgICAgIFN1cHBvcnQgZm9yIGVycm9yIGRldGVjdGlvbiBh
bmQgY29ycmVjdGlvbiBvbiB0aGUgU2lGaXZlIFNvQ3MuDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9lZGFjL3NpZml2ZV9lZGFjLmMgYi9kcml2ZXJzL2VkYWMvc2lmaXZlX2VkYWMuYw0KPiBp
bmRleCBlZTgwMGFlYzdkNDcuLmI4NDRlMjYyNmZkNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9l
ZGFjL3NpZml2ZV9lZGFjLmMNCj4gKysrIGIvZHJpdmVycy9lZGFjL3NpZml2ZV9lZGFjLmMNCj4g
QEAgLTIsNyArMiw3IEBADQo+ICAvKg0KPiAgICogU2lGaXZlIFBsYXRmb3JtIEVEQUMgRHJpdmVy
DQo+ICAgKg0KPiAtICogQ29weXJpZ2h0IChDKSAyMDE4LTIwMTkgU2lGaXZlLCBJbmMuDQo+ICsg
KiBDb3B5cmlnaHQgKEMpIDIwMTgtMjAyMiBTaUZpdmUsIEluYy4NCj4gICAqDQo+ICAgKiBUaGlz
IGRyaXZlciBpcyBwYXJ0aWFsbHkgYmFzZWQgb24gb2N0ZW9uX2VkYWMtcGMuYw0KPiAgICoNCj4g
QEAgLTEwLDcgKzEwLDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9lZGFjLmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ICAjaW5jbHVkZSAiZWRhY19tb2R1bGUuaCIN
Cj4gLSNpbmNsdWRlIDxzb2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5oPg0KPiArI2luY2x1ZGUg
PHNvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5oPg0KPiANCj4gICNkZWZpbmUgRFJWTkFNRSAic2lm
aXZlX2VkYWMiDQo+IA0KPiBAQCAtMzIsOSArMzIsOSBAQCBpbnQgZWNjX2Vycl9ldmVudChzdHJ1
Y3Qgbm90aWZpZXJfYmxvY2sgKnRoaXMsIHVuc2lnbmVkIGxvbmcgZXZlbnQsIHZvaWQgKnB0cikN
Cj4gDQo+ICAgICAgICAgcCA9IGNvbnRhaW5lcl9vZih0aGlzLCBzdHJ1Y3Qgc2lmaXZlX2VkYWNf
cHJpdiwgbm90aWZpZXIpOw0KPiANCj4gLSAgICAgICBpZiAoZXZlbnQgPT0gU0lGSVZFX0wyX0VS
Ul9UWVBFX1VFKQ0KPiArICAgICAgIGlmIChldmVudCA9PSBTSUZJVkVfQ0NBQ0hFX0VSUl9UWVBF
X1VFKQ0KPiAgICAgICAgICAgICAgICAgZWRhY19kZXZpY2VfaGFuZGxlX3VlKHAtPmRjaSwgMCwg
MCwgbXNnKTsNCj4gLSAgICAgICBlbHNlIGlmIChldmVudCA9PSBTSUZJVkVfTDJfRVJSX1RZUEVf
Q0UpDQo+ICsgICAgICAgZWxzZSBpZiAoZXZlbnQgPT0gU0lGSVZFX0NDQUNIRV9FUlJfVFlQRV9D
RSkNCj4gICAgICAgICAgICAgICAgIGVkYWNfZGV2aWNlX2hhbmRsZV9jZShwLT5kY2ksIDAsIDAs
IG1zZyk7DQo+IA0KPiAgICAgICAgIHJldHVybiBOT1RJRllfT0s7DQo+IEBAIC02Nyw3ICs2Nyw3
IEBAIHN0YXRpYyBpbnQgZWNjX3JlZ2lzdGVyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAg
IHJlZ2lzdGVyX3NpZml2ZV9sMl9lcnJvcl9ub3RpZmllcigmcC0+bm90aWZpZXIpOw0KPiArICAg
ICAgIHJlZ2lzdGVyX3NpZml2ZV9jY2FjaGVfZXJyb3Jfbm90aWZpZXIoJnAtPm5vdGlmaWVyKTsN
Cj4gDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBAQCAtODEsNyArODEsNyBAQCBzdGF0aWMg
aW50IGVjY191bnJlZ2lzdGVyKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICB7DQo+
ICAgICAgICAgc3RydWN0IHNpZml2ZV9lZGFjX3ByaXYgKnAgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShwZGV2KTsNCj4gDQo+IC0gICAgICAgdW5yZWdpc3Rlcl9zaWZpdmVfbDJfZXJyb3Jfbm90aWZp
ZXIoJnAtPm5vdGlmaWVyKTsNCj4gKyAgICAgICB1bnJlZ2lzdGVyX3NpZml2ZV9jY2FjaGVfZXJy
b3Jfbm90aWZpZXIoJnAtPm5vdGlmaWVyKTsNCj4gICAgICAgICBlZGFjX2RldmljZV9kZWxfZGV2
aWNlKCZwZGV2LT5kZXYpOw0KPiAgICAgICAgIGVkYWNfZGV2aWNlX2ZyZWVfY3RsX2luZm8ocC0+
ZGNpKTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9zaWZpdmUvS2NvbmZpZyBiL2Ry
aXZlcnMvc29jL3NpZml2ZS9LY29uZmlnDQo+IGluZGV4IDU4Y2Y4YzQwZDA4ZC4uZWQ0YzU3MWY4
NzcxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9zaWZpdmUvS2NvbmZpZw0KPiArKysgYi9k
cml2ZXJzL3NvYy9zaWZpdmUvS2NvbmZpZw0KPiBAQCAtMiw5ICsyLDkgQEANCj4gDQo+ICBpZiBT
T0NfU0lGSVZFDQo+IA0KPiAtY29uZmlnIFNJRklWRV9MMg0KPiAtICAgICAgIGJvb2wgIlNpZml2
ZSBMMiBDYWNoZSBjb250cm9sbGVyIg0KPiArY29uZmlnIFNJRklWRV9DQ0FDSEUNCj4gKyAgICAg
ICBib29sICJTaWZpdmUgQ29tcG9zYWJsZSBDYWNoZSBjb250cm9sbGVyIg0KPiAgICAgICAgIGhl
bHANCj4gLSAgICAgICAgIFN1cHBvcnQgZm9yIHRoZSBMMiBjYWNoZSBjb250cm9sbGVyIG9uIFNp
Rml2ZSBwbGF0Zm9ybXMuDQo+ICsgICAgICAgICBTdXBwb3J0IGZvciB0aGUgY29tcG9zYWJsZSBj
YWNoZSBjb250cm9sbGVyIG9uIFNpRml2ZSBwbGF0Zm9ybXMuDQo+IA0KPiAgZW5kaWYNCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9NYWtlZmlsZSBiL2RyaXZlcnMvc29jL3NpZml2
ZS9NYWtlZmlsZQ0KPiBpbmRleCBiNWNhZmY3NzkzOGYuLjFmNWRjMzM5YmY4MiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9zb2Mvc2lmaXZlL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvc29jL3Np
Zml2ZS9NYWtlZmlsZQ0KPiBAQCAtMSwzICsxLDMgQEANCj4gICMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gDQo+IC1vYmotJChDT05GSUdfU0lGSVZFX0wyKSAgICAgICAgKz0g
c2lmaXZlX2wyX2NhY2hlLm8NCj4gK29iai0kKENPTkZJR19TSUZJVkVfQ0NBQ0hFKSAgICArPSBz
aWZpdmVfY2NhY2hlLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVf
bDJfY2FjaGUuYyBiL2RyaXZlcnMvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmMNCj4gc2ltaWxh
cml0eSBpbmRleCAzNCUNCj4gcmVuYW1lIGZyb20gZHJpdmVycy9zb2Mvc2lmaXZlL3NpZml2ZV9s
Ml9jYWNoZS5jDQo+IHJlbmFtZSB0byBkcml2ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5j
DQo+IGluZGV4IDU5NjQwYTFkMGIyOC4uOTQ5YjgyNGU4OWFkIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3NvYy9zaWZpdmUvc2lmaXZlX2wyX2NhY2hlLmMNCj4gKysrIGIvZHJpdmVycy9zb2Mvc2lm
aXZlL3NpZml2ZV9jY2FjaGUuYw0KPiBAQCAtMSw4ICsxLDggQEANCj4gIC8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICAvKg0KPiAtICogU2lGaXZlIEwyIGNhY2hlIGNvbnRy
b2xsZXIgRHJpdmVyDQo+ICsgKiBTaUZpdmUgY29tcG9zYWJsZSBjYWNoZSBjb250cm9sbGVyIERy
aXZlcg0KPiAgICoNCj4gLSAqIENvcHlyaWdodCAoQykgMjAxOC0yMDE5IFNpRml2ZSwgSW5jLg0K
PiArICogQ29weXJpZ2h0IChDKSAyMDE4LTIwMjIgU2lGaXZlLCBJbmMuDQo+ICAgKg0KPiAgICov
DQo+ICAjaW5jbHVkZSA8bGludXgvZGVidWdmcy5oPg0KPiBAQCAtMTEsMzMgKzExLDMzIEBADQo+
ICAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2Rldmlj
ZS5oPg0KPiAgI2luY2x1ZGUgPGFzbS9jYWNoZWluZm8uaD4NCj4gLSNpbmNsdWRlIDxzb2Mvc2lm
aXZlL3NpZml2ZV9sMl9jYWNoZS5oPg0KPiArI2luY2x1ZGUgPHNvYy9zaWZpdmUvc2lmaXZlX2Nj
YWNoZS5oPg0KPiANCj4gLSNkZWZpbmUgU0lGSVZFX0wyX0RJUkVDQ0ZJWF9MT1cgMHgxMDANCj4g
LSNkZWZpbmUgU0lGSVZFX0wyX0RJUkVDQ0ZJWF9ISUdIIDB4MTA0DQo+IC0jZGVmaW5lIFNJRklW
RV9MMl9ESVJFQ0NGSVhfQ09VTlQgMHgxMDgNCj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9ESVJF
Q0NGSVhfTE9XIDB4MTAwDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FDSEVfRElSRUNDRklYX0hJR0gg
MHgxMDQNCj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9ESVJFQ0NGSVhfQ09VTlQgMHgxMDgNCj4g
DQo+IC0jZGVmaW5lIFNJRklWRV9MMl9ESVJFQ0NGQUlMX0xPVyAweDEyMA0KPiAtI2RlZmluZSBT
SUZJVkVfTDJfRElSRUNDRkFJTF9ISUdIIDB4MTI0DQo+IC0jZGVmaW5lIFNJRklWRV9MMl9ESVJF
Q0NGQUlMX0NPVU5UIDB4MTI4DQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FDSEVfRElSRUNDRkFJTF9M
T1cgMHgxMjANCj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9ESVJFQ0NGQUlMX0hJR0ggMHgxMjQN
Cj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9ESVJFQ0NGQUlMX0NPVU5UIDB4MTI4DQo+IA0KPiAt
I2RlZmluZSBTSUZJVkVfTDJfREFURUNDRklYX0xPVyAweDE0MA0KPiAtI2RlZmluZSBTSUZJVkVf
TDJfREFURUNDRklYX0hJR0ggMHgxNDQNCj4gLSNkZWZpbmUgU0lGSVZFX0wyX0RBVEVDQ0ZJWF9D
T1VOVCAweDE0OA0KPiArI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZJWF9MT1cgMHgxNDAN
Cj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGSVhfSElHSCAweDE0NA0KPiArI2RlZmlu
ZSBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZJWF9DT1VOVCAweDE0OA0KPiANCj4gLSNkZWZpbmUgU0lG
SVZFX0wyX0RBVEVDQ0ZBSUxfTE9XIDB4MTYwDQo+IC0jZGVmaW5lIFNJRklWRV9MMl9EQVRFQ0NG
QUlMX0hJR0ggMHgxNjQNCj4gLSNkZWZpbmUgU0lGSVZFX0wyX0RBVEVDQ0ZBSUxfQ09VTlQgMHgx
NjgNCj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGQUlMX0xPVyAweDE2MA0KPiArI2Rl
ZmluZSBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxfSElHSCAweDE2NA0KPiArI2RlZmluZSBTSUZJ
VkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxfQ09VTlQgMHgxNjgNCj4gDQo+IC0jZGVmaW5lIFNJRklWRV9M
Ml9DT05GSUcgMHgwMA0KPiAtI2RlZmluZSBTSUZJVkVfTDJfV0FZRU5BQkxFIDB4MDgNCj4gLSNk
ZWZpbmUgU0lGSVZFX0wyX0VDQ0lOSkVDVEVSUiAweDQwDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FD
SEVfQ09ORklHIDB4MDANCj4gKyNkZWZpbmUgU0lGSVZFX0NDQUNIRV9XQVlFTkFCTEUgMHgwOA0K
PiArI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX0VDQ0lOSkVDVEVSUiAweDQwDQo+IA0KPiAtI2RlZmlu
ZSBTSUZJVkVfTDJfTUFYX0VDQ0lOVFIgNA0KPiArI2RlZmluZSBTSUZJVkVfQ0NBQ0hFX01BWF9F
Q0NJTlRSIDQNCj4gDQo+IC1zdGF0aWMgdm9pZCBfX2lvbWVtICpsMl9iYXNlOw0KPiAtc3RhdGlj
IGludCBnX2lycVtTSUZJVkVfTDJfTUFYX0VDQ0lOVFJdOw0KPiAtc3RhdGljIHN0cnVjdCByaXNj
dl9jYWNoZWluZm9fb3BzIGwyX2NhY2hlX29wczsNCj4gK3N0YXRpYyB2b2lkIF9faW9tZW0gKmNj
YWNoZV9iYXNlOw0KPiArc3RhdGljIGludCBnX2lycVtTSUZJVkVfQ0NBQ0hFX01BWF9FQ0NJTlRS
XTsNCj4gK3N0YXRpYyBzdHJ1Y3QgcmlzY3ZfY2FjaGVpbmZvX29wcyBjY2FjaGVfY2FjaGVfb3Bz
Ow0KPiANCj4gIGVudW0gew0KPiAgICAgICAgIERJUl9DT1JSID0gMCwNCj4gQEAgLTQ5LDgzICs0
OSw4NCBAQCBlbnVtIHsNCj4gICNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4gIHN0YXRpYyBzdHJ1
Y3QgZGVudHJ5ICpzaWZpdmVfdGVzdDsNCj4gDQo+IC1zdGF0aWMgc3NpemVfdCBsMl93cml0ZShz
dHJ1Y3QgZmlsZSAqZmlsZSwgY29uc3QgY2hhciBfX3VzZXIgKmRhdGEsDQo+IC0gICAgICAgICAg
ICAgICAgICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpwcG9zKQ0KPiArc3RhdGljIHNzaXpl
X3QgY2NhY2hlX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLCBjb25zdCBjaGFyIF9fdXNlciAqZGF0
YSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICpw
cG9zKQ0KPiAgew0KPiAgICAgICAgIHVuc2lnbmVkIGludCB2YWw7DQo+IA0KPiAgICAgICAgIGlm
IChrc3RydG91aW50X2Zyb21fdXNlcihkYXRhLCBjb3VudCwgMCwgJnZhbCkpDQo+ICAgICAgICAg
ICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gICAgICAgICBpZiAoKHZhbCA8IDB4RkYpIHx8ICh2
YWwgPj0gMHgxMDAwMCAmJiB2YWwgPCAweDEwMEZGKSkNCj4gLSAgICAgICAgICAgICAgIHdyaXRl
bCh2YWwsIGwyX2Jhc2UgKyBTSUZJVkVfTDJfRUNDSU5KRUNURVJSKTsNCj4gKyAgICAgICAgICAg
ICAgIHdyaXRlbCh2YWwsIGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9FQ0NJTkpFQ1RFUlIp
Ow0KPiAgICAgICAgIGVsc2UNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAg
ICAgICAgIHJldHVybiBjb3VudDsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGZp
bGVfb3BlcmF0aW9ucyBsMl9mb3BzID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29w
ZXJhdGlvbnMgY2NhY2hlX2ZvcHMgPSB7DQo+ICAgICAgICAgLm93bmVyID0gVEhJU19NT0RVTEUs
DQo+ICAgICAgICAgLm9wZW4gPSBzaW1wbGVfb3BlbiwNCj4gLSAgICAgICAud3JpdGUgPSBsMl93
cml0ZQ0KPiArICAgICAgIC53cml0ZSA9IGNjYWNoZV93cml0ZQ0KPiAgfTsNCj4gDQo+ICBzdGF0
aWMgdm9pZCBzZXR1cF9zaWZpdmVfZGVidWcodm9pZCkNCj4gIHsNCj4gLSAgICAgICBzaWZpdmVf
dGVzdCA9IGRlYnVnZnNfY3JlYXRlX2Rpcigic2lmaXZlX2wyX2NhY2hlIiwgTlVMTCk7DQo+ICsg
ICAgICAgc2lmaXZlX3Rlc3QgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoInNpZml2ZV9jY2FjaGVfY2Fj
aGUiLCBOVUxMKTsNCj4gDQo+ICAgICAgICAgZGVidWdmc19jcmVhdGVfZmlsZSgic2lmaXZlX2Rl
YnVnX2luamVjdF9lcnJvciIsIDAyMDAsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBz
aWZpdmVfdGVzdCwgTlVMTCwgJmwyX2ZvcHMpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgc2lmaXZlX3Rlc3QsIE5VTEwsICZjY2FjaGVfZm9wcyk7DQo+ICB9DQo+ICAjZW5kaWYNCj4g
DQo+IC1zdGF0aWMgdm9pZCBsMl9jb25maWdfcmVhZCh2b2lkKQ0KPiArc3RhdGljIHZvaWQgY2Nh
Y2hlX2NvbmZpZ19yZWFkKHZvaWQpDQo+ICB7DQo+ICAgICAgICAgdTMyIHJlZ3ZhbCwgdmFsOw0K
PiANCj4gLSAgICAgICByZWd2YWwgPSByZWFkbChsMl9iYXNlICsgU0lGSVZFX0wyX0NPTkZJRyk7
DQo+ICsgICAgICAgcmVndmFsID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0NP
TkZJRyk7DQo+ICAgICAgICAgdmFsID0gcmVndmFsICYgMHhGRjsNCj4gLSAgICAgICBwcl9pbmZv
KCJMMkNBQ0hFOiBOby4gb2YgQmFua3MgaW4gdGhlIGNhY2hlOiAlZFxuIiwgdmFsKTsNCj4gKyAg
ICAgICBwcl9pbmZvKCJDQ0FDSEU6IE5vLiBvZiBCYW5rcyBpbiB0aGUgY2FjaGU6ICVkXG4iLCB2
YWwpOw0KPiAgICAgICAgIHZhbCA9IChyZWd2YWwgJiAweEZGMDApID4+IDg7DQo+IC0gICAgICAg
cHJfaW5mbygiTDJDQUNIRTogTm8uIG9mIHdheXMgcGVyIGJhbms6ICVkXG4iLCB2YWwpOw0KPiAr
ICAgICAgIHByX2luZm8oIkNDQUNIRTogTm8uIG9mIHdheXMgcGVyIGJhbms6ICVkXG4iLCB2YWwp
Ow0KPiAgICAgICAgIHZhbCA9IChyZWd2YWwgJiAweEZGMDAwMCkgPj4gMTY7DQo+IC0gICAgICAg
cHJfaW5mbygiTDJDQUNIRTogU2V0cyBwZXIgYmFuazogJWxsdVxuIiwgKHVpbnQ2NF90KTEgPDwg
dmFsKTsNCj4gKyAgICAgICBwcl9pbmZvKCJDQ0FDSEU6IFNldHMgcGVyIGJhbms6ICVsbHVcbiIs
ICh1aW50NjRfdCkxIDw8IHZhbCk7DQo+ICAgICAgICAgdmFsID0gKHJlZ3ZhbCAmIDB4RkYwMDAw
MDApID4+IDI0Ow0KPiAtICAgICAgIHByX2luZm8oIkwyQ0FDSEU6IEJ5dGVzIHBlciBjYWNoZSBi
bG9jazogJWxsdVxuIiwgKHVpbnQ2NF90KTEgPDwgdmFsKTsNCj4gKyAgICAgICBwcl9pbmZvKCJD
Q0FDSEU6IEJ5dGVzIHBlciBjYWNoZSBibG9jazogJWxsdVxuIiwgKHVpbnQ2NF90KTEgPDwgdmFs
KTsNCj4gDQo+IC0gICAgICAgcmVndmFsID0gcmVhZGwobDJfYmFzZSArIFNJRklWRV9MMl9XQVlF
TkFCTEUpOw0KPiAtICAgICAgIHByX2luZm8oIkwyQ0FDSEU6IEluZGV4IG9mIHRoZSBsYXJnZXN0
IHdheSBlbmFibGVkOiAlZFxuIiwgcmVndmFsKTsNCj4gKyAgICAgICByZWd2YWwgPSByZWFkbChj
Y2FjaGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfV0FZRU5BQkxFKTsNCj4gKyAgICAgICBwcl9pbmZv
KCJDQ0FDSEU6IEluZGV4IG9mIHRoZSBsYXJnZXN0IHdheSBlbmFibGVkOiAlZFxuIiwgcmVndmFs
KTsNCj4gIH0NCj4gDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzaWZpdmVf
bDJfaWRzW10gPSB7DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzaWZpdmVf
Y2NhY2hlX2lkc1tdID0gew0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAic2lmaXZlLGZ1NTQw
LWMwMDAtY2NhY2hlIiB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAic2lmaXZlLGZ1NzQw
LWMwMDAtY2NhY2hlIiB9LA0KPiAtICAgICAgIHsgLyogZW5kIG9mIHRhYmxlICovIH0sDQo+ICsg
ICAgICAgeyAuY29tcGF0aWJsZSA9ICJzaWZpdmUsY2NhY2hlMCIgfSwNCj4gKyAgICAgICB7IC8q
IGVuZCBvZiB0YWJsZSAqLyB9DQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBBVE9NSUNfTk9USUZJRVJf
SEVBRChsMl9lcnJfY2hhaW4pOw0KPiArc3RhdGljIEFUT01JQ19OT1RJRklFUl9IRUFEKGNjYWNo
ZV9lcnJfY2hhaW4pOw0KPiANCj4gLWludCByZWdpc3Rlcl9zaWZpdmVfbDJfZXJyb3Jfbm90aWZp
ZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikNCj4gK2ludCByZWdpc3Rlcl9zaWZpdmVfY2Nh
Y2hlX2Vycm9yX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpDQo+ICB7DQo+IC0g
ICAgICAgcmV0dXJuIGF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcigmbDJfZXJyX2NoYWlu
LCBuYik7DQo+ICsgICAgICAgcmV0dXJuIGF0b21pY19ub3RpZmllcl9jaGFpbl9yZWdpc3Rlcigm
Y2NhY2hlX2Vycl9jaGFpbiwgbmIpOw0KPiAgfQ0KPiAtRVhQT1JUX1NZTUJPTF9HUEwocmVnaXN0
ZXJfc2lmaXZlX2wyX2Vycm9yX25vdGlmaWVyKTsNCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHJlZ2lz
dGVyX3NpZml2ZV9jY2FjaGVfZXJyb3Jfbm90aWZpZXIpOw0KPiANCj4gLWludCB1bnJlZ2lzdGVy
X3NpZml2ZV9sMl9lcnJvcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKQ0KPiAr
aW50IHVucmVnaXN0ZXJfc2lmaXZlX2NjYWNoZV9lcnJvcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgKm5iKQ0KPiAgew0KPiAtICAgICAgIHJldHVybiBhdG9taWNfbm90aWZpZXJfY2hh
aW5fdW5yZWdpc3RlcigmbDJfZXJyX2NoYWluLCBuYik7DQo+ICsgICAgICAgcmV0dXJuIGF0b21p
Y19ub3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKCZjY2FjaGVfZXJyX2NoYWluLCBuYik7DQo+ICB9
DQo+IC1FWFBPUlRfU1lNQk9MX0dQTCh1bnJlZ2lzdGVyX3NpZml2ZV9sMl9lcnJvcl9ub3RpZmll
cik7DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1bnJlZ2lzdGVyX3NpZml2ZV9jY2FjaGVfZXJyb3Jf
bm90aWZpZXIpOw0KPiANCj4gLXN0YXRpYyBpbnQgbDJfbGFyZ2VzdF93YXllbmFibGVkKHZvaWQp
DQo+ICtzdGF0aWMgaW50IGNjYWNoZV9sYXJnZXN0X3dheWVuYWJsZWQodm9pZCkNCj4gIHsNCj4g
LSAgICAgICByZXR1cm4gcmVhZGwobDJfYmFzZSArIFNJRklWRV9MMl9XQVlFTkFCTEUpICYgMHhG
RjsNCj4gKyAgICAgICByZXR1cm4gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX1dB
WUVOQUJMRSkgJiAweEZGOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBzc2l6ZV90IG51bWJlcl9vZl93
YXlzX2VuYWJsZWRfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKmJ1ZikN
Cj4gIHsNCj4gLSAgICAgICByZXR1cm4gc3ByaW50ZihidWYsICIldVxuIiwgbDJfbGFyZ2VzdF93
YXllbmFibGVkKCkpOw0KPiArICAgICAgIHJldHVybiBzcHJpbnRmKGJ1ZiwgIiV1XG4iLCBjY2Fj
aGVfbGFyZ2VzdF93YXllbmFibGVkKCkpOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBERVZJQ0VfQVRU
Ul9STyhudW1iZXJfb2Zfd2F5c19lbmFibGVkKTsNCj4gQEAgLTEzOSw5OSArMTQwLDEwNiBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBwcml2X2F0dHJfZ3JvdXAgPSB7DQo+
ICAgICAgICAgLmF0dHJzID0gcHJpdl9hdHRycywNCj4gIH07DQo+IA0KPiAtc3RhdGljIGNvbnN0
IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmwyX2dldF9wcml2X2dyb3VwKHN0cnVjdCBjYWNoZWlu
Zm8gKnRoaXNfbGVhZikNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwICpj
Y2FjaGVfZ2V0X3ByaXZfZ3JvdXAoc3RydWN0IGNhY2hlaW5mbw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICp0aGlzX2xlYWYpDQo+
ICB7DQo+IC0gICAgICAgLyogV2Ugd2FudCB0byB1c2UgcHJpdmF0ZSBncm91cCBmb3IgTDIgY2Fj
aGUgb25seSAqLw0KPiArICAgICAgIC8qIFdlIHdhbnQgdG8gdXNlIHByaXZhdGUgZ3JvdXAgZm9y
IGNvbXBvc2FibGUgY2FjaGUgb25seSAqLw0KPiAgICAgICAgIGlmICh0aGlzX2xlYWYtPmxldmVs
ID09IDIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gJnByaXZfYXR0cl9ncm91cDsNCj4gICAg
ICAgICBlbHNlDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gIH0NCj4gDQo+IC1z
dGF0aWMgaXJxcmV0dXJuX3QgbDJfaW50X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2aWNlKQ0K
PiArc3RhdGljIGlycXJldHVybl90IGNjYWNoZV9pbnRfaGFuZGxlcihpbnQgaXJxLCB2b2lkICpk
ZXZpY2UpDQo+ICB7DQo+ICAgICAgICAgdW5zaWduZWQgaW50IGFkZF9oLCBhZGRfbDsNCj4gDQo+
ICAgICAgICAgaWYgKGlycSA9PSBnX2lycVtESVJfQ09SUl0pIHsNCj4gLSAgICAgICAgICAgICAg
IGFkZF9oID0gcmVhZGwobDJfYmFzZSArIFNJRklWRV9MMl9ESVJFQ0NGSVhfSElHSCk7DQo+IC0g
ICAgICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJfRElSRUNDRklY
X0xPVyk7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkwyQ0FDSEU6IERpckVycm9yIEAgMHgl
MDhYLiUwOFhcbiIsIGFkZF9oLCBhZGRfbCk7DQo+ICsgICAgICAgICAgICAgICBhZGRfaCA9IHJl
YWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9ESVJFQ0NGSVhfSElHSCk7DQo+ICsgICAg
ICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9ESVJF
Q0NGSVhfTE9XKTsNCj4gKyAgICAgICAgICAgICAgIHByX2VycigiQ0NBQ0hFOiBEaXJFcnJvciBA
IDB4JTA4WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiAgICAgICAgICAgICAgICAgLyogUmVh
ZGluZyB0aGlzIHJlZ2lzdGVyIGNsZWFycyB0aGUgRGlyRXJyb3IgaW50ZXJydXB0IHNpZyAqLw0K
PiAtICAgICAgICAgICAgICAgcmVhZGwobDJfYmFzZSArIFNJRklWRV9MMl9ESVJFQ0NGSVhfQ09V
TlQpOw0KPiAtICAgICAgICAgICAgICAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4oJmwyX2Vy
cl9jaGFpbiwgU0lGSVZFX0wyX0VSUl9UWVBFX0NFLA0KPiArICAgICAgICAgICAgICAgcmVhZGwo
Y2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RJUkVDQ0ZJWF9DT1VOVCk7DQo+ICsgICAgICAg
ICAgICAgICBhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbigmY2NhY2hlX2Vycl9jaGFpbiwNCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNJRklWRV9DQ0FDSEVf
RVJSX1RZUEVfQ0UsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiRGlyRUNDRml4Iik7DQo+ICAgICAgICAgfQ0KPiAgICAgICAgIGlmIChpcnEgPT0gZ19pcnFb
RElSX1VOQ09SUl0pIHsNCj4gLSAgICAgICAgICAgICAgIGFkZF9oID0gcmVhZGwobDJfYmFzZSAr
IFNJRklWRV9MMl9ESVJFQ0NGQUlMX0hJR0gpOw0KPiAtICAgICAgICAgICAgICAgYWRkX2wgPSBy
ZWFkbChsMl9iYXNlICsgU0lGSVZFX0wyX0RJUkVDQ0ZBSUxfTE9XKTsNCj4gKyAgICAgICAgICAg
ICAgIGFkZF9oID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RJUkVDQ0ZBSUxf
SElHSCk7DQo+ICsgICAgICAgICAgICAgICBhZGRfbCA9IHJlYWRsKGNjYWNoZV9iYXNlICsgU0lG
SVZFX0NDQUNIRV9ESVJFQ0NGQUlMX0xPVyk7DQo+ICAgICAgICAgICAgICAgICAvKiBSZWFkaW5n
IHRoaXMgcmVnaXN0ZXIgY2xlYXJzIHRoZSBEaXJGYWlsIGludGVycnVwdCBzaWcgKi8NCj4gLSAg
ICAgICAgICAgICAgIHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJfRElSRUNDRkFJTF9DT1VOVCk7
DQo+IC0gICAgICAgICAgICAgICBhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbigmbDJfZXJyX2No
YWluLCBTSUZJVkVfTDJfRVJSX1RZUEVfVUUsDQo+ICsgICAgICAgICAgICAgICByZWFkbChjY2Fj
aGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfRElSRUNDRkFJTF9DT1VOVCk7DQo+ICsgICAgICAgICAg
ICAgICBhdG9taWNfbm90aWZpZXJfY2FsbF9jaGFpbigmY2NhY2hlX2Vycl9jaGFpbiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNJRklWRV9DQ0FDSEVfRVJS
X1RZUEVfVUUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
RGlyRUNDRmFpbCIpOw0KPiAtICAgICAgICAgICAgICAgcGFuaWMoIkwyQ0FDSEU6IERpckZhaWwg
QCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gKyAgICAgICAgICAgICAgIHBhbmlj
KCJDQ0FDSEU6IERpckZhaWwgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gICAg
ICAgICB9DQo+ICAgICAgICAgaWYgKGlycSA9PSBnX2lycVtEQVRBX0NPUlJdKSB7DQo+IC0gICAg
ICAgICAgICAgICBhZGRfaCA9IHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJfREFURUNDRklYX0hJ
R0gpOw0KPiAtICAgICAgICAgICAgICAgYWRkX2wgPSByZWFkbChsMl9iYXNlICsgU0lGSVZFX0wy
X0RBVEVDQ0ZJWF9MT1cpOw0KPiAtICAgICAgICAgICAgICAgcHJfZXJyKCJMMkNBQ0hFOiBEYXRh
RXJyb3IgQCAweCUwOFguJTA4WFxuIiwgYWRkX2gsIGFkZF9sKTsNCj4gKyAgICAgICAgICAgICAg
IGFkZF9oID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZJWF9ISUdI
KTsNCj4gKyAgICAgICAgICAgICAgIGFkZF9sID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVf
Q0NBQ0hFX0RBVEVDQ0ZJWF9MT1cpOw0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCJDQ0FDSEU6
IERhdGFFcnJvciBAIDB4JTA4WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiAgICAgICAgICAg
ICAgICAgLyogUmVhZGluZyB0aGlzIHJlZ2lzdGVyIGNsZWFycyB0aGUgRGF0YUVycm9yIGludGVy
cnVwdCBzaWcgKi8NCj4gLSAgICAgICAgICAgICAgIHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJf
REFURUNDRklYX0NPVU5UKTsNCj4gLSAgICAgICAgICAgICAgIGF0b21pY19ub3RpZmllcl9jYWxs
X2NoYWluKCZsMl9lcnJfY2hhaW4sIFNJRklWRV9MMl9FUlJfVFlQRV9DRSwNCj4gKyAgICAgICAg
ICAgICAgIHJlYWRsKGNjYWNoZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGSVhfQ09VTlQp
Ow0KPiArICAgICAgICAgICAgICAgYXRvbWljX25vdGlmaWVyX2NhbGxfY2hhaW4oJmNjYWNoZV9l
cnJfY2hhaW4sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
SUZJVkVfQ0NBQ0hFX0VSUl9UWVBFX0NFLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIkRhdEVDQ0ZpeCIpOw0KPiAgICAgICAgIH0NCj4gICAgICAgICBpZiAo
aXJxID09IGdfaXJxW0RBVEFfVU5DT1JSXSkgew0KPiAtICAgICAgICAgICAgICAgYWRkX2ggPSBy
ZWFkbChsMl9iYXNlICsgU0lGSVZFX0wyX0RBVEVDQ0ZBSUxfSElHSCk7DQo+IC0gICAgICAgICAg
ICAgICBhZGRfbCA9IHJlYWRsKGwyX2Jhc2UgKyBTSUZJVkVfTDJfREFURUNDRkFJTF9MT1cpOw0K
PiAtICAgICAgICAgICAgICAgcHJfZXJyKCJMMkNBQ0hFOiBEYXRhRmFpbCBAIDB4JTA4WC4lMDhY
XG4iLCBhZGRfaCwgYWRkX2wpOw0KPiArICAgICAgICAgICAgICAgYWRkX2ggPSByZWFkbChjY2Fj
aGVfYmFzZSArIFNJRklWRV9DQ0FDSEVfREFURUNDRkFJTF9ISUdIKTsNCj4gKyAgICAgICAgICAg
ICAgIGFkZF9sID0gcmVhZGwoY2NhY2hlX2Jhc2UgKyBTSUZJVkVfQ0NBQ0hFX0RBVEVDQ0ZBSUxf
TE9XKTsNCj4gKyAgICAgICAgICAgICAgIHByX2VycigiQ0NBQ0hFOiBEYXRhRmFpbCBAIDB4JTA4
WC4lMDhYXG4iLCBhZGRfaCwgYWRkX2wpOw0KPiAgICAgICAgICAgICAgICAgLyogUmVhZGluZyB0
aGlzIHJlZ2lzdGVyIGNsZWFycyB0aGUgRGF0YUZhaWwgaW50ZXJydXB0IHNpZyAqLw0KPiAtICAg
ICAgICAgICAgICAgcmVhZGwobDJfYmFzZSArIFNJRklWRV9MMl9EQVRFQ0NGQUlMX0NPVU5UKTsN
Cj4gLSAgICAgICAgICAgICAgIGF0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZsMl9lcnJfY2hh
aW4sIFNJRklWRV9MMl9FUlJfVFlQRV9VRSwNCj4gKyAgICAgICAgICAgICAgIHJlYWRsKGNjYWNo
ZV9iYXNlICsgU0lGSVZFX0NDQUNIRV9EQVRFQ0NGQUlMX0NPVU5UKTsNCj4gKyAgICAgICAgICAg
ICAgIGF0b21pY19ub3RpZmllcl9jYWxsX2NoYWluKCZjY2FjaGVfZXJyX2NoYWluLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0lGSVZFX0NDQUNIRV9FUlJf
VFlQRV9VRSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJE
YXRFQ0NGYWlsIik7DQo+ICAgICAgICAgfQ0KPiANCj4gICAgICAgICByZXR1cm4gSVJRX0hBTkRM
RUQ7DQo+ICB9DQo+IA0KPiAtc3RhdGljIGludCBfX2luaXQgc2lmaXZlX2wyX2luaXQodm9pZCkN
Cj4gK3N0YXRpYyBpbnQgX19pbml0IHNpZml2ZV9jY2FjaGVfaW5pdCh2b2lkKQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ICAgICAgICAgc3RydWN0IHJlc291cmNl
IHJlczsNCj4gICAgICAgICBpbnQgaSwgcmMsIGludHJfbnVtOw0KPiANCj4gLSAgICAgICBucCA9
IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZShOVUxMLCBzaWZpdmVfbDJfaWRzKTsNCj4gKyAgICAgICBu
cCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZShOVUxMLCBzaWZpdmVfY2NhY2hlX2lkcyk7DQo+ICAg
ICAgICAgaWYgKCFucCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4g
ICAgICAgICBpZiAob2ZfYWRkcmVzc190b19yZXNvdXJjZShucCwgMCwgJnJlcykpDQo+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsNCj4gDQo+IC0gICAgICAgbDJfYmFzZSA9IGlvcmVt
YXAocmVzLnN0YXJ0LCByZXNvdXJjZV9zaXplKCZyZXMpKTsNCj4gLSAgICAgICBpZiAoIWwyX2Jh
c2UpDQo+ICsgICAgICAgY2NhY2hlX2Jhc2UgPSBpb3JlbWFwKHJlcy5zdGFydCwgcmVzb3VyY2Vf
c2l6ZSgmcmVzKSk7DQo+ICsgICAgICAgaWYgKCFjY2FjaGVfYmFzZSkNCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gICAgICAgICBpbnRyX251bSA9IG9mX3Byb3BlcnR5
X2NvdW50X3UzMl9lbGVtcyhucCwgImludGVycnVwdHMiKTsNCj4gICAgICAgICBpZiAoIWludHJf
bnVtKSB7DQo+IC0gICAgICAgICAgICAgICBwcl9lcnIoIkwyQ0FDSEU6IG5vIGludGVycnVwdHMg
cHJvcGVydHlcbiIpOw0KPiArICAgICAgICAgICAgICAgcHJfZXJyKCJDQ0FDSEU6IG5vIGludGVy
cnVwdHMgcHJvcGVydHlcbiIpOw0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+
ICAgICAgICAgfQ0KPiANCj4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgaW50cl9udW07IGkrKykg
ew0KPiAgICAgICAgICAgICAgICAgZ19pcnFbaV0gPSBpcnFfb2ZfcGFyc2VfYW5kX21hcChucCwg
aSk7DQo+IC0gICAgICAgICAgICAgICByYyA9IHJlcXVlc3RfaXJxKGdfaXJxW2ldLCBsMl9pbnRf
aGFuZGxlciwgMCwgImwyX2VjYyIsIE5VTEwpOw0KPiArICAgICAgICAgICAgICAgcmMgPSByZXF1
ZXN0X2lycShnX2lycVtpXSwgY2NhY2hlX2ludF9oYW5kbGVyLCAwLCAiY2NhY2hlX2VjYyIsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5VTEwpOw0KPiAgICAgICAgICAgICAg
ICAgaWYgKHJjKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiTDJDQUNIRTog
Q291bGQgbm90IHJlcXVlc3QgSVJRICVkXG4iLCBnX2lycVtpXSk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHByX2VycigiQ0NBQ0hFOiBDb3VsZCBub3QgcmVxdWVzdCBJUlEgJWRcbiIsIGdf
aXJxW2ldKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPiAgICAgICAg
ICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gDQo+IC0gICAgICAgbDJfY29uZmlnX3JlYWQoKTsN
Cj4gKyAgICAgICBjY2FjaGVfY29uZmlnX3JlYWQoKTsNCj4gDQo+IC0gICAgICAgbDJfY2FjaGVf
b3BzLmdldF9wcml2X2dyb3VwID0gbDJfZ2V0X3ByaXZfZ3JvdXA7DQo+IC0gICAgICAgcmlzY3Zf
c2V0X2NhY2hlaW5mb19vcHMoJmwyX2NhY2hlX29wcyk7DQo+ICsgICAgICAgY2NhY2hlX2NhY2hl
X29wcy5nZXRfcHJpdl9ncm91cCA9IGNjYWNoZV9nZXRfcHJpdl9ncm91cDsNCj4gKyAgICAgICBy
aXNjdl9zZXRfY2FjaGVpbmZvX29wcygmY2NhY2hlX2NhY2hlX29wcyk7DQo+IA0KPiAgI2lmZGVm
IENPTkZJR19ERUJVR19GUw0KPiAgICAgICAgIHNldHVwX3NpZml2ZV9kZWJ1ZygpOw0KPiAgI2Vu
ZGlmDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+IC1kZXZpY2VfaW5pdGNhbGwoc2lmaXZl
X2wyX2luaXQpOw0KPiArDQo+ICtkZXZpY2VfaW5pdGNhbGwoc2lmaXZlX2NjYWNoZV9pbml0KTsN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc29jL3NpZml2ZS9zaWZpdmVfbDJfY2FjaGUuaCBiL2lu
Y2x1ZGUvc29jL3NpZml2ZS9zaWZpdmVfY2NhY2hlLmgNCj4gc2ltaWxhcml0eSBpbmRleCAxMiUN
Cj4gcmVuYW1lIGZyb20gaW5jbHVkZS9zb2Mvc2lmaXZlL3NpZml2ZV9sMl9jYWNoZS5oDQo+IHJl
bmFtZSB0byBpbmNsdWRlL3NvYy9zaWZpdmUvc2lmaXZlX2NjYWNoZS5oDQo+IGluZGV4IDkyYWRl
MTBlZDY3ZS4uNGQ0ZWQ0OTM4OGEwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3NvYy9zaWZpdmUv
c2lmaXZlX2wyX2NhY2hlLmgNCj4gKysrIGIvaW5jbHVkZS9zb2Mvc2lmaXZlL3NpZml2ZV9jY2Fj
aGUuaA0KPiBAQCAtMSwxNiArMSwxNiBAQA0KPiAgLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAgKi8NCj4gIC8qDQo+IC0gKiBTaUZpdmUgTDIgQ2FjaGUgQ29udHJvbGxlciBoZWFk
ZXIgZmlsZQ0KPiArICogU2lGaXZlIENvbXBvc2FibGUgQ2FjaGUgQ29udHJvbGxlciBoZWFkZXIg
ZmlsZQ0KPiAgICoNCj4gICAqLw0KPiANCj4gLSNpZm5kZWYgX19TT0NfU0lGSVZFX0wyX0NBQ0hF
X0gNCj4gLSNkZWZpbmUgX19TT0NfU0lGSVZFX0wyX0NBQ0hFX0gNCj4gKyNpZm5kZWYgX19TT0Nf
U0lGSVZFX0NDQUNIRV9IDQo+ICsjZGVmaW5lIF9fU09DX1NJRklWRV9DQ0FDSEVfSA0KPiANCj4g
LWV4dGVybiBpbnQgcmVnaXN0ZXJfc2lmaXZlX2wyX2Vycm9yX25vdGlmaWVyKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIpOw0KPiAtZXh0ZXJuIGludCB1bnJlZ2lzdGVyX3NpZml2ZV9sMl9lcnJv
cl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsNCj4gK2V4dGVybiBpbnQgcmVn
aXN0ZXJfc2lmaXZlX2NjYWNoZV9lcnJvcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sg
Km5iKTsNCj4gK2V4dGVybiBpbnQgdW5yZWdpc3Rlcl9zaWZpdmVfY2NhY2hlX2Vycm9yX25vdGlm
aWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpOw0KPiANCj4gLSNkZWZpbmUgU0lGSVZFX0wy
X0VSUl9UWVBFX0NFIDANCj4gLSNkZWZpbmUgU0lGSVZFX0wyX0VSUl9UWVBFX1VFIDENCj4gKyNk
ZWZpbmUgU0lGSVZFX0NDQUNIRV9FUlJfVFlQRV9DRSAwDQo+ICsjZGVmaW5lIFNJRklWRV9DQ0FD
SEVfRVJSX1RZUEVfVUUgMQ0KPiANCj4gLSNlbmRpZiAvKiBfX1NPQ19TSUZJVkVfTDJfQ0FDSEVf
SCAqLw0KPiArI2VuZGlmIC8qIF9fU09DX1NJRklWRV9DQ0FDSEVfSCAqLw0KPiAtLQ0KPiAyLjE3
LjENCj4gDQoNCg==
