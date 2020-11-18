Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B72B7EC9
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 15:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgKRN5z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 08:57:55 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:42912
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgKRN5y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 08:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfO4NoSQLgTKTjABURRb4HkaTEE1AJ+2T2KxdhZ6K54xb36zaO8+cSKm+V0qK7RjXiJ2eAcS3YkUDXvETfNIUctzWhFPu0V5vJRiOycqk/8Y3DNhENgp0vpGyEiZ174OGlvP0NzTEW6eGSEHouLvgRnHfcHe0rsEVqUHVxfOEPdVcwJjt4JP9D7Igt1WUkq5szcJpBaksRk9lR+hABJqZnji9Tc0XFBx2fdNV632XeMsGi9kUH7dgs+gqvffNKqh2Z3+ygGCv0C3D5dQAzcFtx6t1uG3hjIl8+uQTCLg21dTWJiG+zV80tZlqGARztK+2clSdcSL9A5y23iI6EEndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjPVXFPUkqhQKfu7LhqTR0D9JPQuM6d1/iIouj8yIHM=;
 b=OorxNBybP/6kAoFRP5to6tMGxvi+3U2BxI0Wa2yW7CIcSvvLKwI/79y7qkKb8CHahDqsH/zlPBIlAD9Zfebvuy86VjOTWXKXURW07Qe4BtXDygYp5qjHveEggfTyVC1oqPltF6GkaNR++5y8yshkJJXN50vCutlSNF44rI71bO1i2USXW5z+S5bWg9NFA62rAGY8RGA96qh2d6Mw/03hR0ewTS6M2ewzfR0JIPoHrglTfINzmNdYFTzzLi0b/McSrfhB0aa/ios7YYP8bWFUkjzTRYyIr2yl6Y+fPyn051UXWroVHBwpv+YK4sSjEaj5EErF9LKYn3QZrVpXg6y/DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjPVXFPUkqhQKfu7LhqTR0D9JPQuM6d1/iIouj8yIHM=;
 b=X2yMuyc3DGExMYC+MXKpUdjnt5lLYPD3NsvPNcD7Iv/3IDZz65LNjVyw0dAhrvWlPC7UKGQnTH6bEultjj1srPIxGAsW0ilFbwJYQOxZFWwLFc+udD0epLYLK2kmt6+R4Lz2j//P1b60KL1WNAeyt2wBRn+qPdsN3djjv+UzHv0=
Received: from SN4PR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:803:2b::19) by BY5PR02MB6549.namprd02.prod.outlook.com
 (2603:10b6:a03:1d9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 18 Nov
 2020 13:57:51 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2b:cafe::dd) by SN4PR0201CA0009.outlook.office365.com
 (2603:10b6:803:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 13:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Wed, 18 Nov 2020 13:57:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 18 Nov 2020 05:57:50 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 18 Nov 2020 05:57:50 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-edac@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 zhangxiaoxu5@huawei.com
Received: from [172.30.17.110] (port=47566)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kfNy2-0002Kq-EQ; Wed, 18 Nov 2020 05:57:50 -0800
Subject: Re: [PATCH] EDAC/synopsys: Fix wrong return value of mc_probe()
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>, <michal.simek@xilinx.com>,
        <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>
References: <20201116135810.3130845-1-zhangxiaoxu5@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <89beec52-28db-bf76-79a5-da65ead85081@xilinx.com>
Date:   Wed, 18 Nov 2020 14:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201116135810.3130845-1-zhangxiaoxu5@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d68675a8-adac-404a-68bb-08d88bc9f0a9
X-MS-TrafficTypeDiagnostic: BY5PR02MB6549:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6549AA4E294E58BDC51A598EC6E10@BY5PR02MB6549.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4ML+LSUmP4sdR9Q/MgeOjQG3e0ijHdFwwxxumjGjaLqMgixEhfvFkBc2Rb37VEdRH7fx6IAhxBdy7qq0vt5rsfB4z3zcK0EwHIyAfKziTc3G79pK24aoRnsuFci56Zqsc77dwvGqzxwNaUAVnpBHaaOebyKaSPXYluMtEb01gvaknDvGz9HGQL8NMGjumHvy089bkHIBcSLTELo0bDH3mDfTHQKXC0InCpQmUBdHNV5ndIDQFhyPKtP5IP2TZBEE2AlONrjY7MwrJx6QCVO+jAROBLAM9wY8NwTEhIQvW+feRbPyB6b+ty4wLc0HP5QvZHWJVhUKDLDAO2voRh6EWr0lRYDBpwGau/dfLIEFshCMBozVIwkyNKJ/j/48jfRpS9gQ/6UNQl7cZU6ivlgD7uu/eC8ObJHZPULhl9uv8X5W66faht5u0mH2BC893yNXJ91SN6udyOl12VJOW8D4fTCcSAqQcPXydBge4GqaqY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(46966005)(426003)(316002)(36906005)(31686004)(47076004)(82740400003)(356005)(4744005)(82310400003)(8936002)(8676002)(7636003)(44832011)(9786002)(2906002)(83380400001)(336012)(110136005)(478600001)(70586007)(36756003)(26005)(31696002)(186003)(6666004)(2616005)(5660300002)(70206006)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 13:57:51.4077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68675a8-adac-404a-68bb-08d88bc9f0a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6549
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 16. 11. 20 14:58, Zhang Xiaoxu wrote:
> If create the inject sysfs file failed, we should return
> the error, rather than 0. Otherwise, there maybe error
> pointer access.
> 
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/edac/synopsys_edac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 12211dc040e8..7e7146b22c16 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1344,7 +1344,8 @@ static int mc_probe(struct platform_device *pdev)
>  
>  #ifdef CONFIG_EDAC_DEBUG
>  	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
> -		if (edac_create_sysfs_attributes(mci)) {
> +		rc = edac_create_sysfs_attributes(mci);
> +		if (rc) {
>  			edac_printk(KERN_ERR, EDAC_MC,
>  					"Failed to create sysfs entries\n");
>  			goto free_edac_mc;
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
