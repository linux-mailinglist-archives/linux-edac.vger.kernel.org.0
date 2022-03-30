Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0214ECDA0
	for <lists+linux-edac@lfdr.de>; Wed, 30 Mar 2022 22:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350873AbiC3UEC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Mar 2022 16:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350844AbiC3UD6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 30 Mar 2022 16:03:58 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF34091B;
        Wed, 30 Mar 2022 13:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM6IelgVe1dTWSCBOYiLgq7afJEHaavXwP/LNY+9vfRcaD/h3Cu8JDFIYkxhy6BjQSDG3wMSHHpJsXFkKw7HUEhB2hObKCzB5sEvvB4J5iWdXyUrdKlD9CFxgJ+K4S3VDv/+Src1HcsegZX205dZZ9BYXJBk1ZnFgi2gdRj90ApeVhncXoszqJI3WWySw0U8O72YqSWss7x7fNjnH5PyCnvclO67ywz+4qQ9cD6BlBY5GmRzEBsCNhTT5viiuk3qRO9p4mebrgiEhCcJAvUVr35MgrWNW/ovoxoX/5EtB1CgtrzhTH7dOPgLkWmUpUKqXQ+KiAT5tF/tQNMAszsofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rY+hiDCPfvF8rN5nPoN8G7nPxYihft4UY/voxKaneM=;
 b=XNzDapRVhoN9xfC/uzb+BAZIMj1BMrBIco7320i/+pDB6uMOkRa0+AU093ieT2MGeG4KFUi0N5qB/gs5FPhbfmq9tF3t+tdqn+oVjc39dA4uCo5XGWKzeB5M6I+s223G6cMTGpo0MIN9zKxRUSBl8m0rkxz8VkWtIbHCzu4VwvymWXGl3paf5L1S/G34/AVyLpbObOCXeluFjkOtbbEBi2u4RJWrJaSV5l16y/v3e74fSgjGqwz8rhM7ivUGNQ/0BsVrAANQrG4ice+OPpST82WZQeuLQfwoDhOikumH6s2c8l+a0wOi2ZZ8KRkrJ+jv1WPhIfPfIrtojxofAySKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rY+hiDCPfvF8rN5nPoN8G7nPxYihft4UY/voxKaneM=;
 b=xekPBBlx8f30ZMIRkRzm8L8YEVbHzRRZOu8xEyIvcDcEz9xPha57kQbqMkt9o856lbyjFEOAJamXyKQf1uPFt+zKM2XBdTrFCOjpmHFBDlrGR5O56upx4rVThO5unV8HGHKZ59zaaD44WcAYOF7CysCpuNyf8d8tZU3VXLfZLYM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN7PR12MB2643.namprd12.prod.outlook.com (2603:10b6:408:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.18; Wed, 30 Mar
 2022 20:02:10 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::6589:ebfc:1f11:3df0%5]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 20:02:10 +0000
Date:   Wed, 30 Mar 2022 20:02:01 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH 1/2] x86/mce: Extend AMD severity grading function with
 new types of errors
Message-ID: <YkS3OYMrWJEyZsnb@yaz-ubuntu>
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
 <20220328134131.736572-2-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328134131.736572-2-carlos.bilbao@amd.com>
X-ClientProxiedBy: MN2PR19CA0034.namprd19.prod.outlook.com
 (2603:10b6:208:178::47) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae7bb170-5cbb-4376-3718-08da12882c98
