Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A1749EB2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jul 2023 16:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjGFOME (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFOMD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 10:12:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DADD;
        Thu,  6 Jul 2023 07:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688652721; x=1720188721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fY+A9GizH/Pl5iVdZ4laoo8lbXzhvK8JADkilay+bDA=;
  b=RFuhme9PaYHvMq+X6JldKjrSbhOVqJjRZrOPrC6ZtRGKTkpo2H1SPaXr
   3FqOnqyLVgLGKRiU31fvq2RXctHSD6rrL+NQ6/wbelbQuutLnb011l17e
   2aC+kTJ8IpWxXYlf4Jh5uYCbKG4T94MqaRYSPPJP34/ssgjo4yDGGhAN0
   l1e66qvnrFSUdtpWPNYKuwNtUTIAxaBpicWgF3n7xPBCHOe6ObFGa7gE2
   es3LSi3RHDEeq0hzlO/8Y3/3STyaTYd1hJWIMVRM40IwhUBlZ+iEy2QfH
   ZgyM2T+xx/viQ1RVhpzJ48LQzhRSQ6M32Pgr4iGLccuS3KRpwgZNRCapU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363647485"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="363647485"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 07:12:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="749154086"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="749154086"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 06 Jul 2023 07:12:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:11:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 07:11:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 07:11:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 07:11:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqYG3KjFc4ravHbQTcQBEMJ9Z/clrnFvThOjjERtsZffds47RPh0ixBdMcM+m23EQ165GsJqxqlsjKWCjc/felK/ITwsOkiUldPAR9nqReTvxJhSDwWPuo4BaOpuPFwOgPh3NtViPtdqeaChQc39kl6s8Wd1+lcEb14fJxlOVQ5QT4zitKT1Qd2GMvBjnXtUC+7YZyDdr41GCVxYpYzTc+L9KG09fSv+HZ/dkYmIMo0qDvg/lx016Bfa5VBB3SikapKafYMDPF4SZ8GGAH19iBFVhm0GjRdcuGVPs6SJCNG8wCGhgr309bzAalAUy43YYN9vq1GwHyYZpw2L975l+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fY+A9GizH/Pl5iVdZ4laoo8lbXzhvK8JADkilay+bDA=;
 b=WzINuxvrsL8T0swiorULkUl3LGR1INJRUpZ6+8p3ZA+Dz9htl7Li7fPAesr4+csBrBlw8e5Vl4YYWY6EB5vK29UVb5Mbpde9lcE17Dx0W16psdhZuATDeZtkh3w39leS3nWW1Olqo6XfymlSiI2KyZhCr+pp4JSgvmER6VHTwbSe8oXK0gMixw0jcXsTtZACK1z9tx9eAYLsbG1FXZ/VgjcwmyQAUqU57VlnKvwl53V0EdzXdM2TVIos2gkRx4cGo8+izE7Gf3WlE+76ZagSlLmF24/xukxzNVSYXUE88IKUop+32E3eACL2R9L2eWnwC5gk7ry31vx/pAMA2+tBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA1PR11MB6757.namprd11.prod.outlook.com (2603:10b6:806:25c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 14:11:55 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:11:55 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Koba Ko <koba.ko@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "James Morse" <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Topic: [PATCH v2] EDAC/i10nm: shift exponent is negative
Thread-Index: AQHZrfiT8S4St58DWkKECHZaJCTaP6+o1+WAgAG4woCAAE1ggIAAbuuAgAF4OeA=
Date:   Thu, 6 Jul 2023 14:11:54 +0000
Message-ID: <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: koba.ko@canonical.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA1PR11MB6757:EE_
x-ms-office365-filtering-correlation-id: 6a2e36e5-9368-4de3-4035-08db7e2af3de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bw+dST8xwNPdLomhxrFLkI7V5zZJ5X//8wXAiwJxWlzhhTiis5iKOiibRZ3+2+0kAuw7XnjDcDp78WUhb5Felz/7q7v6yIr3hfxDYdxQLFK6NiF9N9MEg0LNnDq7x8N+13Ak6Ixym6+3WQ/RpThj4le+lUMHse3e3v6agVs5sFciFGuAi6TeIVtgFy/BQ8+a0EZAUlBJquhXeZyBGsNDPsv83R/Y/sFsei9uPz9xD6svUh1MXGhJJpAWyUDYsDvLnDN5QboVcHd+5dXUlrjKt622uatVo4BJkEvuHC1Khu4rHym7SLWpKB7hEPqDs+YPoMRRJUM+3HkAj+8S7JMhNfu9kIbMd4AH0YTgbIs5A/cPHumXpLaM+5rivFZeTF1ZQlq4+FeUNlcmphHQeku3X5L6k/ZWpJ1uR5g98dUImtcHJf3heeAtSEk5ivxD7hVqeOLQoBuPrrxUn3BvB3uFVnPfZ2MWodADK6pU1E5AyehnMA4QD7A+GcQbE3DdOnwQVDp/1lnfP8EiFvIVcrnyce6MSniNqtx05x9KaUOrwSD6Ac23F1i1AkfMWMMbhDmuuR//pKzuDn32BUgYB94QzUDsfZJkNZ17PMMiH0sahj38fbSiRX7uMg/31FLOdReufWmL71vCskTGnQX79ZlZkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(6506007)(54906003)(41300700001)(7696005)(38100700002)(83380400001)(71200400001)(122000001)(53546011)(82960400001)(186003)(9686003)(110136005)(86362001)(55016003)(966005)(38070700005)(316002)(478600001)(64756008)(66446008)(66946007)(66476007)(4326008)(76116006)(8936002)(66556008)(33656002)(8676002)(2906002)(26005)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1Q3STdWcHc0YU5qNUFCcmJKQlU5YmNidFd2VE9scUJHa2l0T3d6a2g4TEVT?=
 =?utf-8?B?MStsd2s4VUtmamJoMW9xRDN2c1MzZ2hCY2RJcFphS2E4b2pFTjUxbzJURW42?=
 =?utf-8?B?ZlYrd2IycUZoNjk1YnFHL2wzUTFleDU4Q0NSMnAvTFZlbVVyNW5SVW9GNkln?=
 =?utf-8?B?TzMxTkR2ZzJ1dE9mUHlZUTFyMnFSSGUxQk54V2MzQkxQZVlGYlFKRVY5dmIz?=
 =?utf-8?B?cVRpcC9sZEF4RkFkYW92T29kejNTWUJhd0l0OU9rRWNsRzI4cXh2MTRvSFhQ?=
 =?utf-8?B?REJwYUZhVWQ3RUUvOGRWajFhMlJlU1ByYTR6ZHVZdW5TWUNJZDRTaFhxTWZM?=
 =?utf-8?B?Qm13Y3NBY2ZseThac3FCSU5UdVkrNEwvNTZ2TkV1N053ZDFEU3VONUdZUHYz?=
 =?utf-8?B?eGs3cDk2RW1aRTNrdU9oelJOR0EvWFJMbE4rdHNkeXhIQmJ1TzJnLzJ0MkJI?=
 =?utf-8?B?bHYvazg5YzJ5TTVRVUhnMm0xS3B2YWlNd28zcUU1MUlLK1Y2V1Fad2gyNGNR?=
 =?utf-8?B?cmhzWGFYQ1ZCbkg3cGY2Q3M3bnE1K01VVFJwYTkySHJqVjY0L0tBTTVUS1V1?=
 =?utf-8?B?K1I5OG5CYU5kdXBBSG1MK21kS0NKUmNOOHV3Ry81RDl6ZUZJNUZ2cFliRDVV?=
 =?utf-8?B?QW1ZMzlJOE0vZ3Z1Rk5qR09wdGJiQnBLcGRmeGVvNTdwU1lOTHI3QWxtMHEx?=
 =?utf-8?B?THJNajFrYkRaUjA3cThaV0pyU0ZyNXUyZ3E4WGFmMnYwRldWNjluUFUrbkxO?=
 =?utf-8?B?N2p4ZTU3VzcvYnlCUFNMclJZOXBQeWpydGkvV3pxbyt3SVkyMWo1ZWpxQXZa?=
 =?utf-8?B?S0ZENFN5c3hBWlozbDNUNEk3MEFjb1NGcVFBZC90Y0lTY2YweW9DdStOUEpx?=
 =?utf-8?B?OGpEdnVvQmNoK3RvSllWazRWWGFzcmRNV2w3bWNMWDZmQ01sd2xWZWFlL2FG?=
 =?utf-8?B?aC9HMGV1L0krT1F1WldCY3lFS0ZKMG1xRnI0UzByK1lqMkJ1WHVHaHU2VjlB?=
 =?utf-8?B?UFJINWhBdERVUnU5NGRjVDZLY0MrZlFsclpVaHZzcmZvMTNGbUloQmdGOFlE?=
 =?utf-8?B?aFpMTmRCRm0za2RMN05rM3Z5SjRGNHJjbTYyam1OaGlJNHU3REtJNVg0d3pF?=
 =?utf-8?B?Z3ErKy85aTk4SDZZV3FxMkhJZFRCUitlT1Q2NWZmcnJkRmh3SEE0c2VHd3h0?=
 =?utf-8?B?MTBUSitxeGRYaGxhLy90MHBFa1pFd0tac3BPZG9RenEwWERlNVJnYWZYSTk1?=
 =?utf-8?B?QTlCcUhORlI4OE9pUDNxa3RSY0JKN2tqUjlxN3pjcEU4VlU0Tk1KVDJzT0c4?=
 =?utf-8?B?ekZxLzBmZ0l0TzA0S01FbXNNZm1YbEFXcnl0T0hEMzhNNXdkSXhqSWR5eWNV?=
 =?utf-8?B?WUw4RlpvaW1lTWdyZE51dm5aWmVHUloxYzdocnMzUUMrTW1rWDZxbXhVUDhE?=
 =?utf-8?B?RDlVbkZWQVRNUWpxenk2VTNvU2VnSGpyZTBEK3h2TE5WME04ciswZ3BMSGFB?=
 =?utf-8?B?NTZGK0p5czNRdWo0MVFadGVSY3ROWDRGQWhTNXhFdkxXTGxBNVpiWGRDUGli?=
 =?utf-8?B?Z3FsbHdldnVXM0JyM2JOV1NSRUIxaDlHRVA2R3VaTUVXdzBvVmVCUVd5Z0Uy?=
 =?utf-8?B?WUdoKzlJeFdpQ3hndEVZNnNldU5oWWdDd3loQXlPRnc2NmxqcUd1RW5XZlly?=
 =?utf-8?B?WUkrWlgyNlkzMkZ3TG92L3NSZkluYzV6Q1BDYzErSWJ4cndPVEc1a0s5cGsr?=
 =?utf-8?B?YXp6WGxWVFBZWG1WQytLeXhHOGh1UEVVRFpaeVBWYXNDODdFZzAzTm5XTEQy?=
 =?utf-8?B?Zm9jbSs1SmRJSlVEUG56Sk1KcW1XVUhBS3g3UGlmMUJBSnk4QWxDclU2VDRk?=
 =?utf-8?B?WHY1L1g4NlpsWVJRQ2wzUlBwclZFRWJ4QXpucEtxUDlkL1YyUVVVZHhsRU5h?=
 =?utf-8?B?L1BWNjNwMUIrRGJOTGc2bkMvWldaY1Y4aGVxTEJYd2U5ZXBDMGwxNGxBRFNF?=
 =?utf-8?B?V1cyODVKYjhhM0hKaXYyYm9IeUxSaEk0TnNHV0crbkhuY3B6cEdkekFQYXpm?=
 =?utf-8?B?NXFtSmVCQitVcHdkcXE3M1c5eGJoOCtqS0t4aTZURDJHMVBpSUlJaTAwU3Ur?=
 =?utf-8?Q?UVCSR2BfOGeBfF/dc2ltyCsgm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e36e5-9368-4de3-4035-08db7e2af3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:11:54.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xK7gtV3AHLyEB4mIXniuvnnXZjWAfksjFzMOGZizzjsv9salWt0SA/ZHsihb0vymrdkvq/TB4AqS4Lkfx3Lpxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6757
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBMdWNrLCBUb255IDx0b255Lmx1Y2tAaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bHkgNSwgMjAyMyAxMToyMiBQTQ0KPiAuLi4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2
Ml0gRURBQy9pMTBubTogc2hpZnQgZXhwb25lbnQgaXMgbmVnYXRpdmUNCj4gDQo+ID4+ICMgaGVh
ZCAvcHJvYy9jcHVpbmZvDQo+IA0KPiBUaGlzIHNob3dzIHlvdXIgc3lzdGVtIGlzIHRoZSB3b3Jr
c3RhdGlvbiB2ZXJzaW9uIG9mIFNhcHBoaXJlIHJhcGlkcy4gSSBkb24ndA0KPiB0aGluayB3ZSBk
aWQgYW55IHZhbGlkYXRpb24gb2YgdGhlIEVEQUMgZHJpdmVyIGFnYWluc3QgdGhpcyBtb2RlbC4N
Cg0KTm8sIHdlIGRpZG4ndCBkbyBhbnkgdmFsaWRhdGlvbiBvZiB0aGUgRURBQyBvbiBTYXBwaGly
ZXMgUmFwaWRzIHdvcmtzdGF0aW9ucy4NCkZyb20gdGhlIGxpbmsgYmVsb3csIHdlIGtub3cgdGhp
cyBpcyBhIFNhcHBoaXJlIFJhcGlkcyB3b3Jrc3RhdGlvbiB3aXRoIG9ubHkgMiBtZW1vcnkgY29u
dHJvbGxlcnMuDQpodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vcHJvZHVj
dHMvc2t1LzIzMzQ4MC9pbnRlbC14ZW9uLXczMjQzNS1wcm9jZXNzb3ItMjItNW0tY2FjaGUtMy0x
MC1naHovc3BlY2lmaWNhdGlvbnMuaHRtbA0KDQpXZSBvbmx5IGRpZCB2YWxpZGF0aW9uIG9uIHRo
ZSBTYXBwaGlyZSBSYXBpZHMgc2VydmVycyB3aGljaCB3ZXJlIHdpdGggNCBtZW1vcnkgY29udHJv
bGxlcnMgcGVyIHNvY2tldCBiZWZvcmUuIA0KDQo+ID4gIyBkbWlkZWNvZGUgLXQgMTcNCj4gDQo+
IFlvdSBoYXZlIGp1c3Qgb25lIDE2R0IgRElNTSwgYW5kIEVEQUMgZm91bmQgdGhhdC4gU28gZGVz
cGl0ZSB0aGUgbWVzc3kNCj4gd2FybmluZ3MsIEVEQUMgc2hvdWxkIGJlIHdvcmtpbmcgZm9yIHlv
dS4NCj4gDQo+ID4gIyBsc3BjaQ0KPiANCj4gSSBkaWRuJ3QgZGlnIGludG8gdGhpcy4gUWl1eHUg
LSBjYW4geW91IGNvbXBhcmUgdGhpcyBhZ2FpbnN0IGEgc2VydmVyIFNhcHBoaXJlDQo+IHJhcGlk
cz8NCj4gTWF5YmUgaXQgaGFzIHNvbWUgY2x1ZXMgc28gdGhlIEVEQUMgZHJpdmVyIHdpbGwga25v
dyBub3QgdG8gbG9vayBmb3Igbm9uLQ0KPiBleGlzdGVudCBtZW1vcnkgY29udHJvbGxlcnMuDQoN
ClRoaXMgU2FwcGhpcmUgUmFwaWRzIHdvcmtzdGF0aW9uIGhhZCAyIG1lbW9yeSBjb250cm9sbGVy
cyBidXQgYXBwZWFyZWQgDQo0IG1lbW9yeSBjb250cm9sbGVyIFBDSWUgZGV2aWNlcyBmcm9tIHRo
ZSBsb2c6DQoNCiAgICAwMDAwOmZlOjBjLjAgMTEwMTogODA4NjozMjRhDQogICAgMDAwMDpmZTow
ZC4wIDExMDE6IDgwODY6MzI0YSAvLyBhYnNlbnQgbWMgZm9vbGluZyB0aGUgZHJpdmVyLCBzaG91
bGQgbm90IGFwcGVhcg0KICAgIDAwMDA6ZmU6MGUuMCAxMTAxOiA4MDg2OjMyNGENCiAgICAwMDAw
OmZlOjBmLjAgMTEwMTogODA4NjozMjRhIC8vIGFic2VudCBtYyBmb29saW5nIHRoZSBkcml2ZXIs
IHNob3VsZCBub3QgYXBwZWFyDQoNCkJ5IG9ic2VydmluZyB0aGF0IHRoZSBNTUlPIHJlZ2lzdGVy
cyBvZiB0aGVzZSBhYnNlbnQNCm1lbW9yeSBjb250cm9sbGVycyBjb25zaXN0ZW50bHkgaG9sZCB0
aGUgdmFsdWUgb2YgfjAuDQpXZSBtYXkgaWRlbnRpZnkgYSBtZW1vcnkgY29udHJvbGxlciBhcyBh
YnNlbnQgYnkgY2hlY2tpbmcNCmlmIGl0cyBNTUlPIHJlZ2lzdGVyICJtY210ciIgPT0gfjAgaW4g
YWxsIGl0cyBjaGFubmVscy4NCg0KSSBtYWRlIGEgcGF0Y2ggYmVsb3cgdG8gc2tpcCBhbGwgdGhl
c2UgYWJzZW50IG1lbW9yeSBjb250cm9sbGVycw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtZWRhYy8yMDIzMDcwNjEzNDIxNi4zNzA0NC0xLXFpdXh1LnpodW9AaW50ZWwuY29tL1QvI3UN
CkBLb2JhIEtvLCBjb3VsZCB5b3UgcGxlYXNlIHZlcmlmeSB0aGUgcGF0Y2ggZnJvbSB0aGUgbGlu
ayBhYm92ZSBvbiB5b3VyIHdvcmtzdGF0aW9uPyBUaGFua3MhIA0KDQpCVFcsDQpLYWktSGVuZyBG
ZW5nIGFsc28gZm91bmQgdGhlIHNhbWUgaXNzdWUgYmVmb3JlOg0KaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtZWRhYy9DQUFkNTNwNDFLdTFtMXJhcGVxYjF4dEQra0t1aytCYVVXPWR1bXVv
RjBaTzNHaEZqRkFAbWFpbC5nbWFpbC5jb20vVC8jbTVkZTE2ZGNlNjBhOGM4MzZlYzIzNTg2OGM3
YzE2ZTNmZWZhZDBjYzINCg0KLSBRaXV4dQ0K
