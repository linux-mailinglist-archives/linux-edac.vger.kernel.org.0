Return-Path: <linux-edac+bounces-3181-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB78CA3FB28
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E81886769
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1E020FA99;
	Fri, 21 Feb 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRM37q1U"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898713224;
	Fri, 21 Feb 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154783; cv=fail; b=SMBxvyIbfI6TDdiktsEc0UvGjo2SjHvXtpZ07Za2JWZNjFx2oOgysoD4aTXjCJiYRQ6L4ruFb9ywBr9ZRyiQJsIAkYUWX8Ev8m5wemN0s6Z1zUjzuc1gxMRJhI+yFk4zJmtOf/pe6DoQ0Gzm+vxFMofZM5dv+cPyW3vxh21oARQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154783; c=relaxed/simple;
	bh=BhBXS0vpn/cewL9fdolcJM2imVm2zdKoMmqSLtXY21A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AqDlJ23cU+rLzOC91JBzC0XUi102ZVTqHKoqsVeDpZbHT3vzLKwf/ZabjADlDdjzLsnv8fZkbcrwTPSl42BL1TX0ZfoQvSNLnimXTKvomEva5yRc+4sDPoMk1ws3lo0GyzVoS9Snd94sayYkjzDFCTndRdNHe37EbOE0j+/2REI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRM37q1U reason="signature verification failed"; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBF+DUI4k9b1/VzgWBUZTV1k+LjgHZ9NK1THY4JWcRNDsGeNpKVjWmX2fxm0DLFxJNvUbWPqLoqcSwSDuRWXCAdr2M2SLYiuMztamlBABMSSV3KkJNiI9/F8aStWGGcr4yzSBsjZftzWVJ44q70m3ODd3O9KL9OTAVZCKEeQ20y+grWaTYt2i5GE6haIyIxBxdVFFaXptUXBeEkCVhdO4ruZmUr9zNe9cp7hXpLjstc9Gdw/j2CAAJlKMTXNJNBdr92g7h+KncnjS8hsAriGp1b1yzVsIKb47demo4SMCTiHLw9KAOUOW8HXNB+gC2cXoBQXkg7ZWbvbHj8wz5RmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O1ce0fHexLux+jQu0Y/ywp1Thx3ahKW28fi/jkDbcM=;
 b=yfZQt8V3LqVYsR2FZ91mJz6DvEvIHQtcG3i5ysx892YYQGZWuyv7WXhqP7Gw6EV4rMAQUkgUFbQV0X/ToQC8V7wOqJ8LrPbOkU8N++Zxe188vRuOOwjrqDS7SeHqV4bASUBjTpxY6T1ExzxjOnA5DwSF/aXqrC4bPuHYDqmrawcFdtRZTtdaUOoAAIpPFrkiL0XGodgX2zQ5xHyLePqPN/HmRHfAuU/wHih/UKeTf+RnDv0qlqxSy1H57n8EzdqSgUEiqjUr359BLbRL0HHMJM5ZrUyAVqe4JJKN8ZnLyIwo3U2gxLGNbeIbbrDGqGZyhQrS1CIwVGo/9byTzfNhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O1ce0fHexLux+jQu0Y/ywp1Thx3ahKW28fi/jkDbcM=;
 b=WRM37q1UJgieAF5d7v0wRAKm31wQ+wPVRkeSy/CNE31obGgt+aODfFbvCAzhnDqq3IutpgMeOsR8Egg4NRqx8YbJV7E6KuD/SlXz4QKJEQ7qH+SnraFKE4HG0tyy+hMp26hcfUe/S0JPY0qKDxPCQNguqvGLDMWOx5EQCW+uvwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH7PR12MB5853.namprd12.prod.outlook.com (2603:10b6:510:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Fri, 21 Feb
 2025 16:19:36 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:19:36 +0000
Date: Fri, 21 Feb 2025 11:19:26 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Handle TLP Log in Flit mode
Message-ID: <20250221161926.GB926653@yaz-khff2.amd.com>
References: <20250207161836.2755-1-ilpo.jarvinen@linux.intel.com>
 <20250207161836.2755-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207161836.2755-3-ilpo.jarvinen@linux.intel.com>
X-ClientProxiedBy: MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::35) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH7PR12MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dde43a8-d3cf-4ee0-6e31-08dd529388a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?hoOcyiqhiVsSPS74fjmtN8+g4eIiCPIGS9ZSJ6jYzbkFjBoDxp48gb2Jfe?=
 =?iso-8859-1?Q?1md++DKhqWH72gCdIAG0aGkvKwzme1JSFXmykn9m9MqBp8CK5EdG051c8E?=
 =?iso-8859-1?Q?Ibvo5S22uO7MiZEgb+dqZYbMKqG4XM8AIVs2060i8yZDcBEiOuvUwUDZAh?=
 =?iso-8859-1?Q?H9MlpkPIQo4SRXhE4afptlVOW4cRKrbhis1isUwbb1oCgCMuAFWEKd/HTy?=
 =?iso-8859-1?Q?QAgeAyTOPZdXtT19iPCbE7fjfF0SMnJMOHsOglzGietDNMQ+3zjEvs6zc1?=
 =?iso-8859-1?Q?nWJZnoSB/+ko7c7Po43zB3MHKCDyYbyK8HyIb+Opl5g24EnuoAAp6YabqU?=
 =?iso-8859-1?Q?k2NSGo+nbaVvandcs1O3hHvDvwzf+yRuN0SeOx0fZaHBvHHgcz4pS2hhj9?=
 =?iso-8859-1?Q?/skye0jd/c7Sg5Or9Y2gTd8Y2LlT8nHrd4uGH6wjtf8YTAc3oQ80YghNJI?=
 =?iso-8859-1?Q?8LIn4/wnygcXf1guZRSuZ5hRbQc5i4bVqJ9weNO++h0u52Zyerm+BMLBR+?=
 =?iso-8859-1?Q?4B0ZeS/1hbex0ZBrp5tjUTWcvwOi7nJM4e4cIBxnhQ//OEmqPHPmxgwdjB?=
 =?iso-8859-1?Q?+0350i0Z51mU9hTqjWUPQ13xOuEBAJdDK70H3yVtUAnkYD6PDuaeAHmtB+?=
 =?iso-8859-1?Q?J4ahCRPtCTJTyLBaf4ejsNBXLdo0bLYPWqFnGrPaquP6g5LI8gytwBdVNN?=
 =?iso-8859-1?Q?ts/ho0LBmW1owv78wcNI3xL5XaowlkY8s2TMCErDD3jBD5kokNAjjo4vM4?=
 =?iso-8859-1?Q?KidB9LeStkrEdWHUdbJQP3REDLE6uBq6saPa2c4l6xTCHi+E0+V+uPG0lv?=
 =?iso-8859-1?Q?FKx3fwPhVvoN6klTEYOSU9yu7Joqva3mPcS53BUgfA+hDZvBKagTOzTHKp?=
 =?iso-8859-1?Q?2A/59T+SG35GZbUJ+7S5LDSSGI3ICuiGF97NYFskhSXUCrnx87/kGckhM6?=
 =?iso-8859-1?Q?ONFGCq/FbTVMdGpbfcEUXtFqLW9IfSJOucgi0Q/JqrRso1xQJWmxgRukfh?=
 =?iso-8859-1?Q?Tm/YaWKbPVGstYwUpuXmuTzHOMUVcx9j6QR3xo6w/CLLpqFj8Jhn+mSjVp?=
 =?iso-8859-1?Q?oIkqKRRhs88jwcuEY2j0/2Ge4kYw1kwPDgwORGG7oLI56QDkiDTwtRMIao?=
 =?iso-8859-1?Q?nwTLKAfSFBVPZnIntkLBJ8pCUlytV7kKUo7dzORUT/OP2Fb+Caoyg2gLay?=
 =?iso-8859-1?Q?Xlx1Ai7DUCNV2LJtquMMwAx2Fmv442cZWU5/n+xgfJWa2nb+w3b95t/d93?=
 =?iso-8859-1?Q?FXO3z5l/R/4PtOcFsAwBCt5rdV7fuN3/wnKi8KV3NtAemHQpSRdX9Iieim?=
 =?iso-8859-1?Q?8XsL2GEZUDFpsjdMPGGjTWVmQTrMkjOWoY5aSra+g87zHnKOCf3EnW/HeO?=
 =?iso-8859-1?Q?19vysNyvjryzrv/9xPz5xqcslH4fkXYxjlRWWK54pUHeDxOt39NmxKKdhW?=
 =?iso-8859-1?Q?syfbSPu8fCB58tRe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?63k+sYPIehsYoBlurwwVac4tBjnDUSgZ89lx5oMqFIm2hoEiXhVHEX56Lk?=
 =?iso-8859-1?Q?hBdoqkqWMvKnGaLTjWxYLOARfnTQNkxVm6PKgeddOEg6pmT+rfHLbF+8BW?=
 =?iso-8859-1?Q?y1LLHKGrb3WKTJJdnMs7lci1GDJkwkavgOW7GgJ8qzvfLWjcpSBisQ6JEu?=
 =?iso-8859-1?Q?VeWatLMdwMe48iyT2XEBMCqq3m1TMOkYw+6DaRfFS46uk/cHFyRleoKypT?=
 =?iso-8859-1?Q?7D0yrbjnZHis29VE7wdSeIisvetVq8M4CVFauG4gf4+kkBdUXgOgydjqBb?=
 =?iso-8859-1?Q?Z5Z6bSyeoH9JS+mOoLhZxGhEH6t1+kl/yjwGgJ58+rGOdq8OZikF743NCM?=
 =?iso-8859-1?Q?6uSD4rfmmj07A/vrZN8q8Epez3LDw2cvNLspgDGbuvM2jVLC0fwRTSyT3/?=
 =?iso-8859-1?Q?H3rNLD5uBElfFTgRKNvgG6ag3JlmHOi2+ffuYkXmzMgEEUxqitzf3BwjnB?=
 =?iso-8859-1?Q?8iIopiMhnyNUHLTGgGQd3lgTxToZEVZ8PvMC3GR9y1c4vGjaktdsMgxJHw?=
 =?iso-8859-1?Q?d0lcJbO06s+zpIxeIWCZvcD1i2gzskWgnNoEn6PPkzrlZLK7skFV5WfkYK?=
 =?iso-8859-1?Q?U2S9GzdOL3ej8acPo2GDBhVSunMfV1zj+PbzUX/vYKqtz+r2uO51ffng1d?=
 =?iso-8859-1?Q?TuY76P8WXYjmjDOpWImVK0vBJM4ybmWz5nLIZhjUR3ykgtgPTNY7Af6YVe?=
 =?iso-8859-1?Q?LlsWxWZBYj8C1n5eNfTMrtMRXCQREWTCHKJSb6m29riJi3o2DF3/sbiS2C?=
 =?iso-8859-1?Q?hR8N4XBSISlk6D46J6V0pdGGKvw/gpZE/5rs2p/L7n8Sr3mt3nt5u+swYN?=
 =?iso-8859-1?Q?w7T4VP4v0u86m1+B/ge4RlkFW66ifdGPBGg9pIYnWwFlfahMYMfo6H7Qci?=
 =?iso-8859-1?Q?J2qliqlvwAw8Xy+b4aSjoVE5DZ/M6plbMHvhO6m6E1XFw45BBcWpUXd3zI?=
 =?iso-8859-1?Q?W70rrtplmWNSBWHPoq81QHG2yKG2wA2aB9+bYVDdwDwJJsMbHWobpnrmm2?=
 =?iso-8859-1?Q?tozmq0NSGB1whbs4bUfWlqISTjPd7wDzDobNb1LeeHtqMi9T5/dz2uuCKc?=
 =?iso-8859-1?Q?ZxkZOzQ5phWXIu5eo9PBlrza3tE4OSXXELjU+/OD7QJWUNueMRHYjrpiT7?=
 =?iso-8859-1?Q?x5/HOZJcRAtBXu+Cavx7SksZRRuDLUIs7gZsKvC5ACq6GFQJ5E6vsgjJKf?=
 =?iso-8859-1?Q?VO0YCb1p0Kqrb4+2EnQFy2pPwBgbax4hpusRoJDlxSVbWc8iLDvQ6ZVj1M?=
 =?iso-8859-1?Q?rsZ26I6RarkjegXxGhS4m7NPMqkrMVTdK28dYMLUK0Sd/JrIiNbaxKEU1F?=
 =?iso-8859-1?Q?LsqZ86A3L41sLyJdM8KKQTnHjXYUW/Bdhtc1BfLNe9eloTOOHbWAjRjxPR?=
 =?iso-8859-1?Q?bbqOKTHFgbP3/XdTqBKr8jWESvF7p0L7f06ckV7qzc+NRphdOLPTpSXly+?=
 =?iso-8859-1?Q?kj31gNTVIn+iodxMB01t9in3rc8rW7NJtHR/T0acmSWxPn7KKwCIqIPRTT?=
 =?iso-8859-1?Q?uUK6CP/CqfNzr8Vk4T31xHdbYaUQwzguF2i39AIYvKkotCbJYW5Adh/sFf?=
 =?iso-8859-1?Q?vjY+XSO3eA9OvBklto7HlI+czSf+EmLjqRdwukZUQoUXZwR3IE8GwiYAl2?=
 =?iso-8859-1?Q?VSbNoWM0pl35IkOnMxgeQZlZ58xHoOoGVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dde43a8-d3cf-4ee0-6e31-08dd529388a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:19:36.4822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FokNinZcver/6wC5RhvtK2x1UyR7jm2gx+zk69TzuxIGrZ3Q7RrDkcocAuguYnLmWdc+jrWWdbt0InBMT85KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5853

