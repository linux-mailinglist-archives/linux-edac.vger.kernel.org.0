Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55F7D6165
	for <lists+linux-edac@lfdr.de>; Wed, 25 Oct 2023 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjJYGBC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 25 Oct 2023 02:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYGBB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 25 Oct 2023 02:01:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB7CAC
        for <linux-edac@vger.kernel.org>; Tue, 24 Oct 2023 23:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698213659; x=1729749659;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OSbF0j6gASSdU362FGL+tM1WzoW/D08CexJK5BUf8oY=;
  b=a3A/rT+hMUyOcyc+2oX3Ehmr76/u5GWllAyQQHkjD4Rwow8f9tdymAMH
   JqtPq9MhOLzNt6RDGmoRs17JQuKeBGN1DEvngxN75JIJSQZAaOQYK7RFr
   niW+DtfczBYjAZa0ezWClfIGecBdQFDGxZQgFaEJbR8dXP6Z6G5N9lk4n
   4/qALfOEhzyupyLmjSePR2gNHlwNVPf51qS1TB9jQBt8kGaoHc6dcjy0P
   vNNyuLARHrFV5VIlshmmAjkI4BtUeIu9ivmvAMmBAJHqthXtj+PfhPJAv
   AvEY+5nBaaSTdfijYxNz7d/quDoRieg9qEh1TABhbxqn2sxlWvnFh4RL3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5858205"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="5858205"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 23:00:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875374339"
X-IronPort-AV: E=Sophos;i="6.03,249,1694761200"; 
   d="scan'208";a="875374339"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 23:00:58 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 23:00:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 23:00:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 23:00:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ll4XBAA0l5eOG8r4xupub9uxj6cCprQyEoi+biceFyluazZ7Lz++XKTiDV+6nk01xZN5quulTcZdQw4tP48TrswsTiBT00QjGIzeVfxdDdLBT+R1Q23RP4MoqJAlpYzSYtPYp8LSsvO7mRKzy0K6NH1qt3BUUMB/jCFBTl5xWl6/6rhVlAfECJvErLUpmW9g2b67K1mTeddur/NRzwzVagW4IsrZ4sGaPSER8sF9cORjqbhxnuqZDT/kOjnjOyXwkx8UcHjC2XvcM3UNGdiK8tVPozus/i+ij4J0rizonEtPkNs8bBximiifCneNcyFZflPNq4I2ZofTOFi92L6msA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/obQB9UB1dQDlCHTvgZbXvaa/VPBsiPEtCdGUewKgM=;
 b=IEQAHjrORwF9QOwNk5YbV799bDIXgfIzNlq/SwIPlDEjMewcPmxWCz55ZFOTiKVyD2hQDVpFsHKDntpmHDrYdv4hPKsM61BPVVNG0AC7B9HYjtE1PzHGgXQsYrKZv5bNv+pd7kLDNmwJ0nAUg+HOUn+eVax+MfE7Cm0N8uopTTEnHo8ZYosLONtaToKrHcf+mRtlrQVKBOWNK715DROZNL02pju6arUKwgeNITsi6XE3QwAgEoYYUDA2Lfl1tI5/epbaHKJOSJFFQJ/+wgs9ncstGui6oCXwz2KXPVXJ7HD6D8bsjA/kWmzWdyxl69Y0c+sQYGE3JAXSVfv8vLMXUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN8PR11MB3715.namprd11.prod.outlook.com (2603:10b6:408:85::13)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 06:00:51 +0000
