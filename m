Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466A731F86
	for <lists+linux-edac@lfdr.de>; Thu, 15 Jun 2023 19:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjFORzN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Jun 2023 13:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFORyu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Jun 2023 13:54:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C0273D;
        Thu, 15 Jun 2023 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686851685; x=1718387685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M4lqQUTWsKnL2Jd2J400bFu2yDrOehldPJuCv+gU37o=;
  b=BXUpkyNwyEIEsdmSc3olj4cY9GLHE6IswsTZK/MlgGzYzbdoDS7n43FE
   wV/RFuC5XCtj7Mr1Sk5m/I9ei4qR2UShwRED8dB5FFY0XqxxlQ9k0cB4A
   iyiQ1HWAwAtU5GnFITnoOWUtAz0t2Lgqpv+7mwavbuImQAZ0qZ3awnksv
   QNNYCk3gKstsytS7hwTIXNrybyHvq3phiI1Y+po4hW5+p5mJqwhkIsL/C
   Ja523K6dCmL75kbfuULhnkApaf7c1HrIihhvSWgABidAMG9cjDJuRNnrS
   5zsPXNjzxM1NcIWOdcee5a6KjxDtrzU58x4G4+eT/xdOjNvhbIalAwMhT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445369511"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="445369511"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825377658"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825377658"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2023 10:54:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 10:54:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 10:54:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 10:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm8DMN/cuKUa/H+GWNoSi02VfoPPckdIYCUOW82kvEFCSTwgHQhNwNqVcaXB53D8PCInwe+aw4qBy0Nc5OLX8OUwBLsF0eETxKJElB6a4LNiv7F2+WUPZUZ/3FPpBvzMACQI5ZvxbZEMjvHLkSFH0Y0q4F+Mu3XyjPPrUV5ACK9opsxPNArGGsf7/tnztyjrw3ecUC2DvSGcrw/Vk4YH792MTkZYY0z61L9gtMuU9LsxpMlK6CCYYgSKC1ht1gq1rQ3Az1jWmgTziT/ZBhgdc1Q78JJeh7VrB/RIh9hlArwJCzwwP6W9MhSSL/P2HT6m/gxBf44u88O99PuvzIgA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4lqQUTWsKnL2Jd2J400bFu2yDrOehldPJuCv+gU37o=;
 b=VMZUFitxr8Wupy0MbBzLihp7Wtl1YZcZD+rJ3hvoaXIw8pFEIXV4fIWOGG14O4V0Hxv8H1L4poUml9XB1U7WkXgVL/gBWCGGeoCX1sNfPmmB6MXWAlkVSYK/98SLYiu+ZMsKCK0NBY60W99UCi+xB8i4SibXkMby4aQSWwjebm/j5ikoUkdjfV3J/az565AuTMzPIMsE0wN48Wr3T1124C0RjIdr9oyVRLNK8KAuedMKX5SZYiQJXYZmz+ccyLud7OPxRusRHI3PQwmL8LJOQdoczNPfiqVKwFoJ4BhnH0+ZGff9grvuP3uaxKqO06iKULPF3tSnF3vWJ8V52Omfxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 17:54:42 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 17:54:42 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Topic: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER
 decoding
Thread-Index: AQHZcUiOiGs+Y9zOZU23tA/yQJ0VrK+MV0eAgAAD3YCAAAztgIAAC6YAgAAKcoCAAAIuwA==
Date:   Thu, 15 Jun 2023 17:54:42 +0000
Message-ID: <SJ1PR11MB60834DD80A6193F959719CF4FC5BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230417162006.3292715-1-yazen.ghannam@amd.com>
 <20230615152031.GCZIssPyJjGcikn9iA@fat_crate.local>
 <c9f885df-4650-248c-3708-9250a0b530dc@amd.com>
 <20230615162037.GEZIs6VZG9gVs5QtFT@fat_crate.local>
 <d1333fa6-34e1-8b2a-b772-369776428eae@amd.com>
 <da1f680b-f601-0e64-bdb4-1aa5b6fc6175@amd.com>
