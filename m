Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEB341D652
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbhI3J34 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:29:56 -0400
Received: from mail-dm6nam11on2059.outbound.protection.outlook.com ([40.107.223.59]:20448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235943AbhI3J3z (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUmcK86mMSiJjqvBJEWXSCN5Sw7ykUcvRg9ycJzUXbQTkaDGLHsTdsAME36hjto0Vqirk+RJbazFXvtvxmR1XVt1aqnJFEgfSd/xK/P40w/IIrmo2yKSSybhmLgQtRfyZ9mXCOg/Zor3ryPU7DA0sl2MCP7CM38rCBHwqplnM4aHWQPbliL5QgVfmLLVkUHCMDa8Csu7gCG/KQ4//8x5+SW22fN48XX1gioDAmVYWMjcvlbSNrmXxYc13AnlWlfw54lSWnX55SC0xsTzjNTtGN/1TRtR3vQ6POwhgh130syPuZS3CPad/4SXVu48EN1NCWbwCJKq2cNBd4Yt2/V6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7NT5nT3XS/u9mcdPLIGvoUTt8EJdUK36iV/g2N2sboY=;
 b=lq4QTD2+pSWjIjGULQU6MS8BTTxLBtnpsKB6xdbV8nboI0Rk8QX74K3bsdqNf/Fz9fFK3bVDgtyLucoIbYoe6c2iG17Z44thWX/NUO49M4LfCId6p9X8NoOhIa8XOiwG8tGQ2jfnkiVeD8C/UoMY1duhH/DfABmsp6C/gOllw+2S0oobgx1ONSAInQOqFMM7x9C5BfhxVrWclhEUp2ZZgLDxJmA+wLuodsO/ptX/PAselxJZsK9LoJyenTPwG3E9CeUYoo/eLDmEVvNR8KyLTNpAacqz9pPSsAzoMA039R34FZs7J0UuQHIF4SBq7dasARJ3U4GajiD7n0f52g/qtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NT5nT3XS/u9mcdPLIGvoUTt8EJdUK36iV/g2N2sboY=;
 b=HhKPdjg0kjIqYePQNeg4P9QUIuo4mMIq7fQ2IIg5A83bDd4dcNAuAxQFRGQGNjg/2Gi4F7vNNuFmdjDW9VIYWPnMNgYIFE5QFpdE1eRUge/CA6F8oOmhk/ePCbFYOWJ3xx0g3/p2lhyc2mpNFnkCet8pIFKWgophgTV+8sx21Zw=
Received: from BN6PR2001CA0032.namprd20.prod.outlook.com
 (2603:10b6:405:16::18) by BN7PR02MB5090.namprd02.prod.outlook.com
 (2603:10b6:408:23::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.20; Thu, 30 Sep
 2021 09:28:09 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::5d) by BN6PR2001CA0032.outlook.office365.com
 (2603:10b6:405:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 09:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:28:08 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 02:28:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 02:28:08 -0700
Envelope-to: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 dinguyen@kernel.org
Received: from [10.254.241.49] (port=35914)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mVsMK-000BOY-0b; Thu, 30 Sep 2021 02:28:08 -0700
Subject: Re: [PATCHv3 1/3] EDAC/synopsys: use the quirk for version instead of
 ddr version
To:     Dinh Nguyen <dinguyen@kernel.org>, <michal.simek@xilinx.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20210928160423.271187-1-dinguyen@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <932f547a-1f7e-bf98-baaa-30fa1d6a9810@xilinx.com>
Date:   Thu, 30 Sep 2021 11:28:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928160423.271187-1-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33f8d4d4-9649-43d1-53ca-08d983f49db4
X-MS-TrafficTypeDiagnostic: BN7PR02MB5090:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5090A8DA7B1A77AD95DFB21BC6AA9@BN7PR02MB5090.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ShNep8H3mSdXhXvphNlTJTz/NaEy5CcVAbbaRxktd7COS5JgCS4NAgHp866eJqoPE7O1v+sFHhpVZPtPo6wnPbZOpOFeKqcZ3YhYN1DqhK4Mvp5abqMjGWddCza38r9Iew6DaJ59MP0G3DqThFU+Fhg/Q+Rxy2gcYSe01sRQNX6GWCBUm7mfm+L20VSFur2Xx/gA7XUnENbisCuNlSCEg0q3ikOxKjNMdccYdOLdiznHyESotV1Ue5Y/ppoI1NwAKm34/Oo5JddlMdogPBDQy4KZIlSCkPV7A4w6lBxz7x8IYC4DaLGINS6XaE5O0vge4gwL9bUeFsDC7pwqngxx3m0F9i+d79XuleXT5lveMr5bQ+xvuPnfU1YMtJtSAoqR9DQ3r8vrmDOzunjG4y7su1cE1Ac+JduyV6odomBjXdJypmSnxiZ22QMOwHb1K2Cx8kv6swvk/2d0vYHenKM5taPPovO7GlhOkZF+5minNoHsH6JRq+a9L+y3Dwpqii8sF/0GrJsXDbVFzfODWmmroBJHEZs6bJPwJQ6dKBqJWLi6Rk6UpxtXTuHjyBD+/l2Eg6kXN/8esRaM3UqTviGxr2lKkfqf+v0zoH66vvKQELNl7Rg/Suz/TGe3MTx4L3y4uE/OmbB9Rb77A/6hRldBZjek13vd1bjc9xW5vLxiNLIvPRPGGdW0ExMQKw8U1CaXZS7kkMobNCsaWS4BJazhBmDDGJ+9uK1/rMbKp9TYZxOv6QU3TIOeiYiCNdHTlPSYdD3SB+cGh27Se+5VLzQ1og==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(83380400001)(4744005)(2906002)(47076005)(36756003)(508600001)(36860700001)(336012)(31696002)(31686004)(2616005)(426003)(70586007)(54906003)(8936002)(44832011)(53546011)(8676002)(82310400003)(9786002)(7636003)(4326008)(36906005)(316002)(356005)(5660300002)(186003)(26005)(110136005)(70206006)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:28:08.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f8d4d4-9649-43d1-53ca-08d983f49db4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5090
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/28/21 6:04 PM, Dinh Nguyen wrote:
> Version 2.40a supports DDR_ECC_INTR_SUPPORT for a quirk, so use that
> quirk to determine a call to setup_address_map().
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: new patch
> ---
>  drivers/edac/synopsys_edac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7e7146b22c16..bf237fccb444 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1352,8 +1352,7 @@ static int mc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	if (of_device_is_compatible(pdev->dev.of_node,
> -				    "xlnx,zynqmp-ddrc-2.40a"))
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
>  		setup_address_map(priv);
>  #endif
>  
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
