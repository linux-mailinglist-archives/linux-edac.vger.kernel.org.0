Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E841D65A
	for <lists+linux-edac@lfdr.de>; Thu, 30 Sep 2021 11:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349416AbhI3Jao (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 30 Sep 2021 05:30:44 -0400
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com ([40.107.223.47]:30177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349378AbhI3Jan (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 30 Sep 2021 05:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZreRJBj6Kssq2q66LYnHzBnjkJsT+lsg3JCq3pCtLI2SQ4EZhKhRdwLtQPkwargeN6Cd52JyqWehbw9JdXZCgJ0g9enxKRnJwK8JnyT67MlSCH3L6B/UrOszYymgFj26FP+xB9TJ2DAVQVY4g1bwCX+QwLxX45U9L3LkFnw+2X0s5+U6wadZqwuEkSnVUWdMvkiBlCoojewza+Yko6fEsIPd3pWMSIGZZhN5eBpl4IxtiZoOUK9yf35Uw9DbRzgEwIi+7/xya0oUH2CKMA/UfyKxbA2SaxxkhbdkWf3J04405rc5bWT5k2GcaU/c1bBfInx9F7IalZkDp/UfiRX81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JTt22XOsnBfH9cwU+It7Yjoj5mlWpzENtaE+Gy3nxQE=;
 b=cP+zrQHfkLnlV1zYEE0HucWMSgLwA7a/ZEclTY787abJXPkVOIqGmdpTFZqdyQRumwROBCxpsd56IR6HzwAM1GNMxYuBZCJzpR5aFUy4ra2Q0co7zoWEq9ruIKaX/CwC0HNd5yTChMj/7AsoYnCeArrces7/OoWE4hzQLSa1A9qtIV1e6QHJzlNuE7jb4WeH9KTHn2l+JTMNjIa0/rJlFugoGQ0/lL/zHlJnerzqhaRQw4Hkyuzkm8oHppSdDXiGhSJP6wOV4qSB9dAIPqRHLFu+I1/QoopKlzmJ0fkDcF1rU7w6YEqN7Ys1RIYU189t2S9Ataelg5ItO8fiPNf8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTt22XOsnBfH9cwU+It7Yjoj5mlWpzENtaE+Gy3nxQE=;
 b=YDaZ7qoF+hJinRQVnsC9L3EbLX9cJfSHX64lwxGPakMfGAoDIaJJmYJExxSlB+6qhgXuBDJF9/75rP4Ua6CkqmRIA3U3szK16hs2Xm5HDhwkbmncM1/VzqqbOrbCKbIYSCgyxb5yFmg+b2u7XpaXl6gkuIDxDPJ237yi/HwPlQo=
Received: from BN9PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:fa::7)
 by SJ0PR02MB7439.namprd02.prod.outlook.com (2603:10b6:a03:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 09:28:59 +0000
Received: from BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::c7) by BN9PR03CA0002.outlook.office365.com
 (2603:10b6:408:fa::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend
 Transport; Thu, 30 Sep 2021 09:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT060.mail.protection.outlook.com (10.13.3.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 09:28:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 02:28:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 02:28:48 -0700
Envelope-to: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 dinguyen@kernel.org
Received: from [10.254.241.49] (port=35970)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mVsMy-000BRC-40; Thu, 30 Sep 2021 02:28:48 -0700
Subject: Re: [PATCHv3 3/3] EDAC/synopsys: v3.80a of the synopsys edac
 contoller is also on the N5X
To:     Dinh Nguyen <dinguyen@kernel.org>, <michal.simek@xilinx.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20210928160423.271187-1-dinguyen@kernel.org>
 <20210928160423.271187-3-dinguyen@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <05830b6a-a67f-a262-4648-449f72442ee4@xilinx.com>
Date:   Thu, 30 Sep 2021 11:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928160423.271187-3-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16070de8-faff-4861-8983-08d983f4bba7
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7439:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB74390E714320FFA8F13D9E95C6AA9@SJ0PR02MB7439.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLdawj5o9hAwMQrXjbkUYbhVdC0CsxebWIgSb3ibMUqA4oQjUSrMQKRORL8N/gfaz15l/7zFU+rWs/KYFwCT7l6kKDT+ISdPrUR02y3/Z5rppSczALKzMKN28e46HwxWD5BW7JfxXC7xEpOYGBBFFilDbJhxLPA335RGGkviDsjr2TjUOwm2h2XNyfqpQmjTb4GA3XDUSkMTzftQJetDeQokKAkq5KiAAh9LYGYWXuOaP+8qDPvgl5FA12JZqFUHnv4QpWe42Dcms5rn3yhuWIJS+drniqrQkvvHU4UBd1k4IqXGp7yJyNa/jjNHKu9sUTtsgjpUVJqSM+u4vntNW4ClaD0Xa6X32TvSa55Dm8axsKKlxC84x588rkUDLpfTIqkqSzNSNYkvF3wgLsRyY6FP6GRLUjf1HkfyZ37tLfwPkdg3u1jYuaNiDr53rxnoRqiZt6afaxehQOL5MMdwfmiVHLrAVpP+nNfMDp6+KOiEJ2Cr3e+fSFaID8Ets5QqTStfjn5Sll/5hbbMuZkSCiAwICExoEz+XsgLRvX52CmDQ0as6XslmI5cmrPHLn1Rrgbosbq88Hw3SnfNwZ3oNpHZfmLTGDRtL5anF2vPk7QuWmN6WO4DUyrdL+Sh4ojymSXd9Z7vajG36Ukf59kvHu8PfUpWtQ/2CoXNCAfIeOvVNYRIbBXgg4aU00D525YeN8gSWQJxFG0e2pvc//4MmOjDIBfXmn1MhveABknOVjKhgjPu1vWLrZ2T/YP8Q57d
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(5660300002)(53546011)(4744005)(2616005)(508600001)(336012)(6666004)(9786002)(426003)(70206006)(8676002)(70586007)(8936002)(36756003)(356005)(47076005)(36906005)(316002)(31696002)(31686004)(4326008)(186003)(83380400001)(2906002)(54906003)(36860700001)(110136005)(7636003)(44832011)(82310400003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 09:28:59.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16070de8-faff-4861-8983-08d983f4bba7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7439
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/28/21 6:04 PM, Dinh Nguyen wrote:
> Intel's N5X platform is also using the Synopsys EDAC controller.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v3: s/ARCH_N5X/ARCH_INTEL_SOCFPGA
> v2: no changes
> ---
>  drivers/edac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 2fc4c3f91fd5..58ab63642e72 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ || ARCH_ZYNQMP
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
