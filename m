Return-Path: <linux-edac+bounces-5231-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3D2C13CBC
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B625070C1
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55982EA743;
	Tue, 28 Oct 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JUTMFSD8"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199563009E2;
	Tue, 28 Oct 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643511; cv=fail; b=BGGLcDY0gi/QT184mZiG+DqlpdvvMoGY9m8X3msf7Qs2Q1Ivh47WWrlb/t2Q5njouqCl+OosZiKsAsCz0uYgcJr0+fEbruG5tkR43ZtiugnyO93sayIq/BjNPbBxkepxKxVkCY/EYFE1NmTRZS+0vUo0niwzTsmQt68HLCMjHoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643511; c=relaxed/simple;
	bh=uy9RQbkLOhkm15pHQDDBD7cP/+2kD4AELKcyHg8UOWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8qqBtNgvjEoJ/FcQBoqn+8NuJ2K1Wa9WaNatAXS2HCMQrhnUtE+XRJjkpYr1Dx4X2sJY7lPTl0QtiEe+1vdIeEO+Mqs2lwGf+i9PrxcVXXe0hv33srCyBXU4F5StDTcu9rY+DPjYanAalflWA9DK/mtk2emDCXtq1FJmsfuKs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JUTMFSD8; arc=fail smtp.client-ip=52.101.193.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMyVfAWryREaWwFrWyDlyUbN6wBdlwRbfMrXvH1xQG0cUZs/C4P6EBv4nbKF8EvriKXJKN/s/U/cWe4+PFdwnvHRjpytXgun17fvLfuxPNtQD28JEJzrs88/t2Ufl6+3rOF1WdH0e8NU3YHSHExeLZ4aXQz6HiELEuUzHFG9ZVEHYYrZAf7eQ3K3ZtSc9PBNj0T1ucPX/ygR3plNscadtMI0ihPljevhe7wRSeRQQl9QpQFuqSuzzWY+LAskam8f0GTWbjY47/MlsJ4fNszraVLMHtjjqS0mtxbHBXOWeF54xfJrLQCoRz7siFQ9+PORDHpHf10q5Gc8W28tnlp2VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuF0uvKSIy+j/Yi9WBUxKf/5S/3JC7RRCh57Rl+9bw8=;
 b=ID/7eSwQ8SmL/0p6Z8olVD+MPFOG98sbOf8EvSV4nyn+UfTsIFky0oGlBJxU/rfRmNbIft9GgJymTFoJhabPOXcgNxQd8IJJSswGI0beEuwZzJA7yVzCIr618QRMxbpSkSEYDiLh/x2gxWNAyGW2xwWMSm/w7F9mgJDriFk4iHB/I3+piyDuWMDOq/Sezf98DSx22+c3pvPg2NQScU6F9nBVCt81/z7mzyo4Rt5UsF87QxH4DUb0HLejdAAZy6X73z1owbeqq037AhKVD/nLvjNvSc/9lNIWl1VhlyvHpp71fqaEjaNbGhDeuuRslFp6usg5Gv5pmuNdIlj+iUEM7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuF0uvKSIy+j/Yi9WBUxKf/5S/3JC7RRCh57Rl+9bw8=;
 b=JUTMFSD88gbUFEptHp/CAmmt8NJUluN9FWeX3x00x0L3gUfpFDsgODqzAWS6wn4gSemARGaEK6cTzzPhx5DAVmt85WxdaTjgHwr/BTe+wHRmrHLMBAU9Fnht9IUhTSKh/DvY6a3d95XzpdmJEchMNqmI2gn1pbehoc+0b1XPIc1B7nzybiFv2tcqBdAOybSQ4snfhQUXY+/iZ07Ml3zFdQWT5jU6GEX4WcwAIqgiLXPiw+lXaMvh4GUFoYXPQsA60NEx6cUM3pH7zWqyIoLcGVWDqQUx2xZq1wfpJk4MD+uOS6xMSuDBFDTcBpbHdr3jj7fiXEYNYxwc8LD33PivaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Tue, 28 Oct
 2025 09:25:07 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:07 +0000
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
Subject: [PATCH 2/6] arm64: dts: agilex5: Add ECC manager and submodule nodes
Date: Tue, 28 Oct 2025 17:22:28 +0800
Message-Id: <20251028092232.773991-3-niravkumarlaxmidas.rabara@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7829cd21-5a72-45e5-ce00-08de1603e20b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fNiLpr2UUcw41ePI66WrzbIk25FzevQZ3xpNySy1PwtQXL7A733QIVBPnsic?=
 =?us-ascii?Q?mHIp8tj1I4nPJ0G+mbEx8J54G1cPCSDyA6huMrA+UyOUQZ66bJmHe0erk6Bb?=
 =?us-ascii?Q?X8wPM/zh3W+/l0EK4WVG77xVeznwKY3/2biqxUAnIV5KSxVy17ztSeetfM0Z?=
 =?us-ascii?Q?Zht+cU9UhI92wHtJ99WkUuzw5FTYpMd7o0Ikd37LgGXp3VK3MJxw0p+/YPSD?=
 =?us-ascii?Q?0yllHo4BGTngXVQlrHC3Mr0hVLXrPolWrE1JmjtlMq61DP74dwb5qJNfh1Ok?=
 =?us-ascii?Q?lR5fGs5L6cRjS59xhe8IcJkWZaOOfqbsjXfUZheeOAeJybHH4KaaV61cb+VO?=
 =?us-ascii?Q?O+WnPzDnxoGGVunTd6SHyXlY3y8q/BfT12MiFVpj+rX0GexLLCjwCXy5bfkX?=
 =?us-ascii?Q?SgK8UbAwAmhkzdyJJD3hBTSI4RbW6RtN4jYtEYZQs7aUHdxxiyU4UipBcZIZ?=
 =?us-ascii?Q?3x4zERipkciWWWjknrfw4a0lJYjBS6EIqqA9W1XUxMsqLA3oCQbCaKGSr2AE?=
 =?us-ascii?Q?zQJlCh+VHZEF5b8Y5hK9LbrdaanOoVdVAL3R0EX7Twic1Axp7xU436mPhOjS?=
 =?us-ascii?Q?RVPNV9jSO1ng4UpW2s2GDxMIUXnDaudamNAo2GQYMvV56ReLZFMqtjQNZTbn?=
 =?us-ascii?Q?hembK0APEw7nqpXFdkMdvv5fikmeMbYCA8rcRr6Spk+jm5Fv7V9M9zjIjE1A?=
 =?us-ascii?Q?liTBsJtpL801IHUqh9uHCKChpajEYw+2NDymB2XmtSStxZasw4of4PgQNDPm?=
 =?us-ascii?Q?3oOFS4ICSuu694fwZcHRc3DHknYs+IoGmCvWwBNCXCjo+pDYeNpkUiprQ46A?=
 =?us-ascii?Q?01I8/Q2HXNP6bqTkfmj84klArx4TBmCZruNDUDt1WLxeLz9sbfbcubsFwKwQ?=
 =?us-ascii?Q?GTXtFgLz/vi3QA6s6HKClkVAu6vmxkPymCu82k1C7Ib5P/CJysxD59tilU3c?=
 =?us-ascii?Q?eJCnCN76r9yW8FwM/5b/EckxALxPHMho/zk9PfQZ4+/J0PstnYxj9qLWPcs3?=
 =?us-ascii?Q?d8ilypAZZsmGhWavUcIQkBIsK6/YtzP313FKbN+/N9+3t2EgK6dLUzX4Hufv?=
 =?us-ascii?Q?pZlk7ARvoaF/DargeDmbtUG0/Ttp7L50SazZhdCoWpS5/jM8ZPAgVJP7qr5Q?=
 =?us-ascii?Q?2aCChugXeEmU3XKe6jBAgxd/edtyRWut5LK9sVB6yK80nzvHxJgpVjf8FP83?=
 =?us-ascii?Q?KlCtI0PtZckOIp10Jx5QZTuwl+Mp+be9x7jMmZ7d3F/29DqxPd0gmVd6TPku?=
 =?us-ascii?Q?cHXLgvWfXAByZNghsfngUsX9oIG+UXq+9jqXJu/RINMTBKz4c/c8A9/vGQvO?=
 =?us-ascii?Q?dW9dxv+/2vzJzw6ElpvmB8iLadY3VklpsxbFRbui6m2PQ4Ma4+Yb9LaTXVB/?=
 =?us-ascii?Q?DQbPzWxWcENNMTsfxIwtFKbIK5uEVrV297svl6DhNcUqTc/58U/09w37m+m9?=
 =?us-ascii?Q?dkIXNSjt1NfYnLwkUeq1ZY2b0MYYASbj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KkWzKDGYow0r4GmZwq/1UX7NgC/kM+LkLxyfzs+GNaLuX2+GMS3LsLRnEc/e?=
 =?us-ascii?Q?dfYVDA/Mxyl4Qf7ss7Lo2Jb76bM/+K1znvqhAwu4k+SafVGxOb6gDaAP7Q4O?=
 =?us-ascii?Q?f77Cp/xrIHHW4YTjiUxkpW670miunt0zuoKfx5EGnqlyQswCQYB8PL+dMAB5?=
 =?us-ascii?Q?DpWmltZtBB8qhhiJP86OCbTbp7OZ+OSIme26vS4M16QPYGvKuIgHs5RpwStZ?=
 =?us-ascii?Q?s3dwfC6/OrBnaHUlJWeeUYt5c0Ltsga2wdWCa4gp0C0WjJLOg3mzOlzlIV6j?=
 =?us-ascii?Q?NnrZnd/WXf2BWoRxuCAvwvz+IOl92zrOZMdZJpJ3SC0S7Fz/6dglcuzvLGYF?=
 =?us-ascii?Q?21pkVKrIdUE+8g1GjgXxr3o1n0qsgKVSqPujd1TJy2BINm2MSVjbUr7Hq0ZC?=
 =?us-ascii?Q?fI6zpkZkies5jZwHlkULeG7vIIyODlImevz6iZ6D4i2O4kYR3vgdVnGQOAps?=
 =?us-ascii?Q?L0XyhQ9biB9JWkKaBSUxwG/it6egv/pUkklTo4SBvcBKsFVDUpMy4yDBxktP?=
 =?us-ascii?Q?52ECfzdJB8iahzsaSFkt1sz7c6JmQZtlgDPTGGhMmxiSy3edDjuMrrfALJuR?=
 =?us-ascii?Q?EZ+GmHf0EdKzgii127qjQZimdVsVvxCISsrSTC+0E4+qSKChVRewgWCSt1+X?=
 =?us-ascii?Q?fR1r9r6EvDfeOzObe2UA2XCx2RWlVoIwZ7xcNaRJRBlaChpo6Enk7ys2St7v?=
 =?us-ascii?Q?zIUW1W+n+mlFGatI0xsmA43idOuzRvkEB7P8Ro2bbG5DItsskqro61M0p3NV?=
 =?us-ascii?Q?7Hk4DA2fzgTzGw7L9SWV88nLZmxjRh/mfJnuSeugjtiGv2okIxu8f+XA0w7Q?=
 =?us-ascii?Q?qa9aHPZJmBVzwolds60J3MiuhugV7PYl7mgN2qTugOQlqFOUwmUhJmzteikm?=
 =?us-ascii?Q?5xq8vsg0MNr9xXHb8qhUvVxplcBSZ9B1+xa7WfqxLkzw/Ns/rtpLbCqhdxP8?=
 =?us-ascii?Q?8EFC3q0H48vBFfUPzoF8dSdu8r1jkV9Hv1T0pOG7x2GN+HVb1vzW3BrFc3Mj?=
 =?us-ascii?Q?4XnSqiEliHpIh+1YWpXVtbsgTAVrhVFN1HKPxVurcm+7QsaTxF/1ApOcU0hc?=
 =?us-ascii?Q?byZxLUb0fDp+UVKTMsEKqwszRxXWIzrP3jMaqjjbj/npZ9AIB42XP2whXEEz?=
 =?us-ascii?Q?1l17BqkViox6H/uOxN+u9PGVI1uP39VReaNAgKAJR2vdIaVNrh9J7z6xyYPR?=
 =?us-ascii?Q?KoEjEp1ITzKXMtZe6qoxA4sgzx6K/eZhGeSxAB6PpVZWoIas9tGccLOciRU4?=
 =?us-ascii?Q?i7zIC2ufUjFCNYiFgMmSphW1mM8pjV2IrH5k37heUgdF8uaUuB1sr0hFZo2G?=
 =?us-ascii?Q?rhwX0XxWM3m1h1VmndcKLuQ9dwtQLD0KEG3mGYPRjWte7rb2kTZbhuRp3J1c?=
 =?us-ascii?Q?480A2YiWchNPMpYoT+K22t4nbYfgKu6WnS93KCsX29pqCKQySjJPbhqUYWKC?=
 =?us-ascii?Q?n9Bmm8quxSWMxQgL975te4DpJo5DJeta8AMODUBYcoqB3zJ5Fg+n1qDZ7V+3?=
 =?us-ascii?Q?wl+SccpD963ZlLXZBPvk2A3WxHhUO9VJwTR4fLTBWhZxKxzV9WIvXPryTTqR?=
 =?us-ascii?Q?5J7iFIFjeZ9QdrH9esZ3KMrC7/i+dv5PvU56Yncm48goQFcUQGHdbE4GJAXp?=
 =?us-ascii?Q?Cm0uyKHeQIFtbh46O4aBS1eM/6gzF8xu3d2pPjXtI4WD?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7829cd21-5a72-45e5-ce00-08de1603e20b
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:07.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VprtGVhcNRFrlAqRDtb6Hx8GZTfI3JZ4+av1+Uzrxq4H97PfhsMxADkOnz4CUTyMs+u75G6BzOz3mhkdXutq9w3TKjvt0Rw8R9HHUesdEpifZF0GnpRwQ6p/eY09r5vD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB8121

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add the ECC manager (eccmgr) node and its associated ECC submodules to the
Agilex5 SoCFPGA device tree. The eccmgr node serves as a logical parent to
group various ECC hardware instances, including those for USB, Ethernet,
OCRAM, IO96B memory controllers, Secure Device Manager (SDM) QSPI, and
Configuration RAM (CRAM) Single Event Upset (SEU) subsystems.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..5ea7a506d3d2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -428,6 +428,104 @@ usb0: usb@10b00000 {
 			status = "disabled";
 		};
 
