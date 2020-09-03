Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A423925C9DD
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgICUCN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:13 -0400
Received: from mail-dm6nam12on2060.outbound.protection.outlook.com ([40.107.243.60]:48609
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729184AbgICUCL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9I6+AZ7NLxREsbeviqnB9KhdriLYsXDsx8ApIqCQU1vnKWItje/QR4FAFzrBL4E4RHwMpWILUUrLaCj+E4FRjc9EtWiDcv9A1DlEBCq97zWoLl7EWWJWhgYBIQccW5vA1byc/UB3HrfjDcK9CNcZiHU2LDUm9+BDZmrBATcAgn1RZhj60xARb3ONoZmwSrX2DLtIaj9gLldlraKkBxyxgdyU2/3svNxh1xWIIz3tyrJC7yLXPLWDjj+cb4aRmEOgyxBXa8zdLd61Zj8R4G4p8+8cOEWPCtDrU7f3yWffJJkpeB7oAUQ+sWxZHBtaa+M8BDzV/4A0fz7iYVRkkXMgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg2B3IsQ8Wpo+X2Ac2BpWB9G0oszIn8UU66X5NJpMbA=;
 b=jsme8xSXGnfsOWh/5mByOfskwW35t5fCJ3HnvLSOe50jMZ2aZlL/aLodGK46j+v8nqEaewtugBJo4Q+M3PLE8oPK4UaK5lqZ+iW/Fb7mSa8A80ZvcGt5mO9KpCVRdonIJvKeAmFhLC6G/7Fc4GlSO1C5yZbsUSEFJNbzCrUS/6tFEGZfSytwqCVeKtiZZiG1qHKAdu8NpCkCtPdlQ3n6n0S2fqS5ggd1k/6dzWhYHgWt/xd2JgNU2RDoPKCiiu92WxnDJwMheLBheKySIHz67/CSfqmZCo3pl2/is7YABaOBpGn3SYRSyR+AWPlaOoLoDbG08fAZRKQAtTChxo7stw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg2B3IsQ8Wpo+X2Ac2BpWB9G0oszIn8UU66X5NJpMbA=;
 b=byg9VX5HtssiLhic8OZOozYj69E4wq7uNCUs4dw4+SI0I+wy0TUXVnJWX9gUbcv32DU+wNMF1oeHve4Ho51OmfMSu2eKmgHkA7XgLZW6soOPbnWf6Qx3FIy8ujLnH+z6F8iwh9hw0UUI5E2ujFW6xFkvHXhAuAHx0a1W9MLMck0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB3171.namprd12.prod.outlook.com (2603:10b6:408:99::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 20:01:54 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:54 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 7/8] x86/MCE/AMD: Group register reads in translation code
Date:   Thu,  3 Sep 2020 20:01:43 +0000
Message-Id: <20200903200144.310991-8-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8f09c3b-69e7-4c5f-5384-08d850443465
X-MS-TrafficTypeDiagnostic: BN8PR12MB3171:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB31714302029510592CE890B2F82C0@BN8PR12MB3171.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNhNqkAXcVfSWCDAXqbypGr92u9mEOSw7oKXl/BJJcuSs4E8xqm5wNsWq56aeK2VjNImeaSSC5MDfMEiTrjv8p1hfTjyl26dJn/wPa1kZ9gDBUh1WOHMcmTDHY193Lm8sBmVbqHriBZF2si7GitiWqRVeTYmWe/LmLjuG3phJMX/CZT14cVUsSgoQMB16kznFMJo3cIIT+BMsELTYrFRKlTQhpawC5lTFtrxuNEVi0u0Ox8uOFD3+lHE7XP3ZhPwqTKgeLVgDVJxnT04nAbkfOAlVTzx/J+sp4NY4onsHGgXDL/fLxCb2a3OWUp5eYVt8AHDMm8+MCNngf9ULzMHHdM9Zf0tZXgGT0QuFjGcJOF5fEXOEAa+3dKY2WenXGrwLH/G6Iu6duV4ERPxY39mQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(346002)(376002)(8936002)(36756003)(6666004)(478600001)(186003)(316002)(6486002)(966005)(26005)(8676002)(52116002)(16576012)(5660300002)(66476007)(86362001)(4326008)(6916009)(66556008)(2616005)(956004)(66946007)(2906002)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: d0lCd5uyKcDkbV9qul5MWxg+bVkkyaVitMO8SkFI0KyMT5a+b9lvJrXk0cbD+puKbcBYErfWlRKl0/nOgz9xMOOGCT7A/7D+eIWBQZ9m9cl7EgUeQk9fmfXcKftn7Iz3atgp6/L45jw4/7X/TBPC9gPH6Y6iiSdM4dDvienUx7k2EXaGvTBq4HDu2FcRTx2V3dYFbWcfgm/cF9d7p3H3G7mViUF+P73sqBb90q9v3N7k2H+35qf4h/DUUM/c5ZEhEj+T/lmWobtKuxGiEiP//yscSix98wq/EMfVh6dL9VfMQBjZMqHVLvXQeAE+wgSuqWd2ttPkHAZeqBIMO1O3iSPVHQo9A9k4eBikzYpo60FKJk8PdSMxTwYk0byehPfZ0RsxupOsCgFTHT9to6+8DHYAV/zJg8hm+NVgx1errdqvELJMRJ8u3Zk8c+BJv9NXbtsc2DPiQ2plxUDJUgqMlyBrbV1aNQOuhXdZTvq7AyFdXQJjArobydKnY8WHDKFPeANGS0GDCbpKA/e66PQZESYK/mBU6LJovTHHB7dDvo1HR+LZbpi0X8faqOsva6eBbIaPjdRdailo5omZ6b1YeLc0u5RsSQGysTxWwCPGhxnUuxsOi4GleOOcmHCu4N1WhpaAgrVt8v73WRz/QxZL2A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f09c3b-69e7-4c5f-5384-08d850443465
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:54.1218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jv5HF2MCg0Es31sfgvAIAp2CrWmzjT7r0LHHpS4ad2Ftz4e264oiukK3XobpnPfKTRGxVjV8+fJdeJA5caKIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3171
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

...so that bitfield extraction can be done together to simplify future
patches.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-3-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch based on comments for v1 Patch 2.

 arch/x86/kernel/cpu/mce/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5a18937ff7cd..f5440f8000e9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -729,11 +729,18 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
+	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &reg_dram_limit_addr))
+		goto out_err;
+
 	lgcy_mmio_hole_en = get_bit(reg_dram_base_addr, 1);
 	intlv_num_chan	  = get_bits(reg_dram_base_addr, 7, 4);
 	intlv_addr_sel	  = get_bits(reg_dram_base_addr, 10, 8);
 	dram_base_addr	  = get_bits(reg_dram_base_addr, 31, 12) << 28;
 
