Return-Path: <linux-edac+bounces-850-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585EB890EF9
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 01:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ECD1F236D1
	for <lists+linux-edac@lfdr.de>; Fri, 29 Mar 2024 00:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A164B;
	Fri, 29 Mar 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pT06LTvG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2096.outbound.protection.outlook.com [40.107.93.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40463A29;
	Fri, 29 Mar 2024 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671219; cv=fail; b=Xv/HlKyNZuuuE+EMJxeQKdI2VC/ZSeFFAV3i2ecWLL6Zh+yNXnoFMESDXc0S4kLZH0zojDASEgIWPKwKrGtX2qm+/PJE0AGy/OMhn11vRoTNghZmkNXSmGDbfcw2XrYgBTy2GEcZwRRgmZIRtke34i94d1HXg8YYBNFek/dhrFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671219; c=relaxed/simple;
	bh=6V8lALKU5KgQbyJj8Pq1HFhqzQ6cZHnfr8vw6ejPwxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+UUfiRES1gi9v689qe663Z5RkrhgYqquKFeIK0xhA6/r3fVFz8hccYTs09x6RnT/WcRoRCEXMNJ2ZFCourLlvktzD75B7r8E1VE7+6dgcj6VjR42SMVnPtQvSzACxOpIJIT2wpJHSWj7rm6UacdfTPCLn/lH642xS08BTIints=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pT06LTvG; arc=fail smtp.client-ip=40.107.93.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9LTctUiS1VZZNSvX80mNs4R1Bijpbr0R08ZhgUMyVRC5Dh9cjxt/XhBnjhyeApLtIeLcmGXzmTJG/La7PY7Zf/Oe9lcBVbwVezQnrl/dyuJWP3Xto8j6sVxuBE1kU/emiDb7vlHwTDlytC0U+vum3tgJpPSTJwasiUh/pkb/YhCX2YBJFpmYwfT6oUoqyZWcvuqaEsKeHt5Xry/t9mkMYh1odbvODyia23Lts/qAwJE9hjLtqs6kjpQzmVLz8QsqThZmNr9NAyhLNrATvsnFJHfanN++/FmmIVhUvsGqw2pbXSo7YODESrCPLNCEY5jZ6YsMEp0TzqKKwc07diqJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qof4dzK9jdqTOUL8Zy8pcLowa6vWfVFnl52MqC3ISb4=;
 b=VPgZ1XvIjviAuT65MefbPHRFoBW60yOp/0hwW6UuMSd0LB+ezRDbQCZAGXg9eOns73OpTxXitk04rncFG+ldJjGwhKgpZWGO/BMF/YxdmEufmcgFEwzSaxVPKPKWyhVAN7MJTM11l6AWe7Qo3Fr6xaF+6VAmrSquvIP0BONttbrNLpZEetD+p6ojZYi9AZJbv/lZuAAn+nPW/udyhnklkVAN/Lv80jxeg9Y353oIsHiBOdFzw+YvLN6hkiqgwmGvdQCfy3ftpLwp24QOiM6LfY3oUw79lJNhUjM779slMGQCiQLROu/Cry6cxQb9ORG+mYbbaMiDCOE6ywKyzTNQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qof4dzK9jdqTOUL8Zy8pcLowa6vWfVFnl52MqC3ISb4=;
 b=pT06LTvGgll6GXoeeKKHlcX6j58jReUmpfWnGGN9Woa8KOr5WrgDaBdIDbxt8Yu0SmEmVcvZ42MRiX089t1oMC8LqagOstM99Ount9mGPndNQqpKm9B+VvZL/aFK7X2UIgvWj3CaiXBf9uKtehIQVn085H5F2EIk8QNEUSRZFKs=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 00:13:34 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.028; Fri, 29 Mar 2024
 00:13:33 +0000
Message-ID: <a7246356-98bd-4f8e-9a39-3a2e65b2eded@amd.com>
Date: Thu, 28 Mar 2024 19:13:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Update mce_record tracepoint
Content-Language: en-US
To: Sohil Mehta <sohil.mehta@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc: rostedt@goodmis.org, tony.luck@intel.com, bp@alien8.de, x86@kernel.org,
 yazen.ghannam@amd.com
References: <20240328180435.435076-1-avadhut.naik@amd.com>
 <9640d452-c591-495b-8284-92f7f986c97d@intel.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <9640d452-c591-495b-8284-92f7f986c97d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0005.namprd18.prod.outlook.com
 (2603:10b6:806:f3::24) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MN0PR12MB5905:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l8kbM0i6LPAehIrSh0DecYGJmZLtwjRueFJ/gn9nlfbeYQcT9w+ot8spmome8yYmNoXdERvgiOxD7YQJVfm0aK6QRhAxQCS98CIDrNVK3eu+KWq+cXWZnDTppZCvVdeU3z1RFQ/oo4KPIVGsVTzut8k98M2NvSlKlSFovIOE+aWbEHS6Lcw36lfYPKpa9Zga9CEoJuLDgmypVSfmEEfw8IcrCke/cj7IOsWsdmqprZpLhxHOvXtc9kO2EAuDS5kElVUvZwTcLS2+He9qM0dI7oryUvF2NfVXnRUV5eglhyiv2r9f8Yxeps56gwGG0RIgZ45TSZNgKSM4M4j+jyePx5esXUUZ1L2+OCGiQAz9wCICpNU+9LN2AwnzTM3Xx2O7ya7vf9JoiYAnpxrUEWjXh40nW93nvL9dS/778An/pEpQwHcLP2uxb2zNX441UyzTgq8i5Za2UwWUBYRb528VQftXhcV4QqWzkAQGMNpxWOwiHzxg49mcDKZ8LTzhkfu3klW7xLdC8rhbavfO7yM/JjxCljzAe2gtrQgYpSJq3rP/hHkrShQxC6qpuTfdz2hxAMZ1+MpOzLlLgK4Kpoat/KizpEpgIcC6MeV6fY+pI+t6w4UypwMmO+u0Z9YAtUHzrOK1VEKAIp6DhvvluKxZzlaAdhU/dzR5ptN16nN5x2o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFU0NHlWc2w2V3d0RkIrdmZGaFo4RXFKYnJnOC9MVlYrbEZPT0RYOXVWZlNZ?=
 =?utf-8?B?Zy9YeXdkeVlicExPMi9hVFd0WGxpOWZXditnenVLa2c3ckpGSmpVNjJTczA5?=
 =?utf-8?B?T3cyUS9VUGNpZlRjckNBNkM5NmUvQnloVTZ1M1RVZnhVYzFQZkpqTC9KRE14?=
 =?utf-8?B?MTMvWCtpRkhsMEgxZWhNN3I1bFBqd2tlMlpsUStEY1JQYjBRZ2s4SXR5WjJ6?=
 =?utf-8?B?eTR1NWg3alpnOFQ0UXQ1eStSeFpqa3VrWGx3dUN0T1BidFFabmp0RDZHS042?=
 =?utf-8?B?amM1YUNJelRXOVpUeEQyZ05QbG1pdmhLYkNrbm8xMVJveUpHUDNWazAwQUdr?=
 =?utf-8?B?Tm01aXhiUEhxUjRKQm9MdDhKZHZ6WGk1a0Y0ZTVPWWNXM1BCUGUvTThuc3R0?=
 =?utf-8?B?eGtDSWg0RTNzaDVHMHJCMCtuYy9ZWWV2RVo2aWdkNG1IYTFoSWhHZ2VBRklZ?=
 =?utf-8?B?VlQvZXhiOEtaSlZDc3pxd2xnOSs2blZCS09pczJvV3hLNHRNVHJSVUlYUjNk?=
 =?utf-8?B?TEZWckdQejB5dC81TzdrNGNQUmIzVFdiMDcxN0tOWHdmTXVNUmtXSGR1Z09B?=
 =?utf-8?B?QVZsRUxPakkyOXpGUENNZTlmalVyWEVPelZCL3JIY2NJWWYvL083bVIzOGww?=
 =?utf-8?B?Y1B2WXkvL0kzSVVsaHlwd0FqZHlEcno0djJDdHpXbE9UaVJXRXAyVnFjMnBk?=
 =?utf-8?B?T2NhRlRVSmRzR3J0SDJvWlJQUHJkTjNCaEtqeHI4dkVBZGJqbXFjT0orblAw?=
 =?utf-8?B?MHNsM1RyM1lOMERhVWU1YTdDSlQySU1HRU5MWEcycEduSG40ZzcwOUF3azIy?=
 =?utf-8?B?a0VFa1BlV0ZOakdwdko2OXlndUhISGR1TUFNUisvcUtzR3RTS2RoU2Z2RjZp?=
 =?utf-8?B?TDQwekEyb0pWZTU0UzRYZXRIZG5iZ3JzbEhuTEhaejBwZXJUM1d5YzdUUndJ?=
 =?utf-8?B?VFZ0Slo3bExCMEZJSnlJTmRWWnJHTmlCTUUxc1FkQVFGaXZIM0dXUjFDR3Uw?=
 =?utf-8?B?eUNCYi9ZUjNLSXBDWTZMelhnZ05VZmRqL2ZHQzhJTEJyMHR2UFFLODVHaWgz?=
 =?utf-8?B?aDhjT2tkU2luVWxHSFZXUnRnMGJaTEl5NHkzSVl6b3hHY1Q1MFptbE96dXJn?=
 =?utf-8?B?Zmx0V0lpSm5zNWJXSWUwZWZRWlhoQXY1OWRBMGN5QmZJbm56ZS82WjB3N3Bu?=
 =?utf-8?B?bGFqR2dvN2VuY1JLbVpZVU5GUzQ2R0IzMk02SGExcTUwZ2xTZzhVdlZjRjVu?=
 =?utf-8?B?S3RIQm02ZjlQc1ROMXpIM0o2Njc5ZDRsdDM1MUt6T3BlNlYrTVRwbEk4MUFv?=
 =?utf-8?B?N3JJL1ljUEJxcXQ2TDBPTnIvVWlnRlZXQXFvN2FtRHRUamR2T1JXN3cyMHRX?=
 =?utf-8?B?ZXRPVk1OSTBqL2xVdyt0RVRsbEVYK1RZeU9vSTFMcXFOcWxXOTNhUXA2UkFZ?=
 =?utf-8?B?c0hzZFRjazBYS1lGSmpCaW9xMGw3eHdjT3lYUlVOOWlrN2lZT3dmOTZVQ1pl?=
 =?utf-8?B?TGdVRVVzQmRtd2xvekNiY01mL1NxanhmazBMTVF2RWFpZ1dKdFpsZjRNZG13?=
 =?utf-8?B?dXp5SStjK2c3dUNYbDZVbUM2eVY3ZzlUZTZJVE9HVWNnYy9uNEtMc3ZZaUNI?=
 =?utf-8?B?bk43c2xaUXlXeVZCcFQ0eStibFFkWk94RmVTcjBXdVAxdVJBNXQ5ejA4WGRR?=
 =?utf-8?B?N05ESy9Ud3FhUElaVDl2Qy9nMFhVbHdlcHVMMXdWaWJhZTNScnV1TnZiN1Ur?=
 =?utf-8?B?NGh1QXhEalZoajJ5cEdiVWMzOXdxblJhTmZ3SVI2Q1djc0t6NC9iWkY3b3Y1?=
 =?utf-8?B?eE9xaHJuV1d1UU5BTEpBbnVBUTRvWUZqMkllR0JMcHRQQTlldVBhOXhac2la?=
 =?utf-8?B?OCtIOVFqRHY4K0JMNFVoTkY1OFZaV1l6QkFEdXRpempRSktKb1JjaXVRMFpF?=
 =?utf-8?B?RkJpQzh4WkZMdS9wTittSW5iTWEwWlZUSXd5TnpORTV2QzNGS0N0SnowYnp2?=
 =?utf-8?B?M2FjeXEyazdPZnlsYUU1d3hoaHo3bjJxT1hUVXBJck5uN2xWcSsxSnlWSXMy?=
 =?utf-8?B?S3VkZlR3OG1ZWXU4eUliV29vMVhPWFp0THBFdTg2WGY1VnJFREhqYm5SK1l6?=
 =?utf-8?Q?W5AFQOr0gt5MqFNYCayhELUFa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d29a20-ad2c-47c6-5960-08dc4f8511d9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 00:13:32.9911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gN16zoO+IxcX5gXuAGg2DmWUz9c0jqaSFk+6jWuCqYoumYy0vFBU97suxTNhE26Oj8WHeG6o9mjg7RRJtOAN8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905



On 3/28/2024 13:14, Sohil Mehta wrote:
> On 3/28/2024 11:04 AM, Avadhut Naik wrote:
> 
>>  - Since only caps of words which are not acronyms have been changed in
>>    this version and the word "REVISION" has been removed i.e. changes are
>>    very minor, have retained the the below tags received for previous
>>    versions:
>>     Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
> 
>> Avadhut Naik (2):
>>   tracing: Include PPIN in mce_record tracepoint
>>   tracing: Include Microcode Revision in mce_record tracepoint
> 
> 
> The patches look good to me.

Kindly ignore this set.

As pointed out by Sohit, have missed adding linux-kernel@vger.kernel.org

Will resend the set.

-- 
Thanks,
Avadhut Naik

