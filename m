Return-Path: <linux-edac+bounces-2787-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38979A01EDA
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 06:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FEF3A3377
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 05:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289CF1CEEAE;
	Mon,  6 Jan 2025 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YJ/j009M"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0361B412B;
	Mon,  6 Jan 2025 05:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141683; cv=fail; b=UQSb0A9Qaql4waC+KD8o+AMBuPer1BoK2GtUC3/ktLHvM2rpsWVG8UoAVlbMPb01T07hdBxNDa3QI7ke3aZvstG/0rpvIRDAPiNng7RmE/Zz8HIX8GEoxreB3ywhqzpJmNEvdmCEorljZnVWSkiPUvdEsYx+DAvMW+pTzeLXSHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141683; c=relaxed/simple;
	bh=YV3HR6KuaaWBxk+E70wKothXhlkO0gnLlPp6Ui1efKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LuKbXwWReUHIZw15XTKVoFwSdr0AbqEI/AfZpnpZ3jS2xML4/GFxmWdnWFMeq89z/81hCz1ST8eB+pBkHPAd49KuW+nk4Fx1/g5+23AoBwOD74SoDyGcaVqhNRXhr3ROL9Z/CfWW+wfhr4dFCTcMUWTGknjZ3cpfgc4QHyIRU2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YJ/j009M; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6WmljW+0JoUJcRqQe+Uz1Ew8b31vRNlmVfEctxsq8ki/z9/J2f7lbYqiM3Sh1MIPl6yNvj1bUEWTJZKgA4r8GenfpC5rrk+I4GObP/vRHWfWuFxlC2KDnGxLeiWiwZWKJ7QuIM8LStA8E4xAQJ0X3zZ6eglWb1b+5GQgBJjgfJRLNhXOhwzvfYfniQZaZqqQJDAESzWgbvYLm44kjgmZo2IAr2zJLtK9Yw4Ee7jH3Rzi5dYM9ueUYwliFXksIr4EeD2yH/paxlDKProhm4HCbddSLD/f4ZTWIm2+gGvma/nV+N8K/QyXomh/3nw6dKQM1ZyAaKKRyD6V/yAkWNg3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=l4H22agTOd/wCpYdeHwbQpHKB/sLR5pnM7aC6MGqBRorN/53h+i1LCHCVg8VgLA01aG3tYJ4AkdJHiK5uguwzrMrfWuUTkR8/SDNoO2rLLkeKQmWsBFuktybfmYls4acU8Sp17Lo9D+urXa+A4FbgGba+C49jEo0yT/nn9tYIXMpY8ry4ok3ojmbQcaJtzSIPdglGIQQeDXrZfmaYMsvc7Cmlh9n7UaE8Am+R7xrh9KdqmoWsZOIguLi7cNQHhLUm2fAl1Wi4V4acG7LnZemoNlX3XX6jiiTF1C/S/R+4nT/MYW92sUj1WrEfA9jeLArjaLb20bQXeJTNE50S1eGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq3Xz8fmwKU5pyamx12DqEWdXPh13x5lzP25iyGiFOE=;
 b=YJ/j009Miu1L8noEwyZcWlYaSeW2lc13iLKLb1XCOSconTdcDFHg47VZr7bznZ3I+7A1BHDiVbjLP1JbXXCCghFhfNoJjP/OKGsYs7joHa3FFZiro4ILetrVKK62mHe0cXPw/sawJuuPwSZh4xJiy0t9u8sUUlPbxxcfXiLMWXY=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 05:34:32 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::76) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.16 via Frontend Transport; Mon,
 6 Jan 2025 05:34:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:34:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:29 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 5 Jan 2025 23:34:26 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v5 1/5] cdx: export the symbols
