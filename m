Return-Path: <linux-edac+bounces-3929-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6299EAB93C9
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 03:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2964A7A5F17
	for <lists+linux-edac@lfdr.de>; Fri, 16 May 2025 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E920F090;
	Fri, 16 May 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZHgrxue8"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022122.outbound.protection.outlook.com [40.107.200.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830323AD;
	Fri, 16 May 2025 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747360158; cv=fail; b=MQcu8hs6O5J78+l+mO1dGMlByh2mvZucBj9m9lTphqzRU7zN74PZ+ceYLZWA9m8GECCFl4lHhHX62sIcjWaCveYFgLjA/l05V9I7Boy/SMIVKarHblZPPLeOdzc+Pt9yYSdnOwIOJwqCNENubMotjRnFNT79nU++Hft6msR0lng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747360158; c=relaxed/simple;
	bh=w6qDbYg/PRiTieALi09ZunNuwFVazWx244eXSU5jqvc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+CcbRU8SOl2fB42SswrYAQK+oo3gvJekGM+7iXgsaAkgBM3poh+IMH++bQ7Dtyn66vydpsoVyarZmR0IYTwzHFVEhTx0uEKIAejV1+DNHD8g9MeckCIh5yzDTKhEuEWNqWswtq319S6HPW3iG8nJtjs5ua0/9RNRL4OtX0aa3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZHgrxue8; arc=fail smtp.client-ip=40.107.200.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL5MA7cbyMvLqXuPPfZRb1ZDoU9YoyFCpWZIHP/cC9CFqliGjTHTd6Iip4mpdB6MkGVooNrBnqoqJX+r9LjGSS3HNoXeNIXosuTkW395NeXdowiixzdItPPPMq68Fl6FzmHTacF8Ou14j48DfJg6ZAGPA651n04yeGrRDMCqqdKYUnRz5/ITy4pdEMUvCB3ZmwynFOsy2H2qFGsf7+Q8WCJ7bITA5mtH/pclfe1XOK/+hDzpGw/vh0cMDZFjZlwi4bCofHtryTDf0sgoUzAczn5peIMZRfcBeUkh7KOF9H+g8NtYWgmDwxOQhU7+aAjDPQABXKBq35T4j4mNzd2Ezw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/VJavl3ZIjG7v8GNABiwTPnh7QHuRDsaAbGeFOIAtM=;
 b=P1R6s88WlKHHKJ/uwN7fbT50TPWDt6Bb9yBNC9K2/X5w24KJIOTa5pQoOFBqGvXPBmwdoqj5ke3jnfSbqiS8T+5UnnlXVWlp+iaEGN+Ahb4GFV0i8+Nvp6z2qXMHjKqVNO3ksPbJyR83evcuCbUny+4OceJUnmV4kmxYQijUujFzTKkjYFKpFnlN2NqCtSEfK+Zl6E0dq7jfCa/qGdikEkv24+PTweU55cqIF4TeAIvr6gnkh09j3p7NIGbay1POq3fEwW6SUtGGZ80876BQSB4toFqRjTdgO29nbMImiKlBeCo4oQ1rRCL+F9G4zbNsbWiqD6l2MkhbeIl52y6fcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/VJavl3ZIjG7v8GNABiwTPnh7QHuRDsaAbGeFOIAtM=;
 b=ZHgrxue8nPqVbQZIZJyHKGG75PtkDCZWlqy4DdKDIHO7q9OYMYEc10O8+Ri/HYxzt/mn2WzLM3JBU3/mUfMjCPmqa4b/+kZ1itzi5uvtQqU4dJE9FenBWPqLqvcpZ/iH0H6xGo44iodr411uno7LqXMerwoROQblkFaYEGgosLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW4PR01MB6323.prod.exchangelabs.com (2603:10b6:303:78::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.30; Fri, 16 May 2025 01:49:10 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 01:49:10 +0000
Message-ID: <2dda5ebd-3bd1-4ab3-9722-02590094d6ac@os.amperecomputing.com>
Date: Thu, 15 May 2025 18:49:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] ACPI:RAS2: Add ACPI RAS2 driver
To: Shiju Jose <shiju.jose@huawei.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "rafael@kernel.org" <rafael@kernel.org>,
 "tony.luck@intel.com" <tony.luck@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>, "leo.duran@amd.com"
 <leo.duran@amd.com>, "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Linuxarm <linuxarm@huawei.com>,
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
 wanghuiqiang <wanghuiqiang@huawei.com>