On Fri, Feb 07, 2025 at 06:18:36PM +0200, Ilpo J�rvinen wrote:
> Flit mode introduced in PCIe r6.0 alters how the TLP Header Log is
> presented through AER and DPC Capability registers. The TLP Prefix Log
> Register is not present with Flit mode and the register becomes
> extension for TLP Header Log (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13).
> 
> Adapt pcie_read_tlp_log() and struct pcie_tlp_log to read and store
> also the extended TLP Header Log when the link is in Flit mode. As
> Prefix Log and Extended TLP Header are not present at the same time,
> C union can be used.
> 
> Determining whether the error occurred while the Link was in Flit mode
> is bit complicated. In case of AER, Advanced Error Capabilities and
> Control Register directly tells whether the error was logged in Flit
> mode or not (PCIe r6.1 sec 7.8.4.7). DPC Capability (PCIe r6.1 sec
> 7.9.14), unfortunately, does not contain the same information.
> 
> Unlike AER, the DPC capability does not provide way to discern whether
> the error was logged in Flit mode (this is confirmed by PCI WG to be an
> oversight in the spec). DPC will bring link down immediately following
> an error, which make it impossible to acquire the Flit mode status
> directly from the Link Status 2 register because Flit Mode Status is
> only set in certain Link states (PCIe r6.1 sec 7.5.3.20). As a
> workaround, use the flit_mode value stored into the struct pci_bus.
> 
> Signed-off-by: Ilpo J�rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.h             |  3 +-
>  drivers/pci/pcie/aer.c        |  1 +
>  drivers/pci/pcie/dpc.c        | 18 +++++++++--
>  drivers/pci/pcie/tlp.c        | 56 ++++++++++++++++++++++++-----------
>  include/linux/aer.h           | 12 ++++++--
>  include/ras/ras_event.h       | 12 ++++----
>  include/uapi/linux/pci_regs.h |  6 +++-
>  7 files changed, 77 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9c6a4a980678..07cc9be6f80b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -554,7 +554,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> -		      unsigned int tlp_len, struct pcie_tlp_log *log);
> +		      unsigned int tlp_len, bool flit,
> +		      struct pcie_tlp_log *log);
>  unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
>  void pcie_print_tlp_log(const struct pci_dev *dev,
>  			const struct pcie_tlp_log *log, const char *pfx);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 508474e17183..9c3e8299ad50 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1245,6 +1245,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>  			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
>  					  aer + PCI_ERR_PREFIX_LOG,
>  					  aer_tlp_log_len(dev, aercc),
> +					  aercc & PCI_ERR_CAP_TLP_LOG_FLIT,
>  					  &info->tlp);
>  		}
>  	}

It seems Linux does not support "Multiple Error Handling", correct? We
save the TLP logs once for each device, and the user will need to know
that these are just for the "First" error, right?

Thanks,
Yazen