Date: Mon, 6 Jan 2025 11:03:54 +0530
Message-ID: <20250106053358.21664-2-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: 62649363-2cea-41bf-6298-08dd2e13cc17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Avb9rinZ4btDWRxKVMoTpJyQH9ZmJ4y+ceECiBAeNUya+N9AgKny2upxFQjz?=
 =?us-ascii?Q?qLiYQdvfzhaEAKnZHgwLOTJQlBm6Vnza0O9ZZn/j/6nfWkDwUp+zDD3XLMJG?=
 =?us-ascii?Q?rCULua4BOa33cPNE3uqJZ+IDA3bbcYnHLe1NI2L824Mq6OkzBPSCeSniuClk?=
 =?us-ascii?Q?fbVjqa+9Cbp7rsnTuR3KSrE2/tjcoXFKBCoHyCei0QZAe9N1iu1VvEVvWk0F?=
 =?us-ascii?Q?9DqTsGz0R6a9j488Gu81o3mHGF+O4pXsfyJw640+ywOYmLcf4SaAe83Vo7th?=
 =?us-ascii?Q?ISM5wVqZcnP61C0GddyqwIF0K2zyphMtt9JEBPiv4yAKwpfHRRn1FCaBAdG9?=
 =?us-ascii?Q?cL+UtPMZLxa2ZMYJ4sWsdQJArLblsgckoKZ6LqdMXpRLHFbzRIyQ5s4Z0tg+?=
 =?us-ascii?Q?PIHIGIU6ylPLYXpIhEgtzCqzAzyEZdcbs7Bjz9dAtPFbxGAR4/HopBae/4Y+?=
 =?us-ascii?Q?i+h5exV7FyFgSD/saQjYpvbwKK65lZh2x+MrEeDua2CdZuFtez25KRwspJo/?=
 =?us-ascii?Q?t7CGpRUu+od94ILj3pZrjA/xNwLJD2oqLD1B4bims3FIpqgOKOaIfz4jOif8?=
 =?us-ascii?Q?P6cB27BbNMj3uQOk+MbnAwX1hy49Gdi/tCtRR3pKRKoL9xL9rx1XpczG6o+T?=
 =?us-ascii?Q?4Lp6EX0tEGRQqJV5qSvEE9zkGkCG6oH8NELdX7pSfprGVlX1BSapgt4G9R3S?=
 =?us-ascii?Q?rsPieI0GpSFrBejxAPxUQ8nDXYC6h12Jtv48jWooYDdc0kNKca/KuiJBmQ8n?=
 =?us-ascii?Q?iZo+RENwECQK53fDWepUqkauzKWAAWZLHD7A8gH3eUYVEvIpUo3dPl+d05gq?=
 =?us-ascii?Q?hiTgClcUDErNy66bYxcby4s/wWrMj7RkeXV/szAqmh3nPyL+XAvoWuU4fCe2?=
 =?us-ascii?Q?HrUX67xy5iD72NfpoiPQbPaH5aOo57ygwgys9dA9qkR6Ea4t4n4HepZqLqIR?=
 =?us-ascii?Q?fagjpL6tkImwsOhIfMF8IYPECh7y2Ddr01A7lFo8UJ2cZNDOdY6RJCkeZHFe?=
 =?us-ascii?Q?8qJVXdR1auNnbhSQD5dcxPozll+SQdPooTDMHag8GCdQHZPLJdKbDT0pghl3?=
 =?us-ascii?Q?i7Gki6pOJwZmNQ+xLojrMzQmpm39r+c+HRiSfdM/IMEHURwEuvssQap1w3pN?=
 =?us-ascii?Q?69R/RuibxljLU+Q1JnO4G6RgiVPWqcI/vhZ0fI/Z0XEO6WZ8vz8znD9+cNBl?=
 =?us-ascii?Q?2CEwldxXdfh4QsYKGQDaLa/0vmEkJWYqX2R9J/5gQ5nhx3B2d9+rCNgfgRw/?=
 =?us-ascii?Q?sLQk5wKlQULBe1lGIuQnF+mZNHkPEkEgcSbMTSHH9+sZztzoJ8RoWfqTbGmt?=
 =?us-ascii?Q?K4i8YCjc86/4xu3tTXQSdcIDyQ1/lNfhwUaCT5B0lLOVI3o9UJdbT5lnASW1?=
 =?us-ascii?Q?zOPIPzDRGUyo4yMzeaUgpbO0xcqi4FwszGYScASDmLfiJ6dew5ghvIZkz7rL?=
 =?us-ascii?Q?HwD0yzdq+XdH3+f3AbH/s2vMOYyL89RuqYlN31mUOM7Coi6s8CJn5VV4cNDJ?=
 =?us-ascii?Q?k+OnOUqY92Id3ZM3l8s8uturGSidmp0hgUTT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:34:31.8100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62649363-2cea-41bf-6298-08dd2e13cc17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578

export the symbols for modules.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v2)

Changes in v2:
- Export the symbols for module compilation

 drivers/cdx/controller/mcdi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
index e760f8d347cc..e819049df659 100644
--- a/drivers/cdx/controller/mcdi.c
+++ b/drivers/cdx/controller/mcdi.c
@@ -128,6 +128,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
 fail:
 	return rc;
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_init);
 
 void cdx_mcdi_finish(struct cdx_mcdi *cdx)
 {
@@ -590,6 +591,7 @@ void cdx_mcdi_process_cmd(struct cdx_mcdi *cdx, struct cdx_dword *outbuf, int le
 
 	cdx_mcdi_process_cleanup_list(mcdi->cdx, &cleanup_list);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_process_cmd);
 
 static void cdx_mcdi_cmd_work(struct work_struct *context)
 {
@@ -757,6 +759,7 @@ int cdx_mcdi_rpc(struct cdx_mcdi *cdx, unsigned int cmd,
 	return cdx_mcdi_rpc_sync(cdx, cmd, inbuf, inlen, outbuf, outlen,
 				 outlen_actual, false);
 }
+EXPORT_SYMBOL_GPL(cdx_mcdi_rpc);
 
 /**
  * cdx_mcdi_rpc_async - Schedule an MCDI command to run asynchronously
-- 
2.17.1