References: <20250507214344.709-1-shiju.jose@huawei.com>
 <20250507214344.709-2-shiju.jose@huawei.com>
 <8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com>
 <19ccc1b78e104132962792b55ab92df5@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <19ccc1b78e104132962792b55ab92df5@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0031.namprd21.prod.outlook.com
 (2603:10b6:302:1::44) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW4PR01MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9e1b25-aa06-4bc5-daf9-08dd941bd9e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJzTXN1L0lpQlpqTFFZN3dxc0RnWnAxNURaVEhpZmxLZ1dNVVBpK0FpNWxL?=
 =?utf-8?B?Nnp0ai9PNFRsOHg0RTFYVEJ1c2VhNzYxOC9acjViVlNNRVNha1hGeXp2bmNV?=
 =?utf-8?B?QUFsVjNhS2FXRFdvRnFDQmU3QUxRU0R3bkFWYzNmOHJ5cjVaa1BmV0hmMC8v?=
 =?utf-8?B?NEYxaTA5T2dFa3lGb3FlWGV3MHhWcjJXcXVXWHFvbFRzZ0ZRQnlyejNwaEs5?=
 =?utf-8?B?RFVqSDVLY1NJYjF0MTNXSWIvOThVRWd6MEVMSit0cGFZMUp0SndXc0dpTmVC?=
 =?utf-8?B?VEgyVFVPUzVpYmtacW5yR2trNXVSdFM3a01GMHQwRThYNjVwRElmWmFwMUJp?=
 =?utf-8?B?TEV3bmkwa2c1d25lNDdkdnNCZlExdXV6cEU5b2FieWdGN25TOVFwYTNBSlZH?=
 =?utf-8?B?K1c0ZFNLV0gvajNvR3FLYmVoZDNJelJXVWJZdTZENllUS1BVV0o3R2Q0Vmxz?=
 =?utf-8?B?aFhLcGR5MTJhaEdqY20rcThTb0FHR3RPcUw2WFE4UCtvS0xXanExQ05aRmVS?=
 =?utf-8?B?TEtVQi9mVnpOK3VUZXdOVlhrU2hKam9Qem1wS0puTVE5WVFFTHdZRUFGeUQv?=
 =?utf-8?B?WTZHeGlTdWs0b3h1Y1VnMjZTdERYc1cxb1IyYVd1UEZtUzlUd2RBY3p0bkRR?=
 =?utf-8?B?NWRoQkp2N0RtMmYrSlk3MGFDWitzWkxNcklwMEJpaW1DSXgxM0dUVFVtQ3hG?=
 =?utf-8?B?TW5SUU84N1NSeDMzV1Zzc2NnWVkzcTRyV1hwUGptZzhaVnp2dlhCSlVoYklv?=
 =?utf-8?B?YVVIam5NdHEvdHR5M3lMdUt4YzY3emRod1NaMEYwaERTcnd3Qm13d29Lb2la?=
 =?utf-8?B?WFd5ZzZjWWtUMlpuL1IxcXRYMERVeWhTdkxKUE40Y1lSUnJBRnd5UVBYU3h2?=
 =?utf-8?B?UHVvT014aXN5MGx1UHpnbzc5dXI5S25FUlo1WDFpcTUwM0djUlFxdDBLUW12?=
 =?utf-8?B?TGV4Q3lWdzhBNlBvcGVJNjRCSVNTQ2RpTTZGVVZXcWk0U1oxbTlhVmt4cEcy?=
 =?utf-8?B?bDR4QUtZc0NvY1h5SjdvaWlKSUc2RWZiNDF0akljd1d3WmxueHM3RlVHY2Zk?=
 =?utf-8?B?SmJHeWRWUzJHdTZ4ajQzTHJzbE1nc0thZUVKdWxzTGh4azczc2M3UkYzUmo3?=
 =?utf-8?B?bi9FK202SzNZWVRWU0NCTlF2RXdJemI5ako2TzVrak03MWREQ3JsZG5TeFcz?=
 =?utf-8?B?cHdaQmVWZWpTZkFUbDNmTnBFWTVJd1RNQ1JhZnd3TEZMNjJzTi9TQWZLS05o?=
 =?utf-8?B?aHEyY1UyOExocUl6T0tEZ1E4UWV2alVrUlgwcVlPdTNnVS90RkFvOE9rNUlX?=
 =?utf-8?B?SUYwYkEvU3FjQWgwWHZJN0hrSU5QdGlxaGY3VjRxQytqci9nWU1EVlBwaDlX?=
 =?utf-8?B?dkFqcWxrTlRqK29icGpCSnhzUWt2WVMzcGMyTkJvMEJwZGY0WTJKU045K2tJ?=
 =?utf-8?B?QmpxbGJ2c3BYMExTYkdXcmhzU1JJbzhCdDZsd083ZnpMNEZya0k0ZGRXSVly?=
 =?utf-8?B?TFROT0pDdG4vcG51alVsRS9mVm03Ky9TUGdDV3ZHTUlidVVXaGExTkZGMU9k?=
 =?utf-8?B?Q2VyeG5zbEJETy9kUlRpVUdXQTRxOW1NTnB3U05VaGUvZklzU3FidUdkTzV5?=
 =?utf-8?B?cW5GalJKMmdyTGJXTllDNmRYem8yblo5TzV6WndoN1Zwb0hmS21US0lMbHBt?=
 =?utf-8?B?eHFtYnFtSEQ5QTY2TXdRZklPdTYyeHBoWnRNVE5oRG90OVpFa3dKREFBdFBh?=
 =?utf-8?B?YnV6SDNNRkRybFpVUmNRNGlOTUMwcCs4TDJBYzB4aC8xSHNtMTBWUVlnZFpx?=
 =?utf-8?B?VVZOb1FqbTUyektCVUNsVk9pbmNHTDJ4NGRpUHpOWml6REtYaGV3VEI0Tk8v?=
 =?utf-8?B?LzlSc1FVUzRqTlpzb1l0Qm5kM3hNY2hhMEcwdDNickJLM3lNcG5rbDB5USsw?=
 =?utf-8?B?RW1pbGtmZGJ0WGczTnlva3dreEpHeFVYdzlQYVdBaDRJNEZWeGZyUHdOTWpw?=
 =?utf-8?B?ZTZaWTROR1ZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXdGeVE2bGs4TklBdjVxMThlRGlHalpKdGQ2b0ZJaUY5RlUxR1BqMWIvKytY?=
 =?utf-8?B?Zmhzam5NeHo5WGpCYUNJN1M2UXAyS1B5Q0Zic1psZE5JK2Ewb0pYZit6dHpO?=
 =?utf-8?B?NzZ3aHRpU0R6cTk1cjI4VVB2a1VOcERTSnZ5bXNYSHBjMnVqRWdpQUNEQkJR?=
 =?utf-8?B?KzE3SzZLSmQ5d1NyZTZ6ZjlMSXRGYnBhNkhMZm45cTIwQWdRcnFBTG0vcDRQ?=
 =?utf-8?B?TGkyK1ZkMkJ4eStCTjZ5ZUREcjhOSUQ0WEZkSktXdEZxQXBQU1g4UGc2Z051?=
 =?utf-8?B?Rm1UeTlJbUZqM09LV3UxNHJrQVBQOUFIbU1SbHpEeEk2TGhabFpMUlFTR3pp?=
 =?utf-8?B?bG5UVVYrSU0rbm5aMEJOQ2k2M0NMTlRMK2xBbG4vWjFzek9icFYxZXdPZGxn?=
 =?utf-8?B?ZVhrbDR1eUh6Z3pPOTBtbjZoLzFtaXg5Y3MrUnBoQW4xVXNROEVSdUkxMUJL?=
 =?utf-8?B?NEdqVzNQc1ZQZTJVSUNPNlIzT0ozQnFEeHlCTWJyektock9RNDdreWVSdk1i?=
 =?utf-8?B?K0g5TDhuMjRmcWwxc0FMdWs3c1ZRZFpGT2NZaUJpWlJtTU9xNmhGdDlzLzcw?=
 =?utf-8?B?SHVKeUQybkNOWW5NUm5zaDdQbi9mV0tSTGFKY0hRRjNHZ0RVVjBUZ1g4L2dS?=
 =?utf-8?B?UFgxcUk5Mm9vM05KVmFjLytSRDA4N1M2bWx5SUVoaUo5OHdkY05sZDg5YkZj?=
 =?utf-8?B?N3p5Z1I3STNQdDRTN0xPZWo0RzJ5Vk9XZmJsMkpNN2VzL043L0hxYVJuSnN5?=
 =?utf-8?B?R3lad2Z3UXloRE1NY1NIMTg3T1BneUdNNGhhNkt2MHVOblF3WFNkZGFyZUtr?=
 =?utf-8?B?U3hVcnlHdW5UY0xTcU9XbGdUU2xRTjJ4NXlXMDZVUzFWL3dyc3c0L3U3aEJP?=
 =?utf-8?B?djgvdmtJTGh2TGRLb04rZlVzdEJ5ZW1OMlFMZEIrL2ZsNms4VUxRQTVMdTFQ?=
 =?utf-8?B?UWJFL2lpN1Q0dW9JY2xBNTNhQStnY3VkUm9Ka3lZcEJ5TllTOVFkYzBlVmxN?=
 =?utf-8?B?TXhWNEJ6emRqYVlXOWo4Q3JYZ2NvNVJYRE9YaER4ZXYyUWVVWC92UzV1ai9j?=
 =?utf-8?B?c3FYWEErMWNjRllrM2JCRHlzTWlVWmI2UDZ5d2VMZEtJV0xXSzgxY280aXh4?=
 =?utf-8?B?Z25ZOVQxNTQrRWFnYUFZTVFNZ3pDT2puOHhUSWZxakhnUWtpd3VNRTNtM0VL?=
 =?utf-8?B?aDBrK2JvM0hoWDl1MnNVTnMxQ0JZUTYrOXNuRURFSE5lZHFrcXdOeHo1VElF?=
 =?utf-8?B?KzNCeHBPWlJ2S0tDcnBSZCtRTXJGaEdvU3VNQy8wb1ZGMHdsRFFnUlY2bjFp?=
 =?utf-8?B?aUZvdXl0YzBzVmtYUlNEWEdORFRYZHAzM2F2S1BTcUVKS1hnYmkxbWJWaXBW?=
 =?utf-8?B?YVBoOU5pVmE4SzJVdXdDYVdEVEdtaUJ1ZmhhbEpPVHVwUFYwNVNBb21Fbm9n?=
 =?utf-8?B?NU1TNWM1MUVnQ091UWNmdVo2R3ZESFJlejZoSkMyQ2ZSUUdWdVZmTXdYcDgw?=
 =?utf-8?B?ZFB1VGdVcFZRWFVwblBFbGszb2s1UU82RFRFLzdiRUZkTmlCd1EvTzJtZE81?=
 =?utf-8?B?SjN2WWo3SGplWGhnR0hDMFVXNU9qR09UZWp3WmwrUVlmK3pkOHVuckYrLzd0?=
 =?utf-8?B?bjlIL0ZrMHpCRXlTWjJxSEdBak8wNHVkc2JNVm9IVUJ1Y0dldXg3SEZSRlRn?=
 =?utf-8?B?aStlMnFCTFdNRnN0ZUFsaTRNUmFmNGZ4U1F5RzJ0Z0ljUWc2SnFSaUgrWVJs?=
 =?utf-8?B?UDFsTCs1RHVkcHVucko2bmpUVkFFcGFRUnFkL25xVmpkTVlaczNTbjB1TFMz?=
 =?utf-8?B?Rm1IY3R0d3ZVK3ZIL01VTDkvZk41WkhWL0lzaGJjTE5EdmZ0M010aFZFMlpF?=
 =?utf-8?B?dXBWWlgxL3NwNmpBTUJaR01DYmRLcHhhczBvV2dCRjNHbVZqMVNlMk9kOGhq?=
 =?utf-8?B?dUVHVFBIZ2pFZWNmQVIxWFErTU9iU2UwOVFUREt0SklaTnQ1eG5mdnJqNitX?=
 =?utf-8?B?elZFUzl6TkZXbURXZkhEWldwQmQzQVA5bnhxUWd3QU5vdnF1VXljcHRPOVRT?=
 =?utf-8?B?TmswRWRxQlA3dHRuRXhHK1ltejI0VTljNlE4ajg1R1BSYjNrTE4wbDEraDdw?=
 =?utf-8?B?dkh4TC9NQzFsWlpqTkxKekdrQzkxekIvaHRHWEduVGlSclBuekhObGEvRCtm?=
 =?utf-8?Q?EU/3ZgPhqVHHiWTIfPD5GVU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9e1b25-aa06-4bc5-daf9-08dd941bd9e6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 01:49:10.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg2tFyiu3ioKRUJ+XEqpIXypsoDsq8gn6jlTwxcqo45ypG74U4MA/bmKI80urOP47XNs6etdg+PqxdRPTVN5Tp4okbUssGfxiKGSzoWL9YDkB6EXtTt591RPT5qUQkCQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6323



