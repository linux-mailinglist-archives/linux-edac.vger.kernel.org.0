Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8D53BCEC
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jun 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbiFBQ5O (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Jun 2022 12:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiFBQ5N (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Jun 2022 12:57:13 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA962D0;
        Thu,  2 Jun 2022 09:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPePeozW/MG5r3rCdfMbA7bQdunILmnLilKYQb+r+k3yedJatEiUl7sE3TQJbqqWz2vn1lH8FK7Px+COAQ1xVuZB1YLyV8SfpLXDXP+iN9/3ZOmXj4ioNgZv9UFjI/c47xMRbyAYrx5jCdPL0aUTjXitUm2NvafnSVeANHxn3qmmre8rgCjteYnU1SRHLBXiRUda5M32UBoClig/NEJHJyHR2kZZqXUEW7RYu0JCLwWE8dmNyp+tV0P2tQByqVfDJK9YberlplZVD608+5bvMLjkNESW7tajSdNpRkJZbd8lYWCX+JUuIYKs7MNeobnnPqQSxkc0zYB/2aVyfHx+8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qziTevnl/+gWeHsPrCYPlQe8jjWpP9svZjHJ6/CtKts=;
 b=kvQ29dvSWZAwIEjjofzugT0/i3ABhgrS04zZdFzwzlj/ufETFK4VelspimBdHejv+t2roL1rxGUrAxM/02C5vMMXkJHUsycPLEL6JuMw+c0Rzv45nhMdD7bid7nhaoSmpPbYrqqKC5GwvlpztcxIlg7Nsd+0vdncrquFXipw/aKIuljdGk9FKEfau9bnT6LCjo2x4dNNifULB/BqEbUL51vmqyLqrIdVgYKV35+fhYAHLArpZZaiq5XcxVq8H6kdtzdIylyB/CYhgoBnEhGdWWexXt7/FVMs/uGKZPSvNlRMIcILpkmv85MAdyKKhaFbbCKSVG9EyYahrhNyXbJ09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qziTevnl/+gWeHsPrCYPlQe8jjWpP9svZjHJ6/CtKts=;
 b=RZBsX5P6Q4x7nECLfSiUys3lNrABEH2apKC2mV5gWyrdKNXHNN3rgnukPpUv6i54SWEKrYbiYor6MJ2uYhYwATgirxuJN2dpDIo1vzSx4DBY0+DLn5I8uZv4uo8fS3boqaA3rrVAIwvkViNbRxYkueQWUn2st6uNZp9lHhgxO88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 16:57:09 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6c8e:2b32:b8fb:6928%2]) with mapi id 15.20.5314.013; Thu, 2 Jun 2022
 16:57:09 +0000
Date:   Thu, 2 Jun 2022 16:57:11 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: Warnings when suspending to disk
Message-ID: <Ypjr5yIMan1N0bqH@yaz-fattaah>
References: <alpine.LRH.2.02.2205301145540.25840@file01.intranet.prod.int.rdu2.redhat.com>
 <YpUcf19E+qgb6Eyu@kroah.com>
 <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2205310324410.13770@file01.intranet.prod.int.rdu2.redhat.com>
