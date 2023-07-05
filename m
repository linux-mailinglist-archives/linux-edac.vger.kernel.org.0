Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FC27487CB
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jul 2023 17:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGEPWc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jul 2023 11:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjGEPWG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Jul 2023 11:22:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7810E2;
        Wed,  5 Jul 2023 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688570526; x=1720106526;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SkN2UhYjK1BxSpoT4jA1djb02egq2Xkm8ogT93z2fv8=;
  b=Ict85MwA4OfyUgW6SsdFq9hnZLoNAtph1pfhUn1Y4/EZEtkKNX72/P13
   RI5nZ6B3dm0EKNnYWLFoowAyBU61OWYUV0klivIdUZBiGabZ5NZVzoenP
   LVB6njrtujV+5EY65ZAlVkmZgRk7DaxR1z80n4Z79vm5i7Kzu72D1CVQc
   fJdF6XHIKziHxRR3agFlmU14hDVy+GbRoO7V9jVZPssp4ByNWcruZ/HEz
   WRdpsoOi2OikwvMVF0Cxq3AkAX82UVXeUDxQa+hwXgzN9eizE0QFrud2f
   QYPGRhuLooAN8TTHwTQPN6KRvjINmiGECucrQfUWwHlhw3gGuZ/4t5NWr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="360844578"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="360844578"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 08:22:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="789195448"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="789195448"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jul 2023 08:22:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 08:22:04 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 08:22:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 08:22:04 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 08:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV3+F1rTdXBu+u4hdHeFch/dORZ9ZQ84stXf+bu6RdIOebfzKjUivy+uBWQWpHXGl2Lga8ixZgkheaUCQoc5Qxx2UXd1juJKB+zMmJFwiX39DpEe8oUMl7bVyXNz7xNnH6vH1rUELqLEVTABaRdZiKV8WEjYIDn+68M7lAnvKrHKM/0wws4iW37X4dvvf6tOhe2nN++SOHgsSBHcL3AU3bikvS4GghPjQ2mRummKJIjJIokpZ54ELdy58sIMSsfoypkKwEjl5Ehx2Fg3k/GI98Ice4haINhiiMeJhQsgWkakYCFpVcRXoRFWsQDcPGGnV1UO/u6xiK82pgqf7hTdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkN2UhYjK1BxSpoT4jA1djb02egq2Xkm8ogT93z2fv8=;
 b=M2PkoiJ5aJ/d4zH5RC9OTejSrVBaTIfNcs1AIToaIOs3bg5WYLooNW0SFGUjTgFaNaJ4ePgLcQgQP1ZrHNMVCaoYz6k1TDNsPo0yfbs9g24N780/AJ2+FfKEJTajy90wxEN3asmPE52a8VOkb2QqrssotCwTCPm9/lwaD/ru0LSAE+ZuhlICLsJAW6hUMnt+zw+5DhMx1QTS6QXo8p+ab23+ncuhUp+6Yjqpx5PRUWx6NNmA/Tynn7uHascZpedwNjCgMqGA3g/Uc/P99SgJU3eAeXbOY0VOFNlQ2WdW/S2VU18zv980WzAXVKiEoBlj8AMlq0rnv7HvGfAixWTL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 15:22:02 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::f232:e1a0:b936:2aed%7]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 15:22:02 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Koba Ko <koba.ko@canonical.com>
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
Thread-Index: AQHZrc6A28+shQPK+kOOa0lv+6OuYK+ojzaQgABJA4CAAbbtUIAATzWAgABtsrA=
Date:   Wed, 5 Jul 2023 15:22:01 +0000
Message-ID: <SJ1PR11MB60832C7FFEF98EE33F255B9DFC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230703162509.77828-1-koba.ko@canonical.com>
 <4ec2b7d2-11a5-6ab6-087a-175ed31faca4@web.de>
 <SJ1PR11MB60839A0FC6B5E79E3E5A7997FC29A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+UB+eYoYOOVH2bqnnVEJcLrxaj5A7-zyfgBM7hOf4y8zw@mail.gmail.com>
 <SJ1PR11MB608383A5841E4AE8D3A64B79FC2FA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
