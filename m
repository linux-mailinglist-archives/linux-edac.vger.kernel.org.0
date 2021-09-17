Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414A40F74C
	for <lists+linux-edac@lfdr.de>; Fri, 17 Sep 2021 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhIQMNS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Sep 2021 08:13:18 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:12384
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhIQMNR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 17 Sep 2021 08:13:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxab4UzctSLQf+JZa2qJDtABcKNS6GwEvzvPfo/jKn9LrK1GtXquLK+o5h02NYP7VNIleosn85OW4e5Phh2hSL6aUMouqfwwC6FXNP7Wxwi/5UXZuDCO3M71/bB+EBkjPJIlpJWGa9hYmUqsyY81Z4HQ7WRRKktwMaNVSLBBY/w8d/lIGXq6DRJSTXhm3E3CxlASTvzzxCDu1lzttgjbpiyLHAY3Bbx4befup2DTmK4TQzu74k/8gTyf90Hb2dEKKUhxkzil2KsdfQRXpeS5cz8mr+FV2Q2tILplhAn7yRV1tS38SXWCO0tKBY+Y1gstnz4fLDMCCAqIQa3COJ87sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GJJmM507TtWNBgFU99HIhBq77LfajUw8aK/oUz0pfCQ=;
 b=OyWp8l273IOGQKpO4WiUlEwC1Z9q/9gAEQXFffJSLBYn+TguCIPKbtJJn92wb5xH2Od+rgbd1sVGdgmSsrXvq0TosiHMvceKIrhY1MZ62wcBFhx/hmbsg064x7GXZ5CrRFWo89OTL9Hwh5ZsNCRqUDhc8S8zbQjBOVbGQNEJzhP1KRt520G7HpDSJDsnWW7A72KHIjINmdilg6jgNx/kyxKiq9F5sh1JOFP0xdvmxOQtWUw/c7rEyMmtq7RGencs/bjg+w7uGXRx73+G6/2twMj0ArrPN2cl7yGIzXQXfeLoU7R/YdlFaZwxLJ/VTNarfJW89DsuIOVY7gRj/0wdfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJJmM507TtWNBgFU99HIhBq77LfajUw8aK/oUz0pfCQ=;
 b=B8sF3ZDQsYln31sQP0VAF+hjUk5XVoaLOlu6lpWr5UQSA/E5fcXVfeEHgA9BKHUwxsmrih7FE7GKR6CAwVx1etP0t+0AkdOsFdJ07lRBQGl82BLkWBzRFvClrLixRTCN/JINCBQlVEuwAt1BDDtniUndpT5wgnOQRk8YDO+wVWg=
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by MN2PR02MB6078.namprd02.prod.outlook.com (2603:10b6:208:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 12:11:53 +0000
Received: from BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::d9) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 12:11:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT021.mail.protection.outlook.com (10.13.2.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 12:11:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:11:52 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:11:52 -0700
Envelope-to: linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rric@kernel.org,
 james.morse@arm.com,
 tony.luck@intel.com,
 mchehab@kernel.org,
 bp@alien8.de,
 dinguyen@kernel.org
Received: from [10.254.241.49] (port=54582)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mRCie-0008LY-3P; Fri, 17 Sep 2021 05:11:52 -0700
Subject: Re: [PATCHv2 2/2] EDAC/synopsys: v3.80a of the synopsys edac
 contoller is also on the N5X
To:     Dinh Nguyen <dinguyen@kernel.org>, <michal.simek@xilinx.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <rric@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <20210916231231.1430499-1-dinguyen@kernel.org>
 <20210916231231.1430499-2-dinguyen@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <cd90a6b5-676d-bc11-2438-39e8e5000f48@xilinx.com>
Date:   Fri, 17 Sep 2021 14:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916231231.1430499-2-dinguyen@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc290a35-c67c-4653-0b1a-08d979d4560d
X-MS-TrafficTypeDiagnostic: MN2PR02MB6078:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6078CF3A1CBBC522FFFA75BBC6DD9@MN2PR02MB6078.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jRJQ1QNKdYlgmPECBCDIo3CNMtvGnnp8PwanlurDELNJI16lauFgQMuaw2JsUaiNagHywka04VidRrapjzNsjOM4yeEqxixBmlQ4hcbkGO//ndV98AWBovg7IHm83/Gix6042hSih+mYh8li7aQuMiIh6XaVQaBxTBUzSJCUBXmC9aMHWlhMr4plb25BGO1S00q4mzjtro47DFpwPx589qbrpbMwql9QKv3kRtMMyQhGtiH1DgxtjeTl1cSA2ygFo3rwnLAaPwfk/bcXSis7EM4hg2Mhy1o/Ov3N6z/IJi11ef0oPGB0Im1zBx7d4lMJCS/iNuG38hQBxOxtCHFEbTM2bBeYeyP7/inPhUcB3pOj62JvGVRr7QA+iv24laVYyIXG0pb8VlLTaMW62QC0LFVbiIehAhSJOV51Y0fyVWQRVt/8KCPzzk4M/GIDRlgDwegwdlOxEyStyle/fsBtCjy97kcwFn45ikCaw8AF+b4OHvzEdnOYvCF4SLxMNAH0yq9jikwpxRC5QySacKDyrZmF49HNRdltWYMVbg3tFpJHQ7ZaIs0xKpLYu7GzRr1hBP3GgSBBYLEitZaYNpSgQdHdcV8/9Ke/uy5JmUwTPg1X6PrACzkAl+Umw5GhQ+SqbOkJtxEXDQh/HL2Zk+MTE0XouixdaQlErMwTGrxITdLWEhvOPDF22PTT+hj17lVGyXwNz18N8IUa6jzn5TLdGixzDDhudj0zBTpIcQd6jwuDXBP4ZXymJ+x5Qb5UnYAWPE/Hy6XTumXSkckZraOd2A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(316002)(54906003)(336012)(2906002)(110136005)(36906005)(426003)(47076005)(44832011)(186003)(31686004)(82310400003)(70206006)(8676002)(8936002)(9786002)(2616005)(4326008)(26005)(53546011)(6666004)(356005)(36756003)(31696002)(478600001)(36860700001)(83380400001)(82740400003)(5660300002)(7636003)(4744005)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 12:11:53.1879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc290a35-c67c-4653-0b1a-08d979d4560d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6078
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/17/21 1:12 AM, Dinh Nguyen wrote:
> Intel's N5X platform is also using the Synopsys EDAC controller.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> v2: no changes
> ---
>  drivers/edac/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 2fc4c3f91fd5..df46e7483aa0 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ || ARCH_ZYNQMP
> +	depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_N5X
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> 

NACK.
You have removed ARCH_N5X already
4a9a1a5602d8 ("arm64: socfpga: merge Agilex and N5X into
ARCH_INTEL_SOCFPGA")
I can't see any reason to use this symbol.

Also ARCH_N5X is in arm64 defconfig which should be removed.

M