X-ClientProxiedBy: BL1PR13CA0359.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b03b8379-9903-4a37-0ea6-08da44b8ee8c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4116:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4116E4B2A86AAD41719F5CECF8DE9@BY5PR12MB4116.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FV/ZuFCKCtNucrfP0C1J0GVxoIoGo734xDiIdS/2g53HW7xmOR9fU9jg2E83JyFGdN86JRI4BjI3HbxJ0ieGxhm2/sumgTulLmNCmtQnVkoiG53d4QTXRqNfbjj1ERiMUST9JILMrPbOEAu6r0bdLxNrQ3xH6q5srU+BRlKr4BkydqWIDsyhoGe36s5D4kLfHeQnuN9AnzNrrdfWHA3QVplRzJAAOxKDERmw80Tf8pCvGZHpdPWsFr7L3dHaPNVme2/Xk/W7yFrb30316DevG4eskb9f5Vc3j46joWajoZZlAmIYG6RkBWtBlDKNLftn122UtKVYDFSaNbjqu0aE8A3tXBj0JpzEzFZtViV2+dYc4ya9KTE4yJOfUj+2RAnIPMHFJ3+kBPr+8TeUo+LCLFrVinAIB6zLoOWolmdnPoB3UaunjBSevN1qB/EpRnpZocyejhaKUb2bLmnqM17RCp33EdAz9VY0PzP3klJyhWS2luQb49XmeEY+m3JZTDSFDqAPTerNFHWcPSUUlt3xcDH6ICwB5aSSMGxAoWVtnfUPKQvmIAWPrQt5jYFU7nWPUZf4tHodHJxs9H1K1pB7O9MQFEatYYvd0VPytlRCQpx4Iya5Bu7beMwDDTHVtZlLtNjfG8wA7Qj/sy1F4MBpWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8936002)(5660300002)(44832011)(66946007)(66556008)(6916009)(33716001)(8676002)(4326008)(66476007)(6506007)(2906002)(54906003)(316002)(15650500001)(38100700002)(86362001)(83380400001)(6486002)(508600001)(6666004)(53546011)(186003)(26005)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WocL6mYvczRBr9aOHe7yztnAsdyvndmlJ2T0E3UiPgqCjc+YFqlL9VYK485q?=
 =?us-ascii?Q?0228IR9K/9CTnrIK2nCQ4wi0abNVKY0Yqwv4EN3EjQZTDFpi+SA41TXAE3sb?=
 =?us-ascii?Q?BZ0EJtdj20/7OjZ8xXA3W6FnOWyJgOD35hcc2KQ0MU+GHt2na2j0AcmGzGXJ?=
 =?us-ascii?Q?olSMgJuC+u/TiF6Iy89hkThile+5Mq2O5Oc396+l1pPJWeSq0JOK2EIYyECm?=
 =?us-ascii?Q?mmikRhODwwN/bIPcaJv4n0+Ky4umAxOX/qdha7jrXQ1v1xKNPhdZzlM4Lv4a?=
 =?us-ascii?Q?Am24Qx9G642/xKsKNKX0OQy9DXqivjxCZABeRsb6ijAyE4gkRLw4FjZhVGE4?=
 =?us-ascii?Q?aNedOrDquKsu1m6YGEk86vx4RD9GVR0hSTaf9qsNFtVB3LRsOCiL/EcLmJgU?=
 =?us-ascii?Q?7B9pLBz3fe8IqTwdh4yxMr0l2QLKvgQg5lKp+g760NUMrVDeM26hLjmvdis9?=
 =?us-ascii?Q?bTLlVgFo28SdiUmtTTqSVnBUpgqJcklFEX8rzD4Df7zWUOsw6WvTAVXp6VC8?=
 =?us-ascii?Q?8JohLTVdZBYAk5aKgdBt9NDc5jeE4hPDv8kJYDJ7AzyTvFshl5JzBoyfqkGG?=
 =?us-ascii?Q?xSxte0jFM6cPSV1HEEr02MkNFtkj6lCYwD8pR5Uq0IROHSi8jeUf+LwoPvDU?=
 =?us-ascii?Q?vCk53S3sJ2j6tzW1qHhR9LSEiyYDFXvXX2xplzS8URy8NgewIF82zyYlRts2?=
 =?us-ascii?Q?Ue1OLzRRICW5yLrttk0BA0JOEqAAKaQ8RLVLHzv69hfwj4U+vfwwvBoyVR3O?=
 =?us-ascii?Q?s2/u8iV35fYszyMmirxe8nVRclAWPXhK9Bgs6hPk6/lDtUKo+oYNCdSYV8pE?=
 =?us-ascii?Q?nGW+foNV2pK/QNtMAsZXtYw4fp/cG7O35mFD1vpdgovPG9FMr7SY2GJ6XA92?=
 =?us-ascii?Q?zELDNz0y3bv/McGI4R6ak2tUPsDQfJFPN8WLRm/Ll6ExSPJb/h6AR64+BIpP?=
 =?us-ascii?Q?ZKis77csR9a4PH13kUazpFgk7yBTnKlJlTj5yUcVHowSHOeMAVf3h+GVkfzO?=
 =?us-ascii?Q?UbAb8bDJ9B7G4mFk2q/jsDl4DnmR2GfxUFU9dkFvxxyAnloi98pMIakI+EN8?=
 =?us-ascii?Q?57fj7ns6G6hiMqr8zVMpsS+rmJes8dea3q1vdgjM5iw3Nut8lT7WoLMzp3ky?=
 =?us-ascii?Q?TyVXh/xsX9SBLhZqUMHqG/vYosuew8S1eb1RN9Fslg8TKHFYJNThQvxgoHSY?=
 =?us-ascii?Q?olsE1GhQKGsjrvA1kzdM8teN8435HM5gLVm0RefyTDR5e4bs1eKSYwniydU6?=
 =?us-ascii?Q?U5Z6jpuzdveWlUL4W2+xuzwJavxiENx1GgX6eCkIQxIIVZ5+Gj3GkfWqcpb7?=
 =?us-ascii?Q?euwwaj/mpPW5UWqXWqRewtuvYcHuXmgNe5XCZi6k+GI2Kb7dbRnD5xw1hmHS?=
 =?us-ascii?Q?uyY9wc2z/dvNQHsGkaxMBJYwJNufDg/eumiVW/Nb72gtVTClzPidMOpUaPZs?=
 =?us-ascii?Q?R5WWzTLX5ieV1MTWXaG2ivIzlVc9qY0xl2t4O4tlmFSGCewfTSvhjta06CQ9?=
 =?us-ascii?Q?T9lXi9jekUvzQHV6rKK675apXa2kPgCSSbi0AN7zY8GUHVFW9yjBCoJOj9R2?=
 =?us-ascii?Q?KKfTq6E18TD5l36achIK/6E34mBcIZpEOH5txE26TggfaJdvoEWS9soyrJe8?=
 =?us-ascii?Q?hUqZTLX44MwIbLHwVfTvvxuFE7IW5eSfVsHnukHbj225+afU6eQBcXRwoYpS?=
 =?us-ascii?Q?53aScp3+aZLgRgr3w1WUZDVAq6Id7e4+fLT75ynOC97ZClcSCyz2y9hU2gJA?=
 =?us-ascii?Q?KiT6UZ682Q=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03b8379-9903-4a37-0ea6-08da44b8ee8c
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:57:09.5048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bb2LRcjltcILhUcoXGQcYxK+tHqm2MuiF2T87XuQrdgaZObyI5XE1IFuf4VnecLiMgNw5cKg4w8bzWIOzt2yrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 31, 2022 at 03:42:12AM -0400, Mikulas Patocka wrote:

