Return-Path: <linux-edac+bounces-5712-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHH9HdEXjmlF/QAAu9opvQ
	(envelope-from <linux-edac+bounces-5712-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 19:11:29 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E51302DE
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 19:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 694E23097DBD
	for <lists+linux-edac@lfdr.de>; Thu, 12 Feb 2026 18:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F230274B5C;
	Thu, 12 Feb 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C+aXdZEl"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021103.outbound.protection.outlook.com [40.107.208.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5372701CB;
	Thu, 12 Feb 2026 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919814; cv=fail; b=vGlCQ2GTKlpv6HJnGtVsXdMiUb7WIdbhdpigYNPRpb11hOcIKMLcZHxl2HuvILv2g4INURe+yWTNwgNDB8Gun4/PaeiSBEm8MnORTEkpa4dvsNWtVXYHJE2bZgrMVbWCXdvEMKwYbeVcNkVpPnhPYvadYZwCqLwthqJHC9lSoUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919814; c=relaxed/simple;
	bh=a3VD4kSNoYcCc+fOg83N8QBamA3VIIs3UcG6z9Fvoqg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IsbGFrByU6FUglYS6AdDa/sSwmQqkHocCWTBg+OdsQ+mbryVvbZKM+BYH1MpHZ5irqHmWpzPHrd+Msw1NtlCe0Q67ts6ra87Gl9Gg9mckmBFO+MZFN8oCB94VHDFDNGaiIsoHwtGlJEXBLW6mD4oeYQ8k4FAo7fQp9abcL5QGiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C+aXdZEl; arc=fail smtp.client-ip=40.107.208.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwSnpRrlZXa28F7BTeQ5WGA+uyYiCiOQT4RV4fXo4ni1lsiJIwuHoUALbE4RlmR5WDfDbrGfosj9aBb/9ijTc1BczRKl+qJhJzuUS2qBMExxTAkAro5JFkoO4JCdVa5GdUSvBn3SX0SLr44uloUyt49gWqKDlq1BRMjoPSDed4CrdU+l+GhIejHbLH+umDO4ZfrnlS6wIDmYh8hixzMYhC6j14Oy4CeaGgJfgIwrxEOpEiWJhGi/ohSqTPLFmrPwtQYaFLw8mUeM/LKMoXBEAzImzwJ1uONqD/4+1Tp1AIOmrRQOerG/eHrXfcEAxSdFS3s/KViX1kOglO440HvwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEkPyEZ2BoB5f2ZQ+/Ajm5N8omwcM+K28wpo9uW5HXc=;
 b=aE1vhdHA2iSgh/Nm+NavFAUqOGqsJ7UsLwa/RHPJOlo0T2Hh6jO3T+ctRW5bcWI/6fbRSxpGGlNzwygADMpwJKR39VkxC2iPTtzdnMpuM2qG5V1O1xGZs0ERiPqoP5lWXqiyE8YxSJJewfzpSNeo+tPQPKDHG8qvtAQbj/Ly0vMEwETcQjrtAu7aP9kEU6u9svhy8jOX7zYPUV9q6V6cz+gELLjpeP2t7Z8zMwYOnilupY5fAUjvKmyXTAhZBlXb4pfXlRdDHepDTYJHrxkWjjN0VnZmxxyutd5Ulbmij3+3sSYCHYasNowAQx3PiYfVCAzr3HWQMnHk9bhgKWwQjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEkPyEZ2BoB5f2ZQ+/Ajm5N8omwcM+K28wpo9uW5HXc=;
 b=C+aXdZEltjBW3Ic+F+WMtBzVl4NmBrSOt6KCKuEx4VctnrZEYiiDxhsW11SIadFEQk3A/7L1Wo3URkXRvC01/ekedCMq2G5q52CFuj5soaitGpirjsO5+/qLKxrRzdI6twZSWi+VbV9PZjE/Ka0TxzY2WkJgGrcq209f5OhXdC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 IA3PR01MB8750.prod.exchangelabs.com (2603:10b6:208:532::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.11; Thu, 12 Feb 2026 18:10:06 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::4b21:87c0:adfb:1047]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::4b21:87c0:adfb:1047%6]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 18:10:06 +0000
