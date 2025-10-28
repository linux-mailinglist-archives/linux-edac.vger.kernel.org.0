Return-Path: <linux-edac+bounces-5230-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83738C13CC5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A88F580BA2
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021492FFF87;
	Tue, 28 Oct 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cPuiV8Yf"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCB2BDC34;
	Tue, 28 Oct 2025 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643509; cv=fail; b=uNutH7mzovxwCjVlwBcRAipg5QyWPuMbHTieInWVmr3rHzST5RMlZ5jn1sZbedAT0MJOk1hGP/BzwRfZXGczr0s/loD6UZ0mSHQ2wW8I3zyz/WYmy5EWjF/r6/u68GyFtmD72kWrSDpVMMPLd4PTjR+caVb83cljEY7S58pjZlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643509; c=relaxed/simple;
	bh=Tf1lVsDKZVz1jom0lARbj/oP/QlMPVcZewgorVRkGwY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K3+AKh1hl5+boLOfJ5j/Ne350+5UosBj+fShE91SChMpneOWU679dfTBfwqOQyLvM3dz3prgiwd3LEbXk2Lt4SrwxsLQZQOinMf5wz6BdOmilEa4MdUqbgCdEmFfywsrCGy3itoUVTTb42Od+mWYe6ZwTZFM4FUKKcCAHI//8qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cPuiV8Yf; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCzMdrMHZhA6UjnryjF1/Rvdg8bGVn293iMZd/DeNuItI3etw8vK/g67toUgQ1fK+Z6ry4gNJR2U0Il9HDqUf+o2Uuc9dIrIwCbNgwbM3jq/zoST/kxckmvlrh7IOKrCekFuJSTuFiqXN2qsyotSJ+jbc2LXkiB3ZCmmKEJb/VwXXUu7UZfvgOCyxANkRc1NhxqwUGRtn5QMlC8ZOAX0UY88xHkxFQtrhq7HOUHl0UPmp293CvsoBVHdk1/lT0lPywxwds4azSkaH0wxfz0S25L9fD9T9Hcr1j7AvgsqH7Ju8BE1URsnTW19lnjpp+Ujr6Raj5iXvmUYcpVFH235tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUfko8+C1GJNrrtJHS3TY9zGbBQfiaDfaUso5TyRL6E=;
 b=Kw666Un4SQk9AzEHg9w25GgpxiO2WO0um5nCrS+kSLnQHfX2jcMs6Cb/fxkETrvHtzbUDjZoWpVveKtIgT7f1jb9j9xnAEk+8PE0D0jMeC+uK/HqADmPMQUv71hdfvE9FkvaLHvk2bbP7yCH0vSXmd1umS0ihwbGGPN5Wi/yrxm+COoPSiz6sJebiudIn2nNAOmC+yfMaFFc/bpKsHfQYpWx6oZozQw8nrC3oHP2QpWf/gWw55zIYHpwQ7bdqjY9+tUmOgxVlaPJLbdsRxbTYwds7rgH/bvs5Bl08W67BdUe8FD6JWjKMiggn3osL+CDtOlvEBN/1hsQV0zIEQshTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUfko8+C1GJNrrtJHS3TY9zGbBQfiaDfaUso5TyRL6E=;
 b=cPuiV8YfAaa9CtiSY8eNoI/Ms3/dukU5AHAVAWJkvWHLHPzDRtb82QSTw8rhnZfVPi5SQbep7m0z4HMOVyoKKgBxYJuxO30pdcMbAqghB3GKjZgtquLjEtgf4lZb5mPhqtmoiIwB/AezrZbrjxqj0d7nE743CZJqEFxTQwdKfuZ2euMUagEUvYkzGPTjP1UvNsJ7v5OBgVGFHbhoxwpXnHJGvWlcKepckhr/tuhwMeTuXxl79bcaene3MCfpLeTtjkuSiTom7IphijYoSeJojelo/nu2IXcgd5J4QUa5Y2PFTPGjqJ4QJOHn5RcLkt4NrGkrdqspviVAxHgkg4dNQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 09:25:01 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:01 +0000
From: niravkumarlaxmidas.rabara@altera.com
To: dinguyen@kernel.org,
	matthew.gerlach@altera.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bp@alien8.de,
	tony.luck@intel.com