On 5/14/2025 4:31 AM, Shiju Jose wrote:
>> -----Original Message-----
>> From: Daniel Ferguson <danielf@os.amperecomputing.com>
>> Sent: 14 May 2025 03:55
>> To: Shiju Jose <shiju.jose@huawei.com>; linux-edac@vger.kernel.org; linux-
>> acpi@vger.kernel.org; linux-doc@vger.kernel.org
>> Cc: bp@alien8.de; rafael@kernel.org; tony.luck@intel.com; lenb@kernel.org;
>> leo.duran@amd.com; Yazen.Ghannam@amd.com; mchehab@kernel.org;
>> Jonathan Cameron <jonathan.cameron@huawei.com>; linux-mm@kvack.org;
>> Linuxarm <linuxarm@huawei.com>; rientjes@google.com;
>> jiaqiyan@google.com; Jon.Grimm@amd.com; dave.hansen@linux.intel.com;
>> naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>> somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>> duenwen@google.com; gthelen@google.com;
>> wschwartz@amperecomputing.com; dferguson@amperecomputing.com;
>> wbs@os.amperecomputing.com; nifan.cxl@gmail.com; tanxiaofei
>> <tanxiaofei@huawei.com>; Zengtao (B) <prime.zeng@hisilicon.com>; Roberto
>> Sassu <roberto.sassu@huawei.com>; kangkang.shen@futurewei.com;
>> wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v5 1/2] ACPI:RAS2: Add ACPI RAS2 driver
>>
>>> +static int ras2_report_cap_error(u32 cap_status) {
>>> +	switch (cap_status) {
>>> +	case ACPI_RAS2_NOT_VALID:
>>> +	case ACPI_RAS2_NOT_SUPPORTED:
>>> +		return -EPERM;
>>> +	case ACPI_RAS2_BUSY:
>>> +		return -EBUSY;
>>> +	case ACPI_RAS2_FAILED:
>>> +	case ACPI_RAS2_ABORTED:
>>> +	case ACPI_RAS2_INVALID_DATA:
>>> +		return -EINVAL;
>>> +	default: /* 0 or other, Success */
>>> +		return 0;
>>> +	}
>>> +}
>>> +
>>> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace
>>> +*pcc_subspace) {
>>> +	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace-
>>> comm_addr;
>>> +	u32 cap_status;
>>> +	u16 status;
>>> +	u32 rc;
>>> +
>>> +	/*
>>> +	 * As per ACPI spec, the PCC space will be initialized by
>>> +	 * platform and should have set the command completion bit when
>>> +	 * PCC can be used by OSPM.
>>> +	 *
>>> +	 * Poll PCC status register every 3us(delay_us) for maximum of
>>> +	 * deadline_us(timeout_us) until PCC command complete bit is
>> set(cond).
>>> +	 */
>>> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
>>> +					status &
>> PCC_STATUS_CMD_COMPLETE, 3,
>>> +					pcc_subspace->deadline_us);
>>> +	if (rc) {
>>> +		pr_warn("PCC check channel failed for : %d rc=%d\n",
>>> +			pcc_subspace->pcc_id, rc);
>>> +		return rc;
>>> +	}
>>> +
>>> +	if (status & PCC_STATUS_ERROR) {
>>> +		cap_status = readw_relaxed(&gen_comm_base-
>>> set_caps_status);
>>> +		rc = ras2_report_cap_error(cap_status);
>>> +
>>> +		status &= ~PCC_STATUS_ERROR;
>>> +		writew_relaxed(status, &gen_comm_base->status);
>>> +		return rc;
>>> +	}
>>> +
>>> +	if (status & PCC_STATUS_CMD_COMPLETE)
>>> +		return 0;
>>> +
>>> +	return -EIO;
>>> +}
>>
>> We still have an outstanding problem. This may sound familiar.
>>
>> If a user specifies an invalid address, our firmware will set an error code in the
>> set_caps_status field of the acpi_ras2_shmem structure. In our case, the error
>> code is ACPI_RAS2_INVALID_DATA, and the user will observe an EINVAL. This is
>> expected.
>>
>> However, if the user then subsequently attempts to write a VALID address,
>> ras2_get_patrol_scrub_running will indirectly call ras2_check_pcc_chan using
>> the previously INVALID address to determine if the scrubber is still running.
>> Unfortunately, the INVALID address causes ras2_get_patrol_scrub_running to
>> fail, therefore preventing the user from specifying a VALID address after
>> specifying an INVALID address.
>>
>> The only way to move forward from this inescapable condition is to reboot the
>> system.
>>
>> Here is a demo of the problem as I roughly see it on our system (I've labeled the
>> line numbers for sake of discussion):
>> 1  [root@myhost scrub0]# echo 0x100000000 > size
>> 2  [root@myhost scrub0]# echo 0x1f00000000 > addr
>> 3  [root@myhost scrub0]# echo 0xcf00000000 > addr
>> 4  write error: Invalid argument
>> 5  [  214.446338] PCCT PCCT: Failed to start demand scrubbing
>> 6  [root@myhost scrub0]# echo 0x1f00000000 > addr
>> 7  write error: Invalid argument
>> 8  [  242.263909] PCCT PCCT: failed to read parameters
>> 9  [root@myhost scrub0]# echo 0x100000000 > size
>> 10 write error: Invalid argument
>> 11 [  246.190196] PCCT PCCT: failed to read parameters
>>
>> The upper most memory address on this system is 0xbf00000000. Line 1 and 2
>> use valid values, and line 2 produces the expected results. On line 3, I've
>> specified an INVALID address (outside of valid range). The error on line 5 is
>> expected after executing the START_PATROL_SCRUBBER command with an
>> INVALID address.
>>
>> Line 6 show how I attempt to specify a VALID address. Unfortunately,
>> ras2_get_patrol_scrub_running encounters and error after executing
>> GET_PATROL_PARAMETERS because it used the OLD INVALID values in ps_sm-
>>> params.req_addr_range. Line 7 and 8 are the result. Since the flow of
>> execution if aborted at this point, you can never rectify the situation and insert a
>> valid value into ps_sm->params.req_addr_range, unless you reboot the system.
>>
>> One half baked solution to this problem, is to modify
>> ras2_get_patrol_scrub_running so that if there is a non-zero address or size
>> specified, AND the last error code we received was INVALID DATA, then assume
>> the scrubber is NOT running.
> Hi Daniel,
> 
> Thanks for reporting the issue.
> Can you check whether following change fix the issue in your test setup?
> =============================================
> diff --git a/drivers/ras/acpi_ras2.c b/drivers/ras/acpi_ras2.c
> index 4d9cfd3bdf45..ff4aa1b75860 100644
> --- a/drivers/ras/acpi_ras2.c
> +++ b/drivers/ras/acpi_ras2.c
> @@ -255,6 +255,13 @@ static int ras2_hw_scrub_write_addr(struct device *dev, void *drv_data, u64 base
>         ret = ras2_send_pcc_cmd(ras2_ctx, PCC_CMD_EXEC_RAS2);
>         if (ret) {
>                 dev_err(ras2_ctx->dev, "Failed to start demand scrubbing\n");
> +               if (ret == -EPERM || ret == -EINVAL) {
> +                       ps_sm->params.req_addr_range[0] = 0;
> +                       ps_sm->params.req_addr_range[1] = 0;
> +                       ras2_ctx->base = 0;
> +                       ras2_ctx->size = 0;
> +                       ras2_ctx->od_scrub_sts = OD_SCRUB_STS_IDLE;
> +               }
>                 return ret;
>         }
>         ras2_ctx->od_scrub_sts = OD_SCRUB_STS_ACTIVE;
> ==============================================
> Thanks,
> Shiju 

We're happy! with this fix.

For this to work, we had to no-op the START_PATROL_SCRUBBER and
GET_PATROL_PARAMETERS commands when base and size are equal to zero.
Previously, we returned INVALID DATA when base and size were zero.

Maybe we should amend the ACPI spec with this special knowledge.

Anyways; as of now, with this fix, this driver will work out of the box on our
systems.

Thanks a lot,
~Daniel
> 
>>
>> Regards,
>> ~Daniel


