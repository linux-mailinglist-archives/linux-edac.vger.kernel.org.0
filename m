Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947094DD7F2
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 11:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiCRKfS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Mar 2022 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCRKfQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 18 Mar 2022 06:35:16 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2079.outbound.protection.outlook.com [40.107.96.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF2A255A0
        for <linux-edac@vger.kernel.org>; Fri, 18 Mar 2022 03:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IExqz5WRQgKSLFozzUAhcSg5+g5r2Hwiq+1vSXwmAIHnNnmDXBZq8i8bq9Knd55QuZe8ILJ2rrqIsAPqx+isAzuFlG6NHKTCZ+AuuzLXsBixStQB/V1dixilsqsn953/Nc++Gz5OQMvFSOnFbw/cj18+QyPqixsPuiQREjZTCYOhu5PD2XqKF5/5nRPFsdouXVKZqh/34he6Tq1Jrmau8CdnpygwWq6g+07HNbAlrpL2mp6proICto24WsaftYf8J+p88BGqMych1C+0c7CinO2F0ZeFQwSgu5xJBQHMDAREpY90Eise99xv1pPIrq0EwTidEj9peuOm4aZCeHCm9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auZL5ROJ4xWw4x5yTRFnYU2FmyEcY3PDC5pzHmgC6oI=;
 b=jL45HY2Y+IZr089FEmRJKss4GY8I2WZqf0Gunt+flNyCRh8WfLnPz924fXX7rm9om/6hG/8j06HruIVCut3tibOskCPlhQqx5KrO/HSGESgYKf4MesTpTlZRWiohSfIsxg4arr/yhOm3BHieaNBp8nNoyKJCZZa28DNVsGTMAOPjThitCXPcufqkg7Nh1qTnfEcSd2BFF/QNzjK/aGxZXUEcNPiqOxISgK350wAffCIJK+WJUSTYjfBgwtj2Dblz5TXL8ry+iuubDMwRMKmdTV8WNNiMncW51JJ2e/I+iw81MM8BPU0WrIi2PtVLEdlIzulrmM9AyKIi0nZpJSt3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auZL5ROJ4xWw4x5yTRFnYU2FmyEcY3PDC5pzHmgC6oI=;
 b=jLpT591fJYlwOztyMyDCdTSaHTC7U8hb0y7+H+GC0J30azll8tNCcTrJD/NpNACA5LNsQJwpGcBUazeO2BVS3xGKN0NB+2wuiVKmkmI1BUpWR0EQAu63kw1rlm/xeOet09Waecb6Tv+RNChyzPpJK0C3PCA2BAgfR6C3zV5+pjI=
Received: from DM6PR05CA0051.namprd05.prod.outlook.com (2603:10b6:5:335::20)
 by CH2PR02MB6359.namprd02.prod.outlook.com (2603:10b6:610:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Fri, 18 Mar
 2022 10:33:54 +0000
Received: from DM3NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::fd) by DM6PR05CA0051.outlook.office365.com
 (2603:10b6:5:335::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.10 via Frontend
 Transport; Fri, 18 Mar 2022 10:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT018.mail.protection.outlook.com (10.13.4.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 10:33:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 18 Mar 2022 03:33:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 18 Mar 2022 03:33:53 -0700
Envelope-to: git@xilinx.com,
 linux-edac@vger.kernel.org,
 rric@kernel.org,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com
Received: from [10.254.241.50] (port=44666)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1nV9vc-0002Xn-HN; Fri, 18 Mar 2022 03:33:52 -0700
Message-ID: <b6821312-3aa8-6b76-81a5-45927d6cc1d0@xilinx.com>
Date:   Fri, 18 Mar 2022 11:33:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] edac: synopsys: Fix the issue in reporting of the
 error count
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        <linux-edac@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <rric@kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <git@xilinx.com>
References: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220318101900.28872-1-shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 925ec3c9-4f78-4de8-3ceb-08da08caccfd
X-MS-TrafficTypeDiagnostic: CH2PR02MB6359:EE_
X-Microsoft-Antispam-PRVS: <CH2PR02MB635909BE77CD3C7187D0DB09C6139@CH2PR02MB6359.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUzb5SNzsDJWtio/UHhK9swxmp9kMI/JLusJ7dUAse1S7EenNlkFvWGxaCO84kqxDU0GgZgYFtjXtmekHfyF9VJOJCZszo4cxLryaIp2R/W2LdFUPvbWJanY18beIhWmsz0joybXTPGIlfDLljWT5WbZAMB/J7gCX8CkwqO+ToCijcr14pjHbCNV6PHPlLBsqleOAoei4lt9+NukzjYzvyNFYKNi6gQrtmfFYzjsRXnAz4qqj9oxOVbt8sNbdfQT9JMtT7gskpQ2a6wSsHT5iwVxQlQjwqsFtkgtddPeaL1P2/3l/jppU2rLci0ndh9lhwkF8BZM3hgOwkjneNYkKiG9llrjx1y5j/dhE/F17c2SachUKCFN2Aa4sf84amSQZTtChlCm9cKrUBLKJBFypzPJuzZBTNc1fInGr7MNSyJ5rYH/1N1W/CRq+T0XZX7lxqFQp9um2QDnPnGWm2427+NcSZxrxPvsBZmrcSjX5mj1SMTGlOcj91TU9vOx9OS8/x8iaOzNX1OE5PLGwcwPszyrvscjKKEd2ICCm9LI5M0o3kreC+74IhJ1V4DYxVgakTSnggZE8zsS+6AJhAZ2Gt7Yotw8TMZyAw/3n+m3kiOYRrr7ZNS9R2oDceeOOq71Ey5TfRRK8piH9YOJsuR7mufHdWIMZ8W9AWGLU75zVbBwYyHrBC3ztvU/dup4iK9k8Wd6uCxpHnwRqph+px972RZxTUHhEUmoawklIInJN1A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(26005)(107886003)(336012)(426003)(47076005)(53546011)(36756003)(2906002)(186003)(36860700001)(6666004)(31686004)(82310400004)(70206006)(4326008)(70586007)(44832011)(9786002)(31696002)(5660300002)(8936002)(110136005)(54906003)(316002)(508600001)(83380400001)(7636003)(356005)(40460700003)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 10:33:54.0973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ec3c9-4f78-4de8-3ceb-08da08caccfd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6359
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 3/18/22 11:19, Shubhrajyoti Datta wrote:
> Currently the error count from status register is being read which
> is not correct. Fix the issue by reading the count from the
> error count register(ERRCNT).
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
> v2:
> Remove the cumulative count change


CR number?
M

> 
>   drivers/edac/synopsys_edac.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index f05ff02c0656..1a9a5b886903 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -164,6 +164,11 @@
>   #define ECC_STAT_CECNT_SHIFT		8
>   #define ECC_STAT_BITNUM_MASK		0x7F
>   
> +/* ECC error count register definitions */
> +#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
> +#define ECC_ERRCNT_UECNT_SHIFT		16
> +#define ECC_ERRCNT_CECNT_MASK		0xFFFF
> +
>   /* DDR QOS Interrupt register definitions */
>   #define DDR_QOS_IRQ_STAT_OFST		0x20200
>   #define DDR_QOSUE_MASK			0x4
> @@ -423,14 +428,16 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
>   	base = priv->baseaddr;
>   	p = &priv->stat;
>   
> +	regval = readl(base + ECC_ERRCNT_OFST);
> +	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
> +	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
> +	if (!p->ce_cnt)
> +		goto ue_err;
> +
>   	regval = readl(base + ECC_STAT_OFST);
>   	if (!regval)
>   		return 1;
>   
> -	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
> -	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
> -	if (!p->ce_cnt)
> -		goto ue_err;
>   
>   	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
>   
