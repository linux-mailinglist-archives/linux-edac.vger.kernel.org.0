Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DC6BEBB7
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjCQOuO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjCQOuN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:50:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A63474D3;
        Fri, 17 Mar 2023 07:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjRTrJIrg/brKDDtUa4SGcxml4zQBq2SxjWBURGfuyZNJnJ/Z+XWAWn/Zgn9L5dextawKU1HtFaN0cR4DKpruFPbGJcSgPiZ9wP9dP72t8HXnQAshtqtjGSRrTEi08oXAE9KeypDqwYQX63hKdVUrNnTfNdi7I32FT+JYmGf2GmDIbev2nzZHyN32BgdDwD7ZeHYWJvDENPCGY8giZCZC4udhLeUDgMVWKWJPrqBbnH9IO/uh/LqTncYDdUkLdoLImv/Zh7xLPuJsZFqMNd30uDGj0v+Pr3OfLYUMpM/f6bNdoFfbPS4uLgTN7CmUJQ9WI+KmNvUxlKeRjkIzJfDEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Fb4H1oMlyCha9KOZxLj/PAcWKUf+9TeVMbhrVa/e5M=;
 b=bFKjcDnUrG1nkmM6d8oRjOSkOuMgwyvWODV+WPqZPe7grsT/nZA1BXhuq0OkxHAOjTP5a4p2+u4UlSiut4KIP8Xrq6LZWZPGXbJJelSuSXqblb832MsQeJmGQgQ/0a8ZdemHcl9g5HkEUF7BrIMcWGR5QJabg9ZRNFYQWzKqMG3CFp4zbaARElBSxVIUFdyS6AvA2pHpxwCwxhyf64qv2zrSukyPBT4xJ62LM8MRhdvWVgPmLdWLZ+HMmwYs7RwKCt1LWxvpb74vup3fdAf0y+nTCXL2yWwYdJSuZMzFhwulzBKCtr/6gehbgyrPkQM6UgVgG0GZN7GhsD3Dg8qeYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Fb4H1oMlyCha9KOZxLj/PAcWKUf+9TeVMbhrVa/e5M=;
 b=dW+CYjjFHAOKsoNBnV/0NDf6xLgA2FAGZWgpfjmBlg8iJNmkfWWwCD/p3s3ef6TsU4uuypIuG41WhRvgswgH6cPm1EnVrhrqNrJr1ykV4O1cZn6gL5sJaWnl3UMuKg4eLbfWxvESeAGmkIxPxIfsolFThd6rTNcGx+RfsBx1miA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 14:50:04 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.035; Fri, 17 Mar 2023
 14:50:04 +0000
Date:   Fri, 17 Mar 2023 14:50:00 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 0/5] Handle corrected machine check interrupt storms
Message-ID: <ZBR+GMH0olGoDMGs@yaz-fattaah>
References: <YrFSSZqjtWlm9rUr@agluck-desk3.sc.intel.com>
 <20220627173605.514504-1-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627173605.514504-1-tony.luck@intel.com>
