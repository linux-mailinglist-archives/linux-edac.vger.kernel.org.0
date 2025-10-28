Return-Path: <linux-edac+bounces-5232-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A5C13CD7
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51860583BBA
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2290301484;
	Tue, 28 Oct 2025 09:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="HGx8XbNv"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012056.outbound.protection.outlook.com [40.93.195.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C1301005;
	Tue, 28 Oct 2025 09:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643518; cv=fail; b=TSk4yUhQ9GS1AvW0AXYqrKoZp+B6uXXi1OY/sqHcmGkQdyscKcyNg/zfKkSlFNoc2ynDMPl2u9nfxmE4n37MbwuMDY7surw0++Ny0nHwrjZb/Sz3XPQ1kvq6AjYBvkxbLKGxHOR2M53YBu5gpLdoPhWp0Gs7Xk0JU9T2xUtbvAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643518; c=relaxed/simple;
	bh=szKdNzdqtK9hdY9TCio2rb6bgxT++RO+svRML/H2Lr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5Z6iYz5fMwN94yoqIcRuiGfpV/KBeNwfoeOg8y1S4ijUL6n5FWjlFTj2ExEu8CfOnslZnM8XteDtGpJpfypDls56Dw4Tar8QNNYC4HYoeFFuPy5PcLvPZ8+o7wJUb7mJLhOdj4L+IDpDCMrA3VldPri9clS38QERnEKgMHTTcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=HGx8XbNv; arc=fail smtp.client-ip=40.93.195.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLJwdKrRkJF72rh4hSyZK2RkBir531ZR1v5ala2wAPb5fs3eB7+nzqrmO/XePjqWLkUeiIXrlCWCy8unyxK1WtEql/xUkNm72uUMYVMkYu6yr7oJU95X+bp+p70HZ/hVZ/GZxcQO4t0BH8uhZYOo55XKYrSrlaxTiL4atjXdJ7rZ2jtKrN6V2aityl4aIWZCUprra9SqKhqsiQoKNsRyOWwQn0UzMgQpM6u4Tt3sQ/Zhqlyx4DCR4ktZRo2dp7yAzjOOQE1b3K5ptrCD5z7pQWnzCpryzaZBK9efoUq6UAs4l9z2V9htjctPW16GkhrK8HOPfVP1LddyEZ/vnnGv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6g6LRWRDWpEjdTE0YdUE39psHK0yzmaOi5dUbCUFvI=;
 b=EBB4M/D2tpmgqyCKFieCl52wLR04efPwJ0REPT9YdNPtxBpgaJEfuI2/zU/SnfuLXMCMYFmhsbJSxmuVtUN1fe/TB1gpi++cOOuqCtyMfqIyYtnGQo+C4EAf5YPznq7Pdk75MOjNcaOKqo8McRTs/aKfk2vpUDl2e/U/UmHHsoRQ1GzpVT9rvCYNqc4xRBa6OrmOzBjsFLPL6nMlsB4MKKF4e7CCuEDpYxV68PIIwkiZAdc79YtsjYhHpbZvUZ9oqfBgasyBmfCjCd2HM9xgqTSHpaXaIIsUCP+TTlHx5+WyrxrBPVDgXNcw2ld7VNmIEHqmfVI0HIpEZ9B3Xlbjlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6g6LRWRDWpEjdTE0YdUE39psHK0yzmaOi5dUbCUFvI=;
 b=HGx8XbNvi85CNxbSZqRLj30SU34eym+DjEE4tOTN7oyrGYQGvGF/YTsWeMla+yo4Vd/BVPQ14TXAIbMIS49HZUZAdLCgGnEjYOnTfAKgrq6MSjr9mm5V/IXKiMDOs/6U+qOK6hVMwhqpxdwksn95j2RX6nWmjLxRW6S5A/eCGPRcfN/S3gEZRdgeEOH20g0J/lvvkJPEDwU/YPX6WDnCOV7WlrUk7pBUsDqHy5DfESCxM7A3u32YYCDbABLLvzkxv4nPYUSuKKd9nlHy5iEMzYP1NmpHiQDD1Hd0r2+8or/QbuQbkttHTC5yGmgS2KVG2EWutFaN5905EiDiYt7LZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:25:14 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:13 +0000
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
Subject: [PATCH 3/6] EDAC/altera: Add DBE interrupt handling for Agilex5
Date: Tue, 28 Oct 2025 17:22:29 +0800
Message-Id: <20251028092232.773991-4-niravkumarlaxmidas.rabara@altera.com>
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
X-MS-TrafficTypeDiagnostic: BL1PR03MB6037:EE_|PH0PR03MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: 07aad11e-e5b7-4a1b-34ae-08de1603e618
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A+auj5V/uj+IneM6YRZKXZc9/6CGmTF/fx72dsE2W6/LxZdA9VHb7AIa6vB2?=
 =?us-ascii?Q?ooBAD7PFpH3W03Pyx/+LYgz3wEX4lE6qFWdfL9TmIGtUHMv7HChKYjGuGFSN?=
 =?us-ascii?Q?jsvV4qUNgSxehVN16tWSnZS5jFlgmcHheC0OBEc3Aq9NuC0Z8sC/Xy0PMWIM?=
 =?us-ascii?Q?CB1gbbk2/l+SEsT0tMm6vAYJXiNheAM4I/fcVzWtHIII+X8mYabtyQVVdP+U?=
 =?us-ascii?Q?MNizaqq4U7hhPjA+3nhlnMU33EjmTaqj8XK876hGM9q0RgHP0ZeF2myvNnAF?=
 =?us-ascii?Q?zo8XMI4/6yGdVKqGZ8e2415470Do+WnBzAHn8HrDtojdsRs8v84qlkxjiUrP?=
 =?us-ascii?Q?/m6WE6+yfr6DkGEfS0kihV2/fO6Jq/A6/KaMakdvpIGEjE3yr/c8WkKuvotB?=
 =?us-ascii?Q?mWkEtBJ1XX+Qwa+ayQJA6OX6ZePimjp4tCr0ByXQiZHQhVjoysetrlnnDytv?=
 =?us-ascii?Q?bP4ee8Ms8Z2D3sU6Qc3tKDg9ce+hxhyx+Wq3ljOAJonc9+maN63AodF7Qvdp?=
 =?us-ascii?Q?pTiyCSy9aCHnwoLV/Bb/eggkzNPVeBbvQU67rISqUl7CrOL7kFnP3HyBiXtd?=
 =?us-ascii?Q?RlOViDbir7/+G2t3JWrMiKTJ8usr2iCvg97nSmeD42STvkGKb5xhXLgXZZs+?=
 =?us-ascii?Q?t6GOiPZpqb1cySJEpU/kM7w4/PFndeH6Hl0t87nFfWTrRsTBs8m82mktDnYV?=
 =?us-ascii?Q?W98220swe0++7B1fn1FqtHSpJRXzNJ95A7cYGTWGhhIZClp/P5vUPkkskh0T?=
 =?us-ascii?Q?jyHwP+kZLqm1iKtVNL2htlrMseqMUsLNcttz9y8lTAp8G4SK6zBlxyw8Fwv9?=
 =?us-ascii?Q?22phG8aUXl9jLyAdOPJ0+4AwampBhsAbzpfyv2BMEFSN7SpeuXeELaCFi3TF?=
 =?us-ascii?Q?jdEpTcJPhLq2Ehz78OTFEYCRAipNoeEKBeTDFtJWs1NC1rjlJvvP2yk6hYkx?=
 =?us-ascii?Q?8ME3loNEPkEdncl+fnFdlyuqOm0Ommnspw7LgYJHRdd8oIvPc77U8vlUJ5if?=
 =?us-ascii?Q?bGe8PwzoCma2UFZBi7WLJHWYXKWFtWhy/5YehZgAhpPW6H7qtEPdYJ/Hq/AS?=
 =?us-ascii?Q?Ke4/9/RnshyDI8IgNrYkpGalZ6kVVIlTSzotQTf7EZaQPLiw1YfQ70Ayi9on?=
 =?us-ascii?Q?pY3cEthgDZ1kXTsBxZPsiJDxJd6abyTfKwpVzNZO8ZTajQq9huouGtUiJAVb?=
 =?us-ascii?Q?Aq9qQyCJZPl+wZd0UmOORw4LMIuE4eF/jUCEqQ+H7POubHMvN5NXI+yFO8Fx?=
 =?us-ascii?Q?e0OHNlf8WVsYrE7bjH5Ug5V8Icb+1mj2Xh2lXJ4QIBrfnnRSfHdrgS7fGT9V?=
 =?us-ascii?Q?OaAGkfF/dxsYu+tdIs8bnb34r0YNLIoXWLYUJ7Q976UnuGN0Tv6Z1cfpbkTX?=
 =?us-ascii?Q?7G92j9qAUTSghqv7WM67dB6TEY4aaG5372OLamHX9yQ+VTf2rBokBBgFtvds?=
 =?us-ascii?Q?+TtBKCN3VJoQejZU7ZyXN43ZaYGBCLjq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2viMukPfKuyyCs7c6mxQSczcCv2xRyO89Qm9DkfjjuRlW4MsOEO5S/T9nUwV?=
 =?us-ascii?Q?6IZuUHtVW02D6XnGd9gze4cTfnXYTPk9bEsHmeZgAxzAUwH46SsXdWopyHYi?=
 =?us-ascii?Q?7mcZmlu1DnKmmIT+PCx+rOsMik9odVQ12krLFRXwoDJxyC2hzZ7oudNjEAG0?=
 =?us-ascii?Q?5hg62Hjkz+mDPUdXUG8+bet4gtv8Vco6cgYE/a7OqaOjML2mPgxJyVH8YEY4?=
 =?us-ascii?Q?AdF5cRx6YW5kz2M7/Hi81PhPYcgBXEVAoW8wgQ5yFz7FaTOdK+08VSsgyeOT?=
 =?us-ascii?Q?4hYk5adtSZTj/K/g+MPYOCpiXX4YWZpOItlI9XH3Wmmwzgtog/kuguBvHc2N?=
 =?us-ascii?Q?vliJ8ybv5/7JmMRqa9XRG8DTevIeaaqLd1FieD1tC+TaaZS16zgsYIEKAO8Q?=
 =?us-ascii?Q?nPgq3DkuinYgr/ODSG0cA7JQPfZSkNCAFSGifk7caIatMaqAyKzsXBeUhhbN?=
 =?us-ascii?Q?sCf/03+QG/88q0MN960uPrrqk/UqNoO4JOubDtAsaVbpHZtvFOQaDz++uQbH?=
 =?us-ascii?Q?CHplb+IhfIOBjULkcVrEgE/ybrvAlUb8LjfAk89W7Q90TVvmbxdVnVUEFTS/?=
 =?us-ascii?Q?escDU30+0etLQpEEaK2fHJm0svtj39Y8v/x/Ld68UoMWJllng+gJJHzwZ/7H?=
 =?us-ascii?Q?k2uyHNylh1tcbeNXAduF0ZjoYzDEwMztNaRMBYSC44QaXumItBiCXIh0NpGP?=
 =?us-ascii?Q?QXujfXSQbsmWAQg2B52CtqonjODs/0Bdw7DggrlL9Tj5griUufbE+79SL/bN?=
 =?us-ascii?Q?TEtDGjdDkLTEGA7oAe0UgIimIO/cFPs7vAgluu7elXk5YgpwE/AeGBcpHhe0?=
 =?us-ascii?Q?EJqWI+ZMec7Npw8QzkdoN/1cZYtZq2wTYXaQ9ghT2xw+paoxE/wgX+uFH7vV?=
 =?us-ascii?Q?55vTCTh2LglzdlRzIq8rrpq0/MofVXyzziwkkdtkkpQqse3koI17nqpIMmyP?=
 =?us-ascii?Q?4YKXdSMt/e1lAHnepHBJDJSuLcCsxthLLb0KVb5FFeKoFrx4LDMglg1KXTVX?=
 =?us-ascii?Q?LmH37lN0jsuSI6Y6pIJ5j0OtwBrURUe5nwGmmrsrYa+T/pFj2ZcX9HuJ4uKK?=
 =?us-ascii?Q?V28fIqteyjKZM/Hwz/9bnn9HHc0EraKMZaAYyN5Iwxp7t37YEtN9Ou3hQK0v?=
 =?us-ascii?Q?yGYrst81i93nheiZ7ALNSaQ+Tpe09IMQ4/kgynM9UAbNwZMV+t+dTkztFHq2?=
 =?us-ascii?Q?BVqST1S9MqdXKS5AEkIqNnAdNYTdRpaRWY13zJeTsXRzTaRU4l14jgXSPVtH?=
 =?us-ascii?Q?ACu/40IHa9rZViw3MqPFYW3QU2jJMdTDcgY38MOy/0VjJFIeSn7kZ1eg/cGz?=
 =?us-ascii?Q?kcEEsnSuMvjS3M0I0wFZW8ak150gToRjRryf7j+daB0QuPEWzHEQ1RA9wUcR?=
 =?us-ascii?Q?0Q7yj0nfH5LAzHnGP4sglbFYjVUyC1xpgThfl7aSohEFdiEygt+OSwqlZBQv?=
 =?us-ascii?Q?fsX65hFitN5o4AdVGM8EPpUrHrwQaVXK1i08aYM+H3ClktMCefRL5pYQgftj?=
 =?us-ascii?Q?ZbpO1dasRvfEYmYvLvuy4dzrHbPtgrXNa5RoRPfed1BlLx8wQ8c9yYCWkCdR?=
 =?us-ascii?Q?5wiJ3Hi1Olu5M/nEqlckquOzBuyhNwfNSpLn5BwfAxaPeO6ONWHxnkugXC6y?=
 =?us-ascii?Q?RVq3HTwPexkzThEwmpZo2W5BE20ew6M4nMcqkShJXQO8?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07aad11e-e5b7-4a1b-34ae-08de1603e618
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:13.6254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+wjmipSHE3z0l5ACpzO5cQVtrjx0W+qZczuYqrw9Hm03cIz73ikAVOVS1qku1vB+cs1MBJy7uHwdxWSvd8M0N/X5R4KBlsx9N/oFyYQVVNnzjSeTPKPWRXk2CP+9zVC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Agilex5 SoCFPGA uses a dedicated interrupt for Double Bit Error (DBE)
reporting, unlike other 64-bit SoCFPGA platforms (Agilex7 and Stratix10)
which signal DBE events via Asynchronous SError interrupts.

Add Agilex5-specific handling to differentiate between these platforms and
correctly process DBE interrupt.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/altera_edac.c | 42 ++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 103b2c2eba2a..ee3270bf75e6 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1966,12 +1966,32 @@ static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 	}
 
 #ifdef CONFIG_64BIT
