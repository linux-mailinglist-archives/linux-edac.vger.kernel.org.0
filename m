Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A19F5ADFB6
	for <lists+linux-edac@lfdr.de>; Tue,  6 Sep 2022 08:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbiIFGX2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Sep 2022 02:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiIFGXY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Sep 2022 02:23:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A29C29807;
        Mon,  5 Sep 2022 23:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662445404; x=1693981404;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6ZO/uQdfmUoSZreWNoNzF8xIlktFzYXZvacgZV1oibM=;
  b=MofVzG3urLbwkyov1AUlcuhywzsoomB+Ws2HbJvhF4pRPnytRzb0p1lz
   Fu4vgtnlwuOqAMV9Wufj9CzYG4Ji9rMXtXPsgk7yTuu3O77Dnsm9wq6lT
   xOJAmO/vfmlNv5O1hrV9u2hs0CpgO5yypAszfdBTbTxM6xBqAIw9KKqZB
   4wn06/H6oYYCMfIB2LfIdXchIpuu0+vGfFletrIHbTD0ZKwG8j8oA600+
   onw5qRiv4x+QY0PHcryAtI6mgzhiy/ktdcUZTtGHNTqdATski+lGGadzA
   BU4Y2UhwzAtV6zdd251NAvkorgM0a/rZ3ajjOa9TCLokICWCB1zD2GC96
   g==;
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="172518497"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 23:23:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 23:23:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 5 Sep 2022 23:23:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcQjcTi9XGIAppvJggb6K92Ywq/6gyLY+LSxWcGleyo0TPhxx1yUjFvCiduxlXPtNG65L1udzny3DJykjhkd4gvoNFOKZoyuZNQkWpb5mWgZuBQM9oQtWHtZ7gK7bczAuEAHbna8EPnWsih/NSLxaMxpA9Kd7wCdMyqWlbG5aS3GeFnwBGrCW75fNlaSvwWmPlM9I3M3O7E/SawJdOJ85NNsZE/XlMNYWttGOlLfvQNhel8nMUqrzjoKcAOrieK0h6PRW/gzQpqectj2T2+s4LRfbEGbWiGyETLehCuLT/ar1GGEfwNSUyW4+BaqyPWt2gwhXjdx9tqQHATCrkdzgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZO/uQdfmUoSZreWNoNzF8xIlktFzYXZvacgZV1oibM=;
 b=aeMsySFkp2XAqjoXBbZHHiLPD0v6qHQEs2fZZnAP9dgz6Q9INKZ2VVKh+OABr+PyB3xjx9Lkkm+h3A4/a57x4xtWTEu65G7iouRClOwhxNRQ1DVbZ8n3ykIhhWEHGd/2MBNmM5JSD6ZwHlumhqBXy43QrZTpwf7xlLOcBRR1eTeesq9C1v6D1jcaDFzBcSpo/P7SdenxJeaK9xCSz8Mt1cebhrJnMk7vq//IG+rjv1VgMnnT2IqNkMVrR0I03v9jE7U+CeNz8SIIVbMibWtlgzBZBO6SlABG0AYBHeDe0FnJXZHpsWP2QswfL3M23dypSF1JI3PXmE6zRDPKLtkNvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZO/uQdfmUoSZreWNoNzF8xIlktFzYXZvacgZV1oibM=;
 b=QnSo39GthLMwSdnoSx3/caH7SahiR7m9haVvS+zU2m+kP8C0bS7uhH5E1rLZo+JjuwE46gSjnCrDPvmpqmAKmvBEEAUWqHlP+XYGyChmc9K9t4wsjGHN8FZE3Cvr+FAkDFrAhb/aBwu45qPRhzE+wU+QyqHnST7DkxJ+x1vlMyg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MW4PR11MB6958.namprd11.prod.outlook.com (2603:10b6:303:229::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Tue, 6 Sep
 2022 06:23:18 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 06:23:18 +0000
From:   <Conor.Dooley@microchip.com>
To:     <zongbox@gmail.com>
CC:     <zong.li@sifive.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <greentime.hu@sifive.com>, <ben.dooks@sifive.com>, <bp@alien8.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] soc: sifive: ccache: Rename SiFive L2 cache to
 Composable cache.