Received: from BN8PR11MB3715.namprd11.prod.outlook.com
 ([fe80::58f8:ffac:efb6:3d9d]) by BN8PR11MB3715.namprd11.prod.outlook.com
 ([fe80::58f8:ffac:efb6:3d9d%4]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 06:00:51 +0000
Message-ID: <fe7d6f43-2a10-4c73-be5b-d0702d0d89c8@intel.com>
Date:   Wed, 25 Oct 2023 14:19:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] x86/mce: Mark fatal MCE's page as poison to avoid
 panic in the kdump kernel
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <linux-edac@vger.kernel.org>
References: <12eb6db6-bc24-4e7c-af34-a5c68d49d52a@moroto.mountain>
Content-Language: en-US
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <12eb6db6-bc24-4e7c-af34-a5c68d49d52a@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To DM5SPR01MB013.namprd11.prod.outlook.com
 (2603:10b6:4:ab::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR11MB3715:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6b5513-0708-464c-eab5-08dbd51fbd97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTNVf9SsO5TxNqy/xiPlaKiMz1/J7qmOOEV7882JKOouWkr1g8fWW3o9nkr/qJl6E7nlsrZqEzv7r6957Qgw2aGElOVrWHRM8PdOTPJXp3kKsbj2wLGUiLmBStkiJmw806e0VUF24EmXXy+LSTZklBKlvlUhJAVPH0qTXwWQ6+SUpEAm52NYPt86XRTiURknHYSJEAS+a/GgRQJcJhkvuHCYT8sgiyNBT3YfQQP1MLnamqnOeizriErQ5Aeiyah6NVjYOg6jEFthzU1EW/PAq9ehauFaPk1lfU+9YI9E4dDHz2p3ZtoKJuPkL+UhWmO3eBXB0JpjMpvAYurJ1pzPmteBfKc/yvPJVbsmhzeV9APXHEF4ndwkPCGVtVwN2pGOiuFdFIGIlcPtxIiNRuGSvvrQgM3tEl/9pC5d45xVyMfm9Rck4eH4D19k1hCrAIwZ8ApkwYwJeq3lQ0giwpuaz3kqs4D2BdvNo+k/X2RZG5Fp3f/B/9wcBxdofxsxzRY7HDBf5y4PklKo/okX1/C3sp40iu8ncpVVV6pPBBO8xD0qLGywVf079dLFQ+860nqDs2G5cc5BgLULMzx2lAAqByczj4+dPAn64CHHh5x7P06YFEszTCupwS+s9VhVvl7TQNVfx8gaqD6GiBipHkgP2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3715.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(31686004)(36756003)(38100700002)(2906002)(41300700001)(31696002)(5660300002)(86362001)(316002)(8936002)(8676002)(4326008)(478600001)(6506007)(66476007)(82960400001)(66946007)(6916009)(66556008)(2616005)(83380400001)(53546011)(6486002)(6512007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU0vcWlzOStUVk9pNElPQ21jbEVMU2w3Y2dWRGp2MWNiN0RITytwWUR1elFS?=
 =?utf-8?B?YVZQQi94Z3FKRkIxQ25ta0swUGcrRUpsVmhQS2QwSGtUVHZsT2NKd051alE2?=
 =?utf-8?B?S0RvZ0Z6RXNNdTM3UFRyWWJNbGM0SXEwK3MvSGk1RVlTeFl3aGNpYjY5SkQ0?=
 =?utf-8?B?YWE0VHhsWlIyanBiNWxZU25kTVV3c0F6VDJmWGFnTzRHektNUkNiREJFNDdE?=
 =?utf-8?B?N0xaV1lzK0JhWW10MTAzZVY2dWxteHlGU3Y5ajdsYjBsQUgzQ1NIeHIxVVNy?=
 =?utf-8?B?VWNzdnE5SWRpTjFSQVhYV200S0Jjb1krRlkwTlJySWVlVkRrdnQ1bVkxM2c1?=
 =?utf-8?B?Rkd2Q3R5R0cyblJvdjRrU3RHQ1JFc1VkOUl0RzFEM3AweWM5bU9CcGM3QnhQ?=
 =?utf-8?B?bk1jUkxtU29JQTljcklEbGdEbk9aU0RIcC9Sb1VFUmZ3UU1vK0h5R2FOQlAz?=
 =?utf-8?B?VGtSdTZpclpwKzgxWjV1dk45TW1YVnZrUEJIRklueXoydCtWalNZM2FrQ0JG?=
 =?utf-8?B?R21nLzRDSVU2ejBFVWNtZTN6d2ZVK3B2NEd6RkZuUDk0ZjdoRDZ6djkrd2JH?=
 =?utf-8?B?WElxSGEzMjNpWGU5Tm53bEF4RVlHL1BCWU1NV3NjZy9CbHNIeWVicWcvc2JD?=
 =?utf-8?B?d2ZaMHpaMm9HQkFwRWV0VGh1RU9SWFlyWmhva1NBb2dKV0NtL2F4MTdRTkJt?=
 =?utf-8?B?UEwvS3hpa0dHd2ZqVWJ4STJBbHF5ZXpWY3UxeTgwR3BMZlRWakRoVWNoL2ps?=
 =?utf-8?B?WlNBOVNQTzNFOWZuRWo3VHJlWFZWdTIrdEZRbytIdzRvSkJ4Smt2VVFFTXlv?=
 =?utf-8?B?dUpWNms3Wmd6eVBpQ1IweVEvMXFwRGZGL00vR2Q0V29ENkF3ZmJlNkRjSUds?=
 =?utf-8?B?eThINElFQkZ6SU1KTGhXblpXWHpxQWRaQUw5bzJqWU9Id05GbEIyemxWbkN1?=
 =?utf-8?B?TTZMc25tbitJNzF6TWF0b1dWMDcyRm5zYVozSStOeDlQZmFZT01MeXRiT2cx?=
 =?utf-8?B?cnBMalpHQ1hySjFxR3BDbnA3a2lJUUI4aGlrRU5ET0hQc2c1NEZDVFgyOVdK?=
 =?utf-8?B?cXBiV3poR3F0MndiLzF5cVRaUno5Zk9CYkREYk5MSURhcGtxeGpxMVgvTGhZ?=
 =?utf-8?B?c1dwTVZnNEhoSU1EV3huL0lOZkdQMXQwVHhrUjZKL2VNYXJFZmozM0t6U1NX?=
 =?utf-8?B?L2NNQXl2dVZnbFZvT2gweWM1bzJZaHFUVmR0TFFvNU1jQVE1R2krVHdJTGcr?=
 =?utf-8?B?QjNydDh3UEtXenpCWk9yZFlpK3VGWjdkRngySzFWbHVZR2MyZEFGa3VUWW5s?=
 =?utf-8?B?cTVOY3Zlb3djemRFYjNvVFY3emtNMjd6SGZtQ3V1VUg4MUpCeXhOa0s1aFp3?=
 =?utf-8?B?dzVsWW9GcUFnd2NES3k2cWQwTHFGNHhaOWw2UXNMME5FRitvSS83b1FNWTRa?=
 =?utf-8?B?UEVMSWxhbUk4VDdsanVZRm5hTVpINVIrUENFTGdZejV6a1dYMFNMU2JKYS9U?=
 =?utf-8?B?RlpKdkFmTnJNLy84dEd6NUhWRms1dFNpd2JXdXhoZXpuMXR1cFl0SXlKUko5?=
 =?utf-8?B?OCt3T0c4MHl5eE9PU0F2TVdCamc3YlhaOGNDQUVZZVo2KzZpVE1BNEVOSWM3?=
 =?utf-8?B?S1daSVdWQ2l2Z0MweUxJMGkwY0ozTGtvMUZiYTcxbnB5MytRQWpsd1ZUSUNa?=
 =?utf-8?B?a3BrL1p4byt3OEJOQ3FHTzFlZXh4V3JBR3pDN3pvakhocDdHZElEeFMwNFNK?=
 =?utf-8?B?YUVUejJLNUZZdUM1NkhjdzJWNWd3SWdUclRMOFBwdjEvS21xNURmbE80N1k1?=
 =?utf-8?B?eU54ZUdQb2loKzdBVFA0SS9EL2h3NGVOWE5UVTNFMG9qS0NRdUp1cEtpdzZQ?=
 =?utf-8?B?K29CcTZQamQwblZ4TVh1Vms5cC9weVduK1FySWV6SHFpdmd0L0VjTy9KbEtS?=
 =?utf-8?B?SFJQSnlXZDdBOW5VRzFoV0lGN2lCbWFBazIwY1dZQ1B1QVhhYlc4ZTRQSnZL?=
 =?utf-8?B?eThNdHJrd1Vwb0l6b1YzbmJic201TjhWNmh1cUNmYnpJRmVpQWMwVXpIOFZ2?=
 =?utf-8?B?WXZ6Qm9LUnFpZCtyNVJPSEJGS1U0NUtFT0NCR240UjNISFVQdUxtN1lGNUg0?=
 =?utf-8?Q?kMGqw/f5oiw7oPR2V0P9fGB3U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b5513-0708-464c-eab5-08dbd51fbd97
X-MS-Exchange-CrossTenant-AuthSource: DM5SPR01MB013.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 06:00:51.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7rpgHbkj8qFO3pgbFzcsRymPviKP5CjbvxQrFbH3oLrK0ea6s5TF5HGLmPxaGu/hnwG+eC59Eyu9ksKHZcxC0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/10/25 13:44, Dan Carpenter wrote:
> Hello Zhiquan Li,
> 
> The patch 1d11b153d23b: "x86/mce: Mark fatal MCE's page as poison to
> avoid panic in the kdump kernel" from Oct 23, 2023 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	arch/x86/kernel/cpu/mce/core.c:299 mce_panic()
> 	error: we previously assumed 'final' could be null (see line 281)
> 
> arch/x86/kernel/cpu/mce/core.c
>     270         /* Now print uncorrected but with the final one last */
>     271         llist_for_each_entry(l, pending, llnode) {
>     272                 struct mce *m = &l->mce;
>     273                 if (!(m->status & MCI_STATUS_UC))
>     274                         continue;
>     275                 if (!final || mce_cmp(m, final)) {
>     276                         print_mce(m);
>     277                         if (!apei_err)
>     278                                 apei_err = apei_write_mce(m);
>     279                 }
>     280         }
>     281         if (final) {
>                     ^^^^^
> This assumes final can be NULL
> 
>     282                 print_mce(final);
>     283                 if (!apei_err)
>     284                         apei_err = apei_write_mce(final);
>     285         }
>     286         if (exp)
>     287                 pr_emerg(HW_ERR "Machine check: %s\n", exp);
>     288         if (!fake_panic) {
>     289                 if (panic_timeout == 0)
>     290                         panic_timeout = mca_cfg.panic_timeout;
>     291 
>     292                 /*
>     293                  * Kdump skips the poisoned page in order to avoid
>     294                  * touching the error bits again. Poison the page even
>     295                  * if the error is fatal and the machine is about to
>     296                  * panic.
>     297                  */
>     298                 if (kexec_crash_loaded()) {
> --> 299                         p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
>                                                        ^^^^^^^^^^^
> Unchecked dereference
> 
>     300                         if (final && (final->status & MCI_STATUS_ADDRV) && p)
>                                     ^^^^^
> Checked too late
> 
>     301                                 SetPageHWPoison(p);

Nice catch!

This part should be changed like these:

+                       if (final && (final->status & MCI_STATUS_ADDRV))
+                               p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+                               if (p)
+                                       SetPageHWPoison(p);

The assignment can not be put into the "if" condition, checkpatch.pl script
will complain it. So it have to take a separate line.

I'll re-validate the patch and send V5 soon.
Thanks a lot, Dan.

Best Regards,
Zhiquan

>     302                 }
>     303                 panic(msg);
>     304         } else
>     305                 pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
>     306 
>     307 out:
>     308         instrumentation_end();
>     309 }
> 
> regards,
> dan carpenter
