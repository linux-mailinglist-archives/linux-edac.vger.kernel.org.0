Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB17543CA2
	for <lists+linux-edac@lfdr.de>; Wed,  8 Jun 2022 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiFHTP5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Jun 2022 15:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbiFHTP4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 8 Jun 2022 15:15:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B1947571;
        Wed,  8 Jun 2022 12:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzju0ru2CvK7fnvmLq6PSKGz7mXrN67jvQHI9p58Oiqmc+FsaVxs5/4hLNRPsNcQllxnEJHSEqRiaBt69vcm/MYrDlaLXDcD47ef9X4PwtJphmCabyl6aTUiCF6D7B2cdf+R1Znk+V609Rn0MV8RpC0sErxSA+vZCIMGbZ8arxzHW0CwORsudG1U5jT9i0388afC9ZqyxDIuPb6VqoVo1IUuPbzAmI8eT5rqSM9rb48JTmVIgtpHF31pVn+PUtoLBqeAH1wwAYvgGzGfJInq0LB/JBoBXaHCcH2BQM+KM+7QPxhAXChWXuaCodJRkXwrgiLSwKZF2ZFJQatsCbB0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onBnUwo5yPgkPzhRl/XvoWhl2QHf2b7lEXmggugCF18=;
 b=QNi0Zqu+WxRHhlYFVO51rfQtgDPiU2fsDHCqXIpqnEZp9hLqWcWfc3MDzofARqva/JBHcWeq91c5FHnHeJL1abJrXBADwPiZJpf7LvLjJXA8PCkqE+DaHZP8C6yTrjpRs1jdhEC/pS1F+PqbBQ+CkR4f629q04bi8qHW4phBJEt463qepbguozbhbBiHzG4WMHlkJ7OI7dJ16YFGWZ83yi3ryXXvYDJVpGpLyhnwhV1AYdw3anbALMd3h2O2tLrJY62cDyMRRv35bTavuuG7SLON74EUGVnjP5AEYDNq2HfdOwi/306+SFaz8Q3klLT88sGAdCbIJzwuOHHK9O02LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onBnUwo5yPgkPzhRl/XvoWhl2QHf2b7lEXmggugCF18=;
 b=nkr69EObJDnHgl4cCIc+PBx9Mz2nCozC0NxttTPJ71t9up0EOs263ig80V94D8n7nGa84pW08KRVi+OjHYtTOhpSbl0kSYLZbNelWtXlFtEyaJ9HJNWgre131ZkqQAALj1ifS9+BeI1DAJF3Pn1B5dguXfq7ZiNGAjAeYlLz5GM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by MN2PR12MB3181.namprd12.prod.outlook.com (2603:10b6:208:ae::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15; Wed, 8 Jun
 2022 19:15:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928%2]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 19:15:50 +0000
Date:   Wed, 8 Jun 2022 19:15:46 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
Message-ID: <YqD1YjeovGu28xsP@yaz-fattaah>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com>
 <YpUcf19E+qgb6Eyu@kroah.com>
 <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com>
 <Ypjr5yIMan1N0bqH@yaz-fattaah>
 <alpine.LRH.2.02.2206031327190.25179@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2206031327190.25179@file01.intranet.prod.int.rdu2.redhat.com>
