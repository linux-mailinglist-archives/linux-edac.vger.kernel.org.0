Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA224F539F
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbiDFEIY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572925AbiDERUz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 13:20:55 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B613E08;
        Tue,  5 Apr 2022 10:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmhqqmVxfwxH3AgJwL4V867hp5a/XC+ChYxhFGb/Te/C8SrAdLq/6j4s1ZJnE9vtiLrIYDr7MDe+1wfIj2InHQyLMRU9T98EEo0fQrIhztSQFrvK8Kk6mRqeM/J4QSUAOpjvQpnhc+qXdtmjRlO1wNKQLjCdq7S3ot50Cplr2lXyYufjWzh1mPwxRYp4f5MtjaszLwPbSIvSRJmRa5k66B/yfL407GCfQvJyBBIzYKDNIFf+zajaZ6MD1rRAjL5h5He8KO+mAf/k46SpytrpyYrg7pOpNN+ulvflawCV93pN97Z2Q9wtj3ipj+W86Svp0yAmOMXPjBC8TDF4TH8vJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhYzRqCc66sajwvMDJGLk9r5jVJAkigW8dFGt+3wlTo=;
 b=YL/CQwMkcqT0qSYNdXX9mo9otP2yrDK7WfXwa0IChMvDyZNxbxfEmkNwdU7pO7nvZIHj+YtFs+gd9VixoVDNXQ0i+eBJuC+RB1yBtJn56hDL2CyQZJrOEr7tdAPONHae92nxNU+Ll7MF0Wljo8d0p3m0k6mYOFCPToIYrzGgEM838VpffebErYNe4i+8ZEJfCGGw16NYG7PH1UJV4gEX7SN8uEFE5lkDxlMgpvTplfwuBQ1dImSYVf/BTNQhPsbOXsfuQ0dHs1VKtjr7Jfn4M8+al2i5SWty4hFBU0qZGJuX+bLFgwQleJZVntX29o63Nmh7OsPyXoWsnY6THjfn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhYzRqCc66sajwvMDJGLk9r5jVJAkigW8dFGt+3wlTo=;
 b=JXeHtKRBfEQggEZ17Isux8Jj4z+vwpI2GYrAprkCCoNW1r+0qnug/uP3jIKzlRNYU1b5vVCckfg4z8s8CITcinzPJuv1OgBvpasc7ffEy4xEWrw/Knm5uPb4c+M9rTY/QDe/KJE39bv9MToHeno5kyjgeEMFg7IJw8blnmThKDU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:18:51 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:18:51 +0000
Date:   Tue, 5 Apr 2022 17:18:45 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function
 with new types of errors
