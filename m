Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5F60E4F0
	for <lists+linux-edac@lfdr.de>; Wed, 26 Oct 2022 17:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiJZPja (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Oct 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiJZPj3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Oct 2022 11:39:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79419A;
        Wed, 26 Oct 2022 08:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngNFbiLAO7z68LqyxsI0B1R811l4CJoN/CO2lW6sURMQyUYZznoHYfizNJfVo3prw6E/Hwzm0nJRR4Bky8yJhA89DCc7yMEptmFxJcdOK7cBgL3opTcsvZOx21cHhm2X/6ZM/lnQp8F0Bwnjr8MvBgqVeMbiak85xr9G7Wq6RQlScWOGCJTrF02r/vGlf1dc80TOzdV88CeQkmlj3XCexr+zWEC7TZXbsxt/C//woyrTdpoGe4A9n8UpK+cBXpxIqXShSkSIPaAiyu/GaGlX83eIfmy5p0xsTyF9jFQ9CeM9v4XEGvyMNi4FQblFai/jl2cmJ2RWpaPR5tQ6CzDVSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2YhhmoXhe1iyCNNrF4JjPaVzCvRd0QShDEWc4QfL7E=;
 b=F3u8Va8kcX8A//0pib5m5gsrzmAtlarbay/GhRcUVkpfoBvGrfjHtlb8F0fOC3pscmLtPSgvoNe9kbmZTK1yQqYkZKSXtU50FqNIMmIQWz3lVFRNzItc69L5f8HXtiMVTIW01sfG9Wg2xoJ5CXUxnUgDiBzVpsQAJO+thqrA4NmomFdo9I3BbQSjIRhOWSwn60z7s0uzWV6cnX/FGqUfMeIOl9jeTbvmKQxPWGO+3oxkRB2AW1TJz5cIerJxoTjMsPQO278TP+EzgeiOKmv7bkpNGPEH62CWp5T5PC7Xv3MVa/TYhGujhhRxp8x2zLFfwsZ5b5ciKfMGJQqpTa07Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2YhhmoXhe1iyCNNrF4JjPaVzCvRd0QShDEWc4QfL7E=;
 b=zQnCFwDRlS1qyYM22s9LMXDFx2aY2z1/TJk3OyCasCRDVKXYHYdMiSd75w7TOr1nezhUxbFoE3nz4lQPe69RZxLb04ukvBJ1DE4dR2N49eIPZqFABUbmzip6VCEhjK5iZ/kRAFXJn+Sac7p8SJT4T/rRgwAEUNXbnw/QAy/JmrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB6635.namprd12.prod.outlook.com (2603:10b6:510:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 15:39:23 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::ee94:4f22:751d:278a%7]) with mapi id 15.20.5746.021; Wed, 26 Oct 2022
 15:39:23 +0000
Date:   Wed, 26 Oct 2022 15:39:15 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, mpatocka@redhat.com
Subject: Re: [PATCH] x86/MCE/AMD: Decrement threshold_bank refcount when
 removing threshold blocks
Message-ID: <Y1lUo08UzaqIaI7r@yaz-fattaah>
References: <20220614174346.3648305-1-yazen.ghannam@amd.com>
 <Yql9TqFtebd2h9Z9@kroah.com>
 <Yqnj88FPkZ6kBU7k@yaz-fattaah>
 <Y1kJCHBtatohj/JK@zn.tnic>
 <Y1kiNBh3/XBNe6uv@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1kiNBh3/XBNe6uv@kroah.com>
