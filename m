Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E886C6C31
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 16:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjCWPWa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 11:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjCWPW3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 11:22:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2064.outbound.protection.outlook.com [40.107.100.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227992CC63;
        Thu, 23 Mar 2023 08:22:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzW8QikTs5FmQqprHAdavtki4UNxFqpzwIxK3zDnSsrmfIxGIcENNh+ey75Pv4pmOb5TDANnPu6yx9SbAGceRkZx9xFth8hfsJpEJaIlOemENj5D1Zea11ErgxGayETd2PTuweMg3K3SY5b8nQKYWEBdIx2KKBR4d63SCjPQUHLqURoGsqqMEAytH8Xi6aiFGnPQXAmbPVo20qF51FgF+EOhBbM1/fTLsh7HVaz4B2a5G67lfyoZ3Cf33krvE/scXdCRrAxwOAxHOVhm6KtLxTTocaPN6eqkkvOASPQF3H4RQMcvOK+JEDl75+flzToKD4Qci98BL2yQxTxbylUfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1DDLG9u1ChE5Dwscg/h4/U4C8zNApcIiKHYNDuILcI=;
 b=FkoRVWe3T4FG0mqQhlbhhePx3It2qvm9r942/3S8SQkKGOlu5CzisKk1Unoo2BDjZLWcehh/IWEWDo3H4YFNTSvnw6sOAJfhTMfYcfL8IJzh8B20BGG8UTaLxwxG1/+h6kcWmC1wpmq7V1zlaBiJFaskP5xJ2Rrn9PiDMSK+ALIlbUCE7AWabTIFt1rArz2ZpLaeeZq2dvC09rW+IUJdU2hvWFVfCYt/vc+HfAnTs2r3h9va+TkWycbIXd1HwcuxaHopHQBDPjAVL5sEdMmSN4vrbdBKNeS7VP43EM54pNjMb20Kh4ztIw6qz/g4V2sDX0afWnsUd3/uAQa78xmIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1DDLG9u1ChE5Dwscg/h4/U4C8zNApcIiKHYNDuILcI=;
 b=vJxwLEjEoBpZWEadXTAfC68aHfGNR7O5FROnjSoP/rcnrTAmraL04prArdXDfbySDO2Te3Oebpqkvjmp6+vHmc2Hb6J5aNzjAzMQ8q7hMDFaINE3H7ADcmB60iywBvPtcFapd15/B4VTya1oDZxH26mDgjUcO3DUmSvcQ0iz8Zk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 15:22:25 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::e62f:89e5:df27:9e45%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 15:22:25 +0000
Date:   Thu, 23 Mar 2023 11:22:22 -0400
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v3 3/5] x86/mce: Introduce mce_handle_storm() to deal
 with begin/end of storms
Message-ID: <ZBxurh8ZC39pzZ0a@yaz-khff.amd.com>
References: <ZBR+GMH0olGoDMGs@yaz-fattaah>
 <20230317172042.117201-1-tony.luck@intel.com>
 <20230317172042.117201-4-tony.luck@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317172042.117201-4-tony.luck@intel.com>
