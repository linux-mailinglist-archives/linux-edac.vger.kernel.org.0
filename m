Return-Path: <linux-edac+bounces-1565-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F593B656
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 19:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B23B282E47
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 17:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEFB16A38B;
	Wed, 24 Jul 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pyBWyRKq"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A215F3FB;
	Wed, 24 Jul 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843969; cv=fail; b=l/RBsKV5bpt50nRUFV8S2ewLKDaoblOqVBgV17cgHELtSs9mXorMQUCQ7zScSLiJbP1AB78cVPFwGTyUV6s4miPnGCE3CI2QK0fLc418CvSbJk4A7mf9O1L9vFAKDigB/Ya/KfjIXjCBnfwFQQMnquoVG84+ohpgvTsfYLqfhs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843969; c=relaxed/simple;
	bh=oVKI2YCXuvIcU9t0MANss6ed6btaCf75KFAB+D+V1aE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AxK+AOXpjqvN3rRSunU97sTuJfpP8TOyPZi4AZk3HOF8Jrg+b2jCXOrj89jXNvaxc5HNmo12H1zrRXva4UpF+G4GJnRwzgdGOqjgQKRCcuyme3vv6ikRMH4rnIooP45XYdOMMQMK8GiX7KBTblh0FiVq/yOR6ck4iNcZiVZKJ2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pyBWyRKq; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8+kaStuY6cYArtGbcBEAFwWYVBrh37XR/No2AegQ7FtXIMuMmWL5jvt0VDKoS72uw/2J+90w0IiWv968ZXJb+wy0NaL4/7FHCAcUbdanBLogrn52kFboJb8KvA7Zz8L9V2GUwclwkz8tORquVm9IAPrhKYSa3ujLRafmBhHBlpTqblENkuHXgx8TOZmV95jnAJNwndQbnxhln4E+ftK/Br/B0nNc9Ticm1ftw30R1krwzcuhTZRIuD/gnqUElSd+xpYVAyn3DbUgIzIIyS1wcMqgzV0OfdGPPL/46S+L7vlLPqePXtdhQ1/oa39dgAb5P/GQegLi4X9ogLORJpg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QpSiVPduP+XmjvjT2pLoRKf9qXnQc9B1SQECSYxhD3w=;
 b=SQOvwgyHDjoPtX5HSIn8SOqyI8TX1jmqH4gtDzUGlyGXTBtFNxbG4LsfM/fFtfeAU+jH1z6LfnH0GOOjBdZRBWQpEy9vOOKEPz0SOuiw849R94PrVGSr3wd2s3tg7LIQ87t1nGGU6AbBb07QH26csf9HliMJ7HMei79o5y8596n8KYKqDYVamZNIMyb7aNQXNBVYUWP3RjqHCUHlJA3ombkpwpPzejMDjfimHOKkmcDCdxdQVg/GMCnwsSP0liQA9sqAbgURriWEwMKUyka8rAz9dD9r7pJSA9ZkIqfudp6U9GuJsaJfrf0VRU3T0n/NAMArHv5sL9BOdM7dsRPsNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpSiVPduP+XmjvjT2pLoRKf9qXnQc9B1SQECSYxhD3w=;
 b=pyBWyRKqIO6vMERfey9dR6HYWF7hH3+Rej/tOmxsmdy2dq/azZdAGuoO00+lH3K3zyoJbj2WgLM/gkjPaVBZdHQuWtOL6Rja8ZCBfQbN1Y9rFXu85f5RlsZLV1dIZPwMslo4boTkKwo0jF2sJ++nebU1guWLac4tv8iiocMLaAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Wed, 24 Jul
 2024 17:59:23 +0000
