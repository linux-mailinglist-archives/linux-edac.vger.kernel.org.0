Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF14FFF80
	for <lists+linux-edac@lfdr.de>; Wed, 13 Apr 2022 21:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbiDMTnO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Apr 2022 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbiDMTnN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Apr 2022 15:43:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC25D75E6E;
        Wed, 13 Apr 2022 12:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMexj6rR1Wex9cJib3maidMPC8DMEWwWhQACR/0hOTEFVHf6NlGok4CZX+q4agM4FP9OOcqkrF2tMaTRbdpOycKhlsSLFLacIicnge3CxJMW6c7ci6rXmIfIivYNq1bK3lRdhdGeYJo0eUh6/9NI6LFnbepYidbr+21JfUAumXyZLnIv1nMNni8ELxFOB2484BHu9OS3t0j/HvanT4gfGgan8zY/eOc9fKQZk4RIQSMPs7nR3iSMULeI0rJrbGKXY78QQ4Co91klBdQAtkzHjfyUowhnaha57n7SGUNAkmch5njJspgl9lC7mjSEIdoWVz07fostH+1bK/+oPIHu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TZR6qXSh5dwtIoklAysHYn5VQtBmgBkFIozzhOXXz1k=;
 b=cmeEUfx8O08YpNQgo/znPOhfPZXGCpsAYvwc6P6MAXjEkBvjY60CIwE86l8/1vWuRHJ1u/9B/e2C54Sn96V3neHXy8SvRgexYCq4IfoI63ZHWJLSdZdGcUD6/qPQYp7CAKm8xybU5YXGpBUi70d6Bl27V41SC++KeZ2WWCS9opmvqbv7ZGT6pSt+s7YBHW053V2FS2fvxP43ksVwRwzeGypl+zG1TWgJYGYV85stIRFglGlOKUIMUDCjuw1PCLsKlYLh3Be1EBpw2UKpbN/J1XoaUJI1CdUIEC8HC5T6cbrMPqxFSaLL13rXTUjkD5TFn3stoD5MRXVNZyk5Uj/rdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TZR6qXSh5dwtIoklAysHYn5VQtBmgBkFIozzhOXXz1k=;
 b=eqxRKjJacGpaLyY5d00uYL3JYS1fi/iPfqFYxHgxP8d0mnzqgSbJadXsdu+akAyJiyX2N+YPBgc29CK+B7+4RmerwUJMdYLxGzNiQVJBgsD3cqiG8l9TjCp8n6for2ltTo7g25EInf4T8a5VnfP2HRzS+QuBJsTpnOMZEEgbal8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:23d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 19:40:48 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 19:40:48 +0000
Date:   Wed, 13 Apr 2022 19:40:39 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v5 2/2] x86/mce: Add support for Extended Physical
 Address MCA changes