In-Reply-To: <da1f680b-f601-0e64-bdb4-1aa5b6fc6175@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ1PR11MB6251:EE_
x-ms-office365-filtering-correlation-id: 51179dc7-5bc9-474c-a42c-08db6dc99923
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7+WATG5dN8uhQQjOL9/Bnij40yNtizgVWw51K7AoL3sHtdp4m2ZpnQw8pewr36uuNlc3oPPZUMEyN/PIOYMXg/41kmx4u8Jn8EXgJPPSrJKRbhrJ4nwp6DKXRJIrkDR33JTCdEOeBR+PXYrNYDpN3YcnpmFu7qzmF8Wy/fmWJ4/7OC8sAnzSvuD6oGJCr9OOHZAoPhrcDb1OaK17reY3D3ZpLUJUvuASH5srXnLjCAGpeTa4ujh7MJ9+/im6rAfeMEKYSLqlidtgqTVQdt3BcM68JLWfevIPIpDaCGuwIqceGEJfM0cUznb9xXtPFzzOoisCRnPXpP5nd4CpVkylKBEW9eCdbmMwzFWPLBUCOwRkmfgHZ42H/LlafNjWkPc0hiCnuF5GYk0B09Nv+uS8msVmqJLmvB8KbYPH3VY8zt9jN7mkCqlN452s+qKsocK/qfN9ln/8UsuI1NGPBVEbHyr4Ijifaw2wDzWG24sl2VzLG9fGHE8TmPBSgJy8+iacZmuXKr4Jtar7rEOfMAdG8JqlPuznIl4AmB7jRl0Vd9yhzgeU3Yujqoq39FnfSoNvcdlasRKMFNRR2BhUtx6z3M7+43UxcUywnP74PDa5ri7zoMwiOQGQ1HXs35TNMuP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(7696005)(8936002)(9686003)(26005)(8676002)(41300700001)(82960400001)(478600001)(71200400001)(66446008)(64756008)(76116006)(66556008)(4326008)(86362001)(66946007)(66476007)(38100700002)(110136005)(54906003)(38070700005)(33656002)(316002)(122000001)(55016003)(6506007)(52536014)(5660300002)(186003)(4744005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S283dUdraU9tU01USWovTEM1eTU4ZHBmMTdSZEx5aTRwN2pkYlBLMlVGWHJq?=
 =?utf-8?B?TndLZWIwMmg2eGhGYjVvY05TMHVhL2tWNEtrNE9vUFc0OUwxa0tPQVViTk5I?=
 =?utf-8?B?akRCVDU4M3pOZkJ5Vkd2N2RONzlTa2dTQWdER0dzZS91RHkxT1Y4ODNFdDJK?=
 =?utf-8?B?RjhJa1p5eXhzTTZaQ0tWd05YZnA0RTVvdms3MjZzTnpRM0JxeVdjT1JQdnZq?=
 =?utf-8?B?Nk9YNklhQ1diRTNyK0g0ejVwVTYrQ29HZ0N1WlUrZzhtc2pTMEZiNkl2SmdQ?=
 =?utf-8?B?dmo4VnVTUGxCcjZjN21wNFNIMWowL3k3ZmFsd2Z1YVVBUFRtRFdRUW5Vb3lL?=
 =?utf-8?B?aVV4VkQyaVgwVjRDMWI1aUFteENRYU8yUWs3MjNkQ0ZVL3loOXFEVDF2VGda?=
 =?utf-8?B?blQ4andkWm9IeklCQXJPVG9vcmdhOFpVam9ZQjZnNmQrNm8rdWtCWm5oeU5R?=
 =?utf-8?B?K1RJRUd3U3pnU21uTktpZWEzSGREMVhJd2lTNERycVppc0J0K2tIT1RTQXdV?=
 =?utf-8?B?VVlURW1BN3BELy8xS1hjVW9KWCtNd2hjU0hTTkVlUHpNUUFBMXBFdHdlZmpK?=
 =?utf-8?B?cVFFc1UzMzNwVGRIQTg0QnFGempOSWxZWU9CTERYazEwTldjd1UrbjRCYytR?=
 =?utf-8?B?NEg2REdYTTRzakJrMmV3amhjSUlad2ZSSG8yU0x1QlJ1dXV0NmNTRVVqOEtl?=
 =?utf-8?B?ZnMxbDB6b01OaUVUcDUrT0l0Wks5Yjgvck53RU1NMGJqZEFuaU1PSnlXU3FK?=
 =?utf-8?B?ZS9OUEdxTTJ6R01ESHE1ZEVwRE1XdlJqZWo2OVNsQ2piRW5nZGdGemJUVnky?=
 =?utf-8?B?L0lyRDBRcHlzdVFDTFRmTVUyWi9xM1NNdnRlNjRmOXlRRUk3R3loNithYzgx?=
 =?utf-8?B?OFZQWXBaRGhVSHpnMUFkbXlUK2xUVjBaSUdWeGdqdlNlY1g4TXlVNlRDOG16?=
 =?utf-8?B?RnVja2swQ2Y1OWdCOVBxTE9WMlFpcWlqMXhTZ3llOVdoSmRuU3lPNmZqSTIv?=
 =?utf-8?B?a1VnaHZ1Q09Udi9xM29NVWtjbUJQV1ltVlg4NFk4TFM0UER0c3FGc1ByQWMr?=
 =?utf-8?B?bjJFVy81ejVOR2IyK1F3TnJzWjZtajhiVmZkYisxM2s3am5kZkFLMzVGWmgr?=
 =?utf-8?B?RER6OEY1VXowYXVWajRQVFBTODhTcExGMzNhbng0WTNvMklnUUZia3RPbkJB?=
 =?utf-8?B?ZUdRYWFJUEVWWFRYeUtTMjVWWGxUQTRyU0xQSldVZDNEN1NGV3IxalNjNTlR?=
 =?utf-8?B?KzBCOE1kUzNJZ2orWFpmZ0RWdkZPa1JHQ1Z1R0JUNTZITGxpdVNSS1U5WERU?=
 =?utf-8?B?eGhBWHlkcHNGRUhjcHBRWDRjYmFvSFBOVVVVQkx3bzhQU2cvZFMvM0VpbWdv?=
 =?utf-8?B?S2FnSXY0UFlUbmJMNmZhWHFWbFRPbVowRXByTmtGek9TaGlram1zTERWR3ha?=
 =?utf-8?B?WGthUkZ3SzR3dkN4TFpYS3VOZVgxSURWaVZsb2hycTNIZTBndlJmWHdNVEli?=
 =?utf-8?B?UkQwR2tXZC9UUFpKMm5QZjBiMG5BRDJrSlpsUFY1YnByaTh2ZVhsREhJbUov?=
 =?utf-8?B?ZFpxQ1NiVGhLRy85ZjdTQ0FsMkIyTlhoNnJheXJZOFJyQUhYRFhDc1Y4RERK?=
 =?utf-8?B?Z0JaT2MrL3VJaVEyREw5b2duWlpaYnpUSW5ld2lPZkVHbUlnc3lJS25Rb09D?=
 =?utf-8?B?Qm9qTy9ieHJzcWNibFEvMDdPU1luNUpvNEFUK25BRmdYSGJJUGs1Y1AwWXNa?=
 =?utf-8?B?eHFyRmQzNGlNSXdKbUJUSWVnU0paUldKVU5aaXo1ZzdjUHIyanFPYWZwbFlh?=
 =?utf-8?B?cFE3SG51MjNvdFVDSWRWRGk3dW1RVVFLY2JJUm9NelJSUjhLeE1ReFBqdEt1?=
 =?utf-8?B?N3RKTkh5VVIyR2RWMDhBNUppL1JablgvRTZCMkZOVVduSU5HTmFvQmVlK3Rt?=
 =?utf-8?B?d1JFa3lZYmRWNTY0TXF0YjMyekhwUWdYTE9peU9iUmV5emh0amp2Wnc0M0U5?=
 =?utf-8?B?MkdYNlY1L3NUV1JMN2w2YjRQbnF2MWowMHIzalAyZGRYM1dQT0JOZWJBaVNs?=
 =?utf-8?B?bEZaVDlqS2JkMktvRWJnVUNYVm1EYkoxNkdBbGd5N2pDeURzSWVtWnZTYmFQ?=
 =?utf-8?Q?pbHg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51179dc7-5bc9-474c-a42c-08db6dc99923
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 17:54:42.7769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f3Zz06KdQIgL9p2suA+9B50XJpkS9EceDVUMRozcRzIL+/OlWKmdocmk523JB8N9c71sZOkVaNWyRn85wuHraA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
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

PiAgICAgICAgIGZvcl9lYWNoX3Bvc3NpYmxlX2NwdShjcHUpIHsNCj4gICAgICAgICAgICAgICAg
IGlmIChjcHVfZGF0YShjcHUpLmluaXRpYWxfYXBpY2lkID09IGxhcGljX2lkKSB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIG0uZXh0Y3B1ID0gY3B1Ow0KDQpBcmUgdGhlcmUgYW55IG90aGVy
IHBsYWNlcyBpbiB0aGUga2VybmVsIHdoZXJlIHdlIG5lZWQgdG8gZmluZCB0aGUNCkxpbnV4IENQ
VSBudW1iZXIgc3RhcnRpbmcgZnJvbSB0aGUgYXBpYyBpZD8NCg0KSSBicmllZmx5IGxvb2tlZCBh
IHdoaWxlIGJhY2sgd2hlbiBJIG5lZWRlZCB0aGlzIGZvciBzb21lDQpkZWJ1ZyB1c2UgY2FzZSBh
bmQgZGlkbid0IGZpbmQgaXQgdGhlbi4gQnV0IExpbnV4IGNoYW5nZXMNCmFuZCBtYXliZSB0aGVy
ZSBhcmUgc29tZSBub3cuDQoNCldoaWNoIGlzIGEgbG9uZyB3YXkgdG8gc2F5IEknZCBsaWtlIHRv
IHNlZSBib290IGNvZGUgaW5pdGlhbGl6ZSBhbiBhcnJheSBzbyB0aGUgYWJvdmUNCmNvdWxkIGp1
c3QgYmU6DQoNCgltLmV4dGNwdSA9IGxhcGljX3RvX2NwdVtsYXBpY19pZF07DQoNCkJ1dCB3ZSdk
IG5lZWQgYXQgbGVhc3QgYSBjb3VwbGUgb2YgdXNlIGNhc2VzIHRvIGp1c3RpZnkuDQoNCi1Ub255
DQo=