+	intlv_num_sockets = get_bit(reg_dram_limit_addr, 8);
+	intlv_num_dies	  = get_bits(reg_dram_limit_addr, 11, 10);
+	dram_limit_addr	  = (get_bits(reg_dram_limit_addr, 31, 12) << 28) | GENMASK_ULL(27, 0);
+
 	/* {0, 1, 2, 3} map to address bits {8, 9, 10, 11} respectively */
 	if (intlv_addr_sel > 3) {
 		pr_err("%s: Invalid interleave address select %d.\n",
@@ -741,13 +748,6 @@ int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 		goto out_err;
 	}
 
-	if (amd_df_indirect_read(nid, 0, DF_F0_DRAMLIMITADDR + (8 * base), umc, &reg_dram_limit_addr))
-		goto out_err;
-
-	intlv_num_sockets = get_bit(reg_dram_limit_addr, 8);
-	intlv_num_dies	  = get_bits(reg_dram_limit_addr, 11, 10);
-	dram_limit_addr	  = (get_bits(reg_dram_limit_addr, 31, 12) << 28) | GENMASK_ULL(27, 0);
-
 	intlv_addr_bit = intlv_addr_sel + 8;
 
 	/* Re-use intlv_num_chan by setting it equal to log2(#channels) */
-- 
2.25.1