Thread-Topic: [PATCH v2 2/6] soc: sifive: ccache: Rename SiFive L2 cache to
 Composable cache.
Thread-Index: AQHYwQIC51d6t8FVA0+5gd672Syjta3RLbEAgAB0kYCAAE3zAA==
Date:   Tue, 6 Sep 2022 06:23:18 +0000
Message-ID: <048bb217-e91e-b727-fcd1-e55755a87d0d@microchip.com>
References: <20220905083125.29426-1-zong.li@sifive.com>
 <20220905083125.29426-3-zong.li@sifive.com>
 <2a22c6ac-dc0e-7066-8f5f-04c428c77ee2@microchip.com>
 <CA+ZOyah199Vsa9haepO=uizymy947aLv3tMoO=5ye=FHqhkYCA@mail.gmail.com>
In-Reply-To: <CA+ZOyah199Vsa9haepO=uizymy947aLv3tMoO=5ye=FHqhkYCA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12edeb69-a849-46d4-2438-08da8fd049ed
x-ms-traffictypediagnostic: MW4PR11MB6958:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D0vAU1fKOV5HFXFPBqeW6rcwObefxG6p2HkwKPWOtCCsweA/g4Mq7q8gvl4QE5mog/6NFSeM0XbUnJaIZuI9ATQ18lHUB7/gQYB++bT1xrvFv0gQC0hDo6toErVd1TOzeIHVjAAlsWQvX6eQ54v8Ba7BdNhvBEcJCD/2brPqBdpFaZVmOdBd3ntH47I18p1Ot2GOF78O3yTjrd4TPGt92+Lrez0lk2aJdWTbhcrDcyWbrU0jCVz0rorhgWKtFcIiO/o2F5r9YwSad8f44wcB3WHWyG4IIf8Xf+pQviYn3Aq7K4vbTpeX7nHzS0NOooASVd90Y2H/hWNcRIf/sgsGWKYnk0UTg05/B3VhpP0z/8xR1sXfxeBkGWsPr4Fwq3jeBudsfncYF3BnHJciANn4t2GzBQfCKRjw14rzgP7DmKnaiGsHSBUahIf8Q3L0hy477wzmEde8J3zuHr+psnAjNVjVt6RUBcKWC1k1yTxIACrwKQSYCmsajERJYzRm0TiT4xkDP+E1mNjcttU175WYu1rAVecZ6rZujWRtiDmIr/K6HOf39mVsRrmDgFajIMqHtUz6kKZeRhR2AfrqiWhHZ8IALeR7Xcx5ArR6+A9RMtaKuVePrmPXk8FNmjFn9R4kX807YlYrEhIgJFo8RbhRI83en35TK4jRa8agb58rE1Ou0cXWrgBhWmlpyVLha7CIXB5YrublBO0AYtFUf8R511kkvUczG/THPV+7XSFbBZ8PlOAUZIPrlcX55xHLSiJ9hUZ1kuYHcm9mG/xEjlJY2c98aWr79gxtdq8vHS1+53qeqZM6qdK+2UANzb+heblM/BdNdvTtHS3otPIXQhkEOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(396003)(376002)(366004)(39860400002)(136003)(346002)(66556008)(2906002)(76116006)(41300700001)(8936002)(64756008)(5660300002)(8676002)(478600001)(66946007)(31696002)(7416002)(6512007)(66446008)(86362001)(26005)(53546011)(6506007)(66476007)(38100700002)(122000001)(36756003)(38070700005)(186003)(4326008)(83380400001)(2616005)(91956017)(6486002)(71200400001)(54906003)(316002)(6916009)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpieGJhbjdhaVErd1BDWXJlaWRpTTROOUp6NExXV3BKNEF1QTkwejlmelpF?=
 =?utf-8?B?VERTTE5ldklYWkxKMThzc25OSzlNM0JvYmdidUZPOHpGb3VxRThmd0dsRXNC?=
 =?utf-8?B?OHQ5Y3ZyMFp0eEpWZDNXYlB3TjZ1WWV3cFI4a3BEd0dCTTJybU05Mkc4M0t6?=
 =?utf-8?B?ejNyTmxURDZ0MlJ3K1BJN2F4YUptdmhZbk9IaGxLY2RCTmNqMXVNak9kWDZS?=
 =?utf-8?B?S3RRVFdYVTdUTE5wUHVabWhTZm9BQlpUbHVVV3dGZ3QzOU40L0ZyU2tKNGN5?=
 =?utf-8?B?R0pEQTY3N3NneTRrNmFnS2pZa201NFR2MGxLVURNa1AzRU1tZkpzcThnMlZU?=
 =?utf-8?B?VTNoNFlvNnF5VnZIYmY0QUprRFRuVlQwdUZVQWhrbVdWdG1rZk55aDlmMHZj?=
 =?utf-8?B?MStZaEcrQWgrUVhiRDdORXFkNjhmYzB1anN2M0ZGbFVZMFpQcVcvN29rNjBi?=
 =?utf-8?B?bWMyUzYrdDJzWkhrUURDc0Fob29RZDZwdFh3RWg0QUtnWUlHZUFiQWVYYU9C?=
 =?utf-8?B?bXdwY0o0TVoxQVJsS1dXUlNJbjNKVE1OWVJxZTZ0THNpQWM2d0NoZEFkOHM4?=
 =?utf-8?B?YXB5OG9zdTlrS0drN3pkNGl4QkZSVHlYUnd0OFF1TTNyT0RNOTBYVjREajQ1?=
 =?utf-8?B?akRCVXBNd2NKbGlGNW9BSW5lVnB6ZDRvT0dkUmExMHMzTmxHaGVsY2VrdmZ4?=
 =?utf-8?B?MkM0VldwdUVmM01tUEsvcFhSNWFVemcyaUN4VmJiTjdYeHR6SzZuQnU0NmtH?=
 =?utf-8?B?UXRaWjYrOGdXUUt2WnRRcmtIN1o4em5LUmpnbS9aZ3NuTE0xR2hqVGZpYzht?=
 =?utf-8?B?Z3FqSG8rYUpsL1JNWHA0RlczSnBSVGkwN2ZaTVU4UGFxczdMeXo2S1V4TWEx?=
 =?utf-8?B?TmJKTzM4Y2dFNnk0djRsVGVOMFAxOGc5T0dpMTRnUm14REtZQWF3NDR3YmhJ?=
 =?utf-8?B?V0hydlErZ09sakpxYmQzMGtPRWNwSUhocDFzemNzcnJINm5LMjFidElEclN6?=
 =?utf-8?B?M2o4TDZvTE9GVk0rZ1l5eFRYQW5Zd05sajRxRFQ3MGNLbjQ0TG9mU2t5ZTk0?=
 =?utf-8?B?ZTZoTEJTZUFGZDRDT2FpdHVoOUpKcFcvMWpqMzAxT3NhZU9mMG9wUTIrTmw5?=
 =?utf-8?B?b2JuazY4cmd2M1hibVRQUlQrZGY1K0JETXpJelN2VEJOZldMb2ZBdnVCd0t5?=
 =?utf-8?B?Z1VienU4SURIQjhvQS9vMlcxVWYzbDJkbGE0d0VWK0JzUW4vMTBQOTJ3V1o1?=
 =?utf-8?B?THZUNlc5a1kwekhIeHVtcjZ3cThvOVUvWEpRYUo0RzJKSWVtR1doVUdRcFds?=
 =?utf-8?B?M1k2MXFwbWhwUDVQSUdrQ2w4VHdRa01LbHRjeVFOK2pVL09raWUxYWV3U29Y?=
 =?utf-8?B?dXZneTJpRFR6ZlJVK1FBaVdBczBJRmx1RTF3aWdoRUNhajZYV0VBcENhbWdw?=
 =?utf-8?B?bWZKbXB2QUtiZ0tBajltTEtlQUtiS1JXSVRNY0tTSjc4NDlxSWpiNjYvTkh3?=
 =?utf-8?B?a3hzMUJKZUwvbzFSUUI1ekNqVGZkNDd0YXd4aUlUb1poOVdxZ3R6S3J4bDlr?=
 =?utf-8?B?NWdoZitCakgzQm5hU3BJVHhsV0d0ZjlyV3gwV3VVdzY0d2hIQUVDZnlyaXNh?=
 =?utf-8?B?MzFDRVc1b1V1dm84RzFjRjZMVitBamtsTHdzWngvVlB2Yzd3dVorNTJPUU5v?=
 =?utf-8?B?MFdFOVFVbXo5Y1piMTlxZEJqRitEdVhDVTUzR1RjU04vY0ZNOUN3ZzVDbzdl?=
 =?utf-8?B?bjdkMUhCeHRidVkvb1Z6by8xVk4vUHBVMkVJeEk4MnBydUY1bGZDZlFzZ1JC?=
 =?utf-8?B?ZmRFUzQ0ZmRxdFN4MHcxY1JaaGZhdmVmZ3krQmlOdUdPN3BMT1EyR1Z0bEIy?=
 =?utf-8?B?RWx4LzNEdmFRT2d6a1B4bDJ2Zkt2dmFaUnJMNWtHdWowVzZxYWFFTnlwN0ps?=
 =?utf-8?B?TU0yN3MrZ1FwdlIyVnFHSHhxWktUTk5PdmVtamo1S3NsajdoMnpCVWpyMElx?=
 =?utf-8?B?bjZhQURhbGdZai9kMFNBeDVUWmQvZTQ1KzMvaFBWZmhmTUVIb0FRVUg5bnV3?=
 =?utf-8?B?MGg3dVhWb0V5SVZjRDdzdHNNSFF1SW5qcWljVzVMcWhJZ01RbkkrUjB4eHVG?=
 =?utf-8?Q?rBdU6W3ehFXKmQDNSbEpz/aSK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28BA4D2D02FDBD4095DE3D25F14B6FF8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12edeb69-a849-46d4-2438-08da8fd049ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 06:23:18.1968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSuwyxJBociyypEeY7r25I30bnszvz8j00h3v1v6G1jA6b4eymPrWEjpCpMh06o96/z6jC2QvEt2cC8GDQSE6juwKsqkPmXMLM37CmVz8cM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6958
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