X-ClientProxiedBy: CH0PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:32::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b84e31-29cd-4190-857d-08db26f6e442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYIrFAbzqgvyJbRSTAIS7FZHdqIUQiXekq+QyfDVqCyIpa6RAMt0fKqmCjdSs6evziVs24Y5qZ1ZP0jY1uo4n912/LZECx3rJO4mV4qwXXrRCmXN75+bV5bSfBHh6IKAH9O6gPUEGql+0FuGX2Oyly1AgAzM4aeWwvTRkN92R5Q2jAp7/N0Znn16u2s2IKm5G4xyOcSh1ICdIy/6SDwHR9ksTSuKz9P5+yyYRC28QM/xjsQaXR92W3SAUgQBViEiPGKybZ4yEpKCzvrANGX4FNCyhes/xr7x4KD3rwXkoTLFfgkFa81kYy+t3q1z+p3FuLVBbBrJR1DmcnXEgXL+l7bDg4u2Bv/Q3tPeMHDjX1S76fuc7VNWmyn544dBpOLIF+rqgI3IrCxF/eZpbAiDdJssgeNJpOEkWH/2MPkSSAeSEtA+/ypw9HyLEJ2TmyVprFpyMjofdBp1pnCAzy1F7JyfSbfYNoFcfPJej0wV+PjS5YVkWIo2kpHwtqwgL41kIvkQitJujQd7umq2nFMbGMheh3SdXhhutzHlGDIYwicUp2xvN41Ktd/5vtHlkP+gKRRQKJUBFrrOPfOz8+C2vUzyxGFwLm7jKWKJCn4jTgaHEyj7jjWQMxfo1DmTiHICFuIK7weUabukfb6HY+k55xNBZYFupv63RA/3xrfIWJnvW5+r21ww6ePpvgXXtJln
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199018)(38100700002)(41300700001)(8676002)(66946007)(33716001)(6916009)(66556008)(66476007)(4326008)(316002)(83380400001)(8936002)(66899018)(478600001)(5660300002)(186003)(26005)(9686003)(6512007)(6506007)(6666004)(86362001)(44832011)(2906002)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+FXnK59TcM/ShptutH0T06DgPjuqdtU3MefTHacf+YsGr9VjeP0lttu0rC0?=
 =?us-ascii?Q?xTFrOQl4WE/OKQhPhkoLIJUyNHrqtvqBl2Z6viGpB301w+JEdn+XO+k49aNs?=
 =?us-ascii?Q?RQBvZZ40pDEYNhCE3eJcRv8ZOpHxVnkg+IZGtqiAWlzflLCWRxNM5r6OMq0m?=
 =?us-ascii?Q?L9nSOQqukYhwqkvfoIP8B0SJV9BokmV10jGQ0ahMlYe/iWByN+bLACaDX9EY?=
 =?us-ascii?Q?MRwThFcrELLGkTlm03PtuV6l0V6bo3roP5qieKF6wZbj8c9DhBxIT+GTp2vd?=
 =?us-ascii?Q?Cnh4PJCnl47JUD8gqIt40nhZzACCxS/SymiyrIiKIWh89e4zIxQdToy96XvN?=
 =?us-ascii?Q?5u7XdgIvK1U+kj52Y0D4ZELXpL9RkxL0hZ8ObxBm9XLdpMm/vxxmyUQQX1KZ?=
 =?us-ascii?Q?/GWsRn8kayjPrSgvptY26np1GCQdBTiBe123Ch0GsGDkXor3nB2xDt5fvhQL?=
 =?us-ascii?Q?SHz4ehAt1nHv+yOF+IQi8wcYKA7poLO68A/PMK+DpLiLgpJS3ySk0rPpKvqL?=
 =?us-ascii?Q?fR5VKPZUFFqjUDarZivodPF/btGVui4Oyrxti9w5tg+f+vhMkelwK6EQ8cYF?=
 =?us-ascii?Q?htr6S11asWghzeHjuAD8tDkVxhNsMM7zw+IaZUhTC58hJTA/QywQ6r6k8S88?=
 =?us-ascii?Q?dQ4zz2JLM5KK0hQXHduNZu7Trvcg8mYmlwRdrDNUyb7a4XteyMzyEszl38+B?=
 =?us-ascii?Q?8SKMplVg11Ld/tyj/s6gxw6onrW4qr/A7Gkm5nVXFdZopBjENMWGkXuoCfr3?=
 =?us-ascii?Q?sQoV2kyftVt8qDG0ED8Pk5tMB2hMmGL84P4J5OAx6CsFhrZ1xNNf5IjQFKEy?=
 =?us-ascii?Q?8EPZE9D9RQKGQAiLrJvBOmJF+W6xj3DSn/MqyPrIuL3UtbeFrStpJ7rBSnXp?=
 =?us-ascii?Q?KH9dUld6K4DUkpP+q+DKRyaB4nrJ/2kwKENkeyjPz5bQqIFfBGIUvME44wzl?=
 =?us-ascii?Q?DriUp8p+/+0e/J/8Y8LSyzEhvrRkeRHFUFYMXRj4gKUJAxGGzcg73t9LmXNR?=
 =?us-ascii?Q?PHQrU2OtP8djDSthCkSz+jZVML750pGycZHUg1L4Zwb7SeORaJdfmf1MH6u9?=
 =?us-ascii?Q?Talfy2V+731ZqYTQAJPndJpLf2/w1Dm9KSmYN92xBmCoYRdMFRfSZOdVRSkl?=
 =?us-ascii?Q?CLorL41dg1mKmE+/0wNHoMGZTGF9wPun2aLagAiCj0usvpMisfca6Rh1tOZq?=
 =?us-ascii?Q?95z2yiaO0Oe8gUlLVxYQKVx1antqZ/ucv8JaNpiR1YZb+gP7qhngq1FLAfnJ?=
 =?us-ascii?Q?gmqViBZe4E2/PLDOKS/o7RZtb1VG/kTsKRqBPUoYWR+9mR7wxoSDHAjUKkjC?=
 =?us-ascii?Q?e8hIJ9Y5ubCmhokt1y0s/TGnT2oC00g2+Ta+xYQf8AVljCYyKYDHLEvul0kg?=
 =?us-ascii?Q?RZlzgo6nG26nfUhZmf/sQlCSnWJxLzAClXBSlqAMneu039dB/YmMvOTNWJVC?=
 =?us-ascii?Q?NI/THD8h0/k0AHu//WBYY36rjlHVwmu/vlWlteM0tMc6HUJDm6rdlWH17HY9?=
 =?us-ascii?Q?JNWOkmzCIYF68aZ/0RJh7Lh6XBiF3ZroxTyzB/CcVekOoxvXNsLp7rwcwhmu?=
 =?us-ascii?Q?2UTGpsFYT3iC8r8LHHmYzb3ryzWnoPUUfPiO8oXk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b84e31-29cd-4190-857d-08db26f6e442
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 14:50:03.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr4/iR5PhIhdFqWVwYH3at9ahmEg9nOZoHkz5a/bYDn4cqigJ17rmGRaJVHKMOJSbWcI0zI3KkD12Z49yYkqOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 27, 2022 at 10:36:00AM -0700, Tony Luck wrote:
> Extend the logic of handling Intel's corrected machine check interrupt
> storms to AMD's threshold interrupts.
> 
> First two patches are from Tony which cleans up the existing storm
> handling for Intel and proposes per CPU per bank storm handling.
> 
> Third and fourth patches do some cleanup and refactoring on the CMCI
> storm handling in order to extend similar workaround for AMD's threshold
> interrupt storms. These two patches could be merged into Tony's second
> patch of CMCI storm mitigation.
> 
> AMD's storm mitigation for threshold interrupts also relies on per CPU
> per bank approach similar to Intel. But unlike CMCI storm handling it does
> not set thresholds to reduce rate of interrupts on a storm. Rather it
> turns off the interrupt on the current CPU and bank if there is a storm
> and re-enables back the interrupts when the storm subsides.
> 
> It is okay to turn off threshold interrupts on AMD systems as other error
> severities continue to be handled even if the threshold interrupts are
> turned off. Uncorrected errors will generate a #MC and deferred errors
> have a unique separate deferred error interrupt. The final patch adds
> support for handling threshold interrupt storms on AMD systems.
> 
> Changes since v1:
> 
> 1) Fix shift computation when keeping track of bank history. Shift
> should be "1" when a storm is in progress (because polling once per
> second). When a storm is not in progress shift should be based on
> number of seconds since the bank was last checked.
> 
> 2) Changed Smita's code in part 0003 to avoid use of a function pointer
> (since the kernel is avoiding indirect branch points that might be
> trainable for various Spectre-like issues).
> 
> Smita Koralahalli (2):
>   x86/mce: Introduce mce_handle_storm() to deal with begin/end of storms
>   x86/mce: Handle AMD threshold interrupt storms
>   x86/mce: Move storm handling to core.
> 
> Tony Luck (3):
>   x86/mce: Remove old CMCI storm mitigation code
>   x86/mce: Add per-bank CMCI storm mitigation
> 
>  arch/x86/kernel/cpu/mce/amd.c      |  49 ++++++++
>  arch/x86/kernel/cpu/mce/core.c     | 139 +++++++++++++++++-----
>  arch/x86/kernel/cpu/mce/intel.c    | 179 +++++++----------------------
>  arch/x86/kernel/cpu/mce/internal.h |  33 ++++--
>  4 files changed, 230 insertions(+), 170 deletions(-)
> 
> --

Hi Tony,

Is there an updated version of this set? I can help review and test. Smita is
focusing on other items at the moment.

Thanks!

-Yazen