Cc: linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Subject: [PATCH 1/6] dt-bindings: edac: altera: Document additional ECC instances
Date: Tue, 28 Oct 2025 17:22:27 +0800
Message-Id: <20251028092232.773991-2-niravkumarlaxmidas.rabara@altera.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0010.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:14::7) To BL1PR03MB6037.namprd03.prod.outlook.com
 (2603:10b6:208:309::10)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|CY1PR03MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c65b71-fe11-4417-2d55-08de1603dea0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFh8O+fMe35px4E+bUoCP59km6mQH0DlMS4x1VTLrY8ZuMVIdk7HcvVaeLFJ?=
 =?us-ascii?Q?Nif4YvS6Lcfzsy0i9Pv/SFihosR4PoSn0K11Bkp9PsDgl1IcMygeTZ5ivab4?=
 =?us-ascii?Q?Jc1y3ITe3zrEZ5/nWxSZq7HSy736Is+3dK8GTjyWep+7vcNQfgXdWxWxldCq?=
 =?us-ascii?Q?rqZsMkh7L22KrH6uxSjiAxkdH4Zb9D+diQKBJiwYf/xnVPGCQTFkEZlCe/dF?=
 =?us-ascii?Q?1VGxWvu0DxuJjsp/5DQYI0LKB8aXjDllHBtZyuVfukO7R6hOcjGKViMF9hvf?=
 =?us-ascii?Q?9uaH8fbCSwccy0HD6qoaAlo4j+dw3pADUjAfkvd/dYBdgIMT5fel2C0RQZGi?=
 =?us-ascii?Q?jcIMWpl8ai1EVa3ZnYIpgFaZXqeFhgKlPFHHgVvIdbPViFsmRTsI9cvhQXNl?=
 =?us-ascii?Q?zfqSXT6PNFtv6ilC0mqRh5aEtTeo3Dz1kES1yhd04+d0siY6/Xg3NZHRE8aM?=
 =?us-ascii?Q?G5QctQL107KTEjQLODPDtGR/MIjBiIB0paddCuY4/ydOSGOdcsQ15wlgCmkt?=
 =?us-ascii?Q?xbLpLr2GVvgw4aMNc0y3Zgm5yapWny+2nT2k5N4vCeBJK9qanlfDyYirDRHF?=
 =?us-ascii?Q?eAPHYu+nvQCJ7l00jzvjOcipwynhS+E3ToJgCGdMb8xc1yb6cugnfvYHL4oC?=
 =?us-ascii?Q?3w2X1Si69PJuE+8/5jVlO4+3lM4IGASPLnct1mCDhKEJThnRiWXRqrz2jwSR?=
 =?us-ascii?Q?OdQF/dlA5k8X7wgO+dwjlyfJ6lDIvOZWEyp1i/6HWroaXJYTlaCViEFG8J4h?=
 =?us-ascii?Q?X2k5m3OkGIlKkkDP5EqyDO3oq00mJLhsdPBt6EDpNmVF6gXybIsBGiViwa3T?=
 =?us-ascii?Q?07/bbYniFaxyjeZXEMlVMyDXI/CWq67fOQ6us3Gk+/9TnQwbu39JHe1mOHtW?=
 =?us-ascii?Q?2n1NAv7jo+peH0NORYPUfKHg5rmQIC2PBSUIIJ1JxW4XFugLxllD5UcmVB2r?=
 =?us-ascii?Q?G0xo2spHHoKGqEwWPXPPB61ZUqsqkZKW7kcO4rICKKhR7utolpAdMt9u1cQO?=
 =?us-ascii?Q?uQJfVvYxhqzjz0iL7CeL1Z+JQa6nTRkwD2r982oKBnvlUnsIdX+cTfUOTEGV?=
 =?us-ascii?Q?ptif7vBb+DDztvQoRmwJqIVi57AG2ujZ6qbX90eNjoX8LkiMx96tuKETqvP0?=
 =?us-ascii?Q?tgknn+fvsnwLBNg5rRmY1lxXtOkVdfR89NhDsZVoPphSf/lkrfayTusm/FC9?=
 =?us-ascii?Q?B3737BDnsJTqML6ez+G2J0Z3qBgiCdzaH9W/RnsuBdw6CJ9KInXlwStkZNqE?=
 =?us-ascii?Q?6mpPC5/OM7k8WnzP8OGeoQ+MEYzTL/ojBMxZ6tc+iiItJLFD5FxKIkY6HiDN?=
 =?us-ascii?Q?AF9eKiXjAflLZej/6k9ov3e0DwY2FSVxMRExsZGJayTdVQeDJhmqUA45Axn7?=
 =?us-ascii?Q?fObKP35wRj/Bkl86YSfoa9x8wETKX2q1M1fJTqnnVGpzrlGPeoTzUJGW4aoK?=
 =?us-ascii?Q?/IhGVNAZ679kbQWNAyUmHVaX7MXKPViD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I8/TdIFB/LSgfX07WTNaRaUEkF9yyd3dJOEZpVuldHGfZ9Q0cdnzhxi0Cjbh?=
 =?us-ascii?Q?IPeD+hZnf7kgs5Wk5TE6cJ4+vkuRiJ9O4RxqKKwDptmCNDHThCzBV6ivaxo/?=
 =?us-ascii?Q?0SVY/UKJd8vFrV6Hr026Sy7qW2LSwyoTV5aljwrtN1h6BdNdb4PPBf8oJFnZ?=
 =?us-ascii?Q?EG0KaEJY4GcpgWVdz1ST0/IN9nwJmBlgou2ihY4X7o4PD+CykklSQi2hOeUZ?=
 =?us-ascii?Q?ANZM51ZlDV6CmGMu7ktCQd1ETp7xQC5Z56Xj0ggLkqGP5V8/7Wc/7SAcoX+e?=
 =?us-ascii?Q?dXFbLRk92Wd2fRcGxa84RW3eLaftsCCpBYKvYcVs9flCOBkHfYLrjnlsq6st?=
 =?us-ascii?Q?WyMLSTo9navtDwN1Mo/cIIu1dqJ9NLbNvhlRaYggLaqeSfgaKtlCjC2AoZYc?=
 =?us-ascii?Q?LEIPveYIShYlwNL7c/y4nVuhVSZ9ieN375SCVU7nfK5DL36IRlpPZxmX2xp9?=
 =?us-ascii?Q?rv9iD7EFCU0+/h6FsVku3HPeBGausQKDNV8tPCaJUbyeX0Xc4CBM7js1kAwR?=
 =?us-ascii?Q?03681KKRw4A6vwY6r9EFWDKJVJeSEZ56IY3roNMMDOXNg2PIeItAa8oGrBPi?=
 =?us-ascii?Q?+08AZu9GzbpF98HIDMNbVHMR6T5ECSmvwZFc4+VptC2LjQi29LNhkZIn8zhG?=
 =?us-ascii?Q?JgGb8azncVuSCDgAq3AUxRnrSFoDWHkOrcZNhmVORecbQOu0pKcYmviFYiyW?=
 =?us-ascii?Q?ogF2T7Sd496ulIjnVzvSx8PT/Kst2nc5KFFJ2oLhC0ku6g69Kra7ddtCme1x?=
 =?us-ascii?Q?WIOVPh/KgWe2q4Mqr1fK3NMs9U7322oUfweJYYgF4HC95dRTGVm8XBessEzG?=
 =?us-ascii?Q?lBCevN0bCVBCppo3O2WczJMVR3bW4zNPmUrzCpF6qY69jBE4NPtntY1nPrCw?=
 =?us-ascii?Q?kqE/VtVQhmX+YtORa2wJZD/NkkdVWbIXY6gl1R/+bADdvBTr5LbEHE8dx9Fk?=
 =?us-ascii?Q?uoXDjiy0eFOYZbSf28pIDNJxhxSxaRAUTPboZvc/54nhbPFwiv2Tk2Xb/8cc?=
 =?us-ascii?Q?n8gXnyCsS9XiTjM8T1uGyI0d71a39RM/+Ff4hieVwNr8Bwu09wreitKnPYAi?=
 =?us-ascii?Q?rv9xiHQm7dzOlegie6SFV6sLnnY+1ynUVmNHNKfrrZDHyUo4LOJqk2ke8545?=
 =?us-ascii?Q?1K1n0KhGviQ88avOB7I9GQaBVFAkfX3px5SO9BguvkZPp/UNaRl94pyp/R5Z?=
 =?us-ascii?Q?6OIluoWL6sAdNWu1hy0eu1CCI9eLfxOGfE1d181jBg17WKrk6GQH41VTsBmh?=
 =?us-ascii?Q?bOhE9adCAzc9sbbLr4Ke/zjQ3hS/CEGivPvwMW2qZFNNevYxH0KtGMr7w1vV?=
 =?us-ascii?Q?prwt/kFo036ICg8FlGEUAaaXE4ktPZeQ+HCtISyt3tmpWkacd0P2u2N0ZKfk?=
 =?us-ascii?Q?kN8lS3gZRkaAFvMPnTYz3ZnC2Cp7+KbfPf2EKC5gfKBcqYrKVeNReFeefydF?=
 =?us-ascii?Q?j7ZkPjEBmp2fOU+a9xpGR6fgd7uiPhvma4JQuRYsn5SLYr7MgtqDnThOotZw?=
 =?us-ascii?Q?d+IcrKXTbAiVFfOMoOTIGZ1dIO0RA6lURbn8qiWI+YZ3bc3EZ1gdtyQMv3tC?=
 =?us-ascii?Q?N2RX9FYwA7C7vOtDfrcqJcnhgR9x6PfU6n2bDc/todH84qN5eDyceV/5kDHG?=
 =?us-ascii?Q?cWwcH8ZELtaTrZYOcpO2r9ONR1pihBLIRX+9BjQGvXcc?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c65b71-fe11-4417-2d55-08de1603dea0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:01.2580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJppbxWqec5G7T3QU66wdtzZkH8gMIYP6xohcuEJCEIlTGDnwPv9Hj1ay/y8sX7rvDCPMieBtOZvpeBEdh6rQhZHFHamHwFVajfpBevINLfepezwKXhpFqD/lzlfOnnR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8121

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add support for Secure Device Manager(SDM) QSPI ECC, IO96B memory
controller ECC and Configuration RAM(CRAM) Single Event Upset(SEU).