T24gMDYvMDkvMjAyMiAwMjo0NCwgWm9uZyBMaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiA8Q29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20+IOaWvCAy
MDIy5bm0OeaciDbml6Ug6YCx5LqMIOWHjOaZqDI6NDjlr6vpgZPvvJoNCj4+DQo+PiBOb3RpY2Vk
IGEgYW5vdGhlciB0aGluZywgc29ycnkuLg0KPj4NCj4+IE9uIDA1LzA5LzIwMjIgMDk6MzEsIFpv
bmcgTGkgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4N
Cj4+PiBGcm9tOiBHcmVlbnRpbWUgSHUgPGdyZWVudGltZS5odUBzaWZpdmUuY29tPg0KPj4+DQo+
Pj4gU2luY2UgY29tcG9zYWJsZSBjYWNoZSBtYXkgYmUgTDMgY2FjaGUgaWYgcEwyIGNhY2hlIGV4
aXN0cywgd2Ugc2hvdWxkIHVzZQ0KPj4+IGl0cyBvcmlnaW5hbCBuYW1lIGNvbXBvc2FibGUgY2Fj
aGUgdG8gcHJldmVudCBjb25mdXNpb24uDQo+Pj4NCj4+PiBBcGFydCBmcm9tIHJlbmFtaW5nLCB3
ZSBhbHNvIGFkZCB0aGUgY29tcGF0aWJsZSAic2lmaXZlLGNjYWNoZTAiIGludG8gSUQNCj4+PiB0
YWJsZS4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IEdyZWVudGltZSBIdSA8Z3JlZW50aW1lLmh1
QHNpZml2ZS5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWm9uZyBMaSA8em9uZy5saUBzaWZpdmUu
Y29tPg0KPj4+IC0tLQ0KPj4+ICAgZHJpdmVycy9zb2Mvc2lmaXZlL0tjb25maWcgICAgICAgICAg
ICAgICAgICAgIHwgICA2ICstDQo+Pj4gICBkcml2ZXJzL3NvYy9zaWZpdmUvTWFrZWZpbGUgICAg
ICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4+PiAgIC4uLi97c2lmaXZlX2wyX2NhY2hlLmMgPT4g
c2lmaXZlX2NjYWNoZS5jfSAgICB8IDE2MyArKysrKysrKystLS0tLS0tLS0NCj4+PiAgIC4uLi97
c2lmaXZlX2wyX2NhY2hlLmggPT4gc2lmaXZlX2NjYWNoZS5ofSAgICB8ICAxNiArLQ0KPj4+ICAg
NCBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNlcnRpb25zKCspLCA5MyBkZWxldGlvbnMoLSkNCj4+PiAg
IHJlbmFtZSBkcml2ZXJzL3NvYy9zaWZpdmUve3NpZml2ZV9sMl9jYWNoZS5jID0+IHNpZml2ZV9j
Y2FjaGUuY30gKDM1JSkNCj4+PiAgIHJlbmFtZSBpbmNsdWRlL3NvYy9zaWZpdmUve3NpZml2ZV9s
Ml9jYWNoZS5oID0+IHNpZml2ZV9jY2FjaGUuaH0gKDEyJSkNCj4+Pg0KPj4NCj4+PiAtc3RhdGlj
IHNzaXplX3QgbDJfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpk
YXRhLA0KPj4+ICtzdGF0aWMgc3NpemVfdCBjY2FjaGVfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUs
IGNvbnN0IGNoYXIgX191c2VyICpkYXRhLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICBz
aXplX3QgY291bnQsIGxvZmZfdCAqcHBvcykNCj4+DQo+PiBZb3UgbmVlZCB0byBmaXggdGhlIGFs
aWdubWVudCBoZXJlIGFzIHBlciBjaGVja3BhdGNoOg0KPj4gQ0hFQ0s6IEFsaWdubWVudCBzaG91
bGQgbWF0Y2ggb3BlbiBwYXJlbnRoZXNpcw0KPj4gIzExMjogRklMRTogZHJpdmVycy9zb2Mvc2lm
aXZlL3NpZml2ZV9jY2FjaGUuYzo1MzoNCj4+ICtzdGF0aWMgc3NpemVfdCBjY2FjaGVfd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpkYXRhLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQo+Pg0KPiANCj4gSSdt
IG5vdCBzdXJlIHdoeSBJIGRvbid0IHNlZSB0aGF0IGJ5IGNoZWNrcGF0Y2gsIGJ1dCBpdCBsb29r
cyB0aGF0IGl0DQo+IGlzIGFjdHVhbGx5IG1pc2FsaWdubWVudCB0aGVyZSwgSSB3b3VsZCByZS1j
aGVjayBhbGwgaW5kZW50cyBpbg0KPiBzb3VyY2UuIFRoYW5rcy4NCg0KWW91IG5lZWQgdG8gcGFz
cyAtLXN0cmljdCB0byBjaGVja3BhdGNoIHRvIHNlZSBpdC4NCg0KPiANCj4+PiAgIHsNCj4+PiAg
ICAgICAgICB1bnNpZ25lZCBpbnQgdmFsOw0KPj4+IEBAIC01Nyw3NSArNTcsNzYgQEAgc3RhdGlj
IHNzaXplX3QgbDJfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpk
YXRhLA0KPj4+ICAgICAgICAgIGlmIChrc3RydG91aW50X2Zyb21fdXNlcihkYXRhLCBjb3VudCwg
MCwgJnZhbCkpDQo+Pj4gICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiAgICAg
ICAgICBpZiAoKHZhbCA8IDB4RkYpIHx8ICh2YWwgPj0gMHgxMDAwMCAmJiB2YWwgPCAweDEwMEZG
KSkNCj4+PiAtICAgICAgICAgICAgICAgd3JpdGVsKHZhbCwgbDJfYmFzZSArIFNJRklWRV9MMl9F
Q0NJTkpFQ1RFUlIpOw0KPj4+ICsgICAgICAgICAgICAgICB3cml0ZWwodmFsLCBjY2FjaGVfYmFz
ZSArIFNJRklWRV9DQ0FDSEVfRUNDSU5KRUNURVJSKTsNCj4+PiAgICAgICAgICBlbHNlDQo+Pj4g
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiAgICAgICAgICByZXR1cm4gY291
bnQ7DQo+Pj4gICB9DQo+Pj4NCg0K
