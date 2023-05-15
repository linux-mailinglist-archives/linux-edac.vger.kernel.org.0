Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98174703D54
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbjEOTIM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 15:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242268AbjEOTIJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 15:08:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDC593C4
        for <linux-edac@vger.kernel.org>; Mon, 15 May 2023 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684177685; x=1715713685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Icfrmf4ZONCx961LhttoNZL12kTRXYPGlLQESgLYWOo=;
  b=g0cnYnfpmi72tTRHshS1ifQJ7xziBItWhto+L8TnPBBlPOOhfqXxGtlc
   D4qlbtZY3Fgg2h4psiiBkAKQRWJmM0x39EdoZl+iiZ7xNcUb77HLv1ZYA
   DrH+q5phYTROK3OCiasajEWTTlhfGAO3TnyhJq+Qu7cgR1RkrjVv3/dJF
   CgfloPVB//RU1P5F8C2UNxWowfoGBOBETFKx9ZkS6HeXpv+yODJpxY08u
   LCBTGbCkSYD165wZT4ZZj5gYPGDlw0m8sqIBJ07xbg7XvGGfDmbyQOJ2R
   v7H2tmXDLYcbUIGHukUrtU4ESrYkVzf0LFv9eOnQsNnjh3wtgA7rn8fJx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="340649849"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="340649849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 12:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="651543282"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="651543282"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2023 12:08:04 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 15 May 2023 12:08:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 15 May 2023 12:08:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 15 May 2023 12:08:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN44ivwybUkLjNGEGykpIPhu8lFhjLKKsYqcHmTbKZEEPWAZdLyf+PT8yWbm01FAG9o0FHkVOCzP+oW8jL2GLOg+apX3aDgC9pjWa2m1Qc2M3Cqv4IRKGy3oFpR0O041AJcQQepFPb3ar2XfayRsIqvTvv40Z1cFV7xVGaUjqehR+amyMx5xEh98iRwtmqxOBYeQdAa0Nlr8V8rgEQ2O1+rGkXw1gTQHx/tLkg+s5PhvWlol6L4nW08xjTgkMNJfYt4K9sQDw6bQsfVgpoaQHf30KnzLCrmbSoSQHoZeiMuaTugWyu9fmqS651FC/8LiEV6JkhI9siZNaIOK/rymug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Icfrmf4ZONCx961LhttoNZL12kTRXYPGlLQESgLYWOo=;
 b=OiVGHMUXirFmr6ikmmubamQVfVfK3JnQLvrHlCXZ23X2PWPe4YGyCdBt5j8zuYKFTsjlwZJrFL63fXHapCLdtv8ucGiL7bph3JH1/ENSEET59jUIaphF2R9cCaaoSw7A0A2ApU/R15TmWMxd24ioFJFHr/fAkw50DqYly/1u4Rkba1xM0ds0eU34/uZRy8JxDiGtpQBFrh0EOgrMtcKN4jZ/8s7anvRMtfONeQJkNIC7C3m9aBVDO1d6sl+bKFaGoTLylmJ4K/AuZMSGta71c0ZluVKlT4RAgiG84N38y49/zubzLAZCEP5ErdEaFBNDa+nIjMVonmSk9tr6N//W1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CO1PR11MB5108.namprd11.prod.outlook.com (2603:10b6:303:92::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 19:08:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a52e:e620:e80f:302%6]) with mapi id 15.20.6387.029; Mon, 15 May 2023
 19:08:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Aristeu Rozanski <aris@ruivo.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: RE: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Topic: [PATCH] mce: prevent concurrent polling of MCE events
Thread-Index: AQHZhzo8HZ+8oxPq9k2uyIf0XEmMiK9ba0aAgAAjz7CAABk1AIAACA9g
Date:   Mon, 15 May 2023 19:08:01 +0000
Message-ID: <SJ1PR11MB6083DC9538CDB6E7FA8B803BFC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230515143225.GC4090740@cathedrallabs.org>
 <20230515145227.GGZGJHKyH9sAfToD03@fat_crate.local>
 <SJ1PR11MB6083576B4BE589D6F04559A5FC789@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