Add interrupt-names property and increase interrupts maxItems from 2 to 7
to accommodate additional interrupts.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 .../edac/altr,socfpga-ecc-manager.yaml        | 77 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
index 3d787dea0f14..5e0c08a15ab9 100644
--- a/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
+++ b/Documentation/devicetree/bindings/edac/altr,socfpga-ecc-manager.yaml
@@ -33,7 +33,13 @@ properties:
 
   interrupts:
     minItems: 1
-    maxItems: 2
+    maxItems: 7
+
+  interrupt-names:
+    items:
+      enum: [global_sbe, global_dbe, io96b0, io96b1, sdm_qspi_sbe, sdm_qspi_dbe, sdm_seu]
+    minItems: 1
+    maxItems: 7
 
   interrupt-controller: true
 
@@ -70,6 +76,41 @@ properties:
       - interrupts
       - altr,sdr-syscon
 
+  cram-seu:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-cram-seu
+
+      reg:
+        maxItems: 1
+
+      altr,seu-safe-inject-ce-msb:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: MSB of error injection command for Correctable Error
+
+      altr,seu-safe-inject-ce-lsb:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: LSB of error injection command for Correctable Error
+
+      altr,seu-safe-inject-ue-msb:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: MSB of error injection command for Uncorrectable Error
+
+      altr,seu-safe-inject-ue-lsb:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: LSB of error injection command for Uncorrectable Error
+
+    required:
+      - compatible
+      - altr,seu-safe-inject-ce-msb
+      - altr,seu-safe-inject-ce-lsb
+      - altr,seu-safe-inject-ue-msb
+      - altr,seu-safe-inject-ue-lsb
+
 patternProperties:
   "^ocram-ecc@[a-f0-9]+$":
     type: object
@@ -191,6 +232,40 @@ patternProperties:
       - interrupts
       - altr,ecc-parent
 
+  "^sdm-qspi-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - const: altr,socfpga-sdm-qspi-ecc
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
+  "^io96b[0-9]-ecc@[a-f0-9]+$":
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        items:
+          - enum:
+              - altr,socfpga-io96b0-ecc
+              - altr,socfpga-io96b1-ecc
+
+      reg:
+        maxItems: 1
+
+    required:
+      - compatible
+      - reg
+
   "^l2-ecc@[a-f0-9]+$":
     type: object
     additionalProperties: false
-- 
2.25.1