Message-ID: <YlcnN2q9ducdvsUZ@yaz-ubuntu>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
 <YlakNe012hhErszh@zn.tnic>
 <YlbZ1k1cT1FVJj4W@yaz-ubuntu>
 <YlbkCK9LU2KdXZUG@zn.tnic>
 <YlbzbZO6AvxOqQb/@agluck-desk3.sc.intel.com>
 <Ylb3/4oi6KAjdsJW@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ylb3/4oi6KAjdsJW@zn.tnic>
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651cc4bc-6d7c-4f1a-2edd-08da1d858223
X-MS-TrafficTypeDiagnostic: SA1PR12MB5613:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB56135D296AB481DE44F74B7AF8EC9@SA1PR12MB5613.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xX5dkEJGdwKsJUNF5F7Rq2RWbRMV5wQXmENnx9g4Jo0WOCIiGvz8kkaQuLPcj96Pz8bcVQhnUxRVOaau8YJ5NLrzv6ClDINGJkxPGZVBkkTZZYSWUCTZMCLFl131VDGbvzQDJxKtCni9tTXDQ4bEKr5m0A8KmQP0ZMQtt17E7NJWGlHcR0vLPdRkIXYZ48S8mIqW5EXNSbSP9VnKEbLvgK/m5P4nZqdIyghrKmkDHZ3bb1on5HauTtig+QD0VOFPNlWb0AvhG1H/bUVQyfEQzmR2PylLwv/KoLdEbq3e3wZUej1F0CXQk3D/FoYMuWmCYKcaEXIX5Bn2KhwVNp+6YVSxILfwt2kpd1g+M/HH2ENCdawrMQJaFbjcI3FAcOGCdesc/zxxwU9GjUH98L6A63zJgb9b65z71keT9ALFgauI8wfV57lBpwbdZBG1jGFWat6i01xu98K0LKMHotqwG7wiqGgncOAu2C3UVEty3AzOqb1EnP+lvdgHSouvGua24ETTu+8din2lHC6CFyQediNGY3ayhMD+3nd+yaHiRI84o/Hgqgwt1qkFCMr8+Qo7ryLENlfvCHg+PpNPhK0iCnD7Teuj3+1jSwu3yNOgOM74ubQG2PhmpdahC5i4WvNvi4fNrQBqvs+icI6+u8KIVPIVpkOzKbgUlF5wYxvjfONRq32+0hU8cG6rcIVba0/cHc3wO5DIMTwGrQhCi117nA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6512007)(316002)(8936002)(66946007)(66556008)(66476007)(54906003)(44832011)(8676002)(86362001)(6916009)(4326008)(5660300002)(6486002)(2906002)(508600001)(83380400001)(6666004)(38100700002)(6506007)(9686003)(33716001)(186003)(26005)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nB5tVCPCchLsddaOowTzzhMmvLahmn5T2zKfkUjtlPfXVfkWSVaaA5x+Ghay?=
 =?us-ascii?Q?Si6M9wjHn7rkos4WJDBIRQ6rmWQoumYQ4TL5gAWbQYMQpk7gicWf+Yf9uU8o?=
 =?us-ascii?Q?kQR5y/uj4LH9cUScyr8AYrZdZj5XaV8bQR4ten5jbjv86u5tQA8mLOdKLbWE?=
 =?us-ascii?Q?iUD5kr23nSbfFBeFxzaTGk1A14Jeb4wU/FvC/FUWAOxV5ZIyHLx42I1/6qGi?=
 =?us-ascii?Q?FULJuUgeLhzeXQY/fSwj/cUBQG4048NosRB9VqxADbIPnOuukqahD5cMjmy7?=
 =?us-ascii?Q?eDJRTkyGLVNoarzVOBR52U1QVCAgYTIDpyeRFj10IHPqlcErzVwwogFTJGwh?=
 =?us-ascii?Q?OFUDO2NH4Lr6BB7JnYIlhhq/RbrbE3RHXUhA4Ul0IkrGc68Iw2Y0FUwPtz1v?=
 =?us-ascii?Q?Gs+qx//pNVBMCziJ58JywkUcEA6CCJlwvoBQHEl6T0Kvhch0/2Xd8dBCsxfP?=
 =?us-ascii?Q?IBnXNYzmevIySotPjgHNy7RDJTI4ipCFyjPHHgIvTLGHz9PLE/d50NPQxF2C?=
 =?us-ascii?Q?TvS3Xc3SQNr34cBJoM26yuj8T/VDgOCAfIU6DYDvx7LEOWap85sQV1VAtgT3?=
 =?us-ascii?Q?RcesvhTCSELZib/OnKdBmG5m2OHYbccbfa9p7nnFV1azHVXt+2AYXlZ2Gx2I?=
 =?us-ascii?Q?59H0PG1Rv1sL9smWQpg5KNYTYMYtqXLFkWSsgxgUW4a+i3GHp9db9Bg5qDvs?=
 =?us-ascii?Q?XIKSMtOODZJybvGzSUqbMixq1CgVlarNIbhnPzdLzQo9N0GNsz61imi4blLS?=
 =?us-ascii?Q?M2yeQSZrPER1wsUOa5rGmPK+V6/kwr14e5BcPsz/jVxKiIevZ3lJG5wd7aYj?=
 =?us-ascii?Q?t+GO6+Pyn7ugk10lLqNTBBpD7bU9ev2ol/K6lU84/WTkjFWiCxb5jgecLF7k?=
 =?us-ascii?Q?YOa1AZMFXtlPWudeVHBxTDJPPTftbSuvYhH4Z3bx6DqD2UKcbpGqXTDm8cGK?=
 =?us-ascii?Q?V6UYYIPsT2qE3ma7ro/6aDiAO1nW+m7nceqJNfQBNfadThRF/l0yAo9IXO27?=
 =?us-ascii?Q?FT9FihBj7fUbqNz4buIgXCeYmc1dLaVK8oIPaFN5mNQLuo+a5wqdvrRXytme?=
 =?us-ascii?Q?SJqlsJL9Rlqh7s6HaPn6fDE+SiscWl7bztkGQ+a6xUpDSYxriQLbc5B5d0mg?=
 =?us-ascii?Q?ZwqNZL8gSXegicygHtGlQOuhi9H/O2h7q5xL07qGbgldI/u7HGsA18FYyue2?=
 =?us-ascii?Q?N1GJjTpy5N1BABrD85WKSjtbiS3VYaHlvIrfuSTCJcK8PSoUDXm/D9ktcR+C?=
 =?us-ascii?Q?HqaKhraqLSncFGT73/REQFSyWXnCiRspPErTrPlfTB81Q5Nw8iZZUxqpgVwv?=
 =?us-ascii?Q?zXvrEgO8SehjoN94BQyixU/jnaJA8zo1WQqo/xKh7UAIb9s1MlesW8kiO7i4?=
 =?us-ascii?Q?USLMHbrGGa6sLRftoCHBfO8HaJ6A/iJmAAWYdEgrPS7+bSdSDj4rM9ZS+VgH?=
 =?us-ascii?Q?Et5cGw3Nx4ZYoO6UuAXo9BJbyat2VoRkdMw/f0f67j3KuVnX4bVfwaYbPdle?=
 =?us-ascii?Q?5pMIpnyMeytAYPWtePGs9QenkU7yAQctMH0Ki8U8nXCZtD1mLp0Pb65UA1Lv?=
 =?us-ascii?Q?Kh+6KiaI7MZcxvApt6F+v9frqcdemTtCg5syoT2BQlixdW5s5R/V9HIDHal5?=
 =?us-ascii?Q?wSW6p+lIkpetSMHxrtNe+Jb0hD4XJW8YHcKEWK1bwiXnHbdWBXR1ssgBR+bl?=
 =?us-ascii?Q?Qdy5LLX/RlnKRAfmvLyaPyHcbal6+xv/9vqou1MvBNuEvbOw5VhRMfKtMI5f?=
 =?us-ascii?Q?oGoyllaXkA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651cc4bc-6d7c-4f1a-2edd-08da1d858223
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 19:40:47.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wHM0Eaj35CkCioMPWuZDW+BUZlWRViiDerR4jVAV/9APYvybOTr+ENTaX/xryUFH+OcFLqEXoAORE89VonmWsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 13, 2022 at 06:19:11PM +0200, Borislav Petkov wrote:

...

>  static void __mcheck_cpu_init_generic(void)
>  {
> -	enum mcp_flags m_fl = 0;
> -	mce_banks_t all_banks;
>  	u64 cap;
>  
> -	if (!mca_cfg.bootlog)
> -		m_fl = MCP_DONTLOG;
> -
> -	/*
> -	 * Log the machine checks left over from the previous reset. Log them
> -	 * only, do not start processing them. That will happen in mcheck_late_init()
> -	 * when all consumers have been registered on the notifier chain.
> -	 */
> -	bitmap_fill(all_banks, MAX_NR_BANKS);
> -	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
> -
>  	cr4_set_bits(X86_CR4_MCE);

I think the init logic breaks here. MCE now gets enabled before clearing old
errors. So it's possible that the old errors get overwritten by new ones.

>  
>  	rdmsrl(MSR_IA32_MCG_CAP, cap);
> @@ -1754,36 +1738,22 @@ static void __mcheck_cpu_init_generic(void)
>  		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
>  }
>  
> -static void __mcheck_cpu_init_clear_banks(void)
> +static void __mcheck_cpu_init_prepare_banks(void)
>  {
>  	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> +	mce_banks_t all_banks;
> +	u64 msrval;
>  	int i;
>  
> -	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
> -		struct mce_bank *b = &mce_banks[i];
> -
> -		if (!b->init)
> -			continue;
> -		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
> -		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
> +	/*
> +	 * Log the machine checks left over from the previous reset. Log them
> +	 * only, do not start processing them. That will happen in mcheck_late_init()
> +	 * when all consumers have been registered on the notifier chain.
> +	 */
> +	if (mca_cfg.bootlog) {
> +		bitmap_fill(all_banks, MAX_NR_BANKS);
> +		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
>  	}
> -}
> -
> -/*
> - * Do a final check to see if there are any unused/RAZ banks.
> - *
> - * This must be done after the banks have been initialized and any quirks have
> - * been applied.
> - *
> - * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
> - * Otherwise, a user who disables a bank will not be able to re-enable it
> - * without a system reboot.
> - */
> -static void __mcheck_cpu_check_banks(void)
> -{
> -	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
> -	u64 msrval;
> -	int i;
>  
>  	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
>  		struct mce_bank *b = &mce_banks[i];
> @@ -1791,6 +1761,9 @@ static void __mcheck_cpu_check_banks(void)
>  		if (!b->init)
>  			continue;
>  
> +		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
> +		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);

Same idea here. STATUS should be cleared before turning on reporting in a bank
using MCA_CTL.

> +
>  		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
>  		b->init = !!msrval;
>  	}
> @@ -2158,8 +2131,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
>  	__mcheck_cpu_init_early(c);
>  	__mcheck_cpu_init_generic();
>  	__mcheck_cpu_init_vendor(c);
> -	__mcheck_cpu_init_clear_banks();
> -	__mcheck_cpu_check_banks();
> +	__mcheck_cpu_init_prepare_banks();

I think moving __mcheck_cpu_init_generic() after
__mcheck_cpu_init_prepare_banks() and swapping the MCA_STATUS and MCA_CTL
writes above would be correct.

In summary:
1) __mcheck_cpu_init_vendor()
2) __mcheck_cpu_init_prepare_banks()
  a) Read and clear MCA_STATUS.
  b) Initialize MCA_CTL.
3) __mcheck_cpu_init_generic()

I realize this is still different than the original flow. But it seems to
maintain the goal of this patch. And it actually matches the AMD documentation
more closely than the original flow.

One downside though is that the system goes longer with CR4.MCE cleared. So
there's greater risk of encountering a shutdown due to a machine check error.

Thanks,
Yazen
