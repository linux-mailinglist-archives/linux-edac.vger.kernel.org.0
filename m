Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488F4F5384
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiDFEG7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572988AbiDERlD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 13:41:03 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DBAB91A9;
        Tue,  5 Apr 2022 10:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDDewTOwxkkDnWKE85xJ1Hxqw27rtbMuSrjCvlyeTvVd1PrGhNUSg8+sqQZBrnNmaUOw7Kr3mNosS8TGoIyyZQQT14rFICTn+zlRCqYYqMEQxZHun16KebI9/G9J1JVf2cuojXzLsZ3NpR7E16xcZA2U/Kwrh5mc90zIEv9R21pPUQmw+Is7li7Mp0iNlafuk36nGYuG9mp9K5WnkbDxJqqwNxL3HojV2quobcaahLKGdKLGwxEgIzbubNFog//ZkR81zxzMF0PacCWhyQUP+k7pPUOyRctdu3vG0ipIPQdANnPARlWX+I6Z/VNQTXxwHyL/Ewk0704m3rXp6+Q6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grgU7SAGCr5pUr4X/HfT+ylw87P1MnbK7ZvY7HY1ILg=;
 b=LXxHi6xmP3VyUqFrvqq5aZylvmp78sFK4jOtioBh112mVMHajtSFPQW3XwLMeXdeNlpajcYULzt7/euNsMIkqPjRGMvXDfxbt98RWz6iCI2Lh8BnbHkVVh5HV8hxabBBwBZ0P5ZchUr4YKsZEu6OBl5FhTOXKmDn1khStpCg3Kld20WaJzVxsgSB9FSoYYsypPgARvviHg0k8g6+yYSplgSw0fvgr3/IWPNv3G97f6psxHVX/VZOeIIeOLSPnU2VOGXE8PE/0xz8OrnKvXSxLW8IMz4gQXg23Jfqju/Nl5SgkT/iNQlxC0L8s+lVrfYPu1P0FSpcoqrs9YGm5/4iWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grgU7SAGCr5pUr4X/HfT+ylw87P1MnbK7ZvY7HY1ILg=;
 b=c02lpARcJn5U036HQmqskHPXB1uLu9YPnhP1YIeTbIE4TAoJFmKNuIsSa6Ot3PajUlVtUjTyUsFW44UdgsSzQZ66btm5jEVr5fM3V/igeUt7G8dgDdXKx/vxymEjOYYyWLxobj4/b0hgCh6WgRa/mdV1dEES5BcP0SjwsTONmBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by DM6PR12MB3226.namprd12.prod.outlook.com (2603:10b6:5:186::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 17:39:02 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a941:fe42:23a5:c501%3]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 17:39:02 +0000
Date:   Tue, 5 Apr 2022 17:38:59 +0000
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine
 errors on AMD's MCEs grading
Message-ID: <Ykx+swi/SBjaEzLq@yaz-ubuntu>
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
 <20220331163849.6850-3-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331163849.6850-3-carlos.bilbao@amd.com>
X-ClientProxiedBy: MN2PR18CA0020.namprd18.prod.outlook.com
 (2603:10b6:208:23c::25) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 026e821a-cb4d-46c7-45b5-08da172b2c64