-	/* Use IRQ to determine SError origin instead of assigning IRQ */
-	rc = of_property_read_u32_index(np, "interrupts", 0, &altdev->db_irq);
-	if (rc) {
-		edac_printk(KERN_ERR, EDAC_DEVICE,
-			    "Unable to parse DB IRQ index\n");
-		goto err_release_group1;
+	if (of_machine_is_compatible("intel,socfpga-agilex5")) {
+		altdev->db_irq = irq_of_parse_and_map(np, 1);
+		if (!altdev->db_irq) {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "Error allocating DBIRQ\n");
+			rc = -ENODEV;
+			goto err_release_group1;
+		}
+		rc = devm_request_irq(edac->dev, altdev->db_irq,
+				      prv->ecc_irq_handler,
+				      IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+				      ecc_name, altdev);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "No DBERR IRQ resource\n");
+			goto err_release_group1;
+		}
+	} else {
+		/* Use IRQ to determine SError origin instead of assigning IRQ */
+		rc = of_property_read_u32_index(np, "interrupts", 0,
+						&altdev->db_irq);
+		if (rc) {
+			edac_printk(KERN_ERR, EDAC_DEVICE,
+				    "Unable to parse DB IRQ index\n");
+			goto err_release_group1;
+		}
 	}
 #else
 	altdev->db_irq = irq_of_parse_and_map(np, 1);
@@ -2145,6 +2165,16 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 					 altr_edac_a10_irq_handler,
 					 edac);
 
+	if (of_machine_is_compatible("intel,socfpga-agilex5")) {
+		edac->db_irq = platform_get_irq_byname(pdev, "global_dbe");
+		if (edac->db_irq < 0)
+			return edac->db_irq;
+
+		irq_set_chained_handler_and_data(edac->db_irq,
+						 altr_edac_a10_irq_handler,
+						 edac);
+	}
+
 #ifdef CONFIG_64BIT
 	{
 		int dberror, err_addr;
-- 
2.25.1


