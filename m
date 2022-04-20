Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2A5080C7
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 07:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiDTGAU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 02:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354813AbiDTGAS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 02:00:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DCF37029;
        Tue, 19 Apr 2022 22:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTOJoON9B6OHK0V8f+v7PC6ahzrBFYh9MYGuupx0glsPFgBpP3xjiKa3TWghTTwvz5mE8jsLt3TgPo9V5gq1k093qcfESFs2TECmED6Z0LAZniAF7mVjnATdZjjTWTYIdh9k/RAbFlox1azYIbYHg2Z3LknkUgas8fsZD7DrnJfjNJNN2OnMpnONLqXHu7AngRThf965/sTNuFkIa/kQcwNOeJHc9vwRpD1sN/386bPbkPGNfuLHoG90USoRRI1tHSaQ58xVwf9HNVyQ5yYXzEQjdmau4MN8j9ulUl98GDGxF25TbbySLVI1TUci3z+akCjH64+phtT/7zJ0xl7btQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOfX5dIY4bUoL8wT+pxFBc0JEeRxkOyV3PkXElya/Ss=;
 b=nmRhRWSAe6jJXyCeMeKxKxVnqZd0/s5JmO3VLo1h724MMUfBJCsR9SBEKtHOEedNGvZ5jpjUvkfOQVXoq+Pzb0v0e+wPFxT3qnvBRgHkQ8c9qVdP+evxe0bhsorm6bLCkk0NZ8Rz1/Zkjxy2HIqqm8iPEZkxXYVpMnshq8CIg1EANB1PyxI4e+2Y7rL1DimYQ77DJYMZKY89d1wmOkuf4fPEJYGI5YReLNwOaJFUUxgEb/3MjSa/9Y0DTkpO7u6Q+RF4BLeyvmQFGmXswx+HRaVsP61FgfRTI5P2kGQ1m7OrsIJfFRyvBg/baZDjCG0SjwL4FwYUMLNAvlYJyc2q+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nxp.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOfX5dIY4bUoL8wT+pxFBc0JEeRxkOyV3PkXElya/Ss=;
 b=B+aXhNSkeWSULShPCbTj0725HURSFTtlHSLyH3kEAluHc1IkEWmW4XeESlk5WRwSGSijJWVzr0YzvSqLJHJm2U8NKtVAlDMwZyN8csaHp/EGQLVwBfd8FAJnBe8SP5AelSKraSZnzT9llcA8SRQ9WLqFYoocwkO6DgS7MeIonss=
Received: from DS7PR05CA0091.namprd05.prod.outlook.com (2603:10b6:8:56::12) by
 DM6PR02MB6443.namprd02.prod.outlook.com (2603:10b6:5:17a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Wed, 20 Apr 2022 05:57:30 +0000
Received: from DM3NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::51) by DS7PR05CA0091.outlook.office365.com
 (2603:10b6:8:56::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6 via Frontend
 Transport; Wed, 20 Apr 2022 05:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT038.mail.protection.outlook.com (10.13.5.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 05:57:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Apr 2022 22:57:29 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Apr 2022 22:57:29 -0700
Envelope-to: sherry.sun@nxp.com,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com,
 james.morse@arm.com,
 rric@kernel.org,
 linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-imx@nxp.com
Received: from [10.254.241.50] (port=50436)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nh3LF-0007Ig-1v; Tue, 19 Apr 2022 22:57:29 -0700
Message-ID: <ab18f598-d4f5-049c-66f3-3ce2d5c01670@xilinx.com>
Date:   Wed, 20 Apr 2022 07:57:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 2/2] EDAC: synopsys: re-enable the interrupts in
 intr_handler for V3.X Synopsys EDAC DDR
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <20220318111742.15730-3-sherry.sun@nxp.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220318111742.15730-3-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d321e2-5575-4157-f832-08da2292a800
X-MS-TrafficTypeDiagnostic: DM6PR02MB6443:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB644332894877B52512311930C6F59@DM6PR02MB6443.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DeQXryQnevzODOkQxWCvGtBK6ZGisfAF39PzEeanyelG+Bq+FFnRtJnkjzys9rt+czkbrFsSU8xoTFlwihRoi1W1dAaHAW0c09xjyqRx8HZ3ou4sdUBxabXL67pmV1h7kW3YTECAQykfhVZJPANvq4jPc0khx8N49t5sgKo0JNF91PQAsUY0d0AIra3Cz4lG5wt1L1/Cd7jDTMkLEW1cZodEUlNbfwYSgehp9P9Ty7wVqJ74mJTYvVzWl12VmZ3RAsXL0+DbGAADsz/Nvbtr+gOBvpwFO4x6GWPHT6gwWiNhacV5OUM49LqEekllbF47zQO0v5+KcRYicgwmJA2eoFJG8rhUtxsIu9m7oFm8MPF9h20BT1FVKzEFvdbiojrJYF2XtRgBqIVSy1Z9VcHgleGVhbpqfNEFrjaoQqRlCJOqVUOvLYPmgRXKvBHXa92rzj1TH9xpNKXNDG4TCgFbZBOEOCRY3I+bJiP1q0+8Uu89xVZIdzsgZMVOpD9A7OhgsZA56x9RjIIMznIAW/LL/ER4o49NkuZD2J/Yz7RSJXcjizECKFCp6PF9DUwZOrqU1AnQ0sD7hCulplA7qtyUwQeEh5fOVvRaj7yxUGtz++4ro5PONLlPwMcShYrLHeUiJz6VMKUS2P4ema1PQF+LzKu/g1eb5Fm+nfLDRncDbsAfumKZ7mYi3BwdmcFBiioJ3eax1xEvaNt0esjEpHDl16qUg45c8tHMkaElCue7cumI/awHo+LVXmTl8kQnYRkf
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(2616005)(336012)(40460700003)(47076005)(9786002)(53546011)(356005)(2906002)(110136005)(54906003)(186003)(7416002)(5660300002)(508600001)(7636003)(82310400005)(316002)(8936002)(31686004)(44832011)(31696002)(6666004)(36860700001)(70586007)(8676002)(4326008)(70206006)(26005)(36756003)(83380400001)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:57:30.4614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d321e2-5575-4157-f832-08da2292a800
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6443
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/18/22 12:17, Sherry Sun wrote:
> Since zynqmp_get_error_info() is called during CE/UE interrupt, at the
> end of zynqmp_get_error_info(), it wirtes 0 to ECC_CLR_OFST, which cause
> the CE/UE interrupts of V3.X Synopsys EDAC DDR been disabled, then the
> interrupt handler will be called only once, so need to re-enable the
> interrupts at the end of intr_handler for V3.X Synopsys EDAC DDR.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/edac/synopsys_edac.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 1b630f0be119..3a1db34a8546 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -521,6 +521,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>   	memset(p, 0, sizeof(*p));
>   }
>   
> +static void enable_intr(struct synps_edac_priv *priv);
> +
>   /**
>    * intr_handler - Interrupt Handler for ECC interrupts.
>    * @irq:        IRQ number.
> @@ -562,6 +564,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
>   	/* v3.0 of the controller does not have this register */
>   	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
>   		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	else
> +		enable_intr(priv);

nit: newline here would be good.

>   	return IRQ_HANDLED;
>   }
>   

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