Received: from CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607]) by CH0PR12MB5388.namprd12.prod.outlook.com
 ([fe80::a363:f18a:cdd1:9607%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 17:59:23 +0000
Message-ID: <cf486746-6f96-4f09-bacb-8019e7f33756@amd.com>
Date: Wed, 24 Jul 2024 12:59:21 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] EDAC/ti: Fix possible null pointer dereference
 in _emif_get_id()
To: Ma Ke <make24@iscas.ac.cn>, kristo@kernel.org, bp@alien8.de,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240724071042.1493917-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <20240724071042.1493917-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:806:d2::16) To CH0PR12MB5388.namprd12.prod.outlook.com
 (2603:10b6:610:d7::15)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5388:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ffafa67-7500-49c6-5138-08dcac0a59be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVhsQ3dlMHk0cldOekV0QUx4cHdKb1RrNllYek5IbWtjMElyVkhQM2taeGtW?=
 =?utf-8?B?VG9xZXFJZ3dMUW8xN1lldmhMTmtRV00xTFZoUGdocHZXM2xNMHhoNFprVmc1?=
 =?utf-8?B?cVVlSjJabjRyMzV1SVlaMXVyaTVGOE9iL1FNOHNxU21PRW9NRXNKUDhyQ0Jv?=
 =?utf-8?B?SG5LbXJ4NVRKc3dROGtwRXl3THliNnIvWkhlVm5lRUxGNlVRckk1dVVONW9U?=
 =?utf-8?B?aUczSk5Dd3NkdkwvaCtEQmVyMk9mWUFpWThIczdqd3RTK3RLeUFmbzhxOUxG?=
 =?utf-8?B?ZlJDTnFiMFVsTDdRN0tFdFFkWi8rT1FGSDFZZDFIQ3k2UHBnRmFjWDNrczlS?=
 =?utf-8?B?NXp4OUNMZTZwTTVTZDFNdXlRTkZJM1dJSVZNTmE5L1ovQjJWNktlMDI5T1pP?=
 =?utf-8?B?TU03ZWlNTnFyMDhiYlN6Tyt2U3JSU0VRQlc5R3FVRnpkSWZ2ekd1SGxRSmd0?=
 =?utf-8?B?ckc0c2JSS2JoSlU5NXVCK0FJdHJmUFVhYlpjNnZuNXR4V3k0ZnZxOEhLb20w?=
 =?utf-8?B?TFFsTjJ2NEd3a0JpQmFtWkNhRGtoNUlDak9xNGgrWUJINGtXcm5QTkdYODRF?=
 =?utf-8?B?NUpaTGdvRGsycG5OeW9wOE1mOHpVZThaRDNLTjdZRGZoVmFpQllqSUlERG5i?=
 =?utf-8?B?ZnQ5L1U4U1doUkdBLzlwNGZzU3hxWm1lZVRXY3dmRmdzSFZLekVIbDI5Lyts?=
 =?utf-8?B?WnJidDZXRU1WMkgrRDEwYis4MFQ1b0JLQ2FUdkFHRWxnd2dkTXloWVpJcHJ0?=
 =?utf-8?B?aXZvbGdWb3FJTnM3a3c2a2tGcWdTdG85WHJ3R2ZQK0ZPNksyVkpGODlqTXFP?=
 =?utf-8?B?TGgvMlZsK0pJRWtpbkVtMS9kRi9sMnVXcW9HMlVLWUU3WlBkVGZWcHBsbWxl?=
 =?utf-8?B?YVM3aUpQQkRLR1M2KzNwSGJrRlJVM0NCQkNnQVNHWjI1V09mT2QrK2dCMzdO?=
 =?utf-8?B?RHpZeWQyODVDa1BVOWp3bUZnQzZ0N1FxRWxQL29reHBGZmlDWDVNbVdXOGxO?=
 =?utf-8?B?SnYzRmE2YzBjQlR5TlVSRkJ4MkR3NXcxVDNhdW02Zm5mNFlXZlYwVGhLZjdK?=
 =?utf-8?B?UnZPY3VRS0NXTjE5Qzk2RTZrSkZCZjJ1SmxZdFpRV2I4ZkowNGJwaGJGNTg2?=
 =?utf-8?B?eFp1bmg0Q0Jvb0hDZUE0UlZkdEsvZjJIYkQrOU9rakgzMUhzVFNSWkgrSWRj?=
 =?utf-8?B?QldxdGdRVFlHZVJMTXNCL2lQdUJrR0Q0UGtwdXdTSmNTa2JFaExPQlltZzZS?=
 =?utf-8?B?bEVhQ0ZhR0Q0MXM2aS85OXNQamRxcnRYQWRxWjdRTjcwY0g3NTNvclhWd3ov?=
 =?utf-8?B?MFo5S3FXcUxkUjBxbkVUV1ZxNTJtdXZnMlc1Z04wTUptOHU1TUpiSXlCRTJ6?=
 =?utf-8?B?cERGbk15MnFpRWNUTnZIOXNPcmpLWnlXOVExR05yZ082VTBlb3FZakdERXU3?=
 =?utf-8?B?dmxkdHlCeTRWcm8vVmdldkJ5Q1E3cjA2WTBxMW1aQVlmYVNjVWxVNXd5b1dD?=
 =?utf-8?B?V09XTENON20zUTVxWEpKMHloWGhRRksrclYyZFl0SENsNkVoZ1FVcGZyREVI?=
 =?utf-8?B?ZWlBazlnQmN0emZPOGkzWmZTQmFzZmh5V1FBaExraWhtSWw3QUE1RmdwUGts?=
 =?utf-8?B?M3ZXVFhBL2FXMldXd1QzREYydTlDbGc0K1VnY1Y3OWRMVzVtaFVqSWlMSE15?=
 =?utf-8?B?SjZ4SUZTaWJtRXVORlF6R1kwL1hCZVJGUUVJV0xBRHNHNDBsS3V4OG5RV3Fs?=
 =?utf-8?Q?ut3zU3Qdd3hOFooMnI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlVPd2VXbGV2NFlucDZZbjhzbFYvdXV3eHlSRDN1SVdac3YwL1BIYzBMTmRy?=
 =?utf-8?B?UDlGMllKVDNsQlQ4L3JpNXMyK3ZERWRveE9pbC9qQU11ZEhBTG1qQXZBdlZ2?=
 =?utf-8?B?RlphZmlab0ZNSFE5SVdTQW11VE5SdjBvZHFZQXFJK2wwMmhsSjFjaERuMU9B?=
 =?utf-8?B?Q01uVHZ1QisxWWxBZ2kyZE03dzNiS0pNSVI3SkY4cVpIeVZPTzBKbWhQYVl3?=
 =?utf-8?B?NllQUDRuRDlUeDZHUzVSbXFWaDQwTFU3c2dKV1V0TkRKVGZFakZEeDBmUUFK?=
 =?utf-8?B?M2Nic0lTZTBkSUZ3eHNaT20vL0dQMDFNenNvdDc5eW1FZ0dHSDNUTVh3VU5L?=
 =?utf-8?B?UDdodlVXaFU0Z3pIelordm8xemEwMHcvZVBsUmVMMlZVcHZLVFJKV2ZKeXVF?=
 =?utf-8?B?ajg4T0VCMjV2K3BFbGZhSHlYNVJSdFk5NlRrOHhxZjFCcjJkTnRIRXhCRWxJ?=
 =?utf-8?B?dmVqdVUzaDR5SlVvRXNWSkhHNlZDdkpuNFV3QXBVRklGcEFURWR4WGZhMlpS?=
 =?utf-8?B?Nmo3ZjJrcWIyWmsvSEZEbWlKVnpmdHZodXF5a2VnSThONTRzSnNFL3diMzJG?=
 =?utf-8?B?dVlrRTlWZTJ2a0haTG16WjFxV1p1UEpSSkpRODhJZ0JKN1JhMGh6Z1hTZEhY?=
 =?utf-8?B?SHJyUndqZ2hsQ1NDWVhySGVpQWg0QWYweUgwb2ZVcTU2aGFVazc4bUI4VTMz?=
 =?utf-8?B?Sjljb1hBRG9DK25uUEFoVUYrT2pIc0ZuZlRtcU84aUc5a20wOWFlbitDZ3pN?=
 =?utf-8?B?QVU4Tng5d3o3a1Qwbk5vdExlZUc2Q1Y0RDc0V0x0WW8wNU5RSWpzWHdpSEZX?=
 =?utf-8?B?cStja3lhZ3JWQjVLUjZGUG1razRkZnVBYTF4QjdUMTA0R2ppVm0yNXBhbmZi?=
 =?utf-8?B?VVdZdW5yZFhkbkJhS0w5d1kvSmZkMjVBaU5vVWxsZ001bDNIQytycDhvcVZr?=
 =?utf-8?B?TDJvMHpkdzhnNFF4ZWR5S0I1cTZaRWxwMGM0WTFkYURwd09tRW5Bbks2cUh3?=
 =?utf-8?B?QXowbUNZRk16bC9veHRhTnJrN01vTTJWZWtMUjYySWI2aXJqdldhb1JCNUJq?=
 =?utf-8?B?YzVCaUZKb1VTREtHTU1WUzhWQS9rWWxtYm9NMUpuOUIrRVJjbldYMHQxN3Q0?=
 =?utf-8?B?bkpjMTdGK0xiaHZSWXNKUWRrSVNxZkx4SW5aODZua05QSHJUc2JXQkdKZE0y?=
 =?utf-8?B?Q3IxK3kxK00vczFFOEVLaGFDc1BDR3FqMyt4dFNCQWdPOGJTZVVUTDZ4Ry9O?=
 =?utf-8?B?bnNUbXAwQjhOTTFvMS8ySTlvQS9OdHRyTjZWb0J4TkdZTS9LeVFUV1lsb25o?=
 =?utf-8?B?dlZWWjhpelluV1JZZ25OK2lCTis4Z2pvNHJlQjFaTGFjNnl5OTkzSUlpU1lT?=
 =?utf-8?B?UXY5Vm1pOWZpRUdMN0ErQk5hTmo2YTVLeGxoOVYyalRSU2Z6N2N3K3JCSFBF?=
 =?utf-8?B?d1c2VTFWZ003N3hHMVZNa3hCUnVKdUFqSUxPcFpNam5DdWxZZ2Z5MS8xN0dZ?=
 =?utf-8?B?R3lrWFU2eTRxV3g4eWQzVm1jMkhkUWl6bFhSTTZWN2FOWHI0SGV1b1RZTkFY?=
 =?utf-8?B?TWNFaTZKT3BKeWFjRUcwUVRPL2pQZEV4M3J0ajFhaEpxcCthMzBqdW0veVF3?=
 =?utf-8?B?RjVHNGtuMXk2R3NZQXpkbW1laFNqSmRuZWQ1SXpHdEdWR1Ixa2hQQUlKTDFl?=
 =?utf-8?B?aHlPdDUrWUxqMnE4d1I3YSsvRjJiU24xUTg4NjRlLzJrcng5M1hZN0o4NE1N?=
 =?utf-8?B?ZTU2WFQrNDU1Nm1JeTlaNVhHcVU1Zkp0Vmw4WFhwRmpudnlUZ1l6MU5HZjF6?=
 =?utf-8?B?RENncERHMnkxRFp1OC96QUgxWDg4VmpwcE9jdWZzVFVtZlFkQnU3a28vY2hu?=
 =?utf-8?B?bUZoRllHeDVCRGRIck5VVStzM0tFejRaSUZQamZUNVRXUWRtUDhsMFJhcTB3?=
 =?utf-8?B?ODdvMTQ3MzdsdkZsaEJnUVc0cTYweTVVZ1NsdTdBSkhYVEJBV3VCNTZsNXNv?=
 =?utf-8?B?YlNmSWwzSndLZHJ0a3FtK3o2aDNXVEdOUmZ3RnNFZFZXeUFyNXRZTERKM2JJ?=
 =?utf-8?B?V1cxelpoVzIwRENRdmc0TDEyWE9sbll2MGFjNlV0UXlueVYzZFQrUmx3Q1pv?=
 =?utf-8?Q?Fa3Malo3WWJiDQTdY7nwMO1WA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ffafa67-7500-49c6-5138-08dcac0a59be
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:59:23.6565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+v71RzUO/GJ5xB7VIXDpP57XroaLnrYGoCP8UQOVnj+6J/tVxdXbsjUvZW+KYhGtZlHXK7pyIiKxRpqfJr9kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

On 7/24/24 02:10, Ma Ke wrote:
> In _emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added Cc stable line.
> ---
>  drivers/edac/ti_edac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 29723c9592f7..db23887b2d81 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
>  	int my_id = 0;
>  
>  	addrp = of_get_address(node, 0, NULL, NULL);
> +	if (!addrp)
> +		return -EINVAL;
> +
>  	my_addr = (u32)of_translate_address(node, addrp);
>  
>  	for_each_matching_node(np, ti_edac_of_match) {

IIUC, the original v2 submitted seems to differ from this RESEND patch
https://lore.kernel.org/linux-edac/20240718134834.826890-1-make24@iscas.ac.cn/

Snippet from submitting-patches:
Don’t add “RESEND” when you are submitting a modified version of your patch or patch series - “RESEND” only applies to resubmission of a patch or patch series which have not been modified in any way from the previous submission.

Any specific reason for this change?

From a brief look, it seems that the original v2 was correct.
Check for NULL pointer deference might be required in both places
in _emif_get_id().

Also, some more context on how this was noticed might help.
Was it through mere observation?

Thanks,
Avadhut Naik

