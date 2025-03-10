Return-Path: <linux-edac+bounces-3340-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AA1A59CA8
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 18:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0239A16B7F6
	for <lists+linux-edac@lfdr.de>; Mon, 10 Mar 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E34230BF8;
	Mon, 10 Mar 2025 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M+2kONKl"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2094.outbound.protection.outlook.com [40.107.243.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE622B8D0;
	Mon, 10 Mar 2025 17:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626854; cv=fail; b=QNOlL4XiXEKQHBlQBq9wmn5ULCNT6C5Xzu9NfFE4YAlDEho8PzovG6ML0rJJH+Pp0fVDIm2dpCDcBfpiP0wD5ab682KiIYmLrnJJ150328DV9oXaUt4Pce3NJpk1CZsZOgULhJtkijvAmnTR2lgMQf6SfRpqnxYhDAfqCnKsj0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626854; c=relaxed/simple;
	bh=h8htH7597XXd12OsEx3Y5+m7TonL/vzH6oYdJu6Y2So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=giad/SLoWE2SscPwqLv8FA8pq1LW3lePtfsjMxm4cVhOna6pCHrjkVeUKhsrtFihh8cXJ9TbFs0kFKOXJCWxHunx0YqlEtgObjjuzKtDay7RR1KpB2HRWoncLfo8zsyr0Re9A+vNosQ03zzDx0quUgLzJyGL1tYvs4OFnefzTuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M+2kONKl; arc=fail smtp.client-ip=40.107.243.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sb44pMDFLCBxLdhSMLtN2n02ZBpZa2aYVuVBuUuT9HN6+DO/NoGvF7HxzDzuOfx7BNpoZeJ+oAVqKiRgg1zq/SzD2ARufnFrjRWtD6gEbqKyR8/EeLSu1OeVgD1GTyPSYr48DwlIH+lcNQibBTEsE4kKZTNpaLbVpTirKPGb4mr9Cch5z4QCp55/iPN4mlB7yjFTHcxVnddZbvIkpQ5wWIOTOAJ/OjGhQi3lWmDKhxh+0yyEFL40wVBZ+p37TGmFf1Ua9lfv7TEQhTy+7KERLIIywtnkthuhA1+uq9eiz+OoUHp+XNh6ApeD6bGiu2cNDJAx9UAsQyZfhr/1X1Xx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=go/xCUcyN5Pin8auOj8nu0nCN6MgAKbjXKJB1YjcM54=;
 b=MIvf4squTpqW/V2RLlEhLeDR24pDLICAWW9Y9Dna+yWbs1MEMjx4oOl0PVjw8tHirCXsAMRLfUnrvi0bJLYYCx7+onopuK55uDRInEEQzVwjtcBvObjpvJvkxoXtRGwDWsaEC/3rqnDia7HRyHDjouPtabXUprnoyzvCX/NXw03ueGGXM6rkiBS2Ouwrz8NMWJB83OOOd0L5GKkEGJ5hfGZ84DCWKHuqlXPj2NKSyuazgScx5B6otJlCNrT9ZoLB7Sa3k4MQY52dhixFJznuZWsxhTnNZWjXYLYEoT/4XaOO8wmATAw4Fv0TdrNida1jp17irNZaNizJUEGMbVdI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=go/xCUcyN5Pin8auOj8nu0nCN6MgAKbjXKJB1YjcM54=;
 b=M+2kONKlcmonXLdczA8TWZw013BroIRHk2fZc1nCSmsN5vnCxIJ1dzErOyvZDmG2BZTzZNm+HCXzYaBy0cOplflxXBUX5PnR3KyyxbXVnltkf63mVu3muiAmTZtRO5oIhybl9ESpLPLrU0bYqS+58gIkAyXkSEZGTSVs/fu04uk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW4PR01MB6466.prod.exchangelabs.com (2603:10b6:303:78::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Mon, 10 Mar 2025 17:14:09 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 17:14:09 +0000
Message-ID: <9627eb50-9e90-4f03-9197-78b3b8a434fa@os.amperecomputing.com>
Date: Mon, 10 Mar 2025 10:14:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ras: mem: Add memory ACPI RAS2 driver
To: Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "leo.duran@amd.com" <leo.duran@amd.com>,
 "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "alison.schofield@intel.com" <alison.schofield@intel.com>,
 "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "david@redhat.com" <david@redhat.com>,
 "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 "dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
 "wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>,
 "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 tanxiaofei <tanxiaofei@huawei.com>, "Zengtao (B)"
 <prime.zeng@hisilicon.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>
References: <20250305180225.1226-1-shiju.jose@huawei.com>
 <20250305180225.1226-4-shiju.jose@huawei.com>
 <0d9066de-769a-44d0-bece-26f1313ce006@os.amperecomputing.com>
 <85e788be5df3483082744a8904560979@huawei.com>
 <b6be7c698cd04f7d8a93f74693e9436a@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <b6be7c698cd04f7d8a93f74693e9436a@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW4PR01MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a0e62b-dbca-4ded-3ff7-08dd5ff6f82c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXltbncyUGRVTll6L1RRY1kwMldVeUlSRjk3VG9sSlVFcm9lSnpEYzNpdXlz?=
 =?utf-8?B?SnRwRjdCdE5WMENCVDc0N2NaZWZEK1RmL3JpdlkvdnV5dnhvZC8vYnRNaDhp?=
 =?utf-8?B?MkFMSU5jWmtLYkxpMkR2VGcyZDRjeS9wK056ZmxCUU9BMTRVK3BnaUpseG5U?=
 =?utf-8?B?Qy95b2JIRERRMXYrOWJ5MW96aC9qZ0ZucGtZS0hvcHRMdlErR1p1L1VnU053?=
 =?utf-8?B?a2RSeVQ2S3JKVDJmODJCMTg3R1duZFVMRlVnVWRRYzc5bmF6dGpzazdVOG1U?=
 =?utf-8?B?TEVjRUF5RkVpV0ZEOTM2eFBwMnpYeXJqa2JBREFBVGRyWm95UWxjdU4wNGdP?=
 =?utf-8?B?UGJraGRYSU9KSE81emVmcjB0bi9WSVR5R3pOSUw5WmRYMlNVU3d4MUx0L2Qw?=
 =?utf-8?B?eEhQZjRhaDI1T3dha0kzYUZyTzB6Q1NNMkh6VjcwZ1k1ZjRnUFFzUXNiWVBY?=
 =?utf-8?B?SW9UZnhHV2lMNmxlWjBwU20wRDFsdFdYVFJSUGxKU2M5NFMwbmxNNDhocW1w?=
 =?utf-8?B?ajVEbm9PZ3Vhdkh3WURsQnB0ZVNidnVRZGR2SmQ3S21CK2FDc3RpbUR2NWJ3?=
 =?utf-8?B?ZXg5QWlLVmFCZUc0VWZZK2RQRHFRZ3R6cmZkbmZFQjQyNDh0RzlGaFVmRFV5?=
 =?utf-8?B?VHhmK3pTU1R4a0c2cDRKaldZNGVZWE5EZFg4OUcyNmowYmhNTVozV29VZFVj?=
 =?utf-8?B?dkRXazZHTXRBYWwzU0pNUkFvYWN0VzBJek1YODBQaGxRNmo2S2g4VnkvYytC?=
 =?utf-8?B?RW9ucWZUVlFVMHRWNS9JUWlmTzliNE9xSjdxQ0d5eXg4cHJZd2xrRjlqWURm?=
 =?utf-8?B?bDlTZGpmSU1PYVh1cjBYdmlSYml0NllpWGF2MUFOTm1HejNaTllCY2EvL010?=
 =?utf-8?B?bWZzRnN1UmZXNmI5NE5hZlNnekJnU2hEM3Z5ZHBBV3hPM1RJT0syZW5jYzZp?=
 =?utf-8?B?QnRLNjVLTzlvWGdpSUtsb2FPMlhEOWlZakJ2dzkyWC9yQ2VHTkUzcXd4MU1T?=
 =?utf-8?B?NWVVUHo1M0dHN3VMb2FvREVuTmNLSk1acllUWHFDdzQxSGxURXozUkpZa01w?=
 =?utf-8?B?eUNtYWRTdndCc3dyMCtpb0g3KzhXckMwYStad292VjhwSUFMT05vSjBxVm54?=
 =?utf-8?B?N3c4dTM2Ym9MYUM0cXFqRDRsc0NibDVRQit6TXV5M0RWbkFsRUlOSWpUZ2F3?=
 =?utf-8?B?TGw5MWVCdU5yOHV1UGdDVWpFb2Q4b09FYndqUWRVOVJXWXB2cFJmY1lleGlv?=
 =?utf-8?B?ak0yd3B0ajI4YlFmK2l1NGlFd0RYRG82aWJVUWI5TVU1eTkxSlJiejlzWllk?=
 =?utf-8?B?YjVPN0lHMzNWc24xRW5WYWU5d3pIS000enFYeVk2eU1GQ1E0bi9mRGQrUTV0?=
 =?utf-8?B?WXdSaE96VWd4QWFQQXkwbGt3VWduTUZhMG8zTFhsSGY1RThOblc1U3ZJSVFB?=
 =?utf-8?B?NFZySVpHRlM3dDRMOGFvTXFsblFObE1lZlh0SFN0RkVmTE5Hc081Z3JmaVhW?=
 =?utf-8?B?dEJwMjdPYnRtM0ZTa0NLYUdjcGtpWUNQK0hLTXJ4REJmbG84RHRuSWtMa3lU?=
 =?utf-8?B?bmF3YU5RSmJCVmhveS9HaS9pZ3d5YWdQK29mYkVScEtXNmpFRVZKSEJiSWYz?=
 =?utf-8?B?M2QyZldMNENEZWp2ODVlbDljZGkzWldhN09oT1p4Wi83bHpSUkxxNmRwSnJS?=
 =?utf-8?B?alUxZE1GNzFEUUhQUi9Ya1dwOE03N1pwNE04WDZzNjNPY01lOUk4dkl1NHE4?=
 =?utf-8?B?UjVTSFNOZDNhbHliYU0xUTRDanNwNHlCeXFES3NJcGJ2c25JbHJucjJ6ZmRX?=
 =?utf-8?B?TlZFak9yanhXaTM1VzNodDdTenV2RTN3VzY2WlNOTWZ1R3kwekhIT1dLZ1Zr?=
 =?utf-8?B?QkpPUi9EUzBQRExzRlhHUTJHaHI5dXZ4dk9wQ3JqeDc3NCtIeW1xdjk1WkRQ?=
 =?utf-8?B?QVM4U3p1ajV0NlVTTFJIckJ2T1dpTWVla1p0L1lkaXJkbHFkUHBiZmh4WDhG?=
 =?utf-8?B?R2ZQVFV2eXF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0RTejBpOVh6b3pqNXoyZUY2MWdWN3lEbjh5L0R6RXlkSkNxK1doR0N4QzhE?=
 =?utf-8?B?dVpWMzhnVmxLT3pJNVN5YS8xYTEvb3N2SkhNd2RhT1czSkwzc3FNU05NSlR4?=
 =?utf-8?B?elNTQVAzemV3VXhIZ2tyNCtPcUJJZEYxa2ZjZVJIYXpQNkFobWhHUXloanBO?=
 =?utf-8?B?ZGFaWGhCY0RwUytpcHlPd29tK291ckUwQVVHLzl2T2grc3JwVDMvVE9mUVlv?=
 =?utf-8?B?ZmpGNzFMekNVcEVvTFlMMUNBOTFFV1FRQlRuc1dkMlpBQXkwaW85MTRVN09m?=
 =?utf-8?B?RWpFTGcyei8yRTVLNkgxOWRyMlpBc2Z0UzJGRzFSdS9CSVlCeisrWGFZdkRU?=
 =?utf-8?B?OTAwNUNjNmdyWjRkd3FHUUh1Q3h1cnBNRHVZOEZqSy9uMWJ0bGZ2RGFtLzRs?=
 =?utf-8?B?Z2ZNaldNblYzV2wyMlBvcHlvcVF3K1Qzb2FJenNsSkhsQUxjUW9QY1owdmtD?=
 =?utf-8?B?ci9nS25tb3NCR01BYk9Md216Sjl0MWg2S0daMlpzNXRjYnlKNFBzY2daOG52?=
 =?utf-8?B?dUhZOURNRHpDWGI1WVpBUDBYYWhhQ2FWZmRzRDczUkVHc0xBazV5Wi9ZT3B2?=
 =?utf-8?B?S1hWMXRGUXcxRjJpVGRZY014YzgvQVRWRTJOYnJmR0Z6bGQ5VkFkbndOK21X?=
 =?utf-8?B?eGk4K3hGRCtpVkNld0haUHFpUStGWU94WHpON1ZVL1hMblRTdzlCUlNMQVp5?=
 =?utf-8?B?UFFMY1hsYXNEeEREdS9IVE9NczB0cDFycWlUSHc5dEt6Y0JDYTMwazBxL1Zl?=
 =?utf-8?B?ZlkyQXhyZko2SnphY1pSc1E1NXM3Vi9XQ05hNzI1QjgvYy9za1lweUZuSTRX?=
 =?utf-8?B?Qk9DdXJWenlxWUp6bjZHS2UxL2VwSGRqaFFlV0x4emkwZlN4Yy9Wemp0eVRQ?=
 =?utf-8?B?ekFCemtOSnJKbDJxVSszMENvVmExaHRDV0ovVUFQNThqQTlzbGFvUUR1cGJV?=
 =?utf-8?B?c2lSREZnaG95dTlITEU1bVdudDZhZHh6YXhpRUpGZDB0ZC8rVXhETUNsSjJC?=
 =?utf-8?B?M3JGSXh2TEhGMGJkSjluYTF4ajlDV0ZCa2p3cWFhTFhwS2Z5K3dQdGV1QmVE?=
 =?utf-8?B?cDJXd0s1MUx6RlZPK2lDUXpBckRjbTZ6c3lIZVM1N3ZGRDJIWFYxdnNlSW9y?=
 =?utf-8?B?bjF5bC9yOGhuL2hkZ3ZPSXk5VzZ6NlNkQWw0amdFQ3lWbklTSGNvb29uSWNU?=
 =?utf-8?B?bW9yaGJVR3BUQ0VIdURpL3dZZ21POUNqM2cvRkpuTHlnekhEb2tpeEYzU1l0?=
 =?utf-8?B?UHNuZUlybThJNURod0lMZ2ZJdGtTOXRQWW1TQ05iS3ZwRUw3VWNGaW1GVUNO?=
 =?utf-8?B?MVRhWG5wL2lHV2E2S09BWHVnaElsMnZ2d255REoyU2N1OFhmWXFRNzFpWWEw?=
 =?utf-8?B?Z09ndVBsOHZzTVRockxpSnVpWFhZNkdQKy8xc25nUFRNYnNKbTR5YnYydDF5?=
 =?utf-8?B?MGIwU29wWTFxWW9mVGJEYUpMNTZpU3lkbCttcVpxbUYvdnFzcmEzZ3d2TnFL?=
 =?utf-8?B?K0ViRWFMa0paMFcwWjRIUUZzVEJBZlF6SitpWXBQVTFER3plQ002SHdjTms1?=
 =?utf-8?B?eVJyeVowMnZ5Y2w3dU9NWVlKNkg1THVTYXRuRmFLMlk2dUtuUTVYVGpxMmEv?=
 =?utf-8?B?cXZkVUpuWmdVQ1hCMTZNWERqcXVnd0E4QmROSjhTbSsvd1J2ZXdzV0tnM3VK?=
 =?utf-8?B?MmxYWUZXb2dYKzRwOERrWENvTHZSd2hydnZ3QWpIU0htR0hvMTRxTkQ4RjA5?=
 =?utf-8?B?cG5hU0szOXlHVGlJQ0VUa2d4K3dQSG4zdFVkK1dpMDByTVdpTkFxU2RHQUxG?=
 =?utf-8?B?d2dpZHZ2YXpqTFBGa2ppeUk0SDRITTN6KzlWWGxHZk1ubWpaUUh2aVp5cDFs?=
 =?utf-8?B?STdDbGJEUFpIK3hNU3VIamlQMk9VakVrYUVTMVJTcmFLaGN2T214em5XeGZQ?=
 =?utf-8?B?MU5sMElDN2g3aVpoWUoxeU9NM2YzTVhJNFR2THlHZTAwOUMzZldtVjJTeW8r?=
 =?utf-8?B?ZkphakNSVVI1NW9xc0RBSDJvWUNPUWtHQWZDelIrYW5tY3Urbmh3MlpNVHlt?=
 =?utf-8?B?U3lpTkJZN2gzV0htUjV6RUFNNWJtaUdkbGFsY2h5V1U5Q25oRmR5d3RaTzRo?=
 =?utf-8?B?UW03S1NWTlgxaGM2b0xnZjNGM1cra0pndXhnWUpacE5nK0Z2Q0VKVDc4TmZ0?=
 =?utf-8?Q?YDX1L3nsTN8Y5Q7aecAJScs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a0e62b-dbca-4ded-3ff7-08dd5ff6f82c
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 17:14:08.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SPi4rrYtko6eoIHjcztx1T75zAFHosyJIaLuJjLi/T9G/pvF3nI3EOsWW6h1ZqdKSq1PEtHd4mZr+9aKCz37X6YnxfdzYdftYvVMFzDPGYeYh5cRv51IxMvd82WhyrGz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6466

>>>> +static int ras2_hw_scrub_read_size(struct device *dev, void
>>>> +*drv_data, u64 *size) {
>>>> +	struct ras2_mem_ctx *ras2_ctx = drv_data;
>>>> +	int ret;
>>>> +
>>>> +	if (ras2_ctx->bg_scrub)
>>>> +		return -EBUSY;
>>>> +
>>>> +	ret = ras2_update_patrol_scrub_params_cache(ras2_ctx);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	*size = ras2_ctx->size;
>>>> +
>>>> +	return 0;
>>>> +}
>>>
>>> Calling ras2_update_patrol_scrub_params_cache here is problematic.
>>>
>>> Imagine:
>>>  echo 0x1000 > size
>>>  cat size
>>>  echo 0x2000000000 > addr
>>>
>>> What happens here? What happens is the scrub range is not what you
>>> expect it to be.  Once you cat size, you reset the size from what you initially set
>> it to.
>>> I don't think that is what anyone will expect. It certainly caused us
>>> to stumble while testing.
>>
>> This is an expected behavior and this extra call was added here when changed
>> using attribute 'addr' to start the on-demand  scrub operation instead of
>> previous separate attribute ' enable_on_demand' to start the on-demand scrub
>> operation, according to Borislav's suggestion in v13.
>>
>> Please see the following comment in the ras2_hw_scrub_read_addr() fnction,
>> "Userspace will get the status of the demand scrubbing through the address
>> range read from the firmware. When the demand scrubbing is finished
>> firmware must reset actual address range to 0. Otherwise userspace assumes
>> demand scrubbing is in progress."

Why not just use Bit[0] in the Flags register of the Parameter Block Structure
for PATROL_SCRUB? It seems having firmware reset the actual address range is
extra complexity for something we already have a facility for.

>>
>> Here sysfs attributes 'addr' and 'size' is reading the field: Actual Address Range
>> of Table 5.87: Parameter Block Structure for PATROL_SCRUB, written by the
>> firmware.
>>
>> In my opinion, reading back the address range size set in the sysfs before
>> actually writing the address range to the firmware and starting the on-demand
>> scrub operation doesn't hold much significance?
> 
> After further discussion, I will add a fix for this case to return the 'size' which the user set in the sysfs
> until the scrubbing is started.


I think fixing this will make the interface less confusing, but I also agree
that it doesn't hold much significance technically.

Regards,
Daniel

> 
> Thanks,
> Shiju 
>>
> 


