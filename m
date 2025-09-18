Return-Path: <linux-edac+bounces-4833-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0B1B86E57
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 22:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF973B53CE
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B1F2FBDF8;
	Thu, 18 Sep 2025 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ie4NJIP5"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020105.outbound.protection.outlook.com [52.101.56.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE51E2EAB60;
	Thu, 18 Sep 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758226948; cv=fail; b=sOJd9Qhz6vjfGzt9qDLOFM/xvacL/j5PpgSHtNslM2g6n9boyGxgZ/0iX3AmQdJDS4YqxuZl7h/pTvLEWaexCfS1OsueDI6PVsFh/zneFxT20luyz/w5J77Dinkqi56UrqR0bIOludVe2qPAv1pF4R4ii2LdezYLe4Fc/HGqWRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758226948; c=relaxed/simple;
	bh=SF+K5TZmwRBMnb2igeNE6GTBAfL1MNZRBzdBwQ62Ono=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rSwd6s8Qmzk8qHPHlTHrmIIo9qDqPH2+WFl/DhBmLV5Pi7gpIjRAXwtZcNpT6+3A9gohoAC5xvprHRyMMlX4KXL6QuBmSv1NXOyhtWnp3acTPUnto74xowYLzn+C463gxBlLQrAgk60hqvzEHRAL6Mn0w8/xwvOKDqk9W5G1gQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ie4NJIP5; arc=fail smtp.client-ip=52.101.56.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g32oK86H+6eQLBramIYAdrbkxrhn7ZyrngzyXo5OPUtTcXt0fDdfjMr5jY2SfZQ71ejYFzPtje3CPY4qO6cptv6NIaBbhwSj3eSl8HtqQFih76dHx6JyrTF4u/iysVJQk2Tb1eODLbjgKnx4iTH23Eo8wMQ+nTPHxmDwpw9cL013g3bEzafSyJp01bJ0OT/4ZXdZ4zpExhdj3k5tIRhigBBKGnv5H8vsx/Eh5rQuomSvV0sq8O1D+i6uHiEjv6P1OuXswoYxRFInVnlZ2gnne1bC/81bEO9e7jsRE8QTRy1K5aObEUqrxIfLiTMb4ukMi+B7zHIsPy7TOgOawnNA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/za7bM28tvsm36duIYphKz/VoLuB2W/YF1kl0dKAOA=;
 b=lZ6NiPUThHJxXBE5RHC9QVeVAz7AfvCkA8iA/7yMQC8r+sYURMoJBTi4tcGOylnGaE9gwsw393T7wNdwh8acqzaggP3ZJoirQcVD0jQ1JpPgoREZ1vJrNoGWyrcRIOXVuNd2c/YBzi+MKbu41TDG4L/qaPwkUK3w1jNAQQxmb31b06cjjipX6kQZMHnzPavlBxNn1IzPERtwsWCgNfw0SwDhTXY789Ob4JCTdq7lH/9aMs6YLFoAQC/F3sg8ZynepY7JRdzZdggOQCBX5f6SNPKQGnkS06iZIWhm3n8OPIVXgA2R4GIEGkAIfKcezrJwPJWMJ1aVHlXnqkFqVHDKyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/za7bM28tvsm36duIYphKz/VoLuB2W/YF1kl0dKAOA=;
 b=ie4NJIP513t41kPfpYN0PH6DirpWkALQ/7EWdDXIucdQ9ycV1cFYwnw9Po/YC1rMcBhN9/HJnrkTbSJ5MUBmbf35XgFyavlF2IMF1hpTvyvxLOV937RcO2cyxgIhTATflVn7lFYKmmsD1qYPFkFDAZ5Qb6Cjh3fa+w/pj9rzSNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 CH5PR01MB8815.prod.exchangelabs.com (2603:10b6:610:211::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.22; Thu, 18 Sep 2025 20:22:22 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 20:22:22 +0000
Message-ID: <7a211c5c-174c-438b-9a98-fd47b057ea4a@os.amperecomputing.com>
Date: Thu, 18 Sep 2025 13:22:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/2] ACPI:RAS2: Add ACPI RAS2 driver
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Borislav Petkov <bp@alien8.de>
Cc: Shiju Jose <shiju.jose@huawei.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "rppt@kernel.org" <rppt@kernel.org>,
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 "rientjes@google.com" <rientjes@google.com>,
 "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
 "james.morse@arm.com" <james.morse@arm.com>,
 "jthoughton@google.com" <jthoughton@google.com>,
 "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 "pgonda@google.com" <pgonda@google.com>,
 "duenwen@google.com" <duenwen@google.com>,
 "gthelen@google.com" <gthelen@google.com>,
 "wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, vanshikonda@os.amperecomputing.com,
 danielf@os.amperecomputing.com