Message-ID: <df5fe0ed-3483-4ac5-8096-447e4e560816@os.amperecomputing.com>
Date: Thu, 12 Feb 2026 10:09:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 0/2] ACPI: Add support for ACPI RAS2 feature table
To: shiju.jose@huawei.com, rafael@kernel.org, bp@alien8.de,
 akpm@linux-foundation.org, rppt@kernel.org, dferguson@amperecomputing.com,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org
Cc: jonathan.cameron@huawei.com, linuxarm@huawei.com, rientjes@google.com,
 jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
 somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
 duenwen@google.com, gthelen@google.com, wschwartz@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
 vanshikonda@os.amperecomputing.com
References: <20260123175512.2066-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20260123175512.2066-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::13) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|IA3PR01MB8750:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dbf4a3-9a4c-499b-9f25-08de6a61f2fb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGxjSWhyb01pcmppMWpXclM0M3pyK2tKK0tvTXJXYTlSUkc4cGE5bG5yTGh3?=
 =?utf-8?B?Qzd5UnJIY09HeHNqZ3BEUXcweGxWQVpJS1VicHlQTHFlTGZYYWFWTGxLMUtk?=
 =?utf-8?B?cU91ditvd3ZIQjArL2NPTEJjc3hJNzVYZitMUWlOQVF3NThGaTFYN04rbnpE?=
 =?utf-8?B?T1RyVnVqTG1QWkxXOFhmMjl3MDNLaC9VMDBxR1ZBbjFFSGhPZlY2bzVvQXRq?=
 =?utf-8?B?TnVuSGloRmpLV2NzVDlwN0lFL1RSa2tpRnBBQ3RlSGlrcEowNURjTi9uS3Fh?=
 =?utf-8?B?S0hGYXZWcWFBTGVScEpEWkx3RXR5emlQaVgzSitLbEx3TkJWdENXOTE0T1pW?=
 =?utf-8?B?ekxMN2VkN0h5OU9wMy91VFYveDFmNjNORjVGbzJrbDhVRXNMMk1mSG5OUHFC?=
 =?utf-8?B?dkZLSWZKUGZzRmx6REI2RWkyREpXMThvNm82YUVMKzZXWnBqUjgzdzg0Wnl4?=
 =?utf-8?B?SXQwTEM3NVM3TnJGWmhFbWNTQzJXZC9XMXRMYUZRVTBQVFNacU9USTZ5bEw0?=
 =?utf-8?B?YUZJVzN2bTc5T0hSelJ6ZXZreTZIdFREaDFvVW8yN1MvcXZ2NkhTdm5GamJG?=
 =?utf-8?B?a1JNUjhqQXN2dkhCSzZlQ0FGTXVJZVMxUzRuSEVJSStOMVpSQ2lYVWc4K0Vx?=
 =?utf-8?B?UkE3eWsxeEVBZFpYRnBzOWhpR1lwZERZVG91S3MwQ1N6aEtQbHcwdGV3U0k4?=
 =?utf-8?B?Q3RuR2U2M0c5c3BQS0VDTnBvS1QzYzg5OUFJSGRudnIyOVM5cDlDM2FicWJI?=
 =?utf-8?B?SnZzRHpmczFhNlh3ZlJOSi8xSmlhMm1KWjRWdkwzZE1RTVJoMkhmWDZkODdz?=
 =?utf-8?B?NTZFcEVzaGZxektHZUlIOG16Q2g2bnBNRUFnQVRWM2tBY0s4dUtIcG1VSENa?=
 =?utf-8?B?d0cwdTArZFF0VTVXNEU5bTNzTnZZUis4QUpVT3k5Wk11MTlsdDZZODdDalox?=
 =?utf-8?B?b05mdW9JalFOVEtwMU5Wb0R4ZW9VcUU4TUlTR0s3eVhxdEc4cWtwUEh0MnhT?=
 =?utf-8?B?c2pKVGpOTTV5Vjl1SkZLZHliRVo4V05LdEdURzdDNmdCT2pxRTd4a3ZUdE5H?=
 =?utf-8?B?cVBsb3dVMTVQaHFtMnhWM1h2Uzc5TzN4YnFMbC9zTU91T0JPemN0bDBNcFlC?=
 =?utf-8?B?RURxVGZhdGRjOUFFTXE3MERSdy9pRDQ1R2RsZllYTlc0TFlnY0IwSS9uRXcv?=
 =?utf-8?B?ZXZDMmRqcU5uVGVKRDdUb2dtcmpjQzJOcTdXeEUrQWdkOXlCWU5KbG1BR01F?=
 =?utf-8?B?MVVIeG5ISmZOdDkya0RWMUZaTGhpR2s3Y1RtUm1JVGFhZjd0blhhRDZkY1lH?=
 =?utf-8?B?MERBbkpCYm81dVhsYllYTGdHbEp1Z3k1UnIwRjQ0VVIwVDVoZW8vVVMrSXli?=
 =?utf-8?B?NHJBNzFqOVRrNDdPVEZ1ZFJJMjRhVTF4L2dEN2pqT0l5QVBuVmIzT0s1ZTVl?=
 =?utf-8?B?ejNaNzRyRmJOeUNlTG05VFp2b1h6enIxWHhvNE93eW5yRy9mckxXMEZZQlhG?=
 =?utf-8?B?L01STG85RzBHU0tCTnAzNTVzdEZQTDVDUkFGUTNQai9VRWU2UDFiMzdNb1RI?=
 =?utf-8?B?cVNtKzhOWnRCbXFZYWMyb2tudWc4Y1h4ZUxYT0hKK1F5QzBidk5CMitxQjY1?=
 =?utf-8?B?a0FaZnduV1BnSVhheXByaktVS3dkcHFPTXpyUjJzcFJaNVlEYjB4LzVCVDEv?=
 =?utf-8?B?cDZmMDBZRFh0Wm9tb0tWajBPbWcxeENXendaOFYrZVc2cDVlbGpicEw1N3pl?=
 =?utf-8?B?OVNYV3FVekJsVm5rcHlOSU9JMitVWktrazZhUXFYcFdGakJEMXh4YzFmREVY?=
 =?utf-8?B?VlN3aXE4dGtvanlvcFkrQktRQVhVeElReXRqQXBTOVFDNSt5UjdPY2RLMjVT?=
 =?utf-8?B?elZUWDlXWStRSzgwNXBRcy9RNzYyb1g0NFJTbkZ5a1AveC9NVWhPWnIrdDYx?=
 =?utf-8?B?SEVGeXdrVytaLzJUMmowNS81YWdGVWtDbjZXRFVGdGQ0L3cveFZ6MU5PWlh4?=
 =?utf-8?B?U2VzeVJJY0JGSHF6aDdpMDNmSjl6UDE2OFE4T2xlRUU5QzFBOFRwNUZIN2ZH?=
 =?utf-8?B?bzF5TUtWbEpodmtnNk1pMW0xMHkrWHhRWnk2c2RDcVh1OUdpam5YYUEzZ3B3?=
 =?utf-8?B?UXlBQzR6WmdwbGNKalBES2lSUEx3aVlpREdVME4zeXp5c1pCVXpBckpMelQz?=
 =?utf-8?Q?gFUDmYY3MmFkWoE7dg0zYMWD5Tj/hoZ1P529uRvS/Kya?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0tuZUI3ZlFMQmpaTEwrZWNlMGFXUjZEVEJWajQvWFZIem15ZUZ3bzNkMk1l?=
 =?utf-8?B?SnpvUmRmMUlrVUU2OFJNbEl4aW1DdTFMejhndmhvTUM1YUZVRmhMSWtKNzJM?=
 =?utf-8?B?TnRxNFZzd1NxdFZXaENBVmRHN0h0R2s1RzlKb3dnYjZCZlVRNHVEYW5IR3Zy?=
 =?utf-8?B?MFMzSEUrVDR2dXhTY05ORjFqK2taeE14N3VKWFk3cGt3b3FVdTdhb3NmdkFC?=
 =?utf-8?B?aG1ROU5YNWtnTmlxUEU4QmZqUXk1MzdvbmRMbnVCenRpaE5hdEZRTnlFcUVj?=
 =?utf-8?B?d3Fxb2gwZmYyMm5ZbktBK3VFQVZqVzNOK05LUTN3SGpoTkExOEwxLzF2ZGd1?=
 =?utf-8?B?WVdqd3IrclprSnJJK3JHR0Mza2NZa2RicW55K09UNjUrWEZYV1hmdzNVaDlP?=
 =?utf-8?B?OERJOUdJOFYvb25pa091YmQyemtWUCt0a1o1VHYxeGs5U0dVQlRpMkxOTnJa?=
 =?utf-8?B?eVFmQ0liN2RFSS95MGVZTDRmSCs3eHgyOGI2TGhDU1M1cm1JaVN1a0xZVmY5?=
 =?utf-8?B?ejUybTJOakw5REtlcFJDVWYxM0lsb3dTYmNrZ0JtQ1U4Z3oyMU8ra1NTY2FG?=
 =?utf-8?B?UkQ4blB1TTBwb3BnVXhDTzZOY1RPZkdNbFFETnZGQUNrajdoRHdRT0hOVUVB?=
 =?utf-8?B?QkEzNGwyVG8zbkZKYjVtUkdQQVkxN1ZtTkVLUzM5YWZ3VEd2UUxUSFR6Vm5o?=
 =?utf-8?B?NDBLdEpsVmJ2K1N4aXd0MHpEQ1dTTUYyQ2xuTERWVWNHbCt5RFpMZzlaMHo3?=
 =?utf-8?B?SEVTRmxRSEo0M0M3Q3lnTGpYQkQ3eTBwRmJ5YUpidlc3aDVKSVJtcnVDTFhK?=
 =?utf-8?B?cFh5aGdlcHNhTDNFQ3BBbDR2eTJraHRaUlB5dGptYmVOalBiWnd0VXNRRE54?=
 =?utf-8?B?bWdNT0MyUGpYeHd5VEhkWEszdjV6NUNqQ3NRVzU0RWRBRFdMZmlKS3RFQUx0?=
 =?utf-8?B?YmJwRXd1N3g0Umo1VWNodU9aWGIyRFBIVnBDQ2txV25vQ2NSQnpOMnB6eThv?=
 =?utf-8?B?T3Z5RVlGNCtMcno5OFd1bnJQT0hzNG1RempOc0lYUjMxbERSYU9ocE8yc0kv?=
 =?utf-8?B?YUJScFpVbGRaZlJOSWtIRy9qUFpBaWUyWTNEbnEzZTY0akd3VEF1bU50SGZq?=
 =?utf-8?B?MW9PNG9CbUg4TEw0eVZVcHdKNmpUNHRaM3ZZQWh2d2pSeWMrUVB2OGhzZWRh?=
 =?utf-8?B?Wk5MbEdqMEc5TlNGWjluV2tQVTJ1ZjZ3RWRsUFY4djEvS2J2SEl4Ym1PMHpq?=
 =?utf-8?B?MzhDWWo2ZkRsdzFGSWxlNVliUUdpUlVwb3VLdUV5aTkyV0ZLRENHd2d5VkN0?=
 =?utf-8?B?VXdreUNSaHhHd1ZCRk5iRlNmQWJySHZoQzR0d2hkbE96WUxaTGVsRlJMbDdO?=
 =?utf-8?B?LzZrS3FlRTcyeHdSUjlkSHVUOHlicGJVS0dYaEtDRUJMczIzWHNaTG5LVXV3?=
 =?utf-8?B?QXRYU0lqaWRkSVVrUnovQmkrdTJhbDc2R2ZoVUFFd29URGJrYnlqd3ViZ2gx?=
 =?utf-8?B?RDYreDc1N2t3ejkvSUh1VEV6RGJMaHBJY0dmTFora2NIQURCemxib29WKzVl?=
 =?utf-8?B?czRadzVOazVwKzNZakhVdlZXOUt5MlBaYW1NWXJUL3VZejdrRTd2Tm51eFB5?=
 =?utf-8?B?SVZQU29TNG1YU3Z5TUJTZXltSWFVZDI1Z2hVKzAvN3lMd3A0UkJBMG14a3N4?=
 =?utf-8?B?RjFwNHhhait4RVlIeTdhSVMwb3NZUEJ3c1J0L1pwRTVzUDVGTytsNWdTczJr?=
 =?utf-8?B?ZVQ2SFhsYTEwNGJ1cTlwUXhDUTFpZnRKTlNGVDBlbExVbndCaFZUWWNHemVY?=
 =?utf-8?B?c2pBY01RZTBhblp2KzZibW1sUEVVOVBGMlE4UDhMVUszWGdvQ0xzVHdnWGNB?=
 =?utf-8?B?cC9lRTBhUGlJRWZHL0tRaHNhMUtXWjhROWxTSG40aGIrZXFqaVhlNnhNbE5m?=
 =?utf-8?B?Mm4zcUhZYXI1OGRreU4wcFRqNUFUcmF0UDdpVnJPQmovV1RhdjM0S1dhQ3ps?=
 =?utf-8?B?eU1SZ1I1Q0krSmVjaXNSZjZ0bXBIaVdmK2hGRG9GOUZXNjFKTjlKZk4rblhi?=
 =?utf-8?B?dllkRTF3ZDJtU24vSnVQKzNRVmNqVWd0UDVEaTIwdFZ1V0M3REtLNGt0bVhN?=
 =?utf-8?B?Nmo3Ri9TVmZsWTN2ZUFHamdlb25iT2EvQTgrWk9NSnZYM0ZMV2tGaVhsY1kx?=
 =?utf-8?B?TlhFWVBYZ1U0ZnpucHdFVnY1RGtRY1BxZFFSdlpobDlpMjlMdUZNMzJWa2VT?=
 =?utf-8?B?aFNWV2cyWHVLanNxRzNGVmw2YnFSSmo0S1VWQzlJVEYzNkxQM1VuUGFJNDRu?=
 =?utf-8?B?VHA0T3VMOXM0aFJaQnNtK1Y0dzY4SlNzL0RYbkl0WUF4TlcxWDI2KzNveUNt?=
 =?utf-8?Q?X0v+C9D4yMLWNyORLG20Bd0K+MbGIdqLVD7s5?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dbf4a3-9a4c-499b-9f25-08de6a61f2fb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 18:10:05.8660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5H6gTYDjbNVjQDE22zXzsvE7lS1zvOZOSMynxEXAbrpT1jZLPayn3piFzApejItfSznzc9LytZZFdRimMVUpDCXUkiRRIwvzyIzDtHKqQWBNDRWxlkV0z0+FLn8bZWjN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR01MB8750
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amperecomputing.com,quarantine];
	R_DKIM_ALLOW(-0.20)[os.amperecomputing.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,google.com,amd.com,linux.intel.com,nec.com,arm.com,hpe.com,amperecomputing.com,os.amperecomputing.com,gmail.com,hisilicon.com,futurewei.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5712-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielf@os.amperecomputing.com,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[os.amperecomputing.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[os.amperecomputing.com:mid,os.amperecomputing.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C44E51302DE
X-Rspamd-Action: no action

> v12 -> v13:
> 1. Fixed some bugs reported and changes wanted by Borislav.
>    https://lore.kernel.org/all/20250910192707.GAaMHRCxWx37XitN3t@fat_crate.local/ 
> 
> 2. Tried modifying the patch header as commented by Borislav.
> 
> 3. Fixed a bug reported by Yazen.
>    https://lore.kernel.org/all/20250909162434.GB11602@yaz-khff2.amd.com/
> 
> 4. Changed setting 'Requested Address Range' for GET_PATROL_PARAMETERS
>    command to meet the requirements from Daniel for Ampere Computing
>    platform. 
>    https://lore.kernel.org/all/7a211c5c-174c-438b-9a98-fd47b057ea4a@os.amperecomputing.com/
> 
> 5. In RAS2 driver, removed support for scrub control attributes 'addr' and
>    'size' for the time being with the expectation that a firmware will do
>    the full node demand scrubbing and may enable these attributes in the
>    future.
>    
> 6. Add 'enable_demand' attribute to the EDAC scrub interface to start/stop
>    the demand scrub, which is used for the RAS2 demand scrub control.
> 

I have tested v16 of the driver, and it works as intended.


However, we have some concerns with the limitation that memory scrubbing can
only be invoked at the NUMA node level without specifying the address range. On
a server system with high core count and multi-terabyte DDR capacity, there are
several workloads that are limited by the total DRAM memory bandwidth available
on the system. Triggering an on-demand scrub while one of these workloads is
running on the system results in a measurable drop in workload performance if
the scrub rate is configured to be high. Triggering an on-demand scrub with low
scrub rate would be a very high latency operation due to the large amount of
memory that needs to be scrubbed.

Triggering a scrub on a NUMA node with large capacity, like multiple terabytes,
could have:

* high latency to completion of the on-demand scrub operation if configured for
low scrub rate

* high performance impact to applications that require memory bandwidth if
on-demand scrub operation is configured for high scrub rate

Additionally, there are multiple use cases we have in mind on data center
systems for being able to specify the address range to scrub from the OS. These
scenarios are primarily related to understanding the health of memory modules by
triggering on-demand memory scrub operations to single page regions.



Scenario 1:

A memory device on the server encounters CE errors; due to some failed DRAM
cells.  Over time enough errors are reported to a user-mode RAS error service,
like RASDaemon, that trigger a policy to inspect the “health” of the memory
associated with that page address. The policy triggers the inspection using an
on-demand scrub of the page to see how many errors are reported. It then
triggers the same scrub to see if the same errors are reported again. This
inspection would indicate to the RASDaemon that there is a failed DRAM cell in
this range. The policy manager decides to offline the page till the module can
be replaced when the system is serviced.

Scenario 2:

The OS has offlined a collection of pages due to UE(s) being reported on this
region due to a transient environmental issue; any reference to these pages is
poisoned by the hardware. Newer ARM ISA extensions have provisions for removal
of poison from a page. The RAS policy manager can test these pages for
functionality by triggering an on-demand memory scrub, potentially multiple
times, before adding them back into the normal memory pool.

While triggering a NUMA node level scrub would allow us to support these use
cases, the cost of doing so multiple times with a high scrub rate would be
prohibitive. At the same time, an on-demand scrub with low scrub rate may not be
fast enough to allow the policy manager to make a timely decision about the
health of the memory module.



Being able to specify the address range would allow us to contain the issue to a
smaller part of the memory with minimal impact to other users on the system.

So basically, if we can't specify the address range with on-demand scrubbing, we
might as well just use the background scrubber.

Side note about our platform: We do not allow the user to turn off both
background scrubber and on-demand scrubber. We automatically turn background
scrubber on when on-demand finishes. So, if on-demand is not running, then
background is.
That bypasses a lot of code state in the driver around whether or not background
scrubber is currently running, because you cannot turn our background scrubber
on through the driver interfaces.

Regards,
~Daniel


