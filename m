Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D50774A95D
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jul 2023 05:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjGGDed (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Jul 2023 23:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGGDeb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Jul 2023 23:34:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCBB1FD2;
        Thu,  6 Jul 2023 20:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688700870; x=1720236870;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X7R2/LjGDVwr2rg75JWTotzylBerxs0lUVdt9oeUBFQ=;
  b=WFVYJ8NoWNnKdRrD9r0ZOsbDHLzbxiXN1/2BV6VirAarDrBrhiGt9B8i
   W88uLoKleh3wPJJU6mI+7hQH1dnytF1Tpl+EjtsDWEBrlDDlOcgMIfY9L
   Evx5XksuGQxH2BLOxEz5B+Sqcjf0sw7H1LRBi82SBpMrg9p4fLMwmRl24
   yawE45p+N+zctavktteSHfnJhcZVJNiIboq34UXhsA1cTtycx3OeBO7du
   UhlkDEMHT1hzlCfpBwbhVn6Zd9mOR9TFMlGl5/f4PiVZkKEgTuVWxMyhu
   LGuNOXwnZy0MYa2FYrcfp7jh3NBPG7MK9sHZH1HM/ypRUrnFZ2GhDcdyl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363830673"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363830673"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 20:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="1050364989"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="1050364989"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2023 20:34:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 20:34:29 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 20:34:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 20:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baVYaZOhk/1ptY3LBCncpr6wE6CjhsHRvZ/ta2P5XfhgmRqVAPmY7p3Wdxin89fqT2xrZbvmnVoLAh/TiuzimV+KVP4gYdbHqcLz7b+pDc0kYgmxjH36gR/+0owZbgqBjsTrW3NPLNIAJqFNJr2E4DZMw6ahB5KxXfBXiT4CGkDB9+FCFOMHFaVqpAL0aRDyDwn+q1xDeJ9CXlbMhwVnMObzR2/NLLncK1bjC4fC+rIC0MUqF4YhCHgaVBKns1HdXsTirAFww7fQjA6OzEBZJkm/UFCmVAQqB3FMW28P9ESyQy4tQXGdOemBbU1acg9QwLgQxrLCsesgu10TVGWRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7R2/LjGDVwr2rg75JWTotzylBerxs0lUVdt9oeUBFQ=;
 b=lqqczvlmGxxYLAJbdln2Gjyg6zW54dbJ8mYMJvB5yWhRpRNTBEBUvHqzFjmu6HLJ4oQyqGHjhgs214hTuzc53ZXOkM0suXYhECWh/xFXpJ2nH1hjlQrHOqrabXMkBUQ+yVdlp8QgXMZZnWvFIcX0gqZP5dsrhJJqDqnFZWxfmlhRpYKHm+vwzC9+1hcBx9Td3GigvxifSg6g7vBYJELfVSVI4MsfpHI4OfEM3XhTAWkxkqWcINrmvaJlxNjcwwJmIKUgsAsVCKJ1BY/YslJPHR/tdGHdB71jX9egivcry6YqXSpwbnHAHstz+QQFiTOiNkUmbza2n5UqNALj+gdzZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by SA2PR11MB5051.namprd11.prod.outlook.com (2603:10b6:806:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Fri, 7 Jul
 2023 03:34:27 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::221f:dbc7:48ea:7df3%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 03:34:26 +0000
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
Thread-Index: AQHZrfiT8S4St58DWkKECHZaJCTaP6+o1+WAgAG4woCAAE1ggIAAbuuAgAF4OeCAAEDZAIAApV2w
Date:   Fri, 7 Jul 2023 03:34:26 +0000
Message-ID: <CY8PR11MB71346D8945AAC57D3614CBE2892DA@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
 <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CY8PR11MB713495A12DE47EDC3B7C5E20892CA@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
In-Reply-To: <CAJB-X+X_KW=T4WOe2AS3SFFQKjt7VcQRFUCGYFcjipi5-aXdrw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|SA2PR11MB5051:EE_
x-ms-office365-filtering-correlation-id: 04c901d0-7b97-4f0b-8210-08db7e9b10c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGVh4tjSw4iyZYrq4rcnimMpzmfR7OGdZK08KFEzmmchSRQCpiOUCHfcxVGfYE3KMkfsygiu4hs+w9+QCNeXBav1dE/qjRI6P8KypqBYkML1tpRRj1W5584iNFtXEF2aLtJh2lKaCJ9x4DIs4203s3ezf5nx9T5aqzz6AGa8xynlM0vqmusGFO8RxFtTPenrsISYGWNtV9zbNHzfQZw3oDZ8VGiRAcXhMmgb+SM200LGEPXO4cOQGwxcRNC2j/GvcRyhbHmOzZPjTFFT7qV4RsGfXzQActfxji02fBmemAhoJSYBkX9C2smkCosgfziERXkHphnHaXRy9lBkfTLTUxWedfg2oNCw78dqcHnrW2r4Y9oF4AA2tr8UOfQDrwvWXZamMy8wQMHmfEEkK4jnlwnowbsdJLI+yBu97lHJbC4SlyYcJdg+chYXhhLxhBM9fXg9ZaPHioKBoa6xbh7YbrjF2zaFhxa6E4AHBaidVBHIdhUl0YqEyRP0+9yRjoqXeS2DOtvFJBl/x2QpaD7ynWThl+vcJ3166ma6iIoEcvIWIO7KYfAqPuW0bb80HK5xyDnpovJfWn0A7ujWOcFgIYspe5/mVgNj3YUtz8nqXWmbAlglTH2sXJR4B2srZ2t5OMArSz+lFNbbmK3NUR7E9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199021)(478600001)(83380400001)(82960400001)(122000001)(33656002)(38070700005)(38100700002)(86362001)(55016003)(54906003)(966005)(84970400001)(7696005)(71200400001)(8676002)(8936002)(5660300002)(52536014)(7416002)(316002)(41300700001)(64756008)(4326008)(2906002)(66446008)(76116006)(66946007)(66476007)(66556008)(6916009)(4744005)(53546011)(186003)(6506007)(9686003)(5930299015)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnQ5dDlFc1ZTV1FvdmFCdlowWkR5VmJjUWhicnFtZy9IQklSQ2VYZTZsS3hW?=
 =?utf-8?B?SWo3OGxHS2VGL0ZKc1o3NzlINHFETU5neFBhQ1U1d0E3ejFGMUpNdTVsOUR2?=
 =?utf-8?B?YVZMSng0OVBvN2ZuUjN2ZWZER05tdHJZRUViMDBrOUx3RUNobkVvM3B6RDR6?=
 =?utf-8?B?U0FjZHIyb3ZIS0M4Y2dmOTFoSkRad28vTE16UG91MlRxbUhmRDdNcllYOWls?=
 =?utf-8?B?VjRqb21xWHlxMVF4ZWEzay92UU9BZG9oUDhYck5ja2lsTjNuOUxCcithcXhT?=
 =?utf-8?B?VlpKNFdkQzZUSlhweVRPYnhBaTUrN29nNGhUTFFKT0pTT2dxeTBMeHVrRHls?=
 =?utf-8?B?UldXajBsbGVuOWpFY2xKbVpLcG5iTEpOcVNsODJqbi96NFlNUThaMG16OG5O?=
 =?utf-8?B?dzV5RTRMWGZhOTkyV0NtR0tUY1BSTkxwdVdqcXVYRGl0L0tSc1E4NFlxNnhm?=
 =?utf-8?B?UXJ6QnlBcFVLeDZoWWgzUjJHckM2SEIyOG9ML0hzTjNXZkxYM2JENzI1ZjEw?=
 =?utf-8?B?eWdSbnJRY0IrVUR3ZEJ3OWN2NnUzZTFtZDBIampPNUtGZEJPUzYweEdCSXJQ?=
 =?utf-8?B?cHhORWN3U3JWbitqQ0tJSm9BQzJQY1lxb1g0VDFGUmVqdHZDSVNySnhZWlI5?=
 =?utf-8?B?RytOZ0ZHd3h5eWlmRlJVZk02K1BTanlqRW1SMEZWNzBuTWYwZk8zMXU2WWlB?=
 =?utf-8?B?WTdPekRLWk10eTZiTGY1UFRJaU5ScGh2QnVMeHVEWWhJNjdqSTluTWh5cTZ6?=
 =?utf-8?B?Y2lzMnMvNkVuL0FJSzZveUpqMDdIdUlIVkZ4Uld1cXBjMnY4R2pCYzhxUXBq?=
 =?utf-8?B?Y1pMQTFqSmJ0ZW5BSDB5VmZoUEtPNkgrMzl2dG5WTnpPcHh2N29KemZsNEJr?=
 =?utf-8?B?TE9QOE11TkQ5eE1Zd1ZZZkFXME5lOGZaYVoxeS9wTWpkbHhzSDVqSFcxak1C?=
 =?utf-8?B?UytoeElzOFFXSFJ5R05hZWJJelc5ajhzQmpxbGY0dmtUWG4xNUNTdUlBRnZh?=
 =?utf-8?B?L0QxWFRjUVowamViNnJaVUpHZ3piZzllMGRnMzE3emxnOFZ6MEUzcE1Fekh1?=
 =?utf-8?B?dGc5WG5Yc3d2aXJmY3Q3ZWNCOGVvQlQ3SzRmb2dadmo5RkdSNmQvcm5MTGxj?=
 =?utf-8?B?V1kzMzJyTVk4QThtNWxpVXhiTjBrWUZ4ZFVhNTkwOFhIWkoxWUtzampYSzkv?=
 =?utf-8?B?bE5ZVjVoUis5RnEreEJvRzhiVUhFWkx5ZzdyQUNyOHRnWnlYTndFWGlQMWhD?=
 =?utf-8?B?dkZtb2NQakhHV1ZOcVA0MnNoVFJ0aFBwYVlsSmJCaXc0K09QVlRmYklKNGpD?=
 =?utf-8?B?enlkY1daaDEycGVudVZRT0RGOGpkZkJMdGtOdTlBeE5hTmJyRkFjdzFwcFB1?=
 =?utf-8?B?cWFZQUY4byttVjlFSFlyRFBEZTNKc1lCd3NST1hzRGRKU1pSMVgrV0xleEw1?=
 =?utf-8?B?MTNsY2NUZk1BYmJEN09SanpBY3RzK3ZZaDl4T3RVUE1FT09MVEsxM3JybVBY?=
 =?utf-8?B?SUNPcnZ3R05WR0ZPTWNVTlh0WW9odXMrMWc5RVZYZzVOajZHc1RxTG1mU1RO?=
 =?utf-8?B?M1VibmtLYzdyUzU5bU9wVlFtRkl3REtBcHlpU1FFcHR3SFpIVzE3WGJFNVVX?=
 =?utf-8?B?dzdvL3psZ1A4WG0rdmxYTEZaZ21qSVlsSGtyZGNQd1NSWHp6em9CclhjTk9h?=
 =?utf-8?B?Q1lVVEdjYmZ3OXQwSDhXVUVkRnVRMVBWWC9TUHoxZXNzRWc2YmtETzBvSng2?=
 =?utf-8?B?UVVpQjN0QzB4eTBZeXV1a3VrRkVybTJEYWpvTDV3MzFPR3IwRit6bHJla1JO?=
 =?utf-8?B?S05weWRrTlhHZnVFb090S0NwOTZ1Vm5JWCtYUFlvQkUveWFUNzBtL0NOcnFp?=
 =?utf-8?B?QkR3dFVaUklyRDVDQUdoQkVJNDF3Sk5keVl5T3lzOTdpc2gxM29FNERHZlFy?=
 =?utf-8?B?OElEQllwTlJOYnc1dlBWR2pWRHYwQnlSVTJQQzlubmM0dWhyVnhXNVFNUWh1?=
 =?utf-8?B?NTAzSm51Ri9VckZwUm1HWVRhMmZ6KzdBUi81K2puTEFzWThGVGhJSTRFdEo2?=
 =?utf-8?B?TFRIQVhuT0Q1VS9KSlFTS1ViR2NudHhCOFVuRjBGb3dRbG9WeFpHMkVkL3A1?=
 =?utf-8?Q?xnAPF8e/neMxLi5LWVytB/xQ6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c901d0-7b97-4f0b-8210-08db7e9b10c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 03:34:26.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mU08ZrI7VZDmTJcSWTocM882uDeXbI3kxCgLHql6VwiJc166d/L6hszYgb9v+fDx364LkQmsllOJRruI2yQ3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5051
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBGcm9tOiBLb2JhIEtvIDxrb2JhLmtvQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwg
SnVseSA3LCAyMDIzIDE6NDEgQU0NCj4gVG86IFpodW8sIFFpdXh1IDxxaXV4dS56aHVvQGludGVs
LmNvbT4NCj4gLi4uDQo+ID4gSSBtYWRlIGEgcGF0Y2ggYmVsb3cgdG8gc2tpcCBhbGwgdGhlc2Ug
YWJzZW50IG1lbW9yeSBjb250cm9sbGVycw0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWVkYWMvMjAyMzA3MDYxMzQyMTYuMzcwNDQtMS1xaXV4dS56aHVvQGkNCj4gPiBudGVsLmNv
bS9ULyN1IEBLb2JhIEtvLCBjb3VsZCB5b3UgcGxlYXNlIHZlcmlmeSB0aGUgcGF0Y2ggZnJvbSB0
aGUNCj4gPiBsaW5rIGFib3ZlIG9uIHlvdXIgd29ya3N0YXRpb24/IFRoYW5rcyENCj4gDQo+IEhl
cmUncyBkbWVzZyBwYXRjaGVkKFJlZi4gMSkuIGRpZG4ndCBmaW5kIHRoZSBwcmV2aW91cyBtZXNz
YWdlLCBgRURBQw0KPiBERUJVRzogc2t4X2dldF9kaW1tX2F0dHI6IGJhZCByYW5rcyA9IDMgKHJh
dz0weGZmZmZmZmZmKWANCj4gDQo+IFJlZi4gMSwNCj4gaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29t
L2RyaXZlL2ZvbGRlcnMvMXh5bTlKZ1paZ2FKM0VxdFA0Y2NSY1ZlUVlvSkttVg0KPiBscD91c3A9
c2hhcmluZw0KDQpUaGFua3MgZm9yIHRoZSB2ZXJpZmljYXRpb24uIA0KWW91ciBsb2cgc2hvd2Vk
IHRoYXQgdGhlIHBhdGNoIHdvcmtlZCB3ZWxsLg0KDQotUWl1eHUNCg==
