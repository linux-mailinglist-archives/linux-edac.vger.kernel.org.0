Return-Path: <linux-edac+bounces-5234-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B0C13CCE
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C0563444
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AE73019D9;
	Tue, 28 Oct 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="G5BhUlq3"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012033.outbound.protection.outlook.com [52.101.53.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08FD2FE054;
	Tue, 28 Oct 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643528; cv=fail; b=JQspOE/GZxr28bUg+i3Vny9DhcWWtTX6C6Nxf73cjQWzRCvcSLyCZdWddm3Xqx11pXb1KE/1ZW/v8NCum5wE+16Vx1MRLUlhIWR6OXT/ehqPZnyEzURVGSwdaFPJGlqfBsQq6JqIsJBUl0EQ/LtEhOibaJS28EwuwxEIOglYy8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643528; c=relaxed/simple;
	bh=a9R1GLPmzY8U0MKXP0Qq3FpnJTBTxirQqc5CeJ3GEG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EwwUyBRyjD8s3iWnWT+UMh+95Dm8MMuTOnDgX2+CKSdXqpOaoAJDoN6GeOOKmRtprXBMKotTzK32m2If26rx0ORlto1mUjhjj3+amWoKw7ssmt/MkXyWjR+wB+jiRUTPwBI0zvjqQkSVBqu4lYZjJwL4eSsspxxPkrllyxinjgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=G5BhUlq3; arc=fail smtp.client-ip=52.101.53.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KYsWlf6AULgEFRUF9SLl7oHxj2/WVmlV0nTBoSdjfl2jCCXlupWeRSrlPyFZmTx2SdH5VTNJE9bOFdkqUZMxe6oLNsQe5WaD8M8k+p2I9K9Bkl8lfmzj0g3p6G8IDACH+9RRWGVUZ9ZMCLE/oRmnEBWPHxNa5qKswrtm3i3tHlMU5qOVSpwedZbgvnprLWemHhv6Y9fAoki3zm/mrlz8Dq5/owEpBwFKN2FZTMyUx+StoyqeBoxyjuHPzoper1C7B6MweaB7cLLfGfggKa5OudMl7FWuHFIjJAtHDSdMx7crOw0+j5rV65WhuRtXydaCItgXqJ7T6eV2K13Yr4/3kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tpmi2/oFJhyCIKbVcDa+HbscEpqm1ImgU3hUNj0/1o4=;
 b=xbRFSEYxnoreYaMTluXBC/eLFLNjndBoBoY37xW/mNOiiiglGDOFpDT6VjdVA+yZfwiqhGZEDjhCy4ffUtVX/cZp+N1JuFZUR0iw12NR1V/qEMZaLog0pjyqAM520t1VavH9MzHev6d/x+w2FshrUbHlv5EOwtOcfLeKpP6rzDDKoQl3ChB0N+2mB290AVg0FV8NDbCyppceLZOAmpD+ixl+s7bLv+lsE1AvYnXEtaFLmHdOB2L4U/yji40BhEikVay2PjXLeRdxqVqyiziKUAq5TTnc0cjeIq/KPdDJULk7B4LwB+HFKLNKva0xI1mFMpk7o8xj7oP11NcLSwtcOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tpmi2/oFJhyCIKbVcDa+HbscEpqm1ImgU3hUNj0/1o4=;
 b=G5BhUlq3sSqizant28ePju3LUIn6LYUymIJv2lpaIrKJbgJOlQQtpM8kkVESTwhJFLF284+O1AUfuZsDevhTVl1T0wg8EZQc3uNuF/RruXLIbbmGUhhPg8GnGGX0rPiYnErDbiEU7J/y0YZSYc5j+2Hn2KEWSwEEgIpAEicvUUpT5BEfj/SLem6r7hEH7nXCWjf+8LK7NJpi3Qqq0Jq7QYE8S8pBWCwJqMpqwxZmATXors0iD8Nv+1B3cSHuAuqc1fdAsBQJ3U8EVo92YLOfhSA4yEzfSKd5fGpk+jo9KNtAn7QBABJ/U+2a46JsilPhcBoQI3smIe77dikIYCsw6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BL1PR03MB6037.namprd03.prod.outlook.com (2603:10b6:208:309::10)
 by PH0PR03MB5941.namprd03.prod.outlook.com (2603:10b6:510:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 09:25:24 +0000
Received: from BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1]) by BL1PR03MB6037.namprd03.prod.outlook.com
 ([fe80::9413:f1a2:1d92:93f1%3]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 09:25:24 +0000
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
Subject: [PATCH 5/6] EDAC/altera: Add support for CRAM SEU error handling on SoCFPGA
Date: Tue, 28 Oct 2025 17:22:31 +0800
Message-Id: <20251028092232.773991-6-niravkumarlaxmidas.rabara@altera.com>
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
X-MS-Office365-Filtering-Correlation-Id: d92560a2-9642-4288-d9d1-08de1603ec7c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kCjW9HeeCBYtTqcsyGJw7DyJQgICxKH0KTOnGBPLO0C8tVlum5XsEYVloq+b?=
 =?us-ascii?Q?fb8T+Ipb8ZpTylcuOav+Gr/kQg2TivM1H6QMiX3sN8LWplBHGvCQWue/Fckp?=
 =?us-ascii?Q?fs5paZSkqJ0zDwgjByrUoWabPJhDOx33QorS/3k8eIZkHEQOsz9rU70hWDqQ?=
 =?us-ascii?Q?DGCFCgC6sP5RohwWQhYvNcNHlkLc8ohIWnjQgom7P32GPmXx4XQqsU1eGBuB?=
 =?us-ascii?Q?Zk+13d5qodC/KDxBNOAqBIP6VGXqLs0Bzcrj2Z8vQfjWBsnQb0gKNBgH8BSc?=
 =?us-ascii?Q?6zWg9SmePUKEDdCAmsej957XPr73Ry7Y4r2mkb4pl9Pe3zQObS541dfVHt2F?=
 =?us-ascii?Q?F2eh6IqdDqvhbBHlJ1NOLJehorOZZ9+EWoSlG9wYawu6KwPDAMj3UlsOsX8o?=
 =?us-ascii?Q?dE/UNOh847Rd4wBEly/z1KFaeVkX7eHcOZbm00uNORcwLAGZYVitLXSIUC0+?=
 =?us-ascii?Q?AtfE24XVqRhsmO6c0cf37PyGEoBYgOyiHZhbZ0SQ49RaX83YrCFYZAORTbXi?=
 =?us-ascii?Q?Z+E3M31dt3pdjwd7CXxRPpmNUB2w1jXEj0BrCccsO/pBg2oAMz5GK46UJciY?=
 =?us-ascii?Q?px36HJnFrOJDX0As/QV2ySesP9mceHK2w3MUMU3jwg7jpFmYx00IqS2V65d4?=
 =?us-ascii?Q?KnMWvT+sRlxGnjDh4UzN8BNViab/a+17GvNPN5F/rRVzCTO12azorOIbAkXT?=
 =?us-ascii?Q?ARbLjmUnrrFfz4GXlEHIISDkhPid+jIihNcCSAlb+pkiOeWegiUbOCs5B5XI?=
 =?us-ascii?Q?NqylIfFwrg+rH+nolzvzkEQLElpvuLPU7XcZYRVh/9VyTHMQhKxWaseEj6Vg?=
 =?us-ascii?Q?JEO+OaBoNjSQSsfN5UoCR6XAY+NucTrNSKMaj5qQd4hjVBDgWp2S6o4J33jO?=
 =?us-ascii?Q?WmiUEcV9CmiPLuU/htpOM+EDAgKEBlGk9vsGTykSUZbwQ4Y5aRkq+A6/ZOWt?=
 =?us-ascii?Q?a9jFLP6s4o00/NanY5wM704vxvlA1pXuWG0YZuvrl119myvXHV98Af6Da8W8?=
 =?us-ascii?Q?1rAUiAwbkUnsoIZ5p685XvoWKc/66s3a9Tw1cVgBKDFe6MoKLqa2uY6jR0gk?=
 =?us-ascii?Q?O3NeQ0W0cWS4MPzC40nysndC8A5HzkdAfQa32+9FLuTEgVpSPD5FCPi8/XLr?=
 =?us-ascii?Q?AF86zt2el3vJ7o2wV2mFMr9sNfrOLbEvtR3VWE9lESoN/2RsP32YEy7oWQRj?=
 =?us-ascii?Q?FgbG7wzkVqJkBki0AtGjKPq8X4foBFd/IBhLjU04uE1ASMAxwXIl+DyjfDXE?=
 =?us-ascii?Q?e1L+Xw0YwQIRvXWXJTLgz9VFi3dntobLWYoXrggEhYp4uM5nUQGZB9vP3cmD?=
 =?us-ascii?Q?70RXfmSGgLwrTbmhatZdHhlxaxPMUJaiHWjN2LCP2S/FFj2h9Up4hGZ1ALtL?=
 =?us-ascii?Q?5CmGDt+G6KlhsoEmolIMG0XAAIeJ+Nk8ZtzQ9ubSh4Ye7lq0SKQOepNQfzDh?=
 =?us-ascii?Q?ewRX6KS058ArmDK2cw/++7IIiGum/rmr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR03MB6037.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?npAKjMKi+ZlNTqF2xWAwpa7/aNulsztVYUl1gQej0hC5Slk7qlZQEVRKVZCh?=
 =?us-ascii?Q?nfa7rGOAdd0EP47hPDIUyjDK8C0IpE+O4XqzsbdIUBGr8mXlmxIw0FFnj866?=
 =?us-ascii?Q?vuLiYVj8WfR1oCoktkgO6MhfRCL+dLiCvoI7qvCwIq0sSASlxRdW5J7Q/dWa?=
 =?us-ascii?Q?kjEqjxU+dCkJtUSrXe1PKxBQ+NPwhEa24mdMelq+xMlO8c3DrLMZEbTZ5ifo?=
 =?us-ascii?Q?J9RUJdq+B4sSTDbsKZ1A6w1z5uQlXIaS4B64Y3mV1oHkDGZ48wQl/Hp/TJZh?=
 =?us-ascii?Q?+SRc7X6DJ8f3ytFdPzo7w4XJISjmQ2QAbFJRkY+f0txJxTTNMDTlj6zD8wp6?=
 =?us-ascii?Q?ovkVz2JtTNkl/NnjJO5qJafczrywyB7W2tUZqdnX6MC77GsEuWyLL4WS3p/Z?=
 =?us-ascii?Q?KHr5361TRSA8ugk0gYfZQNLLuyHTwjxEDnpZqLv0VRkMZhn9pN5xu1QtwcD5?=
 =?us-ascii?Q?xZ0JrpYsJ2Fu+eU6mkr01DzfQDqugkWGtmS/9QdEylA5APSHkRSXwNG23kBH?=
 =?us-ascii?Q?7iD1GHqKrsKVPcIC6AbbqYzxpTA0BE/IOidBqVliSDSLpg1I+Qtv5rHlgFpF?=
 =?us-ascii?Q?GYt21dFgNlUQTTYOp5IpanycJ1CtD3dIRk7MUORFDHA5pL5qP2amwYu9dd51?=
 =?us-ascii?Q?lGQ4Mi0YoLL4IW/AC7jCiIwtBPclXYChsgOF6D/ihcNWyAI3NRyapYDEXPzj?=
 =?us-ascii?Q?nlg5I1MDpYSOTdypTnaP+BxRco936+I+PlgNd7n3K7g3LQBPl0q13fI/5vQE?=
 =?us-ascii?Q?+1aePqWMSCxk7gdHDaUxVoqHPqjbWl+CxHjsKdd1ic6ZB42QcXDPEWg9tLHm?=
 =?us-ascii?Q?lV8lNrAiZRGoR7mOIrvYhO81TQ4TpnKAREGpRUDkvllWVOB5N7iOAJD+prZc?=
 =?us-ascii?Q?dmUfM5GJqaH0ZmQpFMukC/d6P0B2M+fyw9fJfrZIlQp0o3F2opUIU0urF1vg?=
 =?us-ascii?Q?mLiHwwFAiURKdZFrEew+E+55MnboaIH7aI95wsHpVg5alMvjPINr+2REV64f?=
 =?us-ascii?Q?XoxMydd0TTRzvyOpEpkjvvZZmHC0c8EpCkfhKM/YlrlIzA9e+TDvkGv3SiuT?=
 =?us-ascii?Q?UMg7D8Ji4oVDBak7JQAJ4Td95GKYwk6XHdpsA6Hhk9nSIfubLR9W7+ZTlWiy?=
 =?us-ascii?Q?dhR8ws1R7N+i4CCqtRbS4m7dmSnzRs9G72mZ4DzNCaC20r35hxZaBMIdFAGf?=
 =?us-ascii?Q?yEkCaUBgERtGWNcGa9wbGIlTFZS7+SonjjYF9BzRdqoYhDObdZ9hnKKOmU8w?=
 =?us-ascii?Q?rWI4wp9wIDE4z0NqtIefsJ0JU8Y8KgOIsuZ58r3PzzpHuUPWzhnnSBGbCe8H?=
 =?us-ascii?Q?VXnJMgUAAqEQPbvdtxBN7tVEu+TjEUQ42VM+62ThUEb1M47XNe7XWsmdsm25?=
 =?us-ascii?Q?D0gQa6D6SnQXKJiVaEKJX6s2v2Fen2CubW/ORx+rYnTOyjPhTXgtPldGO3Kd?=
 =?us-ascii?Q?INHzKUMkzqJ1u38ngqXIxcke7v2MsV7Bv3HwYQ2v29CQgc+AJZ0ATgeVIOF+?=
 =?us-ascii?Q?LsX/Za5Nn/YLu7lqrFiff5Aj5YbqSAsdljJw/HkdHjGUV1gIE4HLTYIgAtgA?=
 =?us-ascii?Q?wLSGaTbGdCuKQ/KttkfrPfLEJXK4ySs6W1s6fQ0V1AjlgvyjSLmC05mXtcdK?=
 =?us-ascii?Q?qoBaGUlDD7Bi4RoAyZEXV/1RkIO8PsUWguseOWq9E44H?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92560a2-9642-4288-d9d1-08de1603ec7c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR03MB6037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 09:25:24.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+2lRhKuLfJN/4peKgoNjDvT8jzOtjlZBKnACr8eQ68/ss5P37ddu9bPG/12XKrLqZ5IWPN45HnRBFUi9snhMUpIhFPS89vP5hbA52k0YLTX1a9e39vvonzv2enbhbp7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5941

From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>

Add new EDAC driver support for detecting and handling Single Event Upset
(SEU) errors in the FPGA Configuration RAM (CRAM) on Altera SoCFPGA
devices.

The Secure Device Manager (SDM) is responsible for detecting correctable
and uncorrectable SEU errors and notifies the CPU through a dedicated
interrupt. Upon receiving the interrupt, the driver invokes an SMC call
to the ARM Trusted Firmware (ATF) to query the error status.
The ATF, in turn, communicates with the SDM via the mailbox interface to
retrieve the error details and returns to the driver.

Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
---
 drivers/edac/Kconfig                         |  12 ++
 drivers/edac/altera_edac.c                   | 178 +++++++++++++++++++
 drivers/edac/altera_edac.h                   |   9 +
 include/linux/firmware/intel/stratix10-smc.h |  37 ++++
 4 files changed, 236 insertions(+)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 33a9fccde2fe..701b15e73a39 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -477,6 +477,18 @@ config EDAC_ALTERA_SDMMC
 	  Support for error detection and correction on the
 	  Altera SDMMC FIFO Memory for Altera SoCs.
 
+config EDAC_ALTERA_CRAM_SEU
+	bool "Altera CRAM SEU"
+	depends on EDAC_ALTERA=y && 64BIT
+	help
+	  Support for error detection and correction on Altera SoCs for
+	  FPGA Configuration RAM(CRAM) Single Event Upset(SEU).
+	  The SEU errors caused by radiation or other transient events are
+	  monitored by the Secure Device Manager (SDM), which notifies the
+	  CPU through a dedicated interrupt.
+	  This driver uses an SMC interface to query the error status and
+	  report events to the EDAC framework.
+
 config EDAC_SIFIVE
 	bool "Sifive platform EDAC driver"
 	depends on EDAC=y && SIFIVE_CCACHE
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index a82c3b01be1a..ac2151c625a2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -656,6 +656,19 @@ static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unu
 	.llseek = generic_file_llseek,
 };
 
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
+static ssize_t __maybe_unused
+altr_edac_seu_trig(struct file *file, const char __user *user_buf,
+		   size_t count, loff_t *ppos);
+
+static const struct file_operations
+altr_edac_cram_inject_fops __maybe_unused = {
+	.open = simple_open,
+	.write = altr_edac_seu_trig,
+	.llseek = generic_file_llseek,
+};
+#endif
+
 #ifdef CONFIG_EDAC_ALTERA_IO96B
 static ssize_t __maybe_unused
 altr_edac_io96b_device_trig(struct file *file, const char __user *user_buf,
@@ -1492,6 +1505,56 @@ static const struct edac_device_prv_data a10_usbecc_data = {
 
 #endif	/* CONFIG_EDAC_ALTERA_USB */
 
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
+static irqreturn_t seu_irq_handler(int irq, void *dev_id)
+{
+	struct altr_edac_device_dev *dci = dev_id;
+	struct arm_smccc_res result;
+
+	arm_smccc_smc(INTEL_SIP_SMC_SEU_ERR_STATUS, 0,
+		      0, 0, 0, 0, 0, 0, &result);
+
+	if ((u32)result.a0) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "SEU %s: Count=0x%X, SecAddr=0x%X, ErrData=0x%X\n",
+			    ((u32)result.a2 & BIT(28)) == 0 ? "UE" : "CE",
+			    (u32)result.a0, (u32)result.a1, (u32)result.a2);
+
+		if ((u32)result.a2 & BIT(28))
+			edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
+		else
+			edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
+	}
+	return IRQ_HANDLED;
+}
+
+static ssize_t __maybe_unused
+altr_edac_seu_trig(struct file *file, const char __user *user_buf,
+		   size_t count, loff_t *ppos)
+{
+	struct edac_device_ctl_info *edac_dci = file->private_data;
+	struct altr_edac_device_dev *dev = edac_dci->pvt_info;
+	u8 trig_type;
+	struct arm_smccc_res result;
+
+	if (!user_buf || get_user(trig_type, user_buf))
+		return -EFAULT;
+
+	if (trig_type == ALTR_UE_TRIGGER_CHAR)
+		arm_smccc_smc(INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR,
+			      ((u64)dev->seu.ue_msb << 32) |
+			      dev->seu.ue_lsb,
+			      2, 0, 0, 0, 0, 0, &result);
+	else
+		arm_smccc_smc(INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR,
+			      ((u64)dev->seu.ce_msb << 32) |
+			      dev->seu.ce_lsb, 2, 0, 0, 0,
+			      0, 0, &result);
+
+	return count;
+}
+#endif
+
 /********************** QSPI Device Functions **********************/
 
 #ifdef CONFIG_EDAC_ALTERA_QSPI