In-Reply-To: <20230515183050.GJZGJ6Wsmr4Yf/H5Ps@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CO1PR11MB5108:EE_
x-ms-office365-filtering-correlation-id: 78f0fc05-f4da-4697-8c4c-08db5577b473
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gDIJbuuFrc023KO9DaYRi2m23ArLsM4Ax4jsbwJVbbrsONBKWjMrj9Z5PaaUwj++b4jGjRQ+xxktLitAJX+ugAr7n5+WHd29ROKrm1WMgDxayHlWH4n8Wlzg1lKStPIHph2v96A9cIs7VM1m+cryT/c1/Y03xBRBIZaTtIkdps9e5ridVB/r3pkeptpaHGMZdboB01cKpW8PXD45wEffd1lWGB7y+AL0uHFxpw+rfLLX2XWmfpbZwUdnYOaytKlfJhb1js6VWE762yvf3RvxmOgWuX3OoVqTczOihu0Cd+1rbkXS8hNlHe2N3nxPNWL1F4bf4ss766o1fO1pERrQyi1U5yHN0UHGNwBNawKVsNGMKPrFrIItxSWnfss9Xv10ljHD94HkTFFttxaQKnuyhE9giDWDVf4rMAmtKN0rcy14hVEFFsvz0UZ1AhcKCE/SiOaBun6drToCYHnhKZeQA639FBdkD+JbCSCK2IPPXxDndOP66szoRa+l4vBT/n12IizKYpYz4BAX8b3QaufD6j7rmr+P0MeNiocGIuDQJpkq40Hr0qovzc3Dp7jZYq7Ev0eQkGPYWRHnIsMhbJD/JdSikA9CO/4Vc3XrNg8v88Jee9TfdTUbdbDPVgSqSv1/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(33656002)(86362001)(54906003)(316002)(66946007)(66476007)(66556008)(6916009)(66446008)(4326008)(64756008)(76116006)(7696005)(478600001)(83380400001)(4744005)(2906002)(55016003)(5660300002)(8676002)(52536014)(8936002)(41300700001)(38070700005)(38100700002)(122000001)(82960400001)(26005)(186003)(9686003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXo1VldUeGxCNHROUS9tUTBkSWNxYTRPWC9XeWZOOWJUZEhSRkp3QjNrV1NU?=
 =?utf-8?B?MzBuU1BDZ3JNQ1RrNEpEUTIza3Y5TW51WmJhcUEwYm94aTVHdmdIeXNBaEhR?=
 =?utf-8?B?SFd1aXVwWkhZTXl5blN5RjdRcnZYZEh4U3dKOGIxWXVaM29tUXRYMTNKUDNh?=
 =?utf-8?B?N3htOXpKRXc3VlBJZDZ6N09jOE8yL1FmL29UbjBiM01vM0Vkdmd6WnU5eUtD?=
 =?utf-8?B?MDRUWVNPaWZuQ05scTZVaUFtTWlySE02bzc5eEk5NHVPRUg4czF3aFVyMDZx?=
 =?utf-8?B?dm9xdDE3bUh0SVh2TjR2Ym8wTzFHUkp0UllvYmNpa0g4b2JWY2QvTFdndzZD?=
 =?utf-8?B?dlVlQitSOWhIR241VXd2dVJIYWcxem1iOFVBVGFhdjNnbmVSREJJeUdmdWtX?=
 =?utf-8?B?U2g5SFF3YzNqb1hTNytzcGE4czFRZGVtM1ZmdDZnODZDOVVoalZwZ3g4bTVI?=
 =?utf-8?B?SVEwT1BTd3BvQ09rcUdIZUNRckEvYis0bmx2c3d2RnluWkdHSXpvOUo4VGlO?=
 =?utf-8?B?dWErdWhqN2tyVXY2VXBmTW5QSlFDRjcweEVJM2FjNzcyVzluc0IyL3VSZFd5?=
 =?utf-8?B?eHY3NkliNlN1WTAwU24wTHBtZEZrMHNzUG1IRmJXWngvejBncHlNREFKeCtD?=
 =?utf-8?B?QXVEU2hCUU10RTNKZTllMmVrU09hOTJpVDVSbkZpdzIzL1BjYTZqVU1CVEFk?=
 =?utf-8?B?SE1XNHliR0VTQVd3c1NrUVQ1SkdpYVNQV0c0K2ZTUlhvdDRQeUh5NUpkdk91?=
 =?utf-8?B?M0twMHpDdzB0eGJXZXNYV3NzNTkxWXB4WWFkcGYwTFI1c2hzaU1PdVpVZFJH?=
 =?utf-8?B?bGpyWjAzMXQrRC8wbXVKZVM1UnVzbUo4UmhyaGZkK3U5MDl1b1Y5aldZdzU4?=
 =?utf-8?B?VmlDOEJ5VGhSang5OXFka0lOenRLTXZ3b1F6YXRvYmxOc0xSOThxc1dpNUlQ?=
 =?utf-8?B?SlRvTFU3Vk1jdkVkb3BMeVh1U0xJZ2F3UmVZb3poN2txY1ErbmhhcHNQaXhQ?=
 =?utf-8?B?Snl4MkRCR0dvSnVIRDFDRHpPSlhDQUdCN0NsaXFXWTFoR2tIUExYSi9aRWhp?=
 =?utf-8?B?WGw5dWl4L1lQN1ZQemlQdHg2ZlpoSldKVExWRFQ0K3QzK3cwYkRuOXZ3YkIv?=
 =?utf-8?B?bFNHZndmcTZLOVZLcTlFK3FLckkvSzNzZlBqMHV3UlA0ZmpYL2o4bUpiTFFQ?=
 =?utf-8?B?NzdSM2ZaWHZVa0dBWnRqVFRHcUxGVEFPVTFVOGF4SnpxNTQ5dUNlTzlpekxY?=
 =?utf-8?B?SUlhcWZFWERnY1ZUa3FubXpEaDA4OWp2OFgxNDRETzM0U0tPQ2oreXJJdjFx?=
 =?utf-8?B?dkY5RnBPM3N4RXRIRFlHTTYxTDk5cExKSXJIL2lhL1hRMGROUTUzWk9OODZ2?=
 =?utf-8?B?cWJhTmRVdnNRSTZCQS9iUTBwZ1ozaE5ybXlaT2RiVnlhL05CZ2cwcmNycGJo?=
 =?utf-8?B?OFNFSGdsWFlzbWlPOGxCamRHR3hIMEJPelJacVhsQ0h5N3l5Q2NUakN3bkdi?=
 =?utf-8?B?bERqVm8rTUhXbHZESXNVM1ZudUYwOUNwaHpMNHEyUVdxMWtMTmE4WXVPanIr?=
 =?utf-8?B?ZmsyeVkxSys4aTRxM0hWcEdERWxWOHVibjBXbnZibVVLSnJDdlVvL29aQWxv?=
 =?utf-8?B?SU9vTW5NZjlWemdjVTRFSndSeDJ0OWpxdmdIUmNsOVdCQW14OU1KRlNoSGZo?=
 =?utf-8?B?bWtTalRyN1R1blZJOERsZ1EwRW1RRVJwUWEvVFg2R1R0dndIekcrWW9ySy9m?=
 =?utf-8?B?bEFXL3RkRi9xYjZJQ0tpQ1o0SXBpSERyK09kRmU1dHJCN3VhNUdoYlo5MXlP?=
 =?utf-8?B?WVVMc0E3SEx2aGZxU1hiZy8rdjNqRnpkaVdUV0phYmlDWXM5ZzY5eUo0RFly?=
 =?utf-8?B?M0F2VitkazMyTVh1cTdiT0tGS3QzdlQ0RGZIYTF4R2UrQnhuUnF0TUJuQ1k5?=
 =?utf-8?B?elFVbzUxL21ZN0JKVFIzVnNxRHpMTCtCMFdsUzZzWjhlTjJpYnBqc1FWN1R4?=
 =?utf-8?B?RXFIa3N0R2x0a0NnQUdReU4zTDA3QlRTWElsVW5vVDdlNDJTZVhHa3Z5dXRZ?=
 =?utf-8?B?NnVDQVV2MUNoOGZjYXhtOU1ha01SOStPN25EeHNJUU1IREREWjQvTEI3VkIw?=
 =?utf-8?Q?Mg5Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f0fc05-f4da-4697-8c4c-08db5577b473
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 19:08:01.9771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YJz6Da95JRbU84eFCoFD/2Z5LR0i+bs47HyR/CCf89Un70ApWVqjk6kSHF9LWgdS/A3s0gMTcE9KenW+fk6WGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5108
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

PiBJJ20gbm90IHRhbGtpbmcgYWJvdXQgdGhpcyBvd25lcnNoaXAgLSBJJ20gdGFsa2luZyBhYm91
dCBob3cgbWFueQ0KPiBsb2dpY2FsIGNvcmVzIGdldCB0byBzZWUgdGhlIHNhbWUgZXJyb3IgaW5m
byBiZWNhdXNlIHRoZSBiYW5rIGlzDQo+IHJlcGxpY2F0ZWQgYWNyb3NzIGFsbCBvZiB0aGVtIGlu
ICpoYXJkd2FyZSouDQoNClRoZSBoYXJkd2FyZSBkb2Vzbid0IGVudW1lcmF0ZSB0aGF0IGJhbmtz
IGFyZSBzaGFyZWQsIG9yIHdoaWNoDQpsb2dpY2FsIENQVXMgc2hhcmUgZWFjaCBiYW5rLiBUaGUg
c2hhcmluZyBzY29wZSBjYW4sIGFuZCBoYXMsDQpjaGFuZ2VkIGZyb20gb25lIGdlbmVyYXRpb24g
dG8gYW5vdGhlci4gRS5nLiBCYW5rcyAwIGFuZCAxIHdlcmUNCmNvcmUgc2NvcGVkIGZyb20gTmVo
YWxlbSB1bnRpbCBDYXNjYWRlIExha2UuIEJ1dCBJY2VsYWtlIGFuZA0Kc3Vic2VxdWVudCAoc28g
ZmFyKSBDUFVzIG1hZGUgdGhlbSB0aHJlYWQgc2NvcGVkLg0KDQotVG9ueQ0K