In-Reply-To: <CAJB-X+VFYyTiQ7yhX=Z8-Q4QW-GMsGXMuEWxLjuoZ1aDB98qXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|PH8PR11MB7120:EE_
x-ms-office365-filtering-correlation-id: 2c5f55b6-e32b-4829-2123-08db7d6b951e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wjlLQRhwbA+Ld29PoWYsEybc2/4HXU1bd4FjSSz7xfI3SB9B3n5GlnRaM8U1+eYvY0yAXrJ+Wk4OOFI6oSwW/fnYRHRh4ml3I7tZF6W04/I/0eK4wQ7pjsbKiHIMdmAWnZQ/NcZEVbTn0cFZejnS6zi/OU2jECUYRJCIhZ1iwrrzT9dWpFvMOf+f5Bkj2GcsiDgTZ54XxqbyEgSWfXzSiQdqfZ5ip0TM//9CPAEpUWbV/AmChFdY2/Z8l6Wh3vEPtsja3tdD/UDpH2AtUZCmqfbu478k5Dla3zzBsM5mi4H+XtMlC1kYR98tvxmkbrI4M39Thw5UMHi7caUk+Ykp7/w45yTJvMFWYwH/6qFGC0VbaIqfr1CT6EStUGjbZkPsq0jnncrFaCjF+CD/LzfUD6LKbX8ocBbTyh4v+oqttu6skcFRAG5WlfgIMDtC+CeJc5wqwnU/TLO2J+iuNlFjRDGf1asnLLpeVRC2czqQrTuL78R8Ua65ho+5VQYL4HPrl4xFFyFxW8B3rM5KXOPHTkHyX0Y7JHk8jsBU9O8uJ7rQCMW6bbMPz1T/CVUNb5V0FDKZ0Y1N1qJopH33X/MZEKsosw8XdFUwt8iVgPsn7bY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(54906003)(478600001)(7696005)(71200400001)(76116006)(186003)(9686003)(6506007)(26005)(966005)(4744005)(2906002)(66946007)(316002)(41300700001)(66476007)(66556008)(6916009)(4326008)(52536014)(8676002)(8936002)(5660300002)(122000001)(82960400001)(38100700002)(66446008)(64756008)(38070700005)(86362001)(33656002)(83380400001)(55016003)(5930299015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0pFbVVKUGdUcjlMSVhwSitkRmhHVUJ4L0E1ak50Wkoxb2NqeHBDVTdXZ3hp?=
 =?utf-8?B?NjdqQ0JLMVdNWVFuRlFQZHV4cXRZQ2MvRitONzEyR2haaHRNWEtINVZyakFX?=
 =?utf-8?B?blpxdlJiYm9RMlA3aDk3d05hNnFNWFd1aGF1ZFZOOElOYVJqMUNHZWNnb3V3?=
 =?utf-8?B?ckI4dU9yYklBUXp2bDZRajh6ZjAzWEUwWTNIMjlObU5tMFdGdWtpaFZZQy9V?=
 =?utf-8?B?TzRFKzFDQXpuYUxXMmJsbnpya21EQzNZWFhWajBUaTZMN2JXSktQSWtJVStu?=
 =?utf-8?B?OVk5OVk0eTlpYms3NXBGZUtmL05yb0o4WENTWktqejlsUE1jR0ZvWU50c0U2?=
 =?utf-8?B?dkJrV2FMZkx4blFnbjFrYXh1cDlkbEw1SlRzSVJoMW4vaFZjRExmYjNXVEVD?=
 =?utf-8?B?cktFSzZ2YzdaQWZUYUhoUVdOSTV3WlJNSjEvYmRwN3U2NmhxdzFGdGNEMHlV?=
 =?utf-8?B?a3V2RXVVYzcyRDZaalpuSlZwNHgvUUNCMjNreGJlVGc5M1l3bnBTcTFnSEUv?=
 =?utf-8?B?d24yTUdXMDlVRnNvU0hKWDNUa3gzZkFwUmF6MkVSMmx6UDZ1WFNWeXlDS3lW?=
 =?utf-8?B?WndtSVhMNHdKLzZVTWlBaTlCbkhERUZxdXBmc1RBOU81d0V4a09DVnhXRm9l?=
 =?utf-8?B?dGRxMDNKaGlWYUVIUEhHREJVeWV2bnN0L3ZjOXdLMHR2TngrUTVrU1FraGRu?=
 =?utf-8?B?OGJRMGlhZDBOT2dzbEwvRGJYQm81NUxFWDM3OE9ndE9EcExmeHFMejlndWpC?=
 =?utf-8?B?WXhNTGtIUkRnOTU2R1NaSGUzZm5nNUpwb1dFTjFvQzdERFl5U0VSb3RGNWN2?=
 =?utf-8?B?dnl1aHZwNUd1d0JsVUNEWXBFcnFpcytQMGZLM1JtUmRnREc3YUpWSVJtL3Iy?=
 =?utf-8?B?Q0tFRU9OTkZoZGdLeHBGWEFhbTU0eEdLWDhpREQ4WVhiZXVTclJKMG5ITHQv?=
 =?utf-8?B?Zm5SU0dBVTQybm5VSWtES0VXay9UNExreHJPMG9UUXFISllWNGlibWk4YUVn?=
 =?utf-8?B?ak9UZjhDa2I4RXRNTjVScTMvSzlpV0xqbkJUYUFFOVdETCtFNXpxMndhUWtW?=
 =?utf-8?B?MnpmZWp0SXpUNnpEUnFmSlhuZUpqL05IaUN4SDdDb3NHa1Q1c0M0cjkzMkZ3?=
 =?utf-8?B?V1Z5WUhvMklhWStVNmxua0NZdW02d2lwYnpwRkNPbnJuUjVoK2grSW9WTlZE?=
 =?utf-8?B?aGNEQldQOU1LOE1YMHd3a2RscXRlalo1bXU2eG8rSGQyd3ZOb2VDOHNWUFJl?=
 =?utf-8?B?TzQybjZZUXJ4NHJFWHVUcndpMTVCTUF5S3ZEbmsxMzFCdzIyd2puRUU3OFFY?=
 =?utf-8?B?MzNiRmw0ajNBeTNPOWFBanFseU5SdzJLeFYwUjB6UWN0bG9WY3lmMWxxT1JG?=
 =?utf-8?B?b1doSk9LbktFT1AveVpQM2tKeXM3dHhjQ2ZHWkt3WlBxMTJZZmNqRTU0UEtt?=
 =?utf-8?B?dndwV1c2c3dGOUpEbUxNMmlTMlNCN3l1TUIvMDFzRloyZVpCM0pXK0psV2RZ?=
 =?utf-8?B?S20vMWNGV0V5clZHMW1EeHBESzBLcEkyaVk4bGpBem9wdzlkY1R1SVFvdGp1?=
 =?utf-8?B?OUIwU1hWNTlOTW5MTHd1TzgrVXpJeHMwUWxSWHB6Mmk4RGxESHl1czZGb3lF?=
 =?utf-8?B?by9YYU81TGJnaDg5c3BRUWxFbFFwY1d6YmZoTWs0NXRicmkwUEFYWFhLZ1Zw?=
 =?utf-8?B?eDhtOEZRUmxoWUZyRXRjcGUrZVBVVVFXR2JSSzM0ZHphcVVMQmwvblFmM085?=
 =?utf-8?B?WHIzSDVGcmZWdFZCZDZXQVJ2cDJEZ1JiRE4zWXhQbWkxMVNUZ0xSalM2ckR0?=
 =?utf-8?B?bVRJWHlMRnVVOU1kRWRjSDVnSUJLand6UWZRVStON1hjdWRGVlRiSlg2MHdi?=
 =?utf-8?B?SU45c09vS3BKSzFHYTZrck9lbUh5cWF3eitCSkliUGttVWxnYlprQkt4QzhW?=
 =?utf-8?B?elFza2tjdnI4aGRkL1BmeEt6dEZOaGNFdS94VHFKSXkxS3ZPb0M3U0J2amh0?=
 =?utf-8?B?ZWVGQ082eHpxQ1N5dlhtTWRORFlQRDllMkNuK1N3RlBEb1J1Y2tpbEVLeHdS?=
 =?utf-8?B?dzVjT0hNbkFFWi8rdmRVWDlEUDdhS0JsOGk4RFcrcHVWbWVoUGQzSVJjK3Rz?=
 =?utf-8?Q?gGww=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c5f55b6-e32b-4829-2123-08db7d6b951e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 15:22:01.9475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0jNtYtOf9KdKyK6xwgsHhSdwK+KCglUyJ23qEWnlkufznXiiTfYSyoowVKkUrWYMX99ExxLsipmRCLAjx9nWlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
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