X-ClientProxiedBy: CH0PR03CA0442.namprd03.prod.outlook.com
 (2603:10b6:610:10e::32) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0f7fb8-bed3-4d59-e51f-08db2bb26823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5ygUx9InVE640DG+sPggHpJkqOAsFKeNspLkYT4CJTixhEZ6V83re0RqvkeMEotR5/EYCl5VvfCsTsoyEAkr1nNcxcTdvZaO5WrKuYZEl2uX9i5KfqHxtUkdcaXVxUttcy6ssaNTjLKZMW4Ne9YhQ9UyqgmGQmCJ3QAy3X3EH4M67aeCVQK9kz0FExKTe40arGKzA0nsBK07fcOJCoCbGJvTknPt+rSvTK3pxATxuWqkBDHvPKEdKz+yvjWCwfzF3CySR3/8FGYg2LiMe2tmzkONOo2Rj8ZyYJyvk3bOBdgT7B1vdvPpLIxImEXAw4RTP+nUmUb5uB3WpWA1+eMvLMGUaQ4XVkNZqcYrQJJfpMrvvMrnjsktigksDjMJs/UT7GoPLukG38yTPd25OnxdVK+iyKgOwaN14baC425qyrOos5q3WeANxyFFK5fPc1rcmL1xkQOvcAerUYmjg+DW16ftXXYy7hxvCs6Lsal5+prWaw6cFGSF0dnfqn7MN5R9XxQseigFwNxxeEC53OAwqQDXtx9BuN3VK0QO6D1pd+2En4JZSpOP2b692SaxyoVb8fIrkeIjpTMTumFvMaJ1kE1c0q8fqUFR80Ihl+au2GTTHm8Vf42ZU4VpW4WETb0bi3gh4HUr8YWU7/pdWyyxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199018)(38100700002)(2906002)(83380400001)(478600001)(6486002)(186003)(86362001)(66556008)(8676002)(66946007)(66476007)(4326008)(6916009)(8936002)(6666004)(26005)(6512007)(6506007)(316002)(5660300002)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cup7iCCv+D8jjiBRaDVfmBtZ75A8oOE06AUNfxTjfq3f4CBtxiGO6vMYz/XU?=
 =?us-ascii?Q?mPaKN/0ThXpYDG99IFqhxLP136PmlRKuJmzvs+mbZNlsBmuw/raMLg8gGpyt?=
 =?us-ascii?Q?Lv7+h3uk1BEAUXyQ1rOa4HcljK5ho2x+GyPxrpCjDQMlZCA3SaT269l2KDYm?=
 =?us-ascii?Q?25IbsuKLrAwTzr8uPhsLjVvjZcGGMOSDVJ1VqkL3CZTC38Eg/XKvqe9fLrcF?=
 =?us-ascii?Q?N/NQVeZCLptw1yP04sOBXdIh2/Rs+1n0KXRXH5eHPjshTBDsRldX1knrcWu2?=
 =?us-ascii?Q?Z3vQAg1ZDQCbO2JrXEvv9bz1RlxRLPnOJLYPo+w1/iH4PSP+NcINwLC5i9tL?=
 =?us-ascii?Q?FGweNuWJBOxrUuFYHwH3XBT4yZmAdiWA0o5y+/Ldh52LKfiFlKIutc3IBVMG?=
 =?us-ascii?Q?0h5UcYhYPTVW7yMvuCD4OZjG4pLsvjfvARq7pZZExRhFGJBsmae72NP24ixB?=
 =?us-ascii?Q?mwGZldbV1bIJuUY3hLBUZbS4pjF4gbFl4g6nAORpWj4NP8kIX1xqpUurl3IA?=
 =?us-ascii?Q?7mYG6UClejyhf1gG9VYVbi2+dBI8npWbU8nhfeFgatIrVE+PeQEe/YLisoZ8?=
 =?us-ascii?Q?W/ShH0NzgLLpy/qrwH9pqGpbVpHLRfxtnXQmjal+7csyjsX5dIp9k+Bm049+?=
 =?us-ascii?Q?nfOKD9uEIvaVe+znMmLOVmULFfxNQtHJ8n7JxMwRt0pXheqYWZdxDn30G7Wo?=
 =?us-ascii?Q?Gk2IdXHGNcnMZ/T68LkpoW4D+4YCUu1KLaJ1ce5f238N09P1bOfe81xzk4Yv?=
 =?us-ascii?Q?NE+MN4d+/fvcb25vaGmcyBa8nlvQ+fKMhHjgHQ+OTc7qfviAsSqCTUFSBDoF?=
 =?us-ascii?Q?1uUJOMKpwDZbzXN13p2+ilQEClucRoZWl53WUOSH+DHn0FvCUIj1vnlYXVYa?=
 =?us-ascii?Q?G+by8/SrSu2iXZGwgrFHESIkzYYSSSRdF+cKYooppV45JihkAv/FDBp7BtpM?=
 =?us-ascii?Q?9Dqm/Cse9zhSfcXIFRXHLEH5e0SdfL2r7f7tc1lcapLMm45GAfEsYK0F00mj?=
 =?us-ascii?Q?9nyGVEvZlrzU3HUGu+yxlqS7MwGIYYSVOWHw1rLl4KEIAKChMZpg1kEsiKhG?=
 =?us-ascii?Q?s8Hw0V/pi1lkfntBMvPzWMZ0ZnqUbxq5YdDbVKfQzMlTze+9j002+veQH8xT?=
 =?us-ascii?Q?pqJ0Znp51QQuivy2uZdfWe4CwvStxAO/WyW/7LeHHJQiUiz2cLvNrdB5hFpx?=
 =?us-ascii?Q?ScNg2kSTwYj1GmuKFfmeW5hmQ1xQdMV6D5xsySRZeoIr21bZuPpmYuGmW19P?=
 =?us-ascii?Q?yywDUw6cYCLKrQ3WwSuMKll+6O9injDCT2zyE2HlZ/HnwfoWP3M2193tQRxC?=
 =?us-ascii?Q?lvwenE65nZxdXiE6FKB7iNHs647rAv7CmKR193iBis4JElPvhSmikVueQDCv?=
 =?us-ascii?Q?YkYS3o4GhcTOOQkWPTkKjzY/sB2B/KkkMHZjVulthn7ivaXAA4VXLrtrZ2UW?=
 =?us-ascii?Q?WDtuX2zSjQdvEMmJen+LYlNSfC7q+odBEMd+so4xbkYfv1Wc/MtEYFgRNgDH?=
 =?us-ascii?Q?Oxh0irGZa6iQ+dpSdDUUYH9PxW2rEGdKSfFEEns5RTyoNPXIYJhW5hr5KLzj?=
 =?us-ascii?Q?cKV37urFuE2fcjt1Y83FfsyL7UiP+VF+hI0GeR3E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0f7fb8-bed3-4d59-e51f-08db2bb26823
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 15:22:25.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaWpWs6bCLQLBWJaXdLF2YmlgWEjlmvnnuvjbBkfl1KZ2OdMTIs4PJSas5oXWsBZDhTZja4gooQs8f8xbVMJgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 17, 2023 at 10:20:40AM -0700, Tony Luck wrote:
> From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> 
> Intel and AMD need to take different actions when a storm begins or
> ends. Prepare for the storm code moving from intel.c into core.c by
> adding a function that checks CPU vendor to pick the right action.
> 
> No functional changes.
> 
> [Tony: Changed from function pointer to regular function]
> 
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/internal.h |  3 +++
>  arch/x86/kernel/cpu/mce/core.c     |  9 +++++++++
>  arch/x86/kernel/cpu/mce/intel.c    | 12 ++++++++++--
>  3 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 72fbec8f6c3c..f37816b4d4cf 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -43,12 +43,14 @@ extern mce_banks_t mce_banks_ce_disabled;
>  void track_cmci_storm(int bank, u64 status);
>  
>  #ifdef CONFIG_X86_MCE_INTEL
> +void mce_intel_handle_storm(int bank, bool on);
>  void cmci_disable_bank(int bank);
>  void intel_init_cmci(void);
>  void intel_init_lmce(void);
>  void intel_clear_lmce(void);
>  bool intel_filter_mce(struct mce *m);
>  #else
> +static inline void mce_intel_handle_storm(int bank, bool on) { }
>  static inline void cmci_disable_bank(int bank) { }
>  static inline void intel_init_cmci(void) { }
>  static inline void intel_init_lmce(void) { }
> @@ -57,6 +59,7 @@ static inline bool intel_filter_mce(struct mce *m) { return false; }
>  #endif
>  
>  void mce_timer_kick(bool storm);
> +void mce_handle_storm(int bank, bool on);
>  
>  #ifdef CONFIG_ACPI_APEI
>  int apei_write_mce(struct mce *m);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 776d4724b1e0..f4d2a7ba29f7 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1985,6 +1985,15 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
>  	intel_clear_lmce();
>  }
>  
> +void mce_handle_storm(int bank, bool on)
> +{
> +	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_INTEL:
> +		mce_intel_handle_storm(bank, on);
> +		break;
> +	}
> +}
> +
>  static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  {
>  	switch (c->x86_vendor) {
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 4106877de028..4238b73c2143 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -152,6 +152,14 @@ static void cmci_set_threshold(int bank, int thresh)
>  	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
>  }
>  
> +void mce_intel_handle_storm(int bank, bool on)
> +{
> +	if (on)
> +		cmci_set_threshold(bank, cmci_threshold[bank]);
> +	else
> +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);

I think these conditions are reversed. When storm handling is 'on' we should
use CMCI_STORM_THRESHOLD, and when off use the saved bank threshold.

> +}
> +
>  static void cmci_storm_begin(int bank)
>  {
>  	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> @@ -211,13 +219,13 @@ void track_cmci_storm(int bank, u64 status)
>  		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
>  			return;
>  		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> -		cmci_set_threshold(bank, cmci_threshold[bank]);
> +		mce_handle_storm(bank, true);

Should be 'false' when the storm subsides.

>  		cmci_storm_end(bank);
>  	} else {
>  		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
>  			return;
>  		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> -		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> +		mce_handle_storm(bank, false);

Should be 'true' when the storm starts.

>  		cmci_storm_begin(bank);
>  	}
>  }
> --

Thanks,
Yazen
