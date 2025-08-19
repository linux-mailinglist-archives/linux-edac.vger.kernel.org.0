Return-Path: <linux-edac+bounces-4616-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB3EB2CD88
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 22:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF95521164
	for <lists+linux-edac@lfdr.de>; Tue, 19 Aug 2025 20:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6F30DECD;
	Tue, 19 Aug 2025 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BkhF0sjs"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020139.outbound.protection.outlook.com [52.101.201.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3526A0AD;
	Tue, 19 Aug 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634347; cv=fail; b=JYjrpqFIm3J0XbIzJb0okv/aI4vs+jsVWsLDgouOBLzz00Dt8a4UjQutRn2RQVepM2AxgGX7akKj9XmQJUgPkIQ3FhsIl0vSM5IA1tgNOgeaSCn6YXgH5BkBW9M0RqWd/+5W8+cTRqMspCd1A1xPRzABl6WFn9MPTl0mqN16Fpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634347; c=relaxed/simple;
	bh=hwv5LmLFI9LuwfbGFh64aCBH2lzkrerGwCif8czpR/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BM6uH9lbV9LIxsbcTEg9rqbz5fmJ7Fuq+watNvOXTZptD2Oz6wYkT6yq4e8UJGrBWAbJz/W/S12LpsOBJSlkPwEJhGoNtXHf9iuvkEj6YAUbgIZhCnIXdu7ybxVkbQ/AXL0yQC38o1jX433Lb894/ORlAMptUoNmp+LWmE+0pBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BkhF0sjs; arc=fail smtp.client-ip=52.101.201.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQ2GA1yoSAffzZLnMV+IfYJd7mvmDmKa1ptZR5AzdDbAcQu53iQ/IenBADLEVtHH4fdEHKikXACLn61hLFhimNbdF4huhu6SdQZ0dzLPOfUiFVqDiTcH2KWMJ0hMk/AVVey1korf8oZ3H+pzHc0S2OTPRsVZPkHueehaVXZrsK2TL/YI+aoKAyduPyNcheQgTbE/WDzOqiAO2qvwRU2TMzvnbg85dxhmSv2c9adnYNtvHdACwJzRwdT21T/T8khuLmFv6xLok/TRuZ/1Vy2OCB981t595DaAE54yQy2CU/vvxY3UBs6qm2+FLvhC/qsDEhbmEBZ+BUEUthpbVH8CHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMy9q8E0IfDEhqqoMEFRpjweTfHECoXnBUjxN2QYpN4=;
 b=AEpRxNjOfdfyBMWvB1fT6bZfPgKEdhXcvu33SMPN4TcpNy0kVbIszazJu0Z7wVTDtGynuId8P8VhLNoqnwbag9PBhFcf4NAlPo1xY45DqIs1qkBUqhhcyB8mghaBVqic8sPpM56fMRCUaKrLUR3sbyOnYE/+raM3Z/uVhwUNsV07zmxmbgexUbYkveBRxkfhv6YQ3hrl4nHb1aaDLpU57UeE7AQlu3CwxTeQ7fs1eIRGGIUFcE3Dakit6mGQ3q3kAohwL76Ksvd5pIsMY9EpiHELLJD4HStA5PBFZ/MViwzGNY+mCwiC7j7XyXL3qmDwp7XFMDIS/k9Uqbn4cYqDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMy9q8E0IfDEhqqoMEFRpjweTfHECoXnBUjxN2QYpN4=;
 b=BkhF0sjs5oVa0G7He+jBnsi2yscL0mIxFvZDdp/uj/6paGvuhmUJy5JNzphmtyeI+P9cAWNcO0kCkJ9+hYIYtQ2xHy2fK83Yvx29nkyQh2VWHP+YKQvD5BH9ZHt/5UfE4UDfPbJ2PAnMueqDoUffc09t/2DxxUUS7zDCGS6bAxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 CH1PR01MB9358.prod.exchangelabs.com (2603:10b6:610:2b2::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.25; Tue, 19 Aug 2025 20:12:23 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 20:12:22 +0000
Message-ID: <7dcff61b-55c1-4242-9ae5-ca965fd4c8c1@os.amperecomputing.com>
Date: Tue, 19 Aug 2025 13:12:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 0/3] ACPI: Add support for ACPI RAS2 feature table
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
 kangkang.shen@futurewei.com, wanghuiqiang@huawei.com