...

> > > The machine is two six-core Opterons 8435.
> > > 
> > > Mikulas

Hi Mikulas,

I'm not able to reproduce this issue on the systems I have access to. But I
think the following patch may be the solution. Can you please try this?

Thanks,
Yazen

=========

From 811aab8b5eb96d7f62b30d745aeacf74447eeccc Mon Sep 17 00:00:00 2001
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 31 May 2022 16:29:37 +0000
Subject: [PATCH] x86/MCE/AMD: Delete kobject for block instead of bank

The AMD Thresholding kobjects are laid out such that each "bank" is parent
to one or more "blocks". Systems from Family 10h to 16h have bank4 shared
between logical CPUs that are attached to the same Northbridge. This
sharing behavior is handled when creating and removing kobjects.

During removal, the block kobjects are deleted from each CPU sharing bank4.
The final CPU puts all the block kobjects, which also deletes them, and
then puts the bank kobject.

However, __threshold_remove_blocks() deletes the bank kobject before
deleting the block kobjects. This essentially deletes the parent before all
the children, and this may cause kernel warnings.

Don't delete the bank kobject in __threshold_remove_blocks(). Leave this
for the put at the end of threshold_remove_bank(). Instead delete the block
kobject which is used as the head of the list of blocks, after deleting
all the other blocks in the list. This follows the same behavior seen in
deallocate_threshold_blocks().

Fixes: 019f34fccfd5 ("x86, MCE, AMD: Move shared bank to node descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..cda75aed8ea0 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1258,10 +1258,10 @@ static void __threshold_remove_blocks(struct threshold_bank *b)
 	struct threshold_block *pos = NULL;
 	struct threshold_block *tmp = NULL;
 
-	kobject_del(b->kobj);
-
 	list_for_each_entry_safe(pos, tmp, &b->blocks->miscj, miscj)
 		kobject_del(&pos->kobj);
+
+	kobject_del(&b->blocks->kobj);
 }
 
 static void threshold_remove_bank(struct threshold_bank *bank)
-- 
2.25.1