Pj4gIyBoZWFkIC9wcm9jL2NwdWluZm8NCg0KVGhpcyBzaG93cyB5b3VyIHN5c3RlbSBpcyB0aGUg
d29ya3N0YXRpb24gdmVyc2lvbiBvZiBTYXBwaGlyZSByYXBpZHMuIEkgZG9uJ3QNCnRoaW5rIHdl
IGRpZCBhbnkgdmFsaWRhdGlvbiBvZiB0aGUgRURBQyBkcml2ZXIgYWdhaW5zdCB0aGlzIG1vZGVs
Lg0KDQo+ICMgZG1pZGVjb2RlIC10IDE3DQoNCllvdSBoYXZlIGp1c3Qgb25lIDE2R0IgRElNTSwg
YW5kIEVEQUMgZm91bmQgdGhhdC4gU28gZGVzcGl0ZSB0aGUgbWVzc3kgd2FybmluZ3MsDQpFREFD
IHNob3VsZCBiZSB3b3JraW5nIGZvciB5b3UuDQoNCj4gIyBsc3BjaQ0KDQpJIGRpZG4ndCBkaWcg
aW50byB0aGlzLiBRaXV4dSAtIGNhbiB5b3UgY29tcGFyZSB0aGlzIGFnYWluc3QgYSBzZXJ2ZXIg
U2FwcGhpcmUgcmFwaWRzPw0KTWF5YmUgaXQgaGFzIHNvbWUgY2x1ZXMgc28gdGhlIEVEQUMgZHJp
dmVyIHdpbGwga25vdyBub3QgdG8gbG9vayBmb3Igbm9uLWV4aXN0ZW50DQptZW1vcnkgY29udHJv
bGxlcnMuDQoNCj4gcGxlYXNlIGNoZWNrIHRocm91Z2ggdGhpcyB1cmwsDQo+IGh0dHBzOi8vZHJp
dmUuZ29vZ2xlLmNvbS9kcml2ZS9mb2xkZXJzLzE5OWszQlg2SWlwTllDRGZ1TUd5OFcyNlp0WVJE
SVlacj91c3A9c2hhcmluZw0KDQpUaGFua3MgZm9yIGFsbCB0aGUgZGV0YWlscy4NCg0KLVRvbnkN
Cg0K