X-ClientProxiedBy: CH2PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:610:52::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB6635:EE_
X-MS-Office365-Filtering-Correlation-Id: c99cc512-da0e-4424-eb0c-08dab76841d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0OBLOB54miW4OlqlCVsI/a8BI7wm3XDAbgpOJFaEYHtpdgQIZr1H4pKe8Y/JPom/4IhhD4Fz4kRMqDK8jrPbgTkXz/NLn6x/IRy8Uw2A99btIW8BiOAFOf0n7GSFRl8vCnT+bqIzU0TYfY1e4/AR5XDyvymnahah0RSgmehty5GsSgGcEplg2Qpyu02F2Uz0PJdnsj3rInWhYgos/05jfNvwLygCz7flMsFR4QAno3pPVbrTSCntacV7cSbXzs9Y3yK8p4Luc8Bs/xco5z0fOldU+EIFFKMV4LnoBjYhaBWx+FMaIgk9H2KVhJ7VQkCtXgIstQh7O6qs7Du0+MYyTSOZ+AFeduLSgXaO47Wh/apbAAvqUb+Dkki3xc6xo/yCa7DPGrp/eF/yRrjmzVoGx9/wnjA1TQ+bd33XNbnI1Z+hUL+YwiOj/tYQRRJgngw5NlPq+aGr23AdkEOrGLQSZKR6aLYYSjT+iBhxzxrNoID3vCev+TyqI1DLwV0qeSZBxOYZ2jJhjdaSslaNe8pOboV2Ay2PtHgOjNl19uzPKYZmtuq0a2AZZ1EA5PmVrq5hBoGKPFHx73FsmWwcAMFSNpmxsCmuoR/oLPg/b44ubIf9753qOcTyzf4P95WYoMjb8P7BQxiTr9m4vNDcBNLJ36GeLeTpBKoy1lkgiG/VxjuSZNDMynHwBiDp/XOQ2Sd1c1P7BFGbXheBxuFqG+yluA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(6486002)(66946007)(316002)(6506007)(6666004)(478600001)(6916009)(66556008)(4326008)(66476007)(8676002)(26005)(6512007)(9686003)(38100700002)(5660300002)(44832011)(8936002)(86362001)(41300700001)(186003)(2906002)(83380400001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7L+jEtT8w1+rik/8nK5EIANGYIbe0qPP3Gr/JgTkYJ+Anz62V5q/z1PIEC4C?=
 =?us-ascii?Q?utsylxaP3fBZne+iVJGRErWhdkP/I4HPqEagua2TKNRUlCLl41/MTUNoDBRI?=
 =?us-ascii?Q?o3KrkGb9oCOlKDWt6UC7khAxfZeyvdJeBl5yT7eUDCnqAWGoQdN4O/7xaHbN?=
 =?us-ascii?Q?YG3yZiE5myZXxFCz2gXrVQV0sUkMre/igSJGm9OTHgoKz98uS6KNx1AGmdZ6?=
 =?us-ascii?Q?/24TQTzA43mVTyvJI4N5p5GAiA+e9fY12sk9xfTXzxSsKGKXIUIe+GDbVjwk?=
 =?us-ascii?Q?JRIm2rivnmtaj7Y5SKw+o+4/L/bxEDYjZUgqCI4IFSRTAwX44hC9ZRIvGS5a?=
 =?us-ascii?Q?FQk88qV1kc9Gpuw8BlnrnfpqslfC+Lvd1KqvA9eyikP4wAiLlWqunePzrOsa?=
 =?us-ascii?Q?brhuK7zCMVw0svBAF5lcroZOY9DFCWPU6ii3ktQzTQseaS01gI70ojw/a8qV?=
 =?us-ascii?Q?3gnv69KG2ECetY3yy+e+CAp3qBHsQOLzNbKTg/pZlMHO3ixADRw0a36vwoto?=
 =?us-ascii?Q?Maw2EPTUwn5FcxSp/NkD4b4LuzfWqpx0GIlSpdbvRGLvFnM9AaB8Fil90tSP?=
 =?us-ascii?Q?6mjWP7JFiFv2XuGxv35wi82QuwO98iAtyIOJ2cHBmxDhzIDlEbtidnw9s+Pf?=
 =?us-ascii?Q?xNJAEixT1tVViVFWKlnJl3xtjOdRWqztmVnSGsNQpQw7jGVx9+RjZFVYE2NI?=
 =?us-ascii?Q?xtT0xm3jVSjgAtO8RYGPgBzW+zxKbHX1nqiyknc3rvHX1pYoB7O0HUVPBH+N?=
 =?us-ascii?Q?5zzdfUV/cZxzcVCOFAGS/FyFpvgZ+bFWNZrbTwSjaLNLuMgDcQvzFTLDMHyN?=
 =?us-ascii?Q?+I43tTxpEEQQ/e85COqbPC5gSE3Z0/xzYho4W4zf1k9XJUleP6O9/M8ON8up?=
 =?us-ascii?Q?t5dF39WW/FlKp14I6p6B6SGUwo4g3JWc5vp+NITsruhz+cwiteDFDKy7dQWu?=
 =?us-ascii?Q?D+95zzeiMS+60TTxhkkjyCPi3UNmtqnPuTrkNgHh73cqqq3uV0e+RsTia2PZ?=
 =?us-ascii?Q?8e7jkalasl+S619sAdBmImlcBIBbfLq2+0v5upLhVf13KE7Pe5yRveuVetJD?=
 =?us-ascii?Q?Gi/osBQdYM17vCZlF7ryS1ChkhG4O6DP81clsDA/k5LHvooUdTRDSjhQws6r?=
 =?us-ascii?Q?nc+yT9TFw4LbRD92VUVJyue/7lB14aabkIBILG7oXFHXuAjTzKm05fLg+WQ9?=
 =?us-ascii?Q?LFLtDCwN6SA9MR61JYDi2dYw1ENRBCYn93ymR9DB4SDLk7Syaxt7tUe5/eYd?=
 =?us-ascii?Q?MyXFN+p+YZiZuRNAmCaI4gOitsShMb8O8ZE6ErmJBf8vPzW27ku3u/QTO1Eh?=
 =?us-ascii?Q?BXhNS9OYihuBqlHL96fEQdsxvNc1RJDYDmH7aNuqZMPNbWZ03FOn2CUmeQSQ?=
 =?us-ascii?Q?mxdWZMaPz8E+oto5IM/KRHsxedrW9/8BDliVm7ERRdIae0Mhh+sh5FT+UQ40?=
 =?us-ascii?Q?9OcmbF9V8nW7vT243gIvy1f/T0Shnflg5BIJwpIiniGf9H6kkvlHU5mhlH/J?=
 =?us-ascii?Q?ghIKtHrUxhGQANGbIao/cf1gRepBCpt4ORwyKdd7cOeN59ULFPJ6EVg5Lxpv?=
 =?us-ascii?Q?l9RoG+xGyP+YQdCV2m7CoXxbQ6LsZtvUMZ7nYNtm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99cc512-da0e-4424-eb0c-08dab76841d3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 15:39:23.7110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eb8IO1AhehauESMw9niNNvlIocSszUPXa77oSt1QrakdeYpcAUhCgz7GkW1419fv0wAgoPwx/UWYQ7YWHcHb+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6635
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 26, 2022 at 02:04:04PM +0200, Greg KH wrote:
...
> > kobject_add() does a kobject_get() on the parent for each sysfs file it
> > adds.
> > 
> > Therefore, in order to unwind the same setup work when the CPU goes
> > offline and the bank *references* only are being removed - the other
> > CPUs still share it - do a kobject_put() on the parent.
> 
> Eeek, no!
> 
> You can't decrement the reference on the parent, that could cause you to
> get dropped.
> 
> And you can not reuse kobjects, is that the issue here?  When you are
> done with one, you have to delete it.  Then create a new one.
> 
> No need to move anything around, just destory it all and then add new
> ones.
> 

Yes, it seems like we're messing up refcounts as we try to manually manage the
life of shared kobjects.

But I take it this is not allowed, correct? So maybe the best solution is to
not do this sharing at all.

...
> 
> What changed to cause problems?  the kobject reference logic hasn't
> changed, was it some topology stuff?
>

Here's a snip from the commit message at the top of the thread:

"During kobject_del(), kobject->sd is removed. If the kobject is not part of
a kset with default_groups, then subsequent kobject_del() calls seem safe
even with kobject->sd == NULL.

Originally, the AMD MCA thresholding structures did not use default_groups.
And so the above behavior was not apparent.

However, a recent change implemented default_groups for the thresholding
structures. Therefore, kobject_del() will go down the sysfs_remove_groups()
code path. In this case, the first kobject_del() may succeed and remove
kobject->sd. But subsequent kobject_del() calls will give a WARNing in
kernfs_remove_by_name_ns() since kobject->sd == NULL."

Basically, we're deleting a shared kobject. The first CPU gets to delete it,
and the following CPUs complain that we're deleting an already deleted
kobject.

Sorry Boris, it's been a while since I looked at this. What's the issue with
my original patch? I think this is the simplest way to fix the current
implementation. But we should probably get rid of this kobject sharing idea in
light of Greg's comments.

Thanks,
Yazen