@@ -2031,6 +2094,117 @@ static int get_s10_sdram_edac_resource(struct device_node *np,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
+static int altr_edac_seu_device_add(struct altr_arria10_edac *edac,
+				    struct platform_device *pdev, struct device_node *dev_node)
+{
+	struct edac_device_ctl_info *dci;
+	struct altr_edac_device_dev *altdev;
+	char *ecc_name = kstrdup(dev_node->name, GFP_KERNEL);
+	int edac_idx;
+	int seu_irq;
+	int rc = 0;
+
+	seu_irq = platform_get_irq_byname(pdev, "sdm_seu");
+	if (seu_irq < 0) {
+		dev_warn(&pdev->dev, "no %s IRQ defined\n", "sdm_seu");
+		return 0;
+	}
+
+	edac_idx = edac_device_alloc_index();
+	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name,
+					 1, ecc_name, 1, 0, edac_idx);
+	if (!dci) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "%s: Unable to allocate EDAC device\n", ecc_name);
+		rc = -ENOMEM;
+		goto err_release_group;
+	}
+
+	altdev = dci->pvt_info;
+	dci->dev = edac->dev;
+	altdev->edac_dev_name = ecc_name;
+	altdev->edac_idx = edac_idx;
+	altdev->edac = edac;
+	altdev->edac_dev = dci;
+	altdev->ddev = *edac->dev;
+	dci->dev = &altdev->ddev;
+	dci->ctl_name = "Altera ECC Manager";
+	dci->mod_name = ecc_name;
+	dci->dev_name = ecc_name;
+
+	rc = of_property_read_u32(dev_node, "altr,seu-safe-inject-ce-msb",
+				  &altdev->seu.ce_msb);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Missing - altr,seu-safe-inject-ce-msb\n");
+		return -EINVAL;
+	}
+
+	rc = of_property_read_u32(dev_node, "altr,seu-safe-inject-ce-lsb",
+				  &altdev->seu.ce_lsb);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Missing - altr,seu-safe-inject-ce-lsb\n");
+		return -EINVAL;
+	}
+
+	rc = of_property_read_u32(dev_node, "altr,seu-safe-inject-ue-msb",
+				  &altdev->seu.ue_msb);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Missing - altr,seu-safe-inject-ue-msb\n");
+		return -EINVAL;
+	}
+
+	rc = of_property_read_u32(dev_node, "altr,seu-safe-inject-ue-lsb",
+				  &altdev->seu.ue_lsb);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE,
+			    "Missing - altr,seu-safe-inject-ue-lsb\n");
+		return -EINVAL;
+	}
+
+	altdev->seu_irq = seu_irq;
+	rc = devm_request_threaded_irq(edac->dev, altdev->seu_irq, NULL,
+				       seu_irq_handler,	IRQF_ONESHOT,
+				       ecc_name, altdev);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_DEVICE, "No SEU IRQ resource\n");
+		goto err_release_group1;
+	}
+
+	rc = edac_device_add_device(dci);
+	if (rc) {
+		dev_err(edac->dev, "edac_device_add_device failed\n");
+		rc = -ENOMEM;
+		goto err_release_group1;
+	}
+
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG)) {
+		altdev->debugfs_dir = edac_debugfs_create_dir(ecc_name);
+		if (!altdev->debugfs_dir) {
+			rc = -EBUSY;
+			goto err_release_group1;
+		}
+
+		if (!edac_debugfs_create_file("altr_trigger", 0200,
+					      altdev->debugfs_dir, dci,
+					      &altr_edac_cram_inject_fops))
+			debugfs_remove_recursive(altdev->debugfs_dir);
+	}
+	return 0;
+
+err_release_group1:
+	edac_device_free_ctl_info(dci);
+err_release_group:
+	edac_printk(KERN_ERR, EDAC_DEVICE,
+		    "%s:Error setting up EDAC device: %d\n", ecc_name, rc);
+
+	return rc;
+}
+#endif
+
 static int altr_edac_a10_device_add(struct altr_arria10_edac *edac,
 				    struct device_node *np)
 {
@@ -2421,6 +2595,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 
 		if (of_match_node(altr_edac_a10_device_of_match, child))
 			altr_edac_a10_device_add(edac, child);
+#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
+		else if (of_device_is_compatible(child, "altr,socfpga-cram-seu"))
+			altr_edac_seu_device_add(edac, pdev, child);
+#endif
 
 #ifdef CONFIG_EDAC_ALTERA_SDRAM
 		else if (of_device_is_compatible(child, "altr,sdram-edac-a10"))
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index a2c8b80eefa8..8b475dc692e1 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -410,6 +410,13 @@ struct edac_device_prv_data {
 	bool panic;
 };
 
+struct altr_seu {
+	u32 ce_msb;
+	u32 ce_lsb;
+	u32 ue_msb;
+	u32 ue_lsb;
+};
+
 struct altr_edac_device_dev {
 	struct list_head next;
 	void __iomem *base;
@@ -424,6 +431,8 @@ struct altr_edac_device_dev {
 	int edac_idx;
 	int io96b0_irq;
 	int io96b1_irq;
+	int seu_irq;
+	struct altr_seu seu;
 };
 
 struct altr_arria10_edac {
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 283597022e61..87e13683776f 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -620,6 +620,43 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FCS_GET_PROVISION_DATA \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FCS_GET_PROVISION_DATA)
 
+/**
+ * Request INTEL_SIP_SMC_SEU_ERR_STATUS
+ * Sync call to get previous Double Bit ECC error information.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_SEU_ERR_STATUS
+ * a1-7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1 error count of response data
+ * a2 sector address of response data
+ * a3 error information
+ */
+#define INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS 153
+#define INTEL_SIP_SMC_SEU_ERR_STATUS \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SEU_ERR_STATUS)
+
+/**
+ * Request INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR
+ * Sync call to inject SEU Error.
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_FUNCID_SAFE_INJECT_SEU_ERR
+ * a1 Number of words
+ * a2-7 not used
+ *
+ * Return status:
+ * a0 INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_NOT_SUPPORTED or
+ *    INTEL_SIP_SMC_STATUS_ERROR
+ * a1-a3 Not used
+ */
+#define INTEL_SIP_SMC_FUNCID_SAFE_INJECT_SEU_ERR 154
+#define INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR \
+		INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_SAFE_INJECT_SEU_ERR)
+
 /**
  * Request INTEL_SIP_SMC_IO96B_INJECT_ECC_ERR
  * Sync call to inject IO96B ECC Error.
-- 
2.25.1