References: <20250902173043.1796-1-shiju.jose@huawei.com>
 <20250902173043.1796-2-shiju.jose@huawei.com>
 <20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local>
 <9dd5e9d8e9b04a93bd4d882ef5d8b63e@huawei.com>
 <20250912141155.GAaMQqK4vS8zHd1z4_@fat_crate.local>
 <9433067c142b45d583eb96587b929878@huawei.com>
 <20250917162253.GCaMrgXYXq2T4hFI0w@fat_crate.local>
 <20250917183608.000038c4@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250917183608.000038c4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|CH5PR01MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae2a003-49da-46b9-f41c-08ddf6f112a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2dtMHlRdm9OS3pZODJFZjhnbEw5VkZjWTl4QTFmR1JXZ21BT2tzWmZHQy9J?=
 =?utf-8?B?MkFLdkY4MUN4VnU0SXJZQzQ2NXFlUlNMQ2RtOXRGUmVhbU50MHVDcFRhVE4y?=
 =?utf-8?B?ekdjNlR5R1dlWldaVWhkU2tGeC9EK2wzWmE0Z3M2YXBYN2xVMUxxVS9rVnhj?=
 =?utf-8?B?ZmNLWVBPdDBjdTRlUnJMTHZtT1g5QlRDNHNuNnJwQm1ja1RoK1RJb2MzODdY?=
 =?utf-8?B?UFNJcllrZVBzUy85NFZ2YSs2N1lsSmJ0TFltZXdCWlk0VnIrNlhNQklZdEd5?=
 =?utf-8?B?R3c3VjRBUWgwUGZOTm1qckk3alVSTW9ZVFRKemh4VktJQ0tPSnBZWHJGSzJr?=
 =?utf-8?B?OXVzOEUzdXJWYjQra013YWFkMFpZUVBER3AwZWlOcFZwYVE5dTlnRjhaRzVN?=
 =?utf-8?B?YytIY09VMy9LcjFXelRZeEMwNENVS3NzM0RDVFZGZ3U3UEtzWllIM3UvbGY3?=
 =?utf-8?B?em43ZkNFSzVOSlgvVGw4c1JmUHAvYnJFdndGRkRRVTE1OW1rNnF5RkZzMjg2?=
 =?utf-8?B?cTFmY0NyYW5rcWQrdk94QUptZGxFTmdTZ2xFSnNNOGVvV1AxNnl1eDk3OTFp?=
 =?utf-8?B?bU9aOXR6eEluTFhtL2YvOUhhcHFqTFVZQXFoaHlQbkNOM1JvUzBtN3BabmtK?=
 =?utf-8?B?ZjFTdlpzVDl2ZmdiYVV0c2xOVmxEUys1bTdXR1c0dUhXNHEwMVFPVXNuaitU?=
 =?utf-8?B?OEVMU0VKS0ZVcXEvWEkyQnZRbjNXUEZ4bWtmVGlaL2EvQ0k3NGxoL2lVWVNF?=
 =?utf-8?B?K1hOMGVySHY0L3lXL1dhZStLa2ZsUS85MnkyYU03VSsxelhyQUdyRG10WWRy?=
 =?utf-8?B?SGVMYTlzRFYrWlBIaUYyT2VxbHF4RjEwVGJTcVFPQ1c1T0phNk1QZTBtMFJS?=
 =?utf-8?B?UWJVNTR4aGgrbU1nZlJjOVRMZVJsam1yTUlXUEtTYUF3bUsyRXZ6MmdJRmkw?=
 =?utf-8?B?cTQ0US83MjFEVmpJMU03UzJRK0drOGdmdUJmaHJHd2F3RVVsK0swNUJnaGpX?=
 =?utf-8?B?N3FKV0FiNnVpZXFHeVJBcjNNZ3JmaW5Wc1pQMFRkWndURStyY1RZcnRiUm5j?=
 =?utf-8?B?amw5bjhTY0pUWG1FSXVBRjdpZjc2ZFlqclFJQVJiU1JVZlVCaUhBUnI4Tncx?=
 =?utf-8?B?QWM5bGgzVm9TYytMYS9vK3hNNnh2MXQ4V0lDUHFIZ1RxWFhLaExOT2t4MVpw?=
 =?utf-8?B?UlRCd3BGc21vZS9PaVFWT1NzcHhrQ29JS1ZzR2g5NHpXcEY2ME1vaTY2TDFY?=
 =?utf-8?B?NVdIL2JGSHdxanVvQ1BsKzFOcTd3bVViRlZvK3pxd0UzTXUyaWlodkI1aEhR?=
 =?utf-8?B?cTg4enlzY1VUUis2Z3hKKy80Ync1d0FtVUpUWSt3ckp4Ny9CVDJjai9XZTRQ?=
 =?utf-8?B?eE1Fa1RZTUJETzcvL2VPRXNYOEVGZXpuQ1cveDNPa2ZSZGg4RCt4SjJtbnla?=
 =?utf-8?B?R25xazBSL29qRlBvK2hGdk9xTUpHa1F2WFoyRVBkcXlzbUxJY0llSFlFQ2tP?=
 =?utf-8?B?QmNzeUFqQkdveGx1bFVud0szOGYwWTNaajFJeGY3bythTHFXcytRdEdmNEFu?=
 =?utf-8?B?V01pL1VYUXpLazlqL2Y2bGtvTWRIc1pFU1hieWNUM1JUaXVxMnBQaURWZnZZ?=
 =?utf-8?B?YzI5Yk1hU0Z5cGZoSS9FdEVaSitocStQZmEyWjVKZHBRSWx6a3pkNFlJeGM3?=
 =?utf-8?B?czJmcTA3NzVVS0tsZE9NTFp3WENFdnY5OEhNOUFTL3M1bi9Va2QzZFQvUFJE?=
 =?utf-8?B?V2dNL0YwRU5xS290MEpnVzF6SC9KQ2hlZ1poakRseTg2T3M2S2xpTkFwSHMr?=
 =?utf-8?B?MEM4dEpGMUNTK3pYc3dvbU9rOENWWUtua0c3TkZOcUtSZUN4bGR4ZlozNEJ2?=
 =?utf-8?B?K1dhM0xBMTgwQ1RuT0lHdGRJYVhvOTJFNXhqK09Wa25Yb3hGZ3RURERKcFIx?=
 =?utf-8?Q?pVO9/QKSTHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjF3bXg4ZUdQTE0xVjF1bnVvZ0ZMTVdpNzU3SDV3TzVnTzRoV0NtVFphSVB3?=
 =?utf-8?B?R3ZwOTJxYWpnQlJzdlBEL3R1b2VqREVDOE5tQ1FndzdZc1FjU1JrcXExeEoz?=
 =?utf-8?B?ZGdwWXZYdUh0OWhiam1BMHRSYnhxNExsYUhjMFZ2aW1WRzVmV2RsamNuOFRJ?=
 =?utf-8?B?UStuVEVMV2tGeVh6Qy9LSi9HN0RRV0JsSklmMkVSOXhjUnRNeXlEbFgvSk9Q?=
 =?utf-8?B?TlJxcWo1ZVB1YmVXVGdqZkFVNzJaeFJvNjFHLzI4S3lTVUxUa1NqUFJmVkdV?=
 =?utf-8?B?WnhGMWJXTUZNKzE2dzZ4QTA4cDB2bTFLUHRqd2ZUWXhJc0ZDdHlPZnYwUWc4?=
 =?utf-8?B?QmxlNllOZjQ4NUVlNkY3VXVPaEd4b0UvMHdvbzlLazFQclJmQS8yWjh0eE5n?=
 =?utf-8?B?cnFYV3BMWVNIL0J0OXZQUy9XR0d2NVBDRnV2Z2h6WHV6eXdVSWx5N1pYdVZo?=
 =?utf-8?B?QTZYaUFjR216Z3hoQ3hGT0xxQW1Lc2JudVFYUnlUQk1BUHU0NkdaN3pzNE1M?=
 =?utf-8?B?eUs0bXpGcjZSYjVzaWppeXNhNUVaTjNaaDJKTEp2V3F1TStpbXpJQ2FaNVRX?=
 =?utf-8?B?bzM5dTE1NXBmZnBvV1ZZelgrSUZRWk5kMmtsZUkySDd5M2VpQlFVbC9DTFA0?=
 =?utf-8?B?b2dabFFNV2xzTC80ak5TQzdqMXQ5N0lOQlZlSlBkU0tuSE92OWsrSktUVE1j?=
 =?utf-8?B?Z0NzOXZrd3JOaDV6MmxPaW9jZzFEdGl0QXhaM0Rrdkh0d2FYT2c2VFQ2YmFp?=
 =?utf-8?B?bzFCbDhrUGJtdldwaUM4azB5MGExR3pYWlZzS3hrQWdIaVVIYWh4TXNra0h3?=
 =?utf-8?B?b2pmbDc5bFludFJWZWRXTlRNd1lwS2NwZXlqRjF4QnM4dC9CdnFEam44ZmZk?=
 =?utf-8?B?K2g5azBndXJBU09BWnNneDV4OGgzamdocU5ubm9KQUd4azI2Ylh2OHJzYnln?=
 =?utf-8?B?bjhvWkdHRFVscVFiTGFBeEdYeHg5MkozM2VCcDBuVTMwS29Tczd4L3RSeDdO?=
 =?utf-8?B?TkhaZzJRUEVJK3hBaktxTEtPUERPa3ptM2U1WjZQTDdDV3hnd2w0OFc5dXYz?=
 =?utf-8?B?R0JPNXQvcjZLQ2tWd0I3eUZaL0tzYUFtSVZEb1R4T0t3VDBKSnlMQkxpS1dr?=
 =?utf-8?B?aHBoR0doSkh2Q05kaVpXcmcycmlVeWh2eWVqZDhOZ3hYR0ZhTUJxb2RISzJE?=
 =?utf-8?B?UmhtaTUxdlFTQURBQ3ozNUQvZEVPcG95bVp1WVRhbWU5anUzWGVoUEIzbHl5?=
 =?utf-8?B?M3pvUWFyQ3BPYmpVakpMalNEY0dHYjY3MHMzYTU3NzhRMWM2T3NETDBpTHJU?=
 =?utf-8?B?aUdOaXMwUTh4Y2YvL1g0TFdBUS9BS2UrQ1lRSkdEeTEvaWJ4OEtoK2pqYnV0?=
 =?utf-8?B?QWFOaGFqWEpkVi9OUkJrOEdPQWduMk01NDFCUTdkc3JLTUtRRmxwbTFoQXJq?=
 =?utf-8?B?VWVzcDVLbkUxSWZLVDYyNjhaSUVMb2pTRVBBUmNzcklpWVpiKzB1QjVBNGR3?=
 =?utf-8?B?dkVKR09Ob2pwS2ViQVZ6VDlML3Y0b1lFR3hLaXMwMWJtSEZnQm45Q3Q4Witl?=
 =?utf-8?B?dk4ybVhUR3R6djNPRjVEMFVvbVVFcGl3Sks4QVI0U0lGUEt0aHdMVHQxWDIx?=
 =?utf-8?B?b1ZEcnk0cllGOUZYUEp2bW85SHhoMXdqVGZUU2IvZEp4aC9mVXI4b1BTU0Rt?=
 =?utf-8?B?UGxvUGt1K3FEN2dwUVdvZnF2Mk8yOVhmamRIVGJzak43b1BIZW9JNDd3UjlB?=
 =?utf-8?B?QlRoMGtWQ2RsTHVzekc5bjlrRW0xUk13RVRYRmQ4My9pZ3JFT29COUEyZzRS?=
 =?utf-8?B?TTFBYnhrVEZIa2puVFpWS1RFcG94dVNCdWE1a1JvUzJjdFd6SmhNcVJ4Q3lW?=
 =?utf-8?B?QlZoekovMDlwYlhpR1d5S1AveXN3Z21rdm9LT3ZGZUlQTzR4TklkRytVU2ZJ?=
 =?utf-8?B?SnFWQUxYd3Q0enVHT2ZLMXFKRnBhR0tiY1NaL3ZzbWx2MHkzeGRsNERsN3BK?=
 =?utf-8?B?cjBrd3VSSjBLOENOdFl4bWp6SHZSeXNkZTJJeXZVMFA5QlVBQ3FTY1NmcEtK?=
 =?utf-8?B?alpWaHJ2V2VuS1VrQWVpRXhWRGtHQVF5T0NUS2pqZDc2WlIwTFFqRjNTNVJt?=
 =?utf-8?B?NlIzTXNPKy90ZVR3U213SlZyOUdUWHZrdFZmeTJjc2Jqay95d3NMMWJkZHUr?=
 =?utf-8?Q?dStiYM0m8d2/t8kJTTk6Gb8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae2a003-49da-46b9-f41c-08ddf6f112a1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:22:22.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3X8ldpRTGJlUxQxwI5PnTjoGZYfCNw5gqrNP9MStsh18aODSutMYzbGzBZZe1mvsUbqHWQWW6gxveKtGlJtzqs1DUGfMDHhzOjuL+I12DOEb3hLy2k4vLOT0/zgsEOh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR01MB8815



