Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCEB74C976
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jul 2023 03:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGJBTE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 9 Jul 2023 21:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGJBTD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 9 Jul 2023 21:19:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD0ABB;
        Sun,  9 Jul 2023 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688951942; x=1720487942;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ExDlA7JJgNDQ5QP/PI7CCKDNxyyU46fLUCMEGVy0AFo=;
  b=aoS7kC1B5Yk7m0djdjDMO/alj8DnpQZ80RiNGqbiPIGGJQbUJPD+o5iv
   d+9TmGIT5X3ft/9visIqBkz3vp4wobuVZ9nbxB8sY7IC05OuLQ2m6iDoo
   2EfmDecHAkZKK4rSMEt1YSfdpwoiy876HQPopZd5HaDD2EIeQGMgmQJyk
   RDTfjcjC4j41gDvLyN8RDK+2+Sv0kbpUhdai1oPg7K2DqIe5HOyggVl7e
   hCgffuuzJCXfQZHaRyEZ2XPNP6AgimDBrN5cstPzDmlAuYyrwG/TtDmm/
   kE7IbwUV5JMJjW+qLYtvYp7sjYMO+kl9zwB7g7f6e7A5FnIVyiC4B4ik/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="366813101"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="366813101"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 18:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="670765092"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="670765092"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 09 Jul 2023 18:19:01 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 18:19:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 9 Jul 2023 18:19:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 9 Jul 2023 18:19:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7yfkJZWhQl2ErL6Pau0zHuAEIvlCajRpV5bmKzrBfGh5sK8TPvunwzVVkGcvYNG68v2Qhwt0P91gJZYDoL76UaGnUWKjLp8FJ6gVDK9AnEVstiucYt2RzKDaDr+1sDhLvsBhNpMS/G9L7Wh08sYC6yeN4h6iR2jwy1EWXUmxmICnPxInxGg2oMJOSFQlG4G5FCZhCluDXadCC4ewqE2EKCOPBrI4VjfjxYUb9bKaforwFs2pWDQfGboyXKm2DIydFoxIX0aOKcIpMPpdkdLs+bhCd9BpgNNqyiLYDnagTdgUyws3ynSFvXRxUsyhkl+W6yr8KfroR73a+NpjLT+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExDlA7JJgNDQ5QP/PI7CCKDNxyyU46fLUCMEGVy0AFo=;
 b=h0Rq5UXXIygkWl/GcuIDc2DzbTr6tulpnpxp+khi+G669Bk9bVdyX8z1ORzFSHLQdrS1lCVMdYLHP4hOJMqAwDmvzA7taNBn2gte6uzwYAQGgR88quTr7u8cpTuLaN36r1QSGAJM7KRDaRj9UsMOvSeNizOb9xHUKt5LwAR5hUGuF/lrDSJMjY4cLlqihZo29frvQBqzvWHRopMolRW3rrS/653EMdwvhmid8jEOp73+M1G5/mT/shsDTdFfMjjhXUqnrXoC+MB+Ez/FsrxlHMJfPqsLdGZyejgdiXICu7rMacwC0tOzS4ljadmt0VnZpEsU2k0a5andZ/+32aLG3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB5706.namprd11.prod.outlook.com (2603:10b6:610:ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 01:18:59 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 01:18:58 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrfiT8S4St58DWkKECHZaJCTaP6+o1+WAgAG4woCAAE1ggIAAbuuAgAF4OeCAAEDZAIAApV2wgAPwlACAAKCTAA==
Date:   Mon, 10 Jul 2023 01:18:58 +0000
Message-ID: <CY8PR11MB7134B443199DD93EE881F0348930A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
 <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
In-Reply-To: <CAJB-X+Xe9H0O=-2o3hL+pz=aGdSRYX+hD0bAxUS11CZDRVZLKg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB5706:EE_
x-ms-office365-filtering-correlation-id: 54a76745-f447-4369-8ceb-08db80e3a2f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ua6wmQX6erFAIDFTLI609PNBCHOO0FkZixQkuptf35JtJjxJ39VG4prdspeVmc+s3Hv/ln07DJzMALo0NasMZOXgaAklvrZQFLLVT9AluXPzsHhMumyLHEPgJ3iX/JRLBddGZBAa0bFTpNTUsCDtsK/+EcjF6vitGTSuBEdTr3UYuag1CAOyOmN6qpxnlSqlqs4aD2MlCB/3zCT30IMr+rr08VmP2lT1U6n5hJa9I2aKMRi9uabZchBwm+p+iOpoeQaoTqvAuLIdFNZEn+oK515otrXz1+J81h82G77kdzsVgQoM+eslq27gUQxbqjBkNCo6A46DJED8c3eGuZH8rVoKpRY6uTXcW4aVe9MtcXHZXQPFmErfDLR59ie6EHlSU8xPQoAnrXjYSbDg78ROpiQvR3sylxpwSgO8MAbXkefTgUZqeIxVhkwH+isU983WxJOlHJxUpPz9ARAAxrcn8337ZG+FpvwgrfJw1zl6PhbMXlsetB0J5EmX7NoVmoSEW6OULyqw1tGQ8mUZym2ZI4kdptCJ/bpy7D6lZ5MCp2m2ywU3B86WQaLeTKLFiUTjLM+16ZDj9Gx7ZnxE5UNYHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(5930299015)(86362001)(38100700002)(558084003)(82960400001)(38070700005)(33656002)(55016003)(71200400001)(7696005)(54906003)(76116006)(122000001)(26005)(6506007)(9686003)(186003)(966005)(7416002)(5660300002)(52536014)(316002)(2906002)(66556008)(66946007)(478600001)(8676002)(8936002)(66476007)(83380400001)(4326008)(6916009)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzQvVHZsbHl5Rnkvdi9iRTR0bVpIQmUySFUvcmxTcHZuT05PVXhqdnRxc0xD?=
 =?utf-8?B?b05idnI4YXdBejVUcC9FRFdTMkZNWm03WnhEeHYrYWJCdCtuaDFWZ01KVnRn?=
 =?utf-8?B?aWdJUkJ5cm1sZ1hBWVpMSlhnZmd0SmRvdlhRcnlPQkJxTzlwM3Z0MlEwTGJ5?=
 =?utf-8?B?b2RWNjNjY2tMNnZxdG1SM0p1d045RXFIZ1MzaWJtTTNyU293cVlLSS9zbTlM?=
 =?utf-8?B?eVU2WlJVSXkwYnBIczdaYTZldnBQa3hRZE5qbU9aZDJHUmlRMVBhWkdZWTRZ?=
 =?utf-8?B?WGRjenFYQ0lQN09GNS94dmtnTzFNNU1NZmsxSFB5ZUJCYUdRdis2NFRHUHFG?=
 =?utf-8?B?ZVdCRS9PK3h5ZkpUYURFK1JhazlaZFNYWDJCVkc4RXl2YWVyR3ZnZzZQbmkx?=
 =?utf-8?B?aHE5WGxGZ1FnTkt6Q3NZNjlONVZhWUpoWktaNFVxL0JpNUFOK0hITjFVNkhP?=
 =?utf-8?B?TFczQkJmaHYzb21vMTdnNFFxY2xic2RxWnhOZS8xVWhXT2U4RFhZdVJLZG91?=
 =?utf-8?B?THByU3F0ZUpqNEc2M0UxNlBrREp4ZndDRFNPS2s0akF1aElGN3BIbmF0end1?=
 =?utf-8?B?aWVaWHF5Rmp0VjRnWnRvWFdPT3dWT1UraUw0bjNjbUNkR05RU3I3YWhkUnpr?=
 =?utf-8?B?V3BkbUxHdVJiS2Y0dStpNGtxRWtySWNmWWZNTG1WYjBWT005YlozcUJuc29r?=
 =?utf-8?B?aUR3YmNTdFBWdzc0N3Z2YkRocTJHUHBSb1hvYmVCZVhQd2pDSmRoVGdCa0I2?=
 =?utf-8?B?eDhzcDh2V0E5ZzEyYkFobVZ5ZUtjT2ZITTV6eXRYaGNQVk9JOEpHcEdaWC8z?=
 =?utf-8?B?SWN0anlGR0x3TWhSUGxWVjBZV3dQR1phcWdHc0lDVkJSem5jRklYYzN0QjU1?=
 =?utf-8?B?NjVpbEFaV3kxVlR1UDhOMFVZV1NISDk3cWQzU0I0OUgxdjBySlQyaUNaOXlR?=
 =?utf-8?B?eWJjSWUvQ09DeGNJdHBTdkhJSjc4UERVYWVYQlczU090dVFQTURmSU9GYVc4?=
 =?utf-8?B?WUNpVWJIdkZLMHFZVEhTWGRHKzBzc3NHRTRjMFVtb2s3cGkrWUE4eDZoYjBV?=
 =?utf-8?B?Q1VsNE53LzgycnRGaWxUMXkvTG9wY3dUZXp4ZDQrUitJMTBhdDNRZWFvdzcx?=
 =?utf-8?B?SGJkbDczU2FoYkVMNmxGRXZtaDRpMEJsL25oS2xXaTFCRURVdkNuVlVWR3Ju?=
 =?utf-8?B?K3I4S3l3VG12TTFLU2FPVlc5Umh6ekcreHdscmZPbmhqbWR2dWE3TG1jL2hL?=
 =?utf-8?B?UTN1Z3lXSjZ6Mm9GRGFCQWdJNUhYc3RIQXhLTGlWbnZ0eHVOVzV2RGJUbUoy?=
 =?utf-8?B?bHRrTnhnSDlLVEFDMG9rWDl5RHgxbmhqRlNWWEZ0Ry9Xb2dNMnQ5NEhCb2ly?=
 =?utf-8?B?c1FlOVlTQUdoNlRKQSs5S2g4R3dYZVdYcWU1NjNuemtqVWpHNkt1RFpsUHMx?=
 =?utf-8?B?bng3NE15RFk1L25NbHpZMnluUDgxVHZmVmVIdHNKaVRFRm9BR3Y2MTA2TFNI?=
 =?utf-8?B?K3l4Y2RobGFGbkl3VjVlcTBpaG9IQmR0czFNTEZyVHA1ZFlxbHFjbFJaZnQr?=
 =?utf-8?B?UElnTjVnZlNOVkhTVjByTldBb0tYUTBia2ovT2pCQnF5WTFjV3NwOUltTmpo?=
 =?utf-8?B?bEFpRFYvelhCZCtSVlp2d1c2UFlVeHpoOXBiTDNoQXdsdlpLRWVuakhYYWlr?=
 =?utf-8?B?WUhGbFhSUk5oajY3aldjOHpRVGVRbDEwbG56V0xwSzN0TE9XR29MOE1hSE93?=
 =?utf-8?B?S1Btc1JDM2k4SGJVUHpmVFdiSy9ENEpvekp3TmVQamlDT053OWk2ZnR5K3A4?=
 =?utf-8?B?aWpSSFB2YmIyVGlBRnV3cStTcVRiMXViUnNyRTB3ZkVGM1dTRWxsckdGMnFa?=
 =?utf-8?B?dHRidmpzd0VWbTlzRmpTNWpSQ051MkY3SCt0NjZIOWxSSnFvd2lwYzd0SHF1?=
 =?utf-8?B?ZXJqbVh4SlVHZ3FlZ2ZMR1VKSGVYRlRONndRWEpLVjFGdjZkR2dNUWdwMWpE?=
 =?utf-8?B?VUFsbzFtb1hKeTc4TGIwOXF2b2lyTHlXVkw5eVhpVTdIUFo5RkFTdTkya0pS?=
 =?utf-8?B?dHhzM2czK1YxcmhuRGpkem5NWFVLU0ppT0dpWEhhcHpGSlFNek5TaVo5R1Fm?=
 =?utf-8?Q?begXN6uldrDFxLCylDxLJReBP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a76745-f447-4369-8ceb-08db80e3a2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 01:18:58.3146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQaYW30/OUMNDD08Ja5tyhKeLUNK/zshbzILHC2IBGVcNYyOzcM+7Sc+7+PdCZ0RU5mPY1fphm2oexVE3TDrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5706
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBLb2JhIEtvIDxrb2JhLmtvQGNhbm9uaWNhbC5jb20+DQo+IC4uLg0KPiA+ID4gUmVm
LiAxLA0KPiA+ID4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2RyaXZlL2ZvbGRlcnMvMXh5bTlK
Z1paZ2FKM0VxdFA0Y2NSY1ZlUVlvSksNCj4gPiA+IG1WDQo+ID4gPiBscD91c3A9c2hhcmluZw0K
PiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgdmVyaWZpY2F0aW9uLg0KPiA+IFlvdXIgbG9nIHNob3dl
ZCB0aGF0IHRoZSBwYXRjaCB3b3JrZWQgd2VsbC4NCj4gDQo+IHBsZWFzZSwNCj4gdGVzdGVkLWJ5
OiBrb2JhLmtvQGNhbm9uaWNhbC5jb20NCg0KU3VyZS4NCg==