References: <20250812142616.2330-1-shiju.jose@huawei.com>
Content-Language: en-US
From: Daniel Ferguson <danielf@os.amperecomputing.com>
In-Reply-To: <20250812142616.2330-1-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|CH1PR01MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: d789ecaf-3786-43ad-4b75-08dddf5cb4ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFZ2SHRIeHcyY0xKRW0xS3N3M0dkeUNHbGlRL3dIQUwyUWo5bTVlVU9TUkpp?=
 =?utf-8?B?eEsweFR2Mm16SlpoeTZCRThFR0thYVB3TDVCeXZLQzhpcENvN3hxOUxuMzdq?=
 =?utf-8?B?anRKR01mMWV5L0F3MDNVdHFEdkVTTHh0UGlLL2tzK1k1VXVLVGx3RkhoNU56?=
 =?utf-8?B?dnVKdXhJb0hhVVcyRUEvNG5pZTk5bE9YT3c5LzNZam1XZktmK3hFbHZHUjFH?=
 =?utf-8?B?ZDBwbmRmQ3puRFZjdWY5VFJHcXdER0FjTVhMcHFHekxGOTlwWFFQa3hDR2VC?=
 =?utf-8?B?YjVteFdod1k4Z2pwKzIzSEVkbStSY0VhalNkdEdjUW9oSFVvWWUrZTBBRDZS?=
 =?utf-8?B?V3pwaGlDY0ZHcXJySEVsNk1QcE8rZGdRS05KSndVNEFYc1d2RUNFTkFWd2hi?=
 =?utf-8?B?N3dUOGZTejJRKzlBVUxYTnhTMFNxdjduWXI3ckx6aE9IcGdwQjcwSmN5RGpi?=
 =?utf-8?B?QnEyY3NnRmh3dVloRXIybUM4aXNKT0IvRVBLemJ6cnV6NG1aMEpLSk54ejZG?=
 =?utf-8?B?K2t2ajVZM0E3dyt0YjNpWU9iaGxTaHY2aG5NdndJRGVablJ6T3BmQVFydWlj?=
 =?utf-8?B?N3JyYXR3ZHRMNHBWbzEyLzZSVC8vVlI0U2N5MEVMaHA5V3lOUDJjaXlCM05I?=
 =?utf-8?B?OFlWczNxOHFoL3NCNWV1SlhXcUZlYnFudGFZcHVySTk0ZnliVDR2RmtBUUs0?=
 =?utf-8?B?bFovNFQ0Q21GTkRWekRHK3d4SXozWnZMMlI3Q0htOFZPbndmM1pvbS84T1lJ?=
 =?utf-8?B?VnF4NGFRc1prSS9vaUdlSVhaejE0SGhJZjhmcFpCUVFsQjh0c2NiMmF0NHBq?=
 =?utf-8?B?Sk5EVlFkRTNmRG9UcHVGSDZFaFA0cHNSYjN2S0dZU05OZmN1cGI4S0Ixdmww?=
 =?utf-8?B?dlQxN0FjRDU4YUNicnEwWUtvVWF6ZXFkT1c3emtIRmlRa1F2UllDQXppcHFT?=
 =?utf-8?B?WEJabXg4T1NOUTZ2QWdCdnorNEo4K3pKcHo1VlR1L2UrOThRMkJzSkRCbjAz?=
 =?utf-8?B?NFplM3V0NHZmZ0JXVWtYd05yRmVRUHZWcEUzd2xDaS84b3lZQkw5V0kreUZO?=
 =?utf-8?B?bFhsbllWMXJaLzBnaWNHUDR1RGtJQkhrUVQrQktvVGFiOHE2REFzWXRIMzFL?=
 =?utf-8?B?ZkpBQjhKdWZ2REFFUUNVdjBycVpLNmtzRE9IbVlhWlJjM3hBR2toYnBMQ0dr?=
 =?utf-8?B?WnZjeEpxZ3BYU2V6MnFZV1J0dGFJemJYM2VON2FTZU05TkN2Y2g4ZGh4QTBZ?=
 =?utf-8?B?NDZSOFpxWUNrcXVvci9tS2pHZVdnc2lxbzNQZkhFWTFDTWgwOGQ4QXZ5ajBv?=
 =?utf-8?B?c1I5Z2ZVNGlzenZ3eWhHVFJaN2k5TVZvcHJabHJubXNiVng2MEN3TW56TFFq?=
 =?utf-8?B?d3pHdm1qblc5eHpIbEdZai9oMW1meUxFQmg5WHF1Z3BmbVFoK1RaOGxDNEhX?=
 =?utf-8?B?UzFpbXAraHpJT200NGdxVDlmSEJKaE51TTRSbXU4a0Z4M1VPRlUvQ0lTK0Nn?=
 =?utf-8?B?NXdxVFN4dTNGT3Z2Mk1FcW5mNzRCYVpjU3FhTmF4OUF0NmNMdDh4dDhpVkxr?=
 =?utf-8?B?VkEyWitpZzd2MVNDWmMrRHdLMC9ibHhlcUtNcUUxZWk4eWJCVGxiVks1cHhn?=
 =?utf-8?B?dEJZYVJMLy9JRVFwaFRiOGJ1cHVEa1FhZHZ4M0tGZUpKNXVpaG1IZ0ZVRyto?=
 =?utf-8?B?VmlhMSs5azRtRGY4dTRsdDlHOWh4TSt4SWdKa0Z0OW5lcm5XR3BuTWRqN3F4?=
 =?utf-8?B?emRueHpaR0tQd2t0dWFOa3NscEt5MmlYWXVBSjNmZ1pGekFJMklzN2M3ZlYy?=
 =?utf-8?B?b3lVTDBBcjBBcmFaYVJXMjE2Slh4Sjd4M2l4c1grTDk3Nkh5UXM4YUhRMkEw?=
 =?utf-8?B?S3p2S3Rtck1tZGNGcndOejhUOW9TTXNKNVdyRFhJUXJKS2x6ZU9OTkZrV1Fz?=
 =?utf-8?Q?QLWnn5KZvFd4DF6KRVrvCCyLj0uAKbQR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UklrWklrenhxSGxGUTJMRnFRZlJydVg1YnNXOEt2M3hJWVZjRWE1cURQcE5Z?=
 =?utf-8?B?TjZ0NCtCbjBNOFgxQVdIZFJ2ZUtWZE5OTXo5SlFEUHF5eW94anJsVE1HSUc1?=
 =?utf-8?B?WS9RKzhkUmtQYXY3eVdyQW9ldkhMV0ZTTnd2bmx5d24rTUxHMFR2UUI3clRM?=
 =?utf-8?B?OUNmZHBLVVVlYk52N1Q1b2lDVUtRd0pSTGd0T0JvcDlYOVYxdk9EK1VlRmRu?=
 =?utf-8?B?ZXR0RXdjaklFM3hmRVB2K3Q0RWZjUThNTGIwbmFMa2ZmRzdLTWJOeDZHUEFF?=
 =?utf-8?B?MlM2YmhFcjNLVnE0WVlTM1ZxMDdVTFhsWWJER1ArWGVXL2RGbzRhaE5lUysz?=
 =?utf-8?B?RnJReVIzR3YwRyszVXJHR2RPMWI3Sm9KQXZjMGpnOGhia29ZcUE3ZlpXSkg3?=
 =?utf-8?B?K0w4cXRZNVhuSWhMKzFSa1NnQUd4WisyRG52MGNTTzFJK3E0V0NxZ0dRU1d4?=
 =?utf-8?B?TzgydmZBQnk0SnJITWVCT1VqaEJOYlJrRWdMU0dSa1lSa2tJWUQ5NEtKTnZJ?=
 =?utf-8?B?b01vMURScnkxcVMwZDlkTWx3SU4ySTAvYVFZV0xIWXpHVU9mV3VJTTV6MUhG?=
 =?utf-8?B?VjQyZWNWNnFpMzlzOE5CY2lSZXVwN3N4d2hiWGFyUEhJL2pSYkhCVXhiSy9R?=
 =?utf-8?B?bVh4M3BVOWZoemcvTTZUdFJOUzB1LzloelhDajdtamJ2ZHB2cWtSR1MzeGJK?=
 =?utf-8?B?TGFHQVRsajl4cW9IbC9yd0wrRFYza3ZoUGZQRkN4TXB4NHVFR3VZNU5tVG0y?=
 =?utf-8?B?OCtUTXQ0T2VwU2dJSFppSXViNEVBMlhvRDc1b21lWC9FcVh5MVk3Uys4V1JC?=
 =?utf-8?B?ME1rYTBkZ2RCKytVbHFKTFVkY0U0ejZpSkRXeGVVSzhKUk93cHZuYnFRNXZ0?=
 =?utf-8?B?T0puQTdSbEFGVS8vQzlRRU01WVJUQU92N3JOaFBNUVNRa3NhaXhNdWdhSTJa?=
 =?utf-8?B?akkzTXBsNlgrVW0vaFRCSmRrME5wVzI5R1R6R0ZNeUxDaC9OMXhwNnJ3NVZo?=
 =?utf-8?B?NFAvNEZxZVJVbk11Yi9RVG4vTjF5U3J1SVNUczUvVTVtSEF0Z2V6VVh1cHIv?=
 =?utf-8?B?bzFtcENwRnZXV0lzbExqeUs5elczRk1JRmtQQ0dXOTdUV2xYY1BtbjBYOE1O?=
 =?utf-8?B?MFVmNW1sb2xnbDdLSEZMWGlRZDNDNWN6RGl5QkJ3Ym5xdVJKTGx2Mjd2NElX?=
 =?utf-8?B?RjJ2Uk9uTXVreWp4VGp5VUpJaWVlSkltSUhvRUZEN0FiZ3UwdThHSnlqaDNs?=
 =?utf-8?B?d3JiblY3TG8yNkFsV0h4ZExhV0FYVmhwOXFiaGU3YUN1MHM2Z3NaYmJkbUhr?=
 =?utf-8?B?dzcvWE93blpOTG1BamFyMGRBcmhrczNyQkw0NFJUeGhDL29sZERZRzcrWVRj?=
 =?utf-8?B?dWFOMUZ5QXlSaHNUckdDMitWMHZaUGdXN2xMWEF5T3ErZHkydlRCNnRqSnBI?=
 =?utf-8?B?bk1MUU9yeWkzSi90b09pYXFXMlBlTVVVNVVTTldUSDBpVFVzaVdFWVhVUUJU?=
 =?utf-8?B?MGhLR29LOEtWajlFVUhpZE00N1lrY3JiaGRkcUtid293WnVyaVE4ekppYlMx?=
 =?utf-8?B?cVpLVTRoYUc2eVduclhIa016NENqN2lPV3NQMjBXVzJEaVhvTnpBaElKemJY?=
 =?utf-8?B?TUxycXBuMysxTlN0YUtzbTRyZjVFK0NuTElJblhMQWIyV2JzMTNhVW02TTJr?=
 =?utf-8?B?Q01NVXBuSlhvTmEzR0E3cExwWStxTkNXZWtlY0U1L1ZkUGd5UEVnTHQrYWYr?=
 =?utf-8?B?T0lqZDBiTXB5Nkg5Y2tpTnJuVTBIVUxuMTFZNVAzTmRGMi9Za0RLOFM2L3J1?=
 =?utf-8?B?aG5MUmtERzRFMnM4ZnlDaTd0WXRFaGNnWTZzQTNLd0ErLzJvRWQvUHRjMEhq?=
 =?utf-8?B?cThabDFIVU5SMjhVVENxVTkwK0U2QUVWc21NMmVJcmdvZit5Q0xRUkM0ZXp2?=
 =?utf-8?B?Z3Q1NFIwRTJHazkxdXdTUHR6YS9LZTVZbGpMbThxeGJlWW1EOE5XS0xMRXpP?=
 =?utf-8?B?bjYwM1JxSkpMRkxINlYrY0FKRFhlUkYwa1BHT1hJZ1dCSUk3R2pGeENKYmxi?=
 =?utf-8?B?OVVaQ2syWlhUcEtrVnh2dFoxSllidEJmOE53cGNkK1Q2TWJPOWJMUHVBcFRZ?=
 =?utf-8?B?bUxMbGdDcDBPb1ozWFVIYVN6bm5BWXRLSkJ6N1kvSjRnTTk3YjAzNHVKL0dz?=
 =?utf-8?Q?uu2pYDzPikM38GqC+a15LAI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d789ecaf-3786-43ad-4b75-08dddf5cb4ff
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:12:22.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0VzpG/6nxSdboEvn7SRD8TTZ7cYFoH/stBv2hUWz0yPbBZo0A/Gmd7Wo/NUJfaWzE3j0syRfhAfwxYjyyA9OILo1brP+CgIZN+OmVYeSDx7y+qUOIRn+63/I/+Paxp1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR01MB9358

> Changes
> =======
> v10 -> v11:
> 1. Simplified code by removing workarounds previously added to support
>    non-compliant case of single PCC channel shared across all proximity
>    domains (which is no longer required). 
>    https://lore.kernel.org/all/f5b28977-0b80-4c39-929b-cf02ab1efb97@os.amperecomputing.com/

I've tested everything again, and it works.

Thanks,
Daniel