Message-ID: <Ykx59WvoWKi2y23x@yaz-ubuntu>
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-2-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331163849.6850-2-carlos.bilbao@amd.com>
X-ClientProxiedBy: BLAPR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:208:32d::23) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9d441a-b737-46ab-66d6-08da17285aa2
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4901C3C392009856A46DAF65F8E49@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHUslQiXn0Uw+tb5vLYxCdDJzIbqqZZg5KnpeQm66wfXDwqJNv6Obc+c6Vzzh8KsrzmWedzRGh7uYmVl/FvjdcpuqZcE5UQfYST5u2IRZbeyYZ29/L9Dw8v1GSN4K4tpNVpop7a3zs7Opskqm9StbDgDXAGlNR9sjNfDlXI8Is24BSxD9oL4OvGcRll4Nqj+XaPcQvFS1SB4tzv+uU3zGaQEp9MbpiU6Q/+hcdrqXf95OhEUlxc79yyyLiCvyN6GB3Sy7P3Paq45quNu+AgJKVbVwAL8siE2fsdqVUXp4XAOX08gP3/Z9IIpMvlm0L+LjUSu8dePJuJmrrlmo3fdvTYiVu2xBlmX5MfNerqyP1/y06kFilH1jm1vZpafgU9z8bCt9G0p9UcuYI9D5G/mJ1Rqpfx68KmZDPpJh0dr84B7Wdbyyb3Iq1DMBOquugy8Lk1Jx0anT5QFJ84e034fKjYzifFMqe59eQ95bgiwaI1po9q6+dgoNielDYdVTK6hE622DGNT4yJdqo2KIxTnvV/d6l0LjHoa0VwJXeFBUQqGQs8R0fShbk6zT0xHpFAsAUo3hwvqRb/aw17w5gSKtHQr7pmSK0Gma+cKvgzXVnWcfIFq4bi++IcjQx/Ejowshl7hezbkX0CVYhK+bSbGpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6486002)(38100700002)(186003)(26005)(316002)(44832011)(86362001)(8936002)(508600001)(2906002)(6506007)(6636002)(9686003)(6512007)(6666004)(5660300002)(66946007)(66476007)(66556008)(8676002)(83380400001)(4326008)(33716001)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lz7XB8NCcHW0vYZtX1TCwyW6Vu1hCc5/v4hmUzB01uVAmuGgXLAz/F1wjmk4?=
 =?us-ascii?Q?bt2yk7423yp0zEEcpjO1ryN/qf0l9Q4gA9KOWV+aExX9/0bipHAYSm6y0eT2?=
 =?us-ascii?Q?+wmkGJvvKfgucM2tGrMbz5urbCMzrQhgWda8tJa328cOhuDusizevVO0ZjYE?=
 =?us-ascii?Q?kPXEy62VevUi7BpE/iH9GvgMqe/F9t6QKIfLqaRqAobByynU+j1vbENoNiOl?=
 =?us-ascii?Q?TAav6QuZBPp1x2actGjQG3sIoBnnp5JFO3pTjIwtDccub0A5rbI7cfMYmOjf?=
 =?us-ascii?Q?Z8k2cuSdg2Cd2ZZCiaKuk8ekD1IAlglPpsZdbGZrOcBTIxUncAY0j6UQKHno?=
 =?us-ascii?Q?ltQPrjlT8DngNm0jdeneoh5MlsyYCPppF5socmPQCG+8LvQMVhW520tePok5?=
 =?us-ascii?Q?+tFODJJAZmEt1D+cKcDHb0tswnSg1lCG8oVxUU1XLt2xlYlgQBS/oObiNuAk?=
 =?us-ascii?Q?KygN7b+EkZBg1YzAkmt0RbW3krG23AqD0p8e4ZkrAf3HTBGVWy5v7kUGFEIp?=
 =?us-ascii?Q?fzwfKZDwAX9eFy61F+yMwaiMFG11uzrvJb6A4BbF6UKxKeH/2OGAzKQ/CrI4?=
 =?us-ascii?Q?sJqDKpM4VDqeVCnXmLHq/FgNrDm65dVQeGaLjrDmDiaKfO4rW8Tax4gUH2Sm?=
 =?us-ascii?Q?O51aI1IbO2TGs47Tm/HSgwLVzsYuAIMf+D9+dKcoaGocc/BYlW2BIK/9ywdZ?=
 =?us-ascii?Q?nlR6mNZlqSwzr4vEuooxV9IDWMdLqCnnvZgDFg1OYCM9GS+8+bWiu1p0xveh?=
 =?us-ascii?Q?tAT1lGaCuB+ngaFl1xRJ6EMhGqCok7S/AGe763SJRwt8lRpY3BqPThh30x2b?=
 =?us-ascii?Q?w2Ubdz8qF5CoFH9kcXHADbbsGfE0fEvXMozVJqXQMXV4vuHCfqoXSMTCzCQJ?=
 =?us-ascii?Q?l8yBRVRsdeCX0gUgbctrgIkj1mfXSW+hZki2jwSLvkik2O9KxKdyXPYbk5ZA?=
 =?us-ascii?Q?EjWeTbxClExaolgJf94jduPV8MPla4W31Unm36roXj/+kcRcm+1boY1dXVtH?=
 =?us-ascii?Q?d6inuqQ43Y3P4bA9428WO39EP3QqPM5ZylBLzEDLpUCmmzwxjEoBwyf+HctB?=
 =?us-ascii?Q?oxIgcapT2ypuyse1+S7/1wrSpoXOOhzEZa/7E7BuHMsUKy+Kw3vAfodcqOlo?=
 =?us-ascii?Q?pc8L7vvSTmgFdM1HqrnX86uoXH/F1knQ9w9L4B1ohcocsO5MHStEKsik8C6j?=
 =?us-ascii?Q?OqCFVekWbSJeQQ8tty/E9ncrM/vO9pnSPORPaZfXcDjt7j5RpENeQ3jNQxNH?=
 =?us-ascii?Q?cCCHFNKFDv0WuBi12ihUbdGyxJGpkTn2xVV+1aD/F0GCuGfhkA5mvloxFFof?=
 =?us-ascii?Q?ndIbWuD3eJbaDCLth4Fc94dbARAtebmGP+HmTPOnJt4rFYc5peVb+y6rzI9i?=
 =?us-ascii?Q?vv2nFd3eTAAwZeTk8rwam/hE28pOkb2WJ4QQJHes53f/EzV8e8U+9uvtb/32?=
 =?us-ascii?Q?U5UebJxc2u8CH+Xj27k4n4xJkL8RbBuDdswJdrk5ccu+3Ho1w0HJwMdH+WDM?=
 =?us-ascii?Q?hD7luuIap7OiNv3X6Yf6eQ6sfJ3TErvGyA2F/q9LaWApzL4bDbyD5CfvwfoN?=
 =?us-ascii?Q?V70y/7X6yUbGpWy97Mm1NgczxuUbrWD1SxxHNMxcONyb+wc4LFd0NOtTX+bQ?=
 =?us-ascii?Q?ce9Y0zqBLU6MxEBIwPcY0SdcGr1SWyjO3mttp80UX4LDa7NEMKbIzDqkiczd?=
 =?us-ascii?Q?2zK4B9kCBzrrn0k2JLrLhBQTHioAtbfnfJ9yIxXbD7VCf4qGRz5aydT9uN+0?=
 =?us-ascii?Q?evgosYcXoA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9d441a-b737-46ab-66d6-08da17285aa2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:18:51.5100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5+ZnXHsNhrMNNAxIA9ZzseZDGfY5oSWiF7GA/M+yhr8RKyYKnyGJPzNFtiV73hntqs7tzV1LazBPlWevHqLZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 11:38:49AM -0500, Carlos Bilbao wrote:
> The MCE handler needs to understand the severity of the machine errors to
> act accordingly. In the case of AMD, very few errors are covered in the
> grading logic.
> 
> Extend the MCEs severity grading of AMD to cover new types of machine
> errors.
>

This patch does not add new types of machine errors. Please update the commit
message (and cover letter) to be consistent with changes made between patch
revisions.
 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  arch/x86/kernel/cpu/mce/severity.c | 104 ++++++++++-------------------
>  1 file changed, 37 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index 1add86935349..4d52eef21230 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -301,85 +301,55 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>  	}
>  }
>  
> -static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
> -{
> -	u64 mcx_cfg;
> -
> -	/*
> -	 * We need to look at the following bits:
> -	 * - "succor" bit (data poisoning support), and
> -	 * - TCC bit (Task Context Corrupt)
> -	 * in MCi_STATUS to determine error severity.
> -	 */
> -	if (!mce_flags.succor)
> -		return MCE_PANIC_SEVERITY;
> -
> -	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
> -
> -	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
> -	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
> -	    (m->status & MCI_STATUS_TCC) &&
> -	    (err_ctx == IN_KERNEL))
> -		return MCE_PANIC_SEVERITY;
> -
> -	 /* ...otherwise invoke hwpoison handler. */
> -	return MCE_AR_SEVERITY;
> -}
> -
>  /*
> - * See AMD Error Scope Hierarchy table in a newer BKDG. For example
> - * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
> + * See AMD PPR(s) section 3.1 Machine Check Architecture

I don't know that section numbers will be consistent between different PPR
versions, so having the section name is a good idea. The "Machine Check Error
Handling" section is what the severity grading function is based on.

>   */
>  static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
>  {
> -	enum context ctx = error_context(m, regs);
> +	int ret;
> +
> +	/*
> +	 * Default return value: Action required, the error must be handled
> +	 * immediately.
> +	 */
> +	ret = MCE_AR_SEVERITY;
>  
>  	/* Processor Context Corrupt, no need to fumble too much, die! */
> -	if (m->status & MCI_STATUS_PCC)
> -		return MCE_PANIC_SEVERITY;
> +	if (m->status & MCI_STATUS_PCC) {
> +		ret = MCE_PANIC_SEVERITY;
> +		goto amd_severity;
> +	}
>  
> -	if (m->status & MCI_STATUS_UC) {
> +	/*
> +	 * Evaluate the severity of deferred errors for AMD systems, for which only
> +	 * scrub error is interesting to notify an action requirement. The poll
> +	 * handler catches deferred errors and adds to mce_ring so memorty-failure
> +	 * can take recovery actions.
> +	 */

I think this whole comment can be dropped. The "scrub error" part is not
correct. The polling function may find deferred errors, but they are most
likely to be see by the deferred error interrupt handler on modern AMD
systems. The "mce_ring" was removed a long time ago (in v4.3).

> +	if (m->status & MCI_STATUS_DEFERRED) {
> +		ret = MCE_DEFERRED_SEVERITY;
> +		goto amd_severity;
> +	}
>  
> -		if (ctx == IN_KERNEL)
> -			return MCE_PANIC_SEVERITY;
> +	/* If the UC bit is not set, the error has been corrected */

This comment is not true. Deferred errors are an example of an uncorrectable
error where UC is not set.

> +	if (!(m->status & MCI_STATUS_UC)) {
> +		ret = MCE_KEEP_SEVERITY;
> +		goto amd_severity;
> +	}
>  
> -		/*
> -		 * On older systems where overflow_recov flag is not present, we
> -		 * should simply panic if an error overflow occurs. If
> -		 * overflow_recov flag is present and set, then software can try
> -		 * to at least kill process to prolong system operation.
> -		 */
> -		if (mce_flags.overflow_recov) {
> -			if (mce_flags.smca)
> -				return mce_severity_amd_smca(m, ctx);
> -
> -			/* kill current process */
> -			return MCE_AR_SEVERITY;
> -		} else {
> -			/* at least one error was not logged */
> -			if (m->status & MCI_STATUS_OVER)
> -				return MCE_PANIC_SEVERITY;
> -		}
> -
> -		/*
> -		 * For any other case, return MCE_UC_SEVERITY so that we log the
> -		 * error and exit #MC handler.
> -		 */
> -		return MCE_UC_SEVERITY;
> +	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
> +	     || !mce_flags.succor) {

I appreciate merged two cases together that have the same result. But I feel
keeping them separate may be easier to follow. They can also each have their
own code comments. Or keep them together and explain each within the same
comment block.

Also, there's a checkpatch "CHECK" here. You'll see it when using the
"--strict" flag with checkpatch.

> +		ret = MCE_PANIC_SEVERITY;
> +		goto amd_severity;
>  	}
>  
> -	/*
> -	 * deferred error: poll handler catches these and adds to mce_ring so
> -	 * memory-failure can take recovery actions.
> -	 */
> -	if (m->status & MCI_STATUS_DEFERRED)
> -		return MCE_DEFERRED_SEVERITY;
> +	if (error_context(m, regs) == IN_KERNEL) {
> +		ret = MCE_PANIC_SEVERITY;
> +	}

Braces aren't needed here. The previous comment about braces was for when
there's a block of "if/else-if/else" statements. A single "if" statement with
a single line doesn't need braces.

>  
> -	/*
> -	 * corrected error: poll handler catches these and passes responsibility
> -	 * of decoding the error to EDAC
> -	 */
> -	return MCE_KEEP_SEVERITY;
> +amd_severity:

This label doesn't look right to me. Maybe I'm too used to seeing "out" and
"err" labels.

Please see "Documentation/process/coding-style.rst" section (7) "Centralized
exiting of functions".

Maybe something like "out_ret_severity" to indicate the code is going to exit
and return the severity. Or maybe just use "out"? Maybe others have thoughts
on this.

Thanks,
Yazen