X-MS-TrafficTypeDiagnostic: DM6PR12MB3226:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB32265C9921CEEB5C471159AAF8E49@DM6PR12MB3226.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIJsbqjxtI0Eo/j6uJ3X1E4/tw0brr27t8QHS9UgYpgdWZuxVTGW1CFhCKxSIJVdfZWuWWAEXarViG8jX6qPqSMdXRv8rbgVCpQd+qXVbzWqL5hmf2NGk1bpmMiVPVPdku2WMoVerW1USlAC4nFTf0Hf86Hi0SKkdyS80f+1l3RqZsEpk2dII4shf48+BamuNuJtceDHEv63jYEnXmPJe6s2Rg+4mXX715y6V6X2z6LczCtVn12e9qnvttD7ZsBdItu3XtBluktoYHMn1c4udrs8p/fX0JnfO+PBoQa1xuxyLqHr7xHsxDrCRXgvYMmP5hufcgrqwJjQz7PUPh81LgG+7YKQFnhA7nKJuz7R4zrnBlXDOMGyhjFSIgfkqRVdrvQmRUpfe1l8IHJQsdIL5wdnWmMhpncijW6IXaQ+kmKpIxw5BrGcUosiQAF7IRjwVYdsj9cfHEAiWQhBuKnb3lMlbbTYdwgKfDNkjoEv9qXcv50csu67V96dImcs1xfxvqqA2+4v1k5aOqjsXy//QzOZCzhdNyf4i0WAfHMsyt1ajve9Z80o8yw/DHxzuxn7GUGb1eArM6k7ljIuOQ9m64JmIgUT3crX9E7GGeLCV6cY9nPlarqIUet2tIb6JKR2kfgAMhL+JxPfj/Z1FS1e2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(44832011)(6506007)(8936002)(33716001)(38100700002)(6486002)(508600001)(66476007)(5660300002)(316002)(6862004)(6636002)(86362001)(26005)(6666004)(66946007)(66556008)(4326008)(186003)(8676002)(83380400001)(9686003)(2906002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1YVhyDev0ieWpFJB7fKcEsRr7BT67TQ0LpHBHZWGhfHBE6fafTXg9NxAv0Po?=
 =?us-ascii?Q?YcYVR3/bG8KhlMmQ89gu+4pR8x2E/8tINlKJWvAHDuU/3OWyv8MnJMkdZjjA?=
 =?us-ascii?Q?/jdx+TsZGVJz2Y0/Y6gkvG7EtIGyC9CBDOa8IA3AMTOOkDM8Ud5zPwvWQQRn?=
 =?us-ascii?Q?OhorgQrATkTxWWGPfUl/4FM9bsQOLA+PSjchNK9ijcd+93bx4MjePa0ekGbN?=
 =?us-ascii?Q?HZ0cPD7ti6DFa1HlfM3SA5o49hi+MuwnfWMr2J8byt7FDnC6gkFP2ED4ZbRy?=
 =?us-ascii?Q?KF/uSy/7mfiZmptRQwI5Dt8W8CMEXb1tDwujnh9/DDc0DyCir8F8S2h70Qvd?=
 =?us-ascii?Q?45gRP1mcAHFBHsrz55A0+ym455ga8z9J9ZGzgdHsjlz/1+GfjaU/97YvV3e3?=
 =?us-ascii?Q?i4Mm6FFz9MPAceYqYEdpZlEN5c9d3A6myssMFHYg/JCWIfQZ/d4gp4tYhi1v?=
 =?us-ascii?Q?oF8TW7x5cqq6A12K3h40CfD3D2DF5wDYiAZ7lLoH3ndq0xqcaED1ioWdaram?=
 =?us-ascii?Q?ny7ZGBq0ferkMMIQo4ecn2ggMCq/5rAMyp+VD4z1SVrM1SC9ixQlWCLF50iB?=
 =?us-ascii?Q?SOTyizq9iW7MoFmblovZxTaGrUZS5lbZVAtyZX1xiwxR3gaJBhA6umnDq1DQ?=
 =?us-ascii?Q?XIKMSitwu7EHqYQ9279icUxOrFBpHP9hYdAD0t4M3eXmFxBObNrqrd50ARCB?=
 =?us-ascii?Q?QSBPesWJWRvoq9xq+ejJNvprb3itWI/58zx+ZxVCDnwyV9Oip2G7WQt2bdxe?=
 =?us-ascii?Q?SmIsyk7tGq+6WfX45JC5kUrJU8PKimbgFAM0/vU/V5mAdAaOLdPmXd2lqs4F?=
 =?us-ascii?Q?PUjPp6q2/eKxkacfo4LAKP7dLA7yU/ngfBm6Ck+icrOBc/AuplobMDKcVmeu?=
 =?us-ascii?Q?RZkAgDktVQoWxW9sDSy06DnxZ+WcRVP7ibcE7+2b+bloGvbDZ959rGe9qqN1?=
 =?us-ascii?Q?/IckDMeHkbX+aXsIjjh0+LJEgAQ342RDB7pI2KrICYXwLoHiCyeIZkHWvqKq?=
 =?us-ascii?Q?R57mWnHW+3MH9lCXxd/1I6iPsiVEl+PWAzDdHGPOXRaJAv+OKz/riYp7r6ic?=
 =?us-ascii?Q?jnmoGksm91r5Uo1ZiDgjlP3ifxNgAmObF8nWiaeV5mMujI1mJoMzKviptj0Z?=
 =?us-ascii?Q?dcF+HY6p38SnyMrmpAS+ZZvM0dgBaKizDfAMlP7wytakrlbXMt9KoBt1K3rZ?=
 =?us-ascii?Q?B2thi3yx3KOzEKtBXkLDsex8UuVvvc8UCRDDRT/F4SNfCWtTrZU8Tu0/S6wO?=
 =?us-ascii?Q?mqneWDgBTtiDuvDoxSJcGVxrLxbGag+G0cM73iezw1DXmNHBreTblCpI9eKz?=
 =?us-ascii?Q?N99Rs00YMsuVlx7eNI82zrb393oa71Zra2HyQgHyMEFeUoY8yuIuy51C8A+u?=
 =?us-ascii?Q?XZJ/b20ubaCHO+p0YpWntxOD4suKL1IA6+PkywCoQIdM8TfAp7o5VHn2Vjrf?=
 =?us-ascii?Q?RvUNiBydQcQTukeTEN7oH/DVJ4JqipZFYm9s+wUiwDs/LYP5NOJ88jsgKHrm?=
 =?us-ascii?Q?BkuQwftGpmgX4mf+IkNY/ddwPjIr2VKVRb22WvY8oLJfEMj0UeNiLBDJv9kj?=
 =?us-ascii?Q?8V5Pp/tMq+BKbdVwZKx51lOTnnn9pZhK72b7T5jESvYO8yEMouPfCkAsMFZ7?=
 =?us-ascii?Q?3iX4IKkLIQzkXqTkFWUGkBVRK/YpPD+Yr7ij2bybH1t7Q0e+bwYSks6rqVR7?=
 =?us-ascii?Q?wU68ceRGumolI4ADBthneZLylhdLJNp1Z1JXRYeSWSY5CcKKO3EXwToRCgHV?=
 =?us-ascii?Q?/EykJZKStw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026e821a-cb4d-46c7-45b5-08da172b2c64
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 17:39:02.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLMCdZgI+xwpcJGufoGGDNzpuI7TUIZIBXPLWCnX+mDR5OkzQTl/IVUwrQHFclamDHqTqjAnZgEpSgEWzV8a9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 31, 2022 at 11:38:50AM -0500, Carlos Bilbao wrote:

...

>  static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
>  {
>  	int ret;
> +	char *panic_msg;

Order variable lines from longest to shortest.

And the pointer should be initiliazed to NULL like Mike said also.

>  
>  	/*
>  	 * Default return value: Action required, the error must be handled
> @@ -316,6 +317,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
>  
>  	/* Processor Context Corrupt, no need to fumble too much, die! */
>  	if (m->status & MCI_STATUS_PCC) {
> +		panic_msg = "Processor Context Corrupt";
>  		ret = MCE_PANIC_SEVERITY;
>  		goto amd_severity;
>  	}
> @@ -339,16 +341,21 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
>  
>  	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
>  	     || !mce_flags.succor) {
> +		panic_msg = "Uncorrected unrecoverable error";

So these two cases should definitely be separate. One is "Overflowed
uncorrected error without MCA Overflow Recovery", and the other is
"Uncorrected error without MCA Recovery".

>  		ret = MCE_PANIC_SEVERITY;
>  		goto amd_severity;
>  	}
>  
>  	if (error_context(m, regs) == IN_KERNEL) {
> +		panic_msg = "Uncorrected error in kernel context";

This should be "Uncorrected unrecoverable error in kernel context". There is
the IN_KERNEL_RECOV error context for a recoverable error in kernel context.

Thanks,
Yazen
