Return-Path: <linux-edac+bounces-3906-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C52CAB60F5
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 04:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B23E863DF2
	for <lists+linux-edac@lfdr.de>; Wed, 14 May 2025 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC55E1E3DDE;
	Wed, 14 May 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="qSE1gjwS"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023098.outbound.protection.outlook.com [40.93.201.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FAC1DFE8;
	Wed, 14 May 2025 02:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747191319; cv=fail; b=iIWIcm6UR/uHVMrRS7UoMsmpxJJtG82NqreipVaZR0pOxVgHszTNlJdtUfW4nTAM9FnMb9rdn4HhLEDtWlPPobjZAWvxSMdKTuclqQJfoe6/Y9o08HAbGZ8GRK6AkBljy7UEI9ZQEv0XicNxs+cReXydsjRx5rNHEGNSRAtdtVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747191319; c=relaxed/simple;
	bh=bt5fczRAdXtd8Q15iqzMDAaqLCMgygQDerbfTNl+A8M=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MdAlrzWNrAgAT2NZ/Iz4rQZemkvYRmXJebBUNI4WL+wWjNfJsyMes0B/Zmn19iYXowG0SLdpUmJRuSZU+LtPTUrHCEtP0zkHYCaRI2YSqoV3/r1r3n+5G0wu6vctpGBjQO/vn7aFcQCiaMzy+cOKmOQYJP4A8LrCdncAINImegc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=qSE1gjwS; arc=fail smtp.client-ip=40.93.201.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flDCG7ZjGVS2jUDJwGyeHgVHb2y46e3QquZKModpO9PFO/Bno0TDI4noVCVuK38QuNzL/3ZTJeCdXM/BurQj3aoaAZhtzwJUIPShakndCn1R8Mg3ec5N8LiuINUESr26ZFjnCJBA+SjAWPJ6zUO1DRICNGWUDPc+jhW1RxtsZNzJMfZn/6HIaW2W7LoKU2Qwlm1R3OrwgwW6iKkTtXxCppuFSdQOSqd7LH0NTX6VAFH6hMHhv9s7GMZ3kNQstqOnOFt8FvlHVbXJaoazx9ox/6L/I9yNwxRXQCuXyZrV3LLMniu0dal7H42/XZXme14s2Y2kfLTXo/Ulearr2lU4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGZmHOiKZ+/b0aCEyKwrvSnLWu288L6cUZ5y5U6E3u4=;
 b=w7WW9qDQHxQBjwiKnKA5Lnoffu5+oJWBwBKtzlDIS+bhNzM03wiRbbUauLD+yJqlamdtzeOZ/KRhq/YJgDHI69/+e7ybFQ6yWjiJOo59g/cIca2yn6iMmr6C0NVtWmi+oAuuHGF6XT8sc45hcYX8r5a6KO1O8cOzuObcdNlXOlUBXDbREZ1oy00fnK4iXs6wGIoKQNcAW+m3/zOPkki4q774WcDqqEDulGNb0TB25hkkOuxehattJ+AEzjoSXbzIq8f0MkGHApcwrwt4FvWecXIsxKjjedo0e7RngIZLqXxfoi/caQ2DClI0+pHRjs5GhKHE3hYM9IxOKGK6M7e1uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGZmHOiKZ+/b0aCEyKwrvSnLWu288L6cUZ5y5U6E3u4=;
 b=qSE1gjwSxpWWwK7gaedb15FgP2+6y/PP70XDjMI0O5QObfUumMqPBHw23XJX8ECN8DvhakRbpuDQpWo5y13c/olPw/0OVV6rZuxpgifwYTqj6LO6LECtl7AotDELavaXhdGyJON4WB1bM1rdh1ph+Z6UAikLDr/3hBoPADSubUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW4PR01MB6322.prod.exchangelabs.com (2603:10b6:303:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Wed, 14 May 2025 02:55:14 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 02:55:14 +0000
Message-ID: <8cdf7885-31b3-4308-8a7c-f4e427486429@os.amperecomputing.com>
Date: Tue, 13 May 2025 19:55:08 -0700
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v5 1/2] ACPI:RAS2: Add ACPI RAS2 driver
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
Cc: bp@alien8.de, rafael@kernel.org, tony.luck@intel.com, lenb@kernel.org,
 leo.duran@amd.com, Yazen.Ghannam@amd.com, mchehab@kernel.org,
 jonathan.cameron@huawei.com, linux-mm@kvack.org, linuxarm@huawei.com,
 rientjes@google.com, jiaqiyan@google.com, Jon.Grimm@amd.com,
 dave.hansen@linux.intel.com, naoya.horiguchi@nec.com, james.morse@arm.com,
 jthoughton@google.com, somasundaram.a@hpe.com, erdemaktas@google.com,
 pgonda@google.com, duenwen@google.com, gthelen@google.com,
 wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
 wbs@os.amperecomputing.com, nifan.cxl@gmail.com, tanxiaofei@huawei.com,
 prime.zeng@hisilicon.com, roberto.sassu@huawei.com,
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250507214344.709-1-shiju.jose@huawei.com>
 <20250507214344.709-2-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250507214344.709-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0074.namprd03.prod.outlook.com
 (2603:10b6:303:b6::19) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW4PR01MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 87094552-057d-4396-c9e1-08dd9292bfc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkZXMWIrc2hEY0RGWHYvQkoxTGFVdmFWM2lyYVdPVkx3cVkwa3NNUWFCUVg3?=
 =?utf-8?B?YVNkUi80WkpHNktnSU01MnIralc5M0NsYm8zejBrd1AzWVlqODZ6NGVwY1k0?=
 =?utf-8?B?ZHJHa2IrYmpxWHI4RGhscGFya2NqL0Njb1pFanVtWm5lbHZVbzZyblljMDhr?=
 =?utf-8?B?dHJGMmt0VFJWcTM2TVlHTjZVSjJNNkpJa0M3SHdSNFNsdWhEOVFNTFhRQXVl?=
 =?utf-8?B?UzIvZ2NOc3VEaGZyWnowVTVSOHRsLytGQWJsTHdwMnlhWHFkQXp0cUxxMmV5?=
 =?utf-8?B?dzNFcEtzQjhsOHV5cWltRVhUT1g0WndNK01MdkVrYkRlYlZ1QlVDUjBqNDVB?=
 =?utf-8?B?VWU0WTR1K1VHbFlPYVBpL0xhckhGamJmZm9tTXhNNExldTZjT0Zjc0RRNXEy?=
 =?utf-8?B?UEhyQWdLSENSc25CZTUwTHRud0xjemFUZ2tON2h2eUd2QW9GSVBpbFdNYXQz?=
 =?utf-8?B?cDVYVkd6U0phZ2dwTkpMLytKeEV0VVhiQ05FVnlJRWhMMlJLU0pSeUdhN2tX?=
 =?utf-8?B?VUthcDdRblJUVzJzaDNaTVZhblNUcFNjTnJ3Q1l5YXU2dWVWdS96K3BUVCt5?=
 =?utf-8?B?a0lJUVBTcW53MHJWQ28yeGRYekNrTm1hQ2FPdHBxT25MdFIyRGI4NW5NMHJu?=
 =?utf-8?B?d25SZ0Q3SkFUZ3FnMDgwbmNoSHk0dzg3S2dDR1ppTHFNNjNYZ3UrdGFkWFMv?=
 =?utf-8?B?dVlwd2tmNDZBWkxXVkEvSE1uWlQzYXJZdk9WeDE3enhLWFg0cVV5cjQ5WGRT?=
 =?utf-8?B?eGlocFlBUlErZ291cUlmalZMQkVnSDV2RzFVMmNmRXZRbFE5M1NEWTAwNGhN?=
 =?utf-8?B?Q2tkeU94UllWYVhpZHN1Vno3NmgrZ1hHSEY1SWpDN3orNjRYZVc3UkR2TWU5?=
 =?utf-8?B?TVpxNHhBVThCR0dDYzUxd0kwVEVzTFBBZkxpUjBmRnVPLzYvT3JrQm56bjlk?=
 =?utf-8?B?dUhISWF5ZnRIQTlBbllYZHFXQm5CTHB4S25SdG1qZVZVZURDTWdCZzBQREtq?=
 =?utf-8?B?WDFkS3l1eUtvQkxRR29JSXBKNnRUOEs1QzdSWkNRbTl3Nk9WR05rajhIV2xE?=
 =?utf-8?B?ZXJWSmJycUF5Z2UvQnFSUG1HWW1ieFpuWnd4YTQrM2NyRXJndDNKampSSC9z?=
 =?utf-8?B?U1BhN2RsdmlhYWlaQUNwR3EvdG1KZjBhZE50VlJ5clZiZ0g3ajlZZzRhQmhk?=
 =?utf-8?B?Y1NUNFVnaE5wWXlCM2ZqUC9iMGd4SFE1WG40bjJNU2ZmWFBWbS9qNUVxMVNq?=
 =?utf-8?B?dTJGbVQ1OXVWaXd2VTRKeUpLTGY3aHFWZFNUS1RwcHZPeVdHVWU3ZTczNGpx?=
 =?utf-8?B?dXZuQUVKcUx1T3VLT1BnTTdzK1JUcThvVms3a3RFak93ejFLMGo0UnZ1dTNj?=
 =?utf-8?B?cXpRSHVEM0pWMlp2WTA2Y3MyQWhKT1kzUXVDR0ptTVIrcGpmVEZ4Q0tsdjBk?=
 =?utf-8?B?bFNJb2l0Q2lvZXE3ZXNXejUwd0Q0UWNaT3Z6WnFqOGpCSTFKZW5RTFI1eXFI?=
 =?utf-8?B?VW1oamN0Vzk0c1orZlJTVncya1djT1JBYmswWHZXdS9VSGdGU1grWTJ0ZUFV?=
 =?utf-8?B?MmMzMVZrdDErM1lYRHJPeFdrUHRSaVg1UnMwZVpwMTUzNWFPNERLaGVsMDFS?=
 =?utf-8?B?RVhqRGRTZm9keVFwUXdrejRkNVduMmRVNW5naXM0M3U5ZXpsamI3dzlPU3hY?=
 =?utf-8?B?UzZ5RmNaWWh6bVVNcG01c1Bzcy85SFZ6VUNEdTY3VWFhLzU1Mno4UFBHRzRu?=
 =?utf-8?B?U1Y2SXo0d2NrU0QzVnFheGhjL2tDVWZ0LzMyQ21DWEk1Q3lCTm9ubVAvdGZF?=
 =?utf-8?B?RkYyT25uMStvK0I1RXZ4LzZrRGlPUFZlQWNmSUp4UHpqNlM1MjUwMUdNU3Q2?=
 =?utf-8?B?L01IdThRekxYczlVcHlXcVgwU1hCUE9uVG02RkIvd1JIYyt6Vk9PdHAzbnIr?=
 =?utf-8?B?eWJUSi9hUmEwQlhiQVBqSzhnSkdEUU5rbklxYkVJdVY3c3VRQzBZVDY3dUhP?=
 =?utf-8?B?WmNNMTN5STZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5jMG9WMmpnOGJoL2hLZng1UUJQYzZJSTdwWWNIL1BkZnpNWkIwNitQcHlo?=
 =?utf-8?B?eFh4K1pVWmpsZXV4eEs1eVVXN1VjOCt6L0ZhNkMwaHByQXBTOVU2MGpXQTdJ?=
 =?utf-8?B?aWxaTDBITEdnamFRWWltdUNRR1JTdFlBV0FTN2tjVHRpTkZFcTFCL0VQNUNz?=
 =?utf-8?B?NDZOV0lkZk5WYmVnelQrYjkxOUxNZXl6Z2o2Y2lvUHZJdlkvejNESEFPcEk2?=
 =?utf-8?B?NnlySmJUWlpHOWk4RWpESTRsZzFTb2NmR2ZsNjRnNWt5TWJxVG8xaHU1NkVz?=
 =?utf-8?B?NVhaUTAvUllpQ3djNTJFTWxIK1lja3NVYUNRMXRoaDZ5Zys4SnVnT3N5d3g1?=
 =?utf-8?B?M1JKRmw0WUNKWE8wZkt2R2Q4UUJUZ3pGaWlIRU90WUtZU245WFhQSDZjaXdI?=
 =?utf-8?B?WFNSRUxnL3VGWnJKcDYvQnd5R1A3cHFaT004eHAzRVFEUWgwbGpFaWNJT1dq?=
 =?utf-8?B?R3Ixd05SVkR0MEFRTFNJd3hwR2ZOcmR4cGlNb1lnY0xTV084a2lzU3FJMzB3?=
 =?utf-8?B?dGJiRFA4eGtuZE1xSnRUM1pYZUpoZnNTaFJPcms2Tmc2d042OTMzanR3eVFi?=
 =?utf-8?B?cGxiOEg2NW5QZzRYZkQrMEFJVTFkV0NPd2ZWUmVRL09FVHEzcGswUTJ4TE5C?=
 =?utf-8?B?VU9ab2hudFFKWUZINlNQZ0Iyem1ncVJ5dDRaWllyTkVuZUhKTk1tMjN6Mzls?=
 =?utf-8?B?VmFhVjBXVEp2eHMzdnZMa0pxQW1kcUVveE9UNEx5d0hxeWFicEwzbkIzOGNt?=
 =?utf-8?B?cmh6SGVURW51NmF1dUpSLzdhSmVzVEtla0tjZzV3VzdDN2xhV1VrZ0s3dWth?=
 =?utf-8?B?aGZ1aVNkYU54ZllFYWF0eXNvV2JQWFZSOEExeDBGeVAzWVlDV3ZaT0ZGZCtn?=
 =?utf-8?B?TVJiOTh3bXM1QkFaczFmQzlFMFpFei9yUTRZMEJPYU5xZ0RwY216bDdld3Zh?=
 =?utf-8?B?c2QwcTNGdlo3TVUzc1hXc1gwV3Q3aERpZDVqU3M1ZERRMUhjSmxZcC9WMXd6?=
 =?utf-8?B?M2hKNEJpQWdrUGNwaVlUZ1NrMnBSdG5mN2l2NnBiRUJOSy9xT04yZVpReVBQ?=
 =?utf-8?B?bzU2T1NXT3JzbmFhanV0Y0Fxa1FnWGl2L0JuUWJXczl0RmtiYmFNRk1lSDE0?=
 =?utf-8?B?NTkrc21PbkQxeWdkV2UzZGN6SDdtRnVQWXUvckZKbkl4c05nSnJWRml4dTZJ?=
 =?utf-8?B?YTdZMm1iT2tCTVJMYUFsM3VSYnZWRHcxeWlsL2RvcExZREF1cUk4WUdVM1pZ?=
 =?utf-8?B?OEJaVExsSFdKN3dudzBDZEN5c0FrRVpEMDZoTGFUaHZHNGYrMzFxNWtHRWFX?=
 =?utf-8?B?ajhrVTRyV04wWUZPNGVFNmlrRko1elZCbzQ3djdPK3FlNFJ2a2g4eHFKOGdx?=
 =?utf-8?B?Nmp0VlNwbmRwU0ZQMHZXVnBnZFpVSWp0V1N3OTA1eFAraSsvRUkrTzI1Qm8r?=
 =?utf-8?B?YmZIdFFFWU9OS1VBUnBqdlNtUUlpNldSdmtEdXhhcG9JbkhsUGw4WHBYMEhY?=
 =?utf-8?B?dCtaWHViYW40MmtBVFRtbFVNRmkzTnhac3RaOFd0OW1xbDVVWG42dlk3aG9N?=
 =?utf-8?B?RVR3RWFvTHJBNjRreE9DZE4wV1Z2S3ZpV1lQZU9wOGR0b1A3dHV6Ry9tUDRq?=
 =?utf-8?B?bEpGVURPbG9yTXJ5Q1hQWGFXVXlLbzZQSkZPSnNHZStoNWFldjExYkd2UFlk?=
 =?utf-8?B?VVM1SVZUU1dTazdiQ0dYMXJHU0dnOERoZ1RNRG1aN1h1SE9jMFhMeDNtNmdP?=
 =?utf-8?B?eUJRcy9RZ0ZTaU9YTlNwUEJpcVp2aXFHWVd1WkZLcEFweFlzaGF3WjMwbU83?=
 =?utf-8?B?L0JTejBEM041OFZGK3o3VU9GRGozc3JhS3ZLWjVBQmR4dmI3djUvTElOUDlJ?=
 =?utf-8?B?N0ZpQ2k3S2htQklkUXQrcmtyUVJBbi9UMGRtbUpwSFJ6dlJOQXJnRU03a2Jn?=
 =?utf-8?B?UWROaUUwNXlqbURrTktuVVJJYlNTYUMvYTZCV0RSWTJ4RERtanBJUFY3L0hm?=
 =?utf-8?B?clJlNVJMVVlFeFZkaEJyYzh0ZHBCNHlxNW44d3hqQmVaTGh1YzVLUUhrQ3VX?=
 =?utf-8?B?dUd4K2xCdG54eFpneUl6VjdyRnRPUkNQNVBkdm0wSlJpcldNQTJQeEsvS1lT?=
 =?utf-8?B?S3FjSURLREJTb3RZbGNsNVdjckJtQnZ2OEpvaUNwRHlvVzNjWld4NFI3cDlF?=
 =?utf-8?Q?nsbUKxiopbTLDrfm520iM4w=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87094552-057d-4396-c9e1-08dd9292bfc4
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 02:55:13.9665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk2tGMoywjcupvZzYIDOMuLnKggRmsSxnIw6UHm35RPcHG8wf5WNq3OI3JloisdGzqH/R45hFnEARmvnH0JjcGtQofFtdU8PreXWXvxoc7DpcwneAAMEGjFJr6Y7UHBN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6322

> +static int ras2_report_cap_error(u32 cap_status)
> +{
> +	switch (cap_status) {
> +	case ACPI_RAS2_NOT_VALID:
> +	case ACPI_RAS2_NOT_SUPPORTED:
> +		return -EPERM;
> +	case ACPI_RAS2_BUSY:
> +		return -EBUSY;
> +	case ACPI_RAS2_FAILED:
> +	case ACPI_RAS2_ABORTED:
> +	case ACPI_RAS2_INVALID_DATA:
> +		return -EINVAL;
> +	default: /* 0 or other, Success */
> +		return 0;
> +	}
> +}
> +
> +static int ras2_check_pcc_chan(struct ras2_pcc_subspace *pcc_subspace)
> +{
> +	struct acpi_ras2_shmem __iomem *gen_comm_base = pcc_subspace->comm_addr;
> +	u32 cap_status;
> +	u16 status;
> +	u32 rc;
> +
> +	/*
> +	 * As per ACPI spec, the PCC space will be initialized by
> +	 * platform and should have set the command completion bit when
> +	 * PCC can be used by OSPM.
> +	 *
> +	 * Poll PCC status register every 3us(delay_us) for maximum of
> +	 * deadline_us(timeout_us) until PCC command complete bit is set(cond).
> +	 */
> +	rc = readw_relaxed_poll_timeout(&gen_comm_base->status, status,
> +					status & PCC_STATUS_CMD_COMPLETE, 3,
> +					pcc_subspace->deadline_us);
> +	if (rc) {
> +		pr_warn("PCC check channel failed for : %d rc=%d\n",
> +			pcc_subspace->pcc_id, rc);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_ERROR) {
> +		cap_status = readw_relaxed(&gen_comm_base->set_caps_status);
> +		rc = ras2_report_cap_error(cap_status);
> +
> +		status &= ~PCC_STATUS_ERROR;
> +		writew_relaxed(status, &gen_comm_base->status);
> +		return rc;
> +	}
> +
> +	if (status & PCC_STATUS_CMD_COMPLETE)
> +		return 0;
> +
> +	return -EIO;
> +}

We still have an outstanding problem. This may sound familiar.

If a user specifies an invalid address, our firmware will set an error code in
the set_caps_status field of the acpi_ras2_shmem structure. In our case, the
error code is ACPI_RAS2_INVALID_DATA, and the user will observe an EINVAL. This
is expected.

However, if the user then subsequently attempts to write a VALID address,
ras2_get_patrol_scrub_running will indirectly call ras2_check_pcc_chan using the
previously INVALID address to determine if the scrubber is still running.
Unfortunately, the INVALID address causes ras2_get_patrol_scrub_running to fail,
therefore preventing the user from specifying a VALID address after specifying
an INVALID address.

The only way to move forward from this inescapable condition is to reboot the
system.

Here is a demo of the problem as I roughly see it on our system (I've labeled
the line numbers for sake of discussion):
1  [root@myhost scrub0]# echo 0x100000000 > size
2  [root@myhost scrub0]# echo 0x1f00000000 > addr
3  [root@myhost scrub0]# echo 0xcf00000000 > addr
4  write error: Invalid argument
5  [  214.446338] PCCT PCCT: Failed to start demand scrubbing
6  [root@myhost scrub0]# echo 0x1f00000000 > addr
7  write error: Invalid argument
8  [  242.263909] PCCT PCCT: failed to read parameters
9  [root@myhost scrub0]# echo 0x100000000 > size
10 write error: Invalid argument
11 [  246.190196] PCCT PCCT: failed to read parameters

The upper most memory address on this system is 0xbf00000000. Line 1 and 2 use
valid values, and line 2 produces the expected results. On line 3, I've
specified an INVALID address (outside of valid range). The error on line 5 is
expected after executing the START_PATROL_SCRUBBER command with an INVALID address.

Line 6 show how I attempt to specify a VALID address. Unfortunately,
ras2_get_patrol_scrub_running encounters and error after executing
GET_PATROL_PARAMETERS because it used the OLD INVALID values in
ps_sm->params.req_addr_range. Line 7 and 8 are the result. Since the flow of
execution if aborted at this point, you can never rectify the situation and
insert a valid value into ps_sm->params.req_addr_range, unless you reboot
the system.

One half baked solution to this problem, is to modify
ras2_get_patrol_scrub_running so that if there is a non-zero address or size
specified, AND the last error code we received was INVALID DATA, then assume the
scrubber is NOT running.

Regards,
~Daniel