X-MS-TrafficTypeDiagnostic: BN7PR12MB2643:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2643AC76CBBB4B9999D7F34EF81F9@BN7PR12MB2643.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIW7ltLRacMA0A2GyZiCgKSKGkC9YhBKelCxQvsBFYOh8IdvWQ2rfFUx4zqO0vNQ+KVtOgz4lrbP1aD5UiB3nD6u9oWmmutMlu281Nein7aYAjc84wKeSn4OdiNRK5oSiGvCouRdEEogPLkIvDYiWSug+TDRwHYnBrbsgyPwDX+E5w7nL8hKqKiC4WA1PyHWzgo4zuQ0Cspls1Gaursb+pG11BK91q1vYt9CZEtvIGlD3V26jJiXPDz7l9+F3rAIK1t+3VQG7Qk4UreOttYLChKH9VMjlOjZQ3YsGNNdo3F6A52fT+UdBhLvPOavIKahQv7YQvk6XNiVczfc2w6wPDwHc3NstIZG1jb8a1UGF+mEnmseI63WPwyhEpio2BzKR3BUMGz3q+KNRBQWx1FPzuhhTECeTVVy1/dKlntTXd+Ka4gxktb+Cb2aQpiW3sjbufRCzCLGxfhy4Qpi7VPYnM+jFsHCEGuRAWjedlw83Iww9CFHqA/ok1T7jJrTkEKm6pWZgBrQQfs69uD0rHQoiDWhTR8F3cIwkVTvwFzswgShfEgogIp8EdXb8HqVz10JAt5wwyDeS8zPBGh0UsEjk01uvUKqRtVxkah4k9y7ZD3fG6sxBgXekY74c/3J3TUFd4L+3umRpSOhW2f/QJj6FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(44832011)(186003)(26005)(6512007)(9686003)(6506007)(316002)(6636002)(6666004)(8936002)(508600001)(86362001)(6486002)(6862004)(33716001)(2906002)(8676002)(4326008)(83380400001)(38100700002)(66556008)(66946007)(66476007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8h0vJz4ASCnCNqf/8ySe+oRnRu16d8WUEvSzkebKxdEV2c0JMnErPRzF7vHf?=
 =?us-ascii?Q?xd3JGs7aESfyg3rNM0pUXH98kF/Vnigrf2O2kw13zO6Tm64B3KAngb0RAaZe?=
 =?us-ascii?Q?CHJRejnJKCbtoJQ2qLSqX2TgivdZ8SqAk2prs+dcRXFWWyY6SxvGE20yUtnb?=
 =?us-ascii?Q?X0M5M5rmGVGMAiE8wiSHEi5POiYbRAVTGyy6jo55upQ8/xu8btIp6MKN4Sqa?=
 =?us-ascii?Q?XnQgjJ/T08JtwQYQWSNr6RPeJzyIzfteP5T/Aas2jY+C24bCtcrkUJQ+VOnH?=
 =?us-ascii?Q?gAYgey5wsT64ve8DNhM3VpacZmrc7FPCT8yFPm/46QREWiVzCugIX6UzGo9h?=
 =?us-ascii?Q?tSJrXM2niNXNVlvirXZboXjnjvdqhfzx/Cgmv3eU5z7aHBSUC9fyKqfibr9R?=
 =?us-ascii?Q?E5cuOOuqa4tS260fAdqGYMJpmI7XXC/rlVaOnOQQNegurHxKddRns6aT8nkq?=
 =?us-ascii?Q?iTy0WMewKhrMXAAD61OEReoPIMqdsK81zH4YLrQaE7rhV5wDH71D8NvNc7/j?=
 =?us-ascii?Q?3P9ukXmKsfVnngxidLo3n+RqawQ1wUksLEBqK3J4lsD2v96fHfVTZIKdD4vW?=
 =?us-ascii?Q?RfZhSVqip70sDagFobBZ8gPdzmHmhdB+TwHbgm/9sXkD6LWv/pMSp4v5OnsB?=
 =?us-ascii?Q?W9kCz1KioDdkUw8Y7KV2U+Jy2bxgHxy5Cx9ptu1QQzZz3dfQW3ku4NpmBX6+?=
 =?us-ascii?Q?BtFZym/x0jKrNsx4qdYM4wSqXBqwThJSfH8SyOe1PzgSEmxgtnszir2Mz1E6?=
 =?us-ascii?Q?qyAo+Z0888yj0FGsC/3ECyp3lyhGcIawtAGYiA6eKyFQMxrRLbccziLZw6jV?=
 =?us-ascii?Q?IKkE6L8qjpDGUEbz7HULJ3qM2BoCyQNUxVIqVv14k2IYorUUnA3TG38JaEih?=
 =?us-ascii?Q?raBKEpT0naCbzbrb0LZRnWQnO5eHBSNxBE9z7cEHd7//jJH4OJ4sSSkR7Z44?=
 =?us-ascii?Q?j0tuBKtT6Hl7TPNiy2IQqBcF8B0zcFYzDviJImGTcc3b7fF38auOgYM1XEsl?=
 =?us-ascii?Q?hbkYZr6KvJR7tYpJR+wimJpyc/bWauA2Hb/CpNI6kxmq8YoMmGRD6jw6+MsB?=
 =?us-ascii?Q?GMxQMqTjY/RlszAhT/9jMbP3Gm4go3hU2UZvxul1Bdy6q8K7IuZ76afJRZdz?=
 =?us-ascii?Q?KQ8BAUnTG7TuoC3tDuBbKY3+oDL2ML754BKXIZk8XX4BYf60I/vb2TlsR+SE?=
 =?us-ascii?Q?M2m/spPjZfyTKrzCL0L3u34pFT6U08anVqzt0tD6ZRvvP3dJAAAqn2couM+F?=
 =?us-ascii?Q?IBbp2f4/08IJHyXvGF7wIzYFXN7pY8Yo0j3wBfn+Ae4q0Tlg6VecqN7cxYd2?=
 =?us-ascii?Q?7ktZS7Lcc+fx30H5SEt16OT3t58kAgLExzwPr/2T2q+BODxulSwZuBV1TxZM?=
 =?us-ascii?Q?bhaiNjl3pg5w+tsbMC9zfhdpfdGvOv0J3S3wUMI/xx5TU8SjJ4mbQ1q6+qE4?=
 =?us-ascii?Q?rruAHypPwxHB7jJWtZOVnMTfLgM69ltLn8xlCQuEERmi8cUqdc/HN3FTd9A8?=
 =?us-ascii?Q?2m8hzaiWcvNlz+OoofQAc+EdfiFc0MGEWjCyB3+3lzXN1dvUHkLF525bMj4v?=
 =?us-ascii?Q?+O/1A4AQJoLCyn/Ey0fx0mv1hHuHJyKmUHBg4CT+eyUiKlWlHvik6MIsd/uK?=
 =?us-ascii?Q?V205eUoPtaLrTzIScOKE44BePNsDX4S3KZBbP72M5sVpd8jezq1/sPxlxAF7?=
 =?us-ascii?Q?SyiWLKycp53EbAyElaJ2ghNrHmJjfFCWtRwkMW1eYxSZQBeXG/1y0ZMRfwux?=
 =?us-ascii?Q?KTctke63Nw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7bb170-5cbb-4376-3718-08da12882c98
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 20:02:10.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28rvx4gjt0Sdt3U439mrcV2CJGXTILaU2tBviFwsVSTW56RauZsj7B5m5eDp/9Mu66Aqvw2IXhNssD3rPYESkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 28, 2022 at 08:41:32AM -0500, Carlos Bilbao wrote:
> The MCE handler needs to understand the severity of the machine errors to
> act accordingly. In the case of AMD, very few errors are covered in the
> grading logic.
> 
> Extend the MCEs severity grading of AMD to cover new types of machine
> errors.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  arch/x86/include/asm/mce.h         |   6 +
>  arch/x86/kernel/cpu/mce/severity.c | 180 +++++++++++++++++++++++------
>  2 files changed, 150 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cc73061e7255..6b1ef40f8580 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -50,6 +50,12 @@
>  #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
>  #define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
>  
> +/* AMD Error codes from PPR(s) section 3.1 Machine Check Architecture */
> +#define ERRORCODE_T_MSK GENMASK(3, 2) /* Mask for transaction type bits */
> +#define ERRORCODE_M_MSK GENMASK(7, 4) /* Mask for memory transaction type */
> +#define ERRORCODE_T_DATA  0x4  /* Transaction type of error is Data */
> +#define ERRORCODE_M_FETCH 0x50 /* Memory transaction type of error is Instruction Fetch */
> +
>  /*
>   * McaX field if set indicates a given bank supports MCA extensions:
>   *  - Deferred error interrupt type is specifiable by bank.
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index 1add86935349..4a089e9dbbaf 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -327,59 +327,167 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
>  }
>  
>  /*
> - * See AMD Error Scope Hierarchy table in a newer BKDG. For example
> - * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
> + * Evaluate the severity of an overflow error for AMD systems, dependent on
> + * the recoverity features available.
>   */
> -static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
> +static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
>  {
> -	enum context ctx = error_context(m, regs);
> +	int ret;
>  
> -	/* Processor Context Corrupt, no need to fumble too much, die! */
> -	if (m->status & MCI_STATUS_PCC)
> +	/*
> +	 * On older systems where overflow_recov flag is not present, we
> +	 * should simply panic if an error overflow occurs. If
> +	 * overflow_recov flag is present and set, then software can try
> +	 * to at least kill process to prolong system operation.
> +	 */
> +	if (mce_flags.overflow_recov) {
> +		if (mce_flags.smca) {
> +			ret = mce_severity_amd_smca(m, ctx);
> +		} else {
> +			/* kill current process */
> +			ret = MCE_AR_SEVERITY;
> +		}
> +		return ret;
> +	}
> +
> +	/* at least one error was not logged */
> +	if (m->status & MCI_STATUS_OVER)
>  		return MCE_PANIC_SEVERITY;
>  
> -	if (m->status & MCI_STATUS_UC) {
> +	/*
> +	 * For any other case, return MCE_UC_SEVERITY so that we log the
> +	 * error and exit #MC handler.
> +	 */
> +	return MCE_UC_SEVERITY;
> +}
>  
> -		if (ctx == IN_KERNEL)
> -			return MCE_PANIC_SEVERITY;
> +/*
> + * See AMD PPR(s) section 3.1 Machine Check Architecture
> + */
> +static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
> +{
> +	enum context ctx = error_context(m, regs);
> +	int ret;
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
> +	/*
> +	 * Default return values. The poll handler catches these and passes
> +	 * responsibility of decoding them to EDAC
> +	 */
> +	ret = MCE_KEEP_SEVERITY;
>  
> -			/* kill current process */
> -			return MCE_AR_SEVERITY;
> -		} else {
> -			/* at least one error was not logged */
> -			if (m->status & MCI_STATUS_OVER)
> -				return MCE_PANIC_SEVERITY;
> +	/*
> +	 * Evaluate the severity of deferred errors for AMD systems, for which only
> +	 * scrub error is interesting to notify an action requirement.
> +	 */
> +	if (m->status & MCI_STATUS_DEFERRED) {
> +		if (m->status & MCI_STATUS_SCRUB)

Multi-line if-else statements should have braces. This is true even for
conditions with a single line. This is a coding style point.

In other words, if all conditions are a single line, then no braces needed.
But if any of the conditions has multiple lines, then all conditions need
braces.

> +			ret = MCE_AR_SEVERITY;

This is wrong. Action required is for errors that need to be handled
immediately and where recovery is possible, like a poison consumption
machine check exception.

Also, the SCRUB indicator does not contribute any new or interesting
information in terms of OS actions.

> +		else {
> +			/*
> +			 * deferred error: poll handler catches these and adds to mce_ring so
> +			 * memory-failure can take recovery actions.
> +			 */
> +			ret = MCE_DEFERRED_SEVERITY;
>  		}
> +		goto amd_severity;
> +	}
>  
> -		/*
> -		 * For any other case, return MCE_UC_SEVERITY so that we log the
> -		 * error and exit #MC handler.
> -		 */
> -		return MCE_UC_SEVERITY;
> +	/* If the UC bit is not set, the error has been corrected */
> +	if (!(m->status & MCI_STATUS_UC)) {
> +		ret = MCE_KEEP_SEVERITY;
> +		goto amd_severity;
>  	}
>  
>  	/*
> -	 * deferred error: poll handler catches these and adds to mce_ring so
> -	 * memory-failure can take recovery actions.
> +	 * Evaluate the severity of memory poison for AMD systems,
> +	 * depending on the context in which the MCE happened.
>  	 */
> -	if (m->status & MCI_STATUS_DEFERRED)
> -		return MCE_DEFERRED_SEVERITY;
> +	if (m->status & MCI_STATUS_POISON) {
> +		switch (ctx) {
> +		case IN_USER:
> +			ret = MCE_AR_SEVERITY;
> +			break;
> +		case IN_KERNEL_RECOV:
> +#ifdef CONFIG_MEMORY_FAILURE
> +			ret = MCE_AR_SEVERITY;
> +#else
> +			ret = MCE_PANIC_SEVERITY;
> +#endif
> +			break;
> +		case IN_KERNEL:
> +			ret = MCE_PANIC_SEVERITY;
> +			break;

Is this case needed if it's identical to the default?

> +		default:
> +			ret = MCE_PANIC_SEVERITY;
> +		}
> +
> +		goto amd_severity;
> +	}
> +
> +	/* Processor Context Corrupt, no need to fumble too much, die! */
> +	if (m->status & MCI_STATUS_PCC) {
> +		ret = MCE_PANIC_SEVERITY;
> +		goto amd_severity;
> +	}

This should be the first condition checked.

>  
>  	/*
> -	 * corrected error: poll handler catches these and passes responsibility
> -	 * of decoding the error to EDAC
> +	 * Evaluate the severity of data load error for AMD systems,
> +	 * depending on the context in which the MCE happened.
>  	 */
> -	return MCE_KEEP_SEVERITY;
> +	if ((m->status & ERRORCODE_T_MSK) == ERRORCODE_T_DATA) {

This information is not useful for determining severity.

> +		switch (ctx) {
> +		case IN_USER:
> +		case IN_KERNEL_RECOV:
> +			ret = MCE_AR_SEVERITY;
> +			break;
> +		case IN_KERNEL:
> +			ret = MCE_PANIC_SEVERITY;
> +			break;
> +		default:
> +			ret = MCE_PANIC_SEVERITY;
> +		}
> +
> +		goto amd_severity;
> +	}
> +
> +
> +	/*
> +	 * Evaluate the severity of an instruction fetch error for AMD systems,
> +	 * depending on the context in which the MCE happened.
> +	 */
> +	if ((m->status & ERRORCODE_M_MSK) == ERRORCODE_M_FETCH) {

This information is not useful for determining severity.

> +		switch (ctx) {
> +		case IN_USER:
> +			ret = MCE_AR_SEVERITY;
> +			break;
> +		case IN_KERNEL_RECOV:
> +#ifdef CONFIG_MEMORY_FAILURE
> +			ret = MCE_AR_SEVERITY;
> +#else
> +			ret = MCE_PANIC_SEVERITY;
> +#endif
> +			break;
> +		case IN_KERNEL:
> +			ret = MCE_PANIC_SEVERITY;
> +			break;
> +		default:
> +			ret = MCE_PANIC_SEVERITY;
> +		}
> +
> +		goto amd_severity;
> +	}
> +
> +	if (m->status & MCI_STATUS_OVER) {
> +		ret = mce_grade_overflow_amd(m, ctx);
> +		goto amd_severity;
> +	}

This condition should be checked earlier.

> +
> +	if (ctx == IN_KERNEL)
> +		ret = MCE_PANIC_SEVERITY;

This condition should be checked earlier. This would avoid the redundant
checks above.


Overall, the severity code should be audited and simplified first. Existing
cases should then be updated with useful information like messages. Finally,
new cases can be added if and only if they are unique, i.e. they're not
already covered by existing cases.

The current code already follows the hardware documentation for the most part.
Here's an example of how it can be simplified.

Pseudocode:

	if "PCC bit set"
		PANIC

	if "Deferred bit set"
		DEFERRED

	if "UC bit not set"
		KEEP

	if "Overflow recovery not supported" and "Overflow bit set"
		PANIC

	if "MCA recovery (SUCCOR) not supported"
		PANIC

	if "In kernel context"
		PANIC

	else
		AR


Notes:

1) The Deferred and !UC cases are moved up compared to documentation. It
looks like you had a similar idea. This saves an indentation level since all
the following cases are for uncorrectable errors.

2) The TCC check is not included. This is because TCC has a similar function
to RIPV|EIPV *. And the only use is in conjunction with "kernel context". So
this is redundant as "UC in kernel context" is a PANIC.

	* A TCC check can be done as an alternative to mc_recoverable(). But
	  let's not worry about that now.

3) There is no SMCA check. This is because SMCA is used only to determine if
the TCC bit *may* be defined.

So please do the code simplification in a first patch. Then add messages for
those existing cases in a second patch.

Thanks,
Yazen