X-ClientProxiedBy: BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::9) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a990ee3d-0512-424e-aafd-08da49834c82
X-MS-TrafficTypeDiagnostic: MN2PR12MB3181:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3181999CA91EDA4EBA1957D1F8A49@MN2PR12MB3181.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74uha6O1pK+uGTTG8u3Fvem5IPYH6qoHhQ2LdCSXE5XkETGhLYjT2tZ+99RewRqSHiUmIRVioOO9Ol6jk1eyEqt+I4wQ1Vyy+Ko9CBqFgxmpBO9OAnAPhqYxeSaoxwfitcOyLY1U+M2u4yGBPv5UWn48wtjalu8GDpTLk2UqoNEnN6hIjZUxMcRQui2Bsv5MAz25g4MhYkwNcIxMuZjwjsNv0+z/eOS84MgYEtHtUszXz2nMFHGDJf9vHmwyIykrBMyRamKVrewSe5mBXkpSCR+g5Gq1/JejUgdgjEV8wlVtw6UZxiN1jCvY7qlU9qszsCFO3EQoyQAOCIuhyT38AxXMrQLhZnJyTbXkGKt12ZQqAD9n0PltZ4mrjihRfLHqqoJLBV2mRhj6JvCin+VwvI91ur1920WGXduKR3BgISflm2YPkjixs0cpnqc9hjkR+C3nXw36zMUPgPWUNofwF29MX62Gfd/w+JhNLhXxX6tGlhJfgTfbwlfxklpOs3s+ruIqqEyEoq6vyKhDkie9BICBOYDuvhEdkNjeerYRqCaWFwlz7kAwkjHLRVxNNvGIie5U0Ba7nCWaMYFUVb3+wIPsZ/yc3YHkfkgjs1btbHL79uXgVP1o56XfbVdRoqVuk7MG7a7GK9CXE0ATF7sQ2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(66556008)(2906002)(66946007)(6666004)(6916009)(54906003)(26005)(15650500001)(38100700002)(316002)(6506007)(9686003)(8676002)(66476007)(5660300002)(53546011)(6486002)(4326008)(186003)(86362001)(83380400001)(508600001)(44832011)(8936002)(33716001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1MyVgYi0wcJaohB6XVD7OLArF3rjFUwHx9XHGAINadvTB40t8UCfW9A8PGfq?=
 =?us-ascii?Q?r1hUrnAmyDiYfmcGDfvKFHf3BH32lhKUFl9IuQUjAJzKvKlfQD+GzyhiZnj2?=
 =?us-ascii?Q?Da9kGvWwPsE+QkE95FhBQ3AIXWZGESxnkoM1Rv/7qBTlqw4bKE6+A5FHarFF?=
 =?us-ascii?Q?KF3CCRe5upn3I1q+Z+ZxG0vl36JW5pM+Mflj5ZT3tZ1NE1zsAd1CfBgqWnUL?=
 =?us-ascii?Q?Cjn4Q+FG/A6ISh1y7JvLaxZdKuyC35lHGnubyqHc+p5AcitKnH3F+CyB+Sfw?=
 =?us-ascii?Q?ly6sBH5nJ7UDzoSEmhY+GPBSaVhRz9R22qkgdm2MNzyMc9lFgGqsDy6wPdrU?=
 =?us-ascii?Q?pFIKrpUSJlciCQ4p1JZ68QF078fVdTkhgQDi24SdvY29w0sYKT2sHjsKhYfj?=
 =?us-ascii?Q?oO2H4gOcGMa6u2j5/IcwMR2Gs8vxviWZ/BHm4hcnvhZSmV18BsvKd1q8z1Eq?=
 =?us-ascii?Q?YjYFJMl5wmUUy5Bqij4y98oLtRJtegv56rsPlC8BMwg55nnS3LkQvCEK2pvV?=
 =?us-ascii?Q?AXg8SkLPZkTFCAzdaf6ZT7ydJwFPkGJM/KSSIMPNs2Z0Vh5EfSE1xmKEiBhE?=
 =?us-ascii?Q?dKoisNd01qD1npVoBTVdoEwlhKqyD5F1YbY7Y4BWoKSP9h2t+R0yoXZt2C0V?=
 =?us-ascii?Q?rezn2I1YyiuDnFWN34hucC1ezbyBffHiXzXFxpTHJqPAl/Z5RwQrTKAqtzpa?=
 =?us-ascii?Q?oICL/ENBJHcaNoOHuPNkEiG49Havxfd2Q5INokcJ30Zi2EgRVy9aGy/XjD2K?=
 =?us-ascii?Q?C1JiIHDhg6KmQlXJg/RYG38v+o0usf6gRC7Rh3xJDfZCp7M0M9vAIXGB8OFO?=
 =?us-ascii?Q?OC2g5Ae8F84hzlZ3BBF4rtuMCGcVoFOwB/jPj+0wEru+csWQsZthjptxVy9J?=
 =?us-ascii?Q?UW5gNIW0+dbIQVp0AN1xtIRQMP9PcK/indeiTzhdzqJEpBV5ySAeGJ8cSn4r?=
 =?us-ascii?Q?N8S7Y8G4ETpmr596FBX0X7134Sxvb7E1M94qZQj/vL1E4jLE9BFXH6R+2AWF?=
 =?us-ascii?Q?xtQyeYOn/uHXS/Kw+2mxdDKDgN9xN6+dxrXtIJs61kDwqkWz+wDdjAZ549Ze?=
 =?us-ascii?Q?fGu8DK1zYfs/l8T/B4HKIKHoPLh8Zp0uGL/uJF/eRvBNgkVcBVV10g/bIPJy?=
 =?us-ascii?Q?863YzIO/QxE7wzgTf+o3xWzf0Gxuanf2i8FLK7wwEEwRb05SEf8GcVyV+A5a?=
 =?us-ascii?Q?0E1tvhCRLDMovP6A3l8WrvZpJc7w4T3QmsmwKBnGtUcZd4gFyhk9GwMHFxih?=
 =?us-ascii?Q?3QiBUPGucRvSpQA7GK9Cc6iB/sDgT/76RpOYf+kOjW8+bi90I7Pvkpm4T35A?=
 =?us-ascii?Q?8ar/Zym+OHj/SPNld2KAETqJ5l+/ABohHOgIEyUKSw912OHxGmtcEmMQDKOd?=
 =?us-ascii?Q?TaJd7biRq5aV8pr6CYan1GlDrA8MwyZa0WV2DQpDOZGJzYO05xJbgazakXM7?=
 =?us-ascii?Q?KlJg3ssA5xwlGsiTZKYRCo/eMn/0YRMQjQtMkFOyxyzSgTP3ShF0Befpnr21?=
 =?us-ascii?Q?CCTkJpyLARQMAgAU/f4Yd/8x8F20XaeGnBPOhTZVApYTGANqvX4MI6/Pn1ig?=
 =?us-ascii?Q?Tlf+gXSU2JPzPJzDMIZAKrn6lvjiEbaj4Zr1HSsJHflQaHgyLNOoKHVtWjP4?=
 =?us-ascii?Q?Z9J3KKFn8wsYvpJ40UoHE4sAdvjkCpB0S/c6sB06u61nypZofTAE0bAp4c3V?=
 =?us-ascii?Q?yRP+WjYYlAP361h6leGyVqhJ1imoNlt5FPEO2bSjNkOxn68Q+e1U0kf4jEp/?=
 =?us-ascii?Q?JgcorgCycA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a990ee3d-0512-424e-aafd-08da49834c82
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 19:15:50.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GIyN4XQlWpWoniM7lkb+3XrMMmKwxH4pGBNMa8Ca3PIZHcuPX3qQi1ugmljIKtwRyLsKn9Kp7uF/sVMVz9cNTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 03, 2022 at 01:34:26PM -0400, Mikulas Patocka wrote:

...

> I tried this patch and it doesn't help.

Thanks Mikulas for testing.

I'm still not able to reproduce the exact issue. But I was able to reproduce
the same symptom by hacking the kernel and doing CPU hotplug.

Can you please try the following patch? This seems to work in my hacked case.
I also tried to write out a detailed description of the issue to the best of
my knowledge.

Thanks,
Yazen

========================

From d1fa5cdc7f29bf810215f0a83f16bc7435e55240 Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 6 Jun 2022 19:45:56 +0000
Subject: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when removing
 threshold blocks

AMD systems from Family 10h to 16h share MCA bank 4 across multiple CPUs.
Therefore, the threshold_bank structure for bank 4, and its threshold_block
structures, will be initialized once at boot time. And the kobject for the
shared bank will be added to each of the CPUs that share it. Furthermore,
the threshold_blocks for the shared bank will be added again to the bank's
kobject. These additions will increase the refcount for the bank's kobject.

For example, a shared bank with two blocks and shared across two CPUs will
be set up like this:

CPU0 init
  bank create and add; bank refcount = 1; threshold_create_bank()
    block 0 init and add; bank refcount = 2; allocate_threshold_blocks()
    block 1 init and add; bank refcount = 3; allocate_threshold_blocks()
CPU1 init
  bank add; bank refcount = 3; threshold_create_bank()
    block 0 add; bank refcount = 4; __threshold_add_blocks()
    block 1 add; bank refcount = 5; __threshold_add_blocks()

Currently in threshold_remove_bank(), if the bank is shared then
__threshold_remove_blocks() is called. Here the shared bank's kobject and
the bank's blocks' kobjects are deleted. This is done on the first call
even while the structures are still shared. Subsequent calls from other
CPUs that share the structures will attempt to delete the kobjects.

During kobject_del(), kobject->sd is removed. If the kobject is not part of
a kset with default_groups, then subsequent kobject_del() calls seem safe
even with kobject->sd == NULL.

Originally, the AMD MCA thresholding structures did not use default_groups.
And so the above behavior was not apparent.

However, a recent change implemented default_groups for the thresholding
structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
code path. In this case, the first kobject_del() may succeed and remove
kobject->sd. But subsequent kobject_del() calls will give a WARNing in
kernfs_remove_by_name_ns() since kobject->sd == NULL.

Use kobject_put() on the shared bank's kobject when "removing" blocks. This
decrements the bank's refcount while keeping kobjects enabled until the
bank is no longer shared. At that point, kobject_put() will be called on
the blocks which drives their refcount to 0 and deletes them and also
decrementing the bank's refcount. And finally kobject_put() will be called
on the bank driving its refcount to 0 and deleting it.

With this patch and the example above:

CPU1 shutdown
  bank is shared; bank refcount = 5; threshold_remove_bank()
    block 0 put parent bank; bank refcount = 4; __threshold_remove_blocks()
    block 1 put parent bank; bank refcount = 3; __threshold_remove_blocks()
CPU0 shutdown
  bank is no longer shared; bank refcount = 3; threshold_remove_bank()
    block 0 put block; bank refcount = 2; deallocate_threshold_blocks()
    block 1 put block; bank refcount = 1; deallocate_threshold_blocks()
  put bank; bank refcount = 0; threshold_remove_bank()

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2b7ee4a6c6ba..680b75d23a03 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1260,10 +1260,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
+	kobject_put(b->kobj);
 
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
-		kobject_del(&pos->kobj);
+		kobject_put(b->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
-- 
2.25.1

