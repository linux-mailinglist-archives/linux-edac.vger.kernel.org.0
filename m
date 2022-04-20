Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE415080C2
	for <lists+linux-edac@lfdr.de>; Wed, 20 Apr 2022 07:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbiDTF7l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 20 Apr 2022 01:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiDTF7k (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 20 Apr 2022 01:59:40 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033C3702F;
        Tue, 19 Apr 2022 22:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldNlSj3vnr+mtsmSRC+X0Bl8WKY0CC4/j3Uv9g7u3IuMSuI8dOoEveNpcmCGXKe5M4BGHwnjutI5JzvJXlbLFaSdGt53NJ1J4pdm+ZpkxZ2pgpwHYfGG9xBHCQvTg+JZgxY6ZL8p+fhyIdkvP0HasHWM+o1r9VkeCTjAAz9R0dIcj6vAO3VEFAdd4ee/A/H/P7GmjetaSdpO2xd3Ut0Ifa+j9jivaPg28CbyCl1CqQp9ofXVC8M4H78yPRgFmG3NvqVfn0/CuvJT4QBMQipbeyBfY4JigcFBPbGxKgpe81/ODjcc9k+4yiv9l9pbGcU0j5ADnIiSzACoLazSEuXowQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aD/QcWgLaVJRTUwjn5DgqKgt8EyWDDdanWlMDpeqt0=;
 b=OCy2EnsITZIwf4yscWtXpgVtjdekVQFbtNnPyJo4YsMhf0P0G7rWhzTuMAP3vEvi9vycvXl+kcgPC36ustjMlfzfXxpOGoC83ZFtg5v1osoMJMQC7aVchJ/qBX5fXHgO4yniDOs5mwpVrNE2wsqGXEEbRziesOcJ/hipsDairiSxsVQoFmLgcBV1YoAKKgtwNbNuYokh6bb4zu6Foi6nXgAeUS30ogWN5KNcEdUadfqDTfs5U1xMDkTePsCW1wQGZKsiPBJROHzVb7aSvN709mfIV8MIrjEb+d75ZzfgSbH7ivFL5BqpmBbXGXlXFkwGA/p3uQj1RjcZxoTCP5vqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nxp.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aD/QcWgLaVJRTUwjn5DgqKgt8EyWDDdanWlMDpeqt0=;
 b=l7L4/YleDu8Ec6H7u2/s6QtYnLOU4X/E8VcOuNf7DpTs5tizegpUktBwvc7Gu++iRqXqxr8ueLjFgXV7pQ8yKDTqkd3uDzAQVM7u3m8Jy29mk0a/IhO3Ec9x57tyKsYb+cG/6pxNkfNKZK/Q5wwk4p1Oz1w+77L4dYOf3vvj9w8=
Received: from SN6PR04CA0106.namprd04.prod.outlook.com (2603:10b6:805:f2::47)
 by SA2PR02MB7770.namprd02.prod.outlook.com (2603:10b6:806:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 05:56:51 +0000
Received: from SN1NAM02FT0039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::49) by SN6PR04CA0106.outlook.office365.com
 (2603:10b6:805:f2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 05:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0039.mail.protection.outlook.com (10.97.5.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 05:56:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Apr 2022 22:56:48 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Apr 2022 22:56:48 -0700
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
Received: from [10.254.241.50] (port=50380)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nh3KZ-0007Fw-RR; Tue, 19 Apr 2022 22:56:48 -0700
Message-ID: <8c49091c-5bba-47fe-6479-8a2af69c7340@xilinx.com>
Date:   Wed, 20 Apr 2022 07:56:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] EDAC: synopsys: Add disable_intr support for V3.X
 Synopsys EDAC DDR
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <michal.simek@xilinx.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>, <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-imx@nxp.com>
References: <20220318111742.15730-1-sherry.sun@nxp.com>
 <20220318111742.15730-2-sherry.sun@nxp.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220318111742.15730-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98846b92-634c-48a5-8827-08da229290ac
X-MS-TrafficTypeDiagnostic: SA2PR02MB7770:EE_
X-Microsoft-Antispam-PRVS: <SA2PR02MB777097345C9BC65F212E8042C6F59@SA2PR02MB7770.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mwa0+LzXsPexlpmZzLuk20D1QxLSvjLscDYOmp3KxMt7DaqwEO0GB+97GbKYusUMuKDFNWNMWeAPQyi4pTd13vv0fD0Nl4X44jMO9vS33sbRG1Bnc/n7qgmMu2EYXfa0yim+/sfeBFNnVplWnRngzmdZ1loBs3jO6Tm0q/23N0tw4ygyizr4NNQ9hv0O1N8yHptdfwAVTK5hUj4JzxwpxObUC+y2xNugMbnrsCCPlBwikaqZ8JbeotP/JDMzeY87S62BiSBOJrNF6O2sFvYiiEtLWzDXev8UbTtVfT+kjoXKrQfAad8OfLcoPGfFqe3yKxR1R1npCulOtq0nGXhKT2nRoLXp9sfVTEARr3x8NtVe+AOjJKTAMHpTHDL2unLmKvqk3H+xuzpn52Y4FXTFlT30ir+6gASJPdmzrYrTGOHpAYCBYB2uVelA0qHxr7aFlzn1CTqEqfVZWvReZpgq94fb+nscRx+k71nzRfL3J20pMdvYZZt1gYFkjtlZ4HjTs1np2WympjB6kyvtlNF3tiQ5wEZJqbosJYW8J3tk9x3mfvzSdRjecOgFemgq4LZnXKLS+ke0G6A0Ugq/qoCBNa6532MShCWXzkcFCVk0jl74qEFn9V4YjzOeyXlS8HG7zPogC4ADLxbzZ9KmysgoeF4jRefUTlvRsDrfi2jDvxDB16+APA80HoYr7F1btPZ6vNSKx/p/N7fpDrRk5IHX4rGXMvNNPbgHmwDzT7Zphv7oT/H9kVGLsq7P9cC0kB4
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(26005)(9786002)(508600001)(186003)(8936002)(2616005)(44832011)(2906002)(6666004)(40460700003)(53546011)(7416002)(31696002)(5660300002)(83380400001)(70206006)(47076005)(70586007)(336012)(426003)(7636003)(4326008)(8676002)(31686004)(110136005)(54906003)(82310400005)(36756003)(36860700001)(316002)(356005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 05:56:51.3361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98846b92-634c-48a5-8827-08da229290ac
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7770
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
> V3.X Synopsys EDAC DDR doesn't have the QOS Interrupt register, need
> to change to use the ECC Clear Register to disable the interrupts.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>   drivers/edac/synopsys_edac.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index f05ff02c0656..1b630f0be119 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -859,8 +859,11 @@ static void enable_intr(struct synps_edac_priv *priv)
>   static void disable_intr(struct synps_edac_priv *priv)
>   {
>   	/* Disable UE/CE Interrupts */
> -	writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
> -			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
> +		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
> +	else
> +		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
> +		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
>   }
>   
>   static int setup_irq(struct mem_ctl_info *mci,

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