+		eccmgr {
+			compatible = "altr,socfpga-a10-ecc-manager";
+			altr,sysmgr-syscon = <&sysmgr>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 95 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 120 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global_sbe", "global_dbe", "io96b0" , "io96b1",
+					  "sdm_qspi_sbe", "sdm_qspi_dbe", "sdm_seu";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			ranges;
+
+			ocram-ecc@108cc000 {
+				compatible = "altr,socfpga-a10-ocram-ecc";
+				reg = <0x108cc000 0x100>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>, <33 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			usb0-ecc@108c4000 {
+				compatible = "altr,socfpga-usb-ecc";
+				reg = <0x108c4000 0x100>;
+				altr,ecc-parent = <&usb0>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>, <34 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac0-rx-ecc@108c0000 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c0000 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>, <38 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac0-tx-ecc@108c0400 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c0400 0x100>;
+				altr,ecc-parent = <&gmac0>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>, <37 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac1-rx-ecc@108c0800 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c0800 0x100>;
+				altr,ecc-parent = <&gmac1>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH>, <38 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac1-tx-ecc@108c0c00 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c0c00 0x100>;
+				altr,ecc-parent = <&gmac1>;
+				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>, <39 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac2-rx-ecc@108c1000 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c1000 0x100>;
+				altr,ecc-parent = <&gmac2>;
+				interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, <40 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			emac2-tx-ecc@108c1400 {
+				compatible = "altr,socfpga-eth-mac-ecc";
+				reg = <0x108c1400 0x100>;
+				altr,ecc-parent = <&gmac2>;
+				interrupts = <9 IRQ_TYPE_LEVEL_HIGH>, <41 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			io96b0-ecc@18400000 {
+				compatible = "altr,socfpga-io96b0-ecc";
+				reg = <0x18400000 0x1000>;
+			};
+
+			io96b1-ecc@18800000 {
+				compatible = "altr,socfpga-io96b1-ecc";
+				reg = <0x18800000 0x1000>;
+				status = "disabled";
+			};
+
+			sdm-qspi-ecc@10a22000 {
+				compatible = "altr,socfpga-sdm-qspi-ecc";
+				reg = <0x10a22000 0x100>;
+			};
+
+			cram-seu {
+				compatible = "altr,socfpga-cram-seu";
+				altr,seu-safe-inject-ce-msb = <0x0>;
+				altr,seu-safe-inject-ce-lsb = <0x30000>;
+				altr,seu-safe-inject-ue-msb = <0x20>;
+				altr,seu-safe-inject-ue-lsb = <0x30001>;
+			};
+		};
+
 		watchdog0: watchdog@10d00200 {
 			compatible = "snps,dw-wdt";
 			reg = <0x10d00200 0x100>;
-- 
2.25.1