On 9/17/2025 10:36 AM, Jonathan Cameron wrote:
> On Wed, 17 Sep 2025 18:22:53 +0200
> Borislav Petkov <bp@alien8.de> wrote:
> 
>> On Mon, Sep 15, 2025 at 11:50:16AM +0000, Shiju Jose wrote:
>>> This has been added as suggested by Jonathan considering the interleaved NUMA node.
>>> Link to the related discussion in V11:
>>> https://lore.kernel.org/all/20250821100655.00003942@huawei.com/#t  
>>
>> Sorry, this doesn't work this way.
>>
>> If something in the code is being done which is not obvious and trivial, then
>> the reason for it is written down in a prominent place so that it is clear to
>> people.
>>
>> Not pointing to a discussion or some funky place on the web where someone
>> might've said something.
>>
>> Your patch submission should contain that info and not have reviewers ask for
>> it.
>>
>>> | node 0 | node 1 | node 0 |   PA address map.
>>> Can you give your suggestion what we should do about it?  
>>
>> I don't know what the problem is to begin with...
>>
>>> I think Option (2) seems better?  If so, can the EDAC scrub interface  be
>>> updated to include attributes for publishing the supported PA range for the
>>> memory device to scrub?  
>>
>> The memory ranges should already be available somewhere in the NUMA/mm code or
>> so and for starters, we should start a scrub for all ranges and do the
>> single-range only when there really is a good reason for it.
>>
>> Also, you don't have to expose any ranges to userspace in order to start
>> a scrub activity - you can simply start the scrub in the affected range
>> automatically.
>>
>> Like I preached the last time, your aim should be to make as much of the
>> variables that control the scrub automatic and not expose everything to
>> userspace so that some userspace tool decides. The tool should simply start
>> the scrub and the kernel should DTRT.
> 
> This 'first contiguous range' is an attempt to DTRT in a corner
> case that is real but where there is not an obvious right thing due to spec limitations.
> 
> The problem is the ACPI specification ties a controller to a NUMA / _PXM but
> then controls it via a single memory range with rules on whether that range can
> include holes (that are actually covered by a different controller).  There
> is no way to discover if two disconnected ranges may be scanned at once other
> that trying that.
> 
> Without resolving this corner, there is no way we could come up with for the kernel
> to DTRT.
> 
> Aim is to automatically establish the range that can be scrubbed. The corner
> case is the hole problem.  Alternative as discussed in earlier versions of
> this series was ignore holes.
> 
> The options discussed in earlier versions of this patch
> =======================================================
> 
> So with Node / PA mapping (happens because people want low memory addresses
> near to CPUs in different sockets - I simplified it here somewhat).
> 
> | Node 0 | Node 1 | Node 0 | Node 2|
> 
> 1. Hole skipping approach
> Have control parameters default to
> |       Node 0             |
>          | Node 1 |
>                            | Node 2|
> 2. Present part of range that is at least not including a hole where it might
> look like we were controlling memory scrub that we were not.
> | Node 0 |
>          | Node 1 |
>                            | Node 2|
> 
> 3. Just don't present anything and leave it up to general mm interfaces
>    to provide what 'should' be set.
> |
> All 3 here, 0 size.
> 
> Whilst nice to support, I'm not seeing 'default' as a key use case and
> changing scrub from a kernel driver without policy from userspace to
> me would be a wrong thing to do. (I'm not sure if you are suggesting this)
> 
> The scrub should always be running pre linux (true today on all systems that I'm
> aware of, but maybe not as universal as I think?).  If there is a need for
> a default scrub setting on boot of Linux, then sure we can add it.
> 
> This interface all about tweaking the settings not defaults (unlike the CXL
> case which does need the setting of defaults as well because of hotplug of
> the devices and lack of firmware involvement in that).
> 
> We are fine with any of the options above.
> 
> This was an attempt to respond to review feedback from Daniel - it was not
> something Huawei needs.
> 
> https://lore.kernel.org/all/547ed8fb-d6b7-4b6b-a38b-bf13223971b1@os.amperecomputing.com/
> 
> After a discussion of why 0, 0 defaults give an unexpected result...
> 
> "Proposed Solution:
> What we propose, is to instead of zeroing out the base and size after an error,
> use the full range of the current NUMA node. We believe that a superset of a
> currently active scrub range can properly report all the relevant and correct
> information."
> 
> The above Numa node pattern in PA space |0|1|0|2| etc is a thing
> that happens on real systems so if was the best that had come up in earlier
> discussion as an approximation of what Daniel asked for that should allow the
> right values to be queried.
> 
> I'm not entirely sure this even matters now they have resolved the shared
> PCC interface issue on their platforms.  Felt nice to provide meaningful
> defaults but maybe this is a problem we don't need to solve and can go back to
> just using 0, 0 until told to do something else.
> 
> Daniel, perhaps you can provide more info?

Thanks for pointing out the limitation of using NUMA base address + size as the
Requested Address Range to determine the status of the scrubber for that NUMA
domain.

> go back to just using 0, 0 until told to do something else.

Here is why I think (0,0) is not scalable:
Not every architecture would consider 0 to be an invalid DRAM address. For a
system where 0 is a valid base address, size 0 is an invalid argument. The
firmware would be correct to return "Status - 0001b" for this Requested Address
Range. This would be compliant to the ACPI spec as defined today.


Based on the discussion so far on all the threads, here's my attempt at
summarizing the spec gap. Please add if I'm missing anything:
The OS can't determine if the component is busy in a single RAS2 scrub call if
the NUMA range has holes. To correctly determine status of the component, the OS
would have to make multiple calls to cover all the disjoint memory ranges in the
NUMA domain.


Could this gap be addressed as follows?:
The patrol scrubber can only be busy due to a previously *successful* request
from the OS. The OS can keep track of the address range it submitted for this
request. The next time we try to submit a GET_PATROL_PARAMETERS command, we use
the previously requested range to check if the scrubber is busy. Additionally,
if you know the previous START_PATROL_SCRUBBER wasn't successful, then there is
no need to call GET_PATROL_PARAMETERS to determine if the scrubber is running.

At driver init time, use the first page of the NUMA range as the Requested
Address Range to invoke GET_PATROL_PARAMETERS - to get parameters that apply to
all addresses in the NUMA domain, i.e., "Scrub Parameters" and the "Extended
Data Region". The "Actual Address Range", "Flags" and "Status" fields will
change when the "Requested Address Range" changes but not "Scrub Parameters" and
"Extended Data Region" [1].

[1] - https://github.com/tianocore/edk2/issues/11353

Thanks,
~Daniel

> 
> Thanks,
> 
> Jonathan

