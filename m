Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A885512BC3
	for <lists+linux-edac@lfdr.de>; Thu, 28 Apr 2022 08:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiD1Gox (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Apr 2022 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiD1Gow (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 28 Apr 2022 02:44:52 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF8B5F266;
        Wed, 27 Apr 2022 23:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YECl4la4DYYHNM93iGVfQijjdL+LD2/geVDhkymCbCjIwgA5/PJfAGvJ/8tUTLO+HAGb9CDNuBUE5zyD8b2cp13txy9//YQngvn7WWcWNsYpkNEMSCNFe3Kzm5fT3/ApJaGcz+mqvx9S2qw89YI5jE3kTvHEyRVEwq0CHytqxiDJ05Q1hyrUeRu+0sgXgwwbxZyzDYkfGUZQgSf+TnIxVM4unm3+8xMtMcGKdD0waFsm/4fwfAu/3qv/czWwhJRgaFG0HPAdT+Vap+nay1ZgsFATVNfyy6bmDy9Dojy258ttmkCbqdepJ+eBDovmFTohEx64DkKMsn4UEzJ2DqopIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXt+F6CfSJs8AC7VYrTnUKhmMeYOYYbohntmyKRDPms=;
 b=d+nhUK4HhHd2U0nQRL9PmaS8g2NoIq2un4mLEZrG2yQcxHe9XlapQJlVEuJ/jLj6y+6aIHymsUcrGlgpgeFI5hmPUjXburJIpyEiu9L01ATg83CXIfgnyZLChs68EuA4Yy+SiLP2Zuxhb8310SBUgB62apxi/Wy5mgbP8gPdSkbkbt7eYTaQZbwhhVhBrPkrIYnzFo073PD5mN2fDe6okKLwhGK8+qXVPJwR6F1s2n/R61ESumaT68TyRoHTxzmLmOSu0X18tbhjzQrAqzkd1Z99QnD6iwoBVnM7z1cXCVn2+9mDSESofrmhaFjXq6Obwx54arASixdc9/e+Z1oxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=nxp.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXt+F6CfSJs8AC7VYrTnUKhmMeYOYYbohntmyKRDPms=;
 b=DOEydAsXIDf1mb8g/xx41TF9QSYKh/2Mo53lRLelsImWKEPoXpR0nZHPMZ6lWcdSVOJEG+QZcQ4y7FTzN4SCNSsI3Deh5d4q7yTicHd+RQectKc791aMcG/+Lry/Uuibl24VjZWFQbjVVJaXGAP1EQr5bIoV3kR1v/6Xy+5eiaw=
Received: from SN7PR04CA0114.namprd04.prod.outlook.com (2603:10b6:806:122::29)
 by BN6PR02MB2420.namprd02.prod.outlook.com (2603:10b6:404:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 06:41:37 +0000
Received: from SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::ef) by SN7PR04CA0114.outlook.office365.com
 (2603:10b6:806:122::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 06:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0047.mail.protection.outlook.com (10.97.5.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 06:41:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 27 Apr 2022 23:41:36 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 27 Apr 2022 23:41:36 -0700
Envelope-to: sherry.sun@nxp.com,
 bp@alien8.de,
 mchehab@kernel.org,
 tony.luck@intel.com,
 james.morse@arm.com,
 rric@kernel.org,
 linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-imx@nxp.com
Received: from [10.254.241.50] (port=52414)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1njxqK-000AL8-7e; Wed, 27 Apr 2022 23:41:36 -0700
Message-ID: <776544f2-74fb-32a1-fb79-4e9a95ec16c0@xilinx.com>
Date:   Thu, 28 Apr 2022 08:41:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2] EDAC/synopsys: Add edac driver support for i.MX
 platforms
Content-Language: en-US
To:     Sherry Sun <sherry.sun@nxp.com>, <bp@alien8.de>,
        <michal.simek@xilinx.com>, <Shubhrajyoti.datta@xilinx.com>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-imx@nxp.com>
References: <20220428023209.18087-1-sherry.sun@nxp.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20220428023209.18087-1-sherry.sun@nxp.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35744611-a5e8-4740-0f6a-08da28e224c4
X-MS-TrafficTypeDiagnostic: BN6PR02MB2420:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB24205BC25BF8736171C79C7CC6FD9@BN6PR02MB2420.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LBASN7lo5BG2fGKQtNqAIXDYUOa10yFy8zD4VdSmADysnNQWYP0SXF7jIWqyOE3fg6oNoJJ/BcLCcD9uFjKApkWl7NTy4XfvtRl6KnkxJbrwyFdGLXjA1zeYtkgB70BpGdFzLZr5l+nXTKH2SEpJEDpsKBnhZj8imRzL7mKtfTh5Cc3B0fAmVAEy1oLzwQbeC+JTI0h5qhGpVIepSvgzdG0TJEIp6Q36QHrYKyuuBspCgbNa1wIthD58EqIv45KKKtOG5vlVZyzyW5grsEpfaWJS7spEEOcG379E/LbnJ5Hdrdky+CvVhedsimhizX3Gd/FOT9zIFvWdNfrJqu2ckZCMzOfhbEQVx2jUeJxZ5VXKag/Xp1rVidSLCAZCukYCFVt6bE6iXWysPSgns61P8HevwSf8Jabli5dgBa2oktL1qIKpCIT0gFmWEBiu1eV1vM39LapWDPQx6wkVmQw1X9ltLoGX7KbtVUhkdlOcRv2X9QxeWioJj4m8jQdUL2vTHSmNNIugVR2n5IFRfGD30rsaPWFBL2VNSd8ZLu5y6BwY6ZFIlIXdtvigV+USh312zRoOAdAjDo6LnmK/vBUtS9FKGF8VbsGYzj2IXO0CFXh3N76JqHstj474yl8eJIY6DxOTVzarOJeZ63K6HA+Bkj5Z7nQ4YMhFfAZeIaVATLRxXLIjwtIxOyrMEVLyyYkG+ZzPGjws08rAurgeu18G4zOwe0hfOiR2Alsxh8Vxe0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(31696002)(6666004)(26005)(40460700003)(316002)(9786002)(8936002)(82310400005)(54906003)(110136005)(8676002)(70586007)(2906002)(70206006)(4326008)(508600001)(5660300002)(44832011)(36756003)(4744005)(53546011)(2616005)(47076005)(186003)(426003)(336012)(83380400001)(31686004)(7636003)(356005)(36860700001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 06:41:37.0114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35744611-a5e8-4740-0f6a-08da28e224c4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0047.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2420
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 4/28/22 04:32, Sherry Sun wrote:
> i.MX8MP use synopsys v3.70a ddr controller IP, so add edac support
> for i.MX8MP based on the EDAC_SYNOPSYS driver.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in V2:
> 1. Improve the patch title and the commit message.
> ---
>   drivers/edac/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 23f11554f400..d3e2477948c8 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -485,7 +485,7 @@ config EDAC_ARMADA_XP
>   
>   config EDAC_SYNOPSYS
>   	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || ARCH_MXC
>   	help
>   	  Support for error detection and correction on the Synopsys DDR
>   	  memory controller.


Acked-by: Michal Simek <michal.simek@amd.com>

M
