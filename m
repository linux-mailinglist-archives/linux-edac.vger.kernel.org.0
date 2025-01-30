Return-Path: <linux-edac+bounces-2958-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C073A23496
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 20:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2283A694C
	for <lists+linux-edac@lfdr.de>; Thu, 30 Jan 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697F91F03EF;
	Thu, 30 Jan 2025 19:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UPbbYzb4"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020082.outbound.protection.outlook.com [52.101.85.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2810199939;
	Thu, 30 Jan 2025 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738264721; cv=fail; b=nOLRuBhS6gTgYefaXPJV0h2TZ+BHdaiTa324DnqpFfAADCk9kjfnJ2JsARps9e3pc/4kghbRoVqRoLa5oQMXfdy+TzboJkpwWu/9B7gVQyhJTj1QjJy3Z1VYV9XukMd5OdnInnlDsUDgm8J66WNaTNz0XYfcNb/SXXgTH9Z0gzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738264721; c=relaxed/simple;
	bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oy59TZor7cacPJqAADwipF7b8aqhoTh2BUAm7e2AYHPVhIq/937tqx5d6mRjBeNmQ6PnqiJ5zUfN/Hsr4t3jjreQM2ediER+x3CvJyljx0wguS7cGmcZ4UeR3s12TwWoepkrtwxBeOMrp30xS3oLDHdpV0LpbhRziHEy4yOcOXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UPbbYzb4; arc=fail smtp.client-ip=52.101.85.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L11znCn34U54klI1Y8ilNZjuF3cHO0q5TMfi7avrlJW1hyT4xwIyAorXTIwsLyWA6xKym+m9OtzwX6AewjS0Li+3/9tWGHl+BKKxo4cc0b8ycx0lxGX3NXa+M2RgM+uCG0J9XPY6jAWBka++r+rv7KdaJ0ycds/bUX7J9w6zKER1SDjNnt1Vcr7nZKG+pSSb8eFYW5LdQdYuHILFP85QTCHNpINOBN5DuBEzCqpkuVvkH4ZZWAqCH9PBEqb7+PKSTilqNiGrryEQbwQRxjDQ8Q5laF4kLPjyrcEiwRdf8mIr/F994I4/UdJ10ZVEKcIHgFwUAJ6e6ONIXd/e6U7h4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
 b=wQfTxcvTAGIDQdcP6wUdr6rZFSHAZ9L/b0U4eUWuUII7NT7TWMHSYktZBK7/4qmL9yKLgGRpvw0IVvV97MOb/n61AJfu87gxZgw+2lv6EnowWimVEBUetw0OFP5zpbe+nhWdoA2tUmbNwQlTeIh5aP1TDStq2T0TwahzinIBQRkcJWDvDktfWEmF8oIFDuqXIo6MilzppKXH3KWz6eONz4nfYCJgW1j+5f13mwhm3x7HrJNR7cD7rOjaSQ4tjlAW5Yk2YkTVqZeUnuTn1hBMXalcigVRygkC+FIfJTSeSczuZS3ForpiWFuJGW8IZhFM0oq8YzcInbIrZ0hBJ+R4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bndT+30OuZ2OxSiHY3Ug81P6ICKi6YP0RPMn2Uoieo8=;
 b=UPbbYzb45gzLQiHoNBhzTbzgPpXi/QDXyld4f/yN5puecPHfuntFiHH4gyhtWdV9FoHOZcNBH0sxDBZ8V+FudaBEeTi0dXlmS0qke0sW8/YAeR7GY+5ILsFE0fWn3TikVFyKx7mpfAy/rpd5pw7VHA4zUCcf8IhqNzsANu+1mE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MW6PR01MB8599.prod.exchangelabs.com (2603:10b6:303:23e::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.5; Thu, 30 Jan 2025 19:18:37 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%3]) with mapi id 15.20.8398.014; Thu, 30 Jan 2025
 19:18:37 +0000
Message-ID: <2fec5a8c-7115-473f-a467-7225d3686d6e@os.amperecomputing.com>
Date: Thu, 30 Jan 2025 11:18:34 -0800
User-Agent: Mozilla Thunderbird
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Subject: Re: [PATCH v18 01/19] EDAC: Add support for EDAC device features
 control
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
 mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
 Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
 Jon.Grimm@amd.com, dave.hansen@linux.intel.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, jthoughton@google.com, somasundaram.a@hpe.com,
 erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
 gthelen@google.com, wschwartz@amperecomputing.com,
 dferguson@amperecomputing.com, wbs@os.amperecomputing.com,
 nifan.cxl@gmail.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
 roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
 wanghuiqiang@huawei.com, linuxarm@huawei.com
References: <20250106121017.1620-1-shiju.jose@huawei.com>
 <20250106121017.1620-2-shiju.jose@huawei.com>
Content-Language: en-US
In-Reply-To: <20250106121017.1620-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0337.namprd04.prod.outlook.com
 (2603:10b6:303:8a::12) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MW6PR01MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9f1323-3741-4349-0c12-08dd4162e5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZElwbFQvZWRpdEVGdlcvZmVPck9nYnp5RFhIckQxTWpjdkZtQnh4Ujh4NWtr?=
 =?utf-8?B?Y0NFZXhIUGdKbGNtQzYvRmE3cTZKZ2ZhY2RSRzhIRXI3Q21acHNDRGhtemtI?=
 =?utf-8?B?TWk1MW1SVjRkd2ZJWEZ6eXBxRDRjQVRBZklxUVJ5NWkzaHZlTjBZWUpIR05x?=
 =?utf-8?B?VGhRYkd3amxDRXF6dFgvb09hSUEzZ2tQN3U2ODJMMHhjSFpGQkVMMndybDlr?=
 =?utf-8?B?cFQzRkQxWnRTQThaMTZiSS9hTW96Nm8zV1d5SHBpZ25CSDRRM0tENS9idmMx?=
 =?utf-8?B?RTZESm02dXhzZWRmaXJzaUh2aWdkdUIzcHFTTXdMUmMrcUcvcDJHeXVJY0lX?=
 =?utf-8?B?dnJ6RFNWb3VuVXZNRGVKUGZqUmo4OS81UUZnRG43WnFZbFhsaEtkUTNzeWd3?=
 =?utf-8?B?NVFFK29sMFNmRmRpdG1DSHBPSmltbFVybEdnQlhDSnJsR0hDdTlDaWNadGtp?=
 =?utf-8?B?SkdXK3JVbUFFSVd2RC9ld1AxVmllYVVqSkl4Z2dCUzdYeGNnNEQwb3g3SWJF?=
 =?utf-8?B?bWxwWjEzQlNnTU8raThNMXdIZkVrTDdlTFFaSWQ0S2VyVG9QWjJpd3RUcm9F?=
 =?utf-8?B?UGNOZldNRW1CL0l2Zm4zWXdHS0l5Zm9wdlpFbTJmK2FEb1Ryd2ZjamovZWND?=
 =?utf-8?B?VVRpbDRtYVRpU3ZHTlpzeWZOTkFKNmNLWjMvNVErWlR1M2N1NGhVU3hlRkFS?=
 =?utf-8?B?MjJVak5pYi84ZFI1ZDYvNVo2UWVubXdxMkdzenQwV2tldERvd3dyN2xta0s5?=
 =?utf-8?B?ZElOWVBsYk1seGxSRisxQVhJTENRTjBvZTNLMHNCQVVTM2pmaVQxU3c4Y0ZW?=
 =?utf-8?B?RGtrdDJDNmNVNnp4R0ZtTDREUStndFBXMktJcDR0T3ZsbU1lSTRGd0krK0JT?=
 =?utf-8?B?ejh0U2N2ZGdrWmVwNCt2ZFdBYVIzSTRrYUs4YW9aMWZObXNwKzd5Z0diTE5q?=
 =?utf-8?B?VHUzT3dOQUhhcWU4bVpPMUJxZkFBd1RDdGFnNzIzekFPL3NXZzhwaUZpQnVr?=
 =?utf-8?B?SDh2Y3FEZWdVbUNUdTZYVDQ0emVqMVg3ZlhNa29HQVhmWGxxa0pYN21GRWpL?=
 =?utf-8?B?dTlDRzlCSm1jZUJwcElON0I1MHo1d2dzZnRrTWVJSXMzMzY0UFI5NTR5NmNh?=
 =?utf-8?B?SkJ6UE56SVdqd2NTTVBVRUlFTWdQOFlkaFVXeEZzZTFtQ1V4UW9ReGNlQXZs?=
 =?utf-8?B?cE9Qc3ByS3V5Smh4TzJuK2JNYm80YjFLMFVzUzRVTnVpRmdtS0FZYWtTbkhh?=
 =?utf-8?B?cG1vdWFvaHFvMFMzdTF0SkVWSWpQMkNkemJtem5IV1JxR2FMNkVVc1Q2L2w4?=
 =?utf-8?B?MVlIbThDN2szTU95QVNBZnBzVGVuQjI1VHVGc2s0bWU4R0t6M1NDaFJkVkVh?=
 =?utf-8?B?bnJjbzNDV0xSYi9TcldFdVBRRlZ1NkQ2bys4NkJhaHFJQ1pmMVpNb1JzTDU5?=
 =?utf-8?B?TDVUN2QwTDdwM0FaNnpVY0lGY1BYNWJIRjFIa0xoSncrL1UwdFlpKzhBU294?=
 =?utf-8?B?YStOUHVXbTVZbGQ4bVhlYloxY3lzeVEzbVFoRkFGYURjSkMyOWNyT0tCMXB4?=
 =?utf-8?B?NlhqUk9JbTJFLzdXNUlmTEFrelVvWDVaTDlmRTFxOXpGNU5UdnNQYTJJTmRv?=
 =?utf-8?B?RkoxVE02dzZZdlRkc3NqN2lTVEhYWUlLU1o3QU1kNTdBTUEvczR0V2JlMHp2?=
 =?utf-8?B?cTNEb0pVRGh2M3hFZFcwMVVsR2o1TU9UZEJJK2puRityUDJ6U2ZlQ1RnSUls?=
 =?utf-8?B?WXI0WnllTE9vSlQ3bUtrd2RSNUx0Z0prNzU1dko3QXRzUC9WVFVwL2JzMkVH?=
 =?utf-8?B?dUUveWwxcGRQa2p2MjNveDVXUDJqQllrdTdFeWJrZ3djb2xNWWZHSjVrTzFx?=
 =?utf-8?B?Z2UzREdYUVc3LzRobWFjalIvUStJSG96RlNnTXFxNHI0bmZjejRpMkNnUzBa?=
 =?utf-8?Q?sumtx/EWl+EXNGHTP0ZP97iyZwtfF72T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxJQW41b3liVEU3L1AwT3RjN0YyYlVxU0VJUWFKV3pacWRvWTVkNGhjeUx4?=
 =?utf-8?B?cmlZWHpVVGQ3QUJxc1pjaXY5azFBTi9xMlI5M29qVTNwdWwyUWlSZGtwR3lj?=
 =?utf-8?B?d1Y4eVFFREsxc1FnYUdUOGF5Y3E5NFFJbDRQZHFuODQxRExvQTdsdXlMOUlz?=
 =?utf-8?B?MjE2WFdqQVVlQnIzVDhkeGlJYmdUY2NFM0hDZ1B4T3hWVVdvbTJPMTNZU201?=
 =?utf-8?B?Z1dXTFFpT2lPYjVkS2ZqVUtFd3hraExCa2ppY2o3K1RCVzg0aDd2MHFVSllG?=
 =?utf-8?B?UDVuY25lMmhwa2xXdXl5UEFyZFBseFF1UkIzR21NdXpGSkNhNUFxNy9Sc2Qy?=
 =?utf-8?B?Y3dudmI3OC9wT2ZpWWtKOFEveHpicWZCVFEzUlVZdktvbnpacmtWOHhyNm5v?=
 =?utf-8?B?TkRYcFBpSTBFU09JZGdPY200VTdSY1NsU1h2MkZOcTBkRG9ZbVREVjJtZE1l?=
 =?utf-8?B?ZUg1YSs4VTBjNWtydnFXNm04R1FySWIyTjE1NXBYWjhJcXFFSTY0TmJZbzJ3?=
 =?utf-8?B?STZiSnVhK3gweXg4QUthU2RmYnNWWi90bTdNRXFrZWhGN0tLenlpeGQzNldS?=
 =?utf-8?B?a0V2eFRKcnY1NDBEa1d3SW04bnJ4REZvbmY3QVFJZGJHRysrempzY1dwT0R0?=
 =?utf-8?B?Yi83WDR4L2RXNWRVUU9lVlZTSy9wSzMyYlZMOFB4RTRQdW5ydzNlbU9VbHlx?=
 =?utf-8?B?UU5MYWUvcHcwZ0Y1a1doMmo0cXNYbGlSL1U1dGloSTJsK1p3K0RLaEJzQkFG?=
 =?utf-8?B?d2Q1U05VREc1MGV5bndWdFl2M1FNanV0RCtsVXFLYjJmVWYyWTFKUENoUFcv?=
 =?utf-8?B?OGZ0TUFxcVAvTkoyK0tFSUVTTmRYM21KZHFMRm8wQlNxUXcwdkYvYlBKb1VY?=
 =?utf-8?B?K2xybjdsTDdFVkRXazg1b1BlczdDQWtiUTI3TXcxMjllKzY0dy9mSUE1Vk1i?=
 =?utf-8?B?TnN1d1NBVkJ5UzA4U3dIdmhmUEVhVjRwYXFtN0JiSWJpcGZVVEhpQWlQdEtF?=
 =?utf-8?B?ckZnT3EyUk1hNXdoQlJkRlluL2JwS2NndnB2dDhHS0s5Q0ZRa3VSRkJneEFt?=
 =?utf-8?B?RWNhUzRCMDR5YkRlcUx3QUFuMGJPMjhQQ3JteHlmdjRZd0RZNm1FOHVSdUJZ?=
 =?utf-8?B?anZ4VVRjazBFa0h4dmtZa1hTL2twbFBhN3VvRHVjaFJneGhscnArbzBQV2I1?=
 =?utf-8?B?WUdPMlQ0THRXTVBFYlp0Q0puQjVsZUxURWo2azhCM1FPb256aFY1K2dHRUZk?=
 =?utf-8?B?Tk5lQVN4RDlMalMzdjhXZ290Wlp0aUZPMnAxMldxcXdnSEw0RU4zbkdVR0lZ?=
 =?utf-8?B?Sm1La3pIYnVCWFQxdGhHUHFHbEVoUW1xb2g5RkxHcFEwaDd3MW92b3IxdGRI?=
 =?utf-8?B?b2wzZDhPZFRNMVFBMHJpOGx1enR5RERseDIzMUh5REJPeG8rQjFJa3lSQ2pY?=
 =?utf-8?B?azBMc3UyK0UwZFhpYWxkUnZBMmZPZmxrcCtEOE4zUFdZVzMyR1ZFekRYMDJh?=
 =?utf-8?B?d3BqeE41b3RCQW1aaitjcEVxYm1TRFJTYTUyNFJjVXVkZ3VqbWpSS0tUTWs0?=
 =?utf-8?B?TGRBOVVpVTFnMWp4YUpOVFduMDBmOEJFbGpOMThEcDVqenVPNFZUS0RSYXds?=
 =?utf-8?B?eUFoQ1ZnQzV2UElXRUZNckIxNGRTSmVyR2xsTFkveGg3bmp1QkJNZHhtMHEx?=
 =?utf-8?B?TWxDeDZVQzJsZ0FlTlJLdHk2VHZ6WVBmQThMRC9kbFdGNmRCSkgwWFFpTGxa?=
 =?utf-8?B?TXA1OHc2eXg2VzhYd24yRkRvYkhYdDBDZXQ3OWZJODU1bHBxYmhBN2JGbVpq?=
 =?utf-8?B?MlAyWXl2elc5ZW9oL3NZUElMczRscHdmRXRBK0lHanJ3QnhmdVRaSnVjK3E0?=
 =?utf-8?B?bWJ6UStTbHhoWjRja2JMbnVsa1kxVnhwN1lXRmdCMkd1Q1Z3KzZnVXYrcFU1?=
 =?utf-8?B?bmROZ1ZLd2FKQ0RCVFc0N0VSbWF4V1Jtbyt0aUMzNU13UWRJdUI5bFhydzdT?=
 =?utf-8?B?ZHBiUXZNVTI5UGVkeVR5TUxYdFJ1N1Axc21rMnlIL0tZdlN0b0w5eWRZRUdN?=
 =?utf-8?B?c0hrNlJPQ1NpREJ2cUNYWjh2UFRGUVdoMHRkWWlkZEZQR3FNN0NKdGgwSlNo?=
 =?utf-8?B?TWpPUFlXRTN6OXptNTIySk9pTytCOVFmNEhlUnNBVERXeFgxRWNJWitwVEl2?=
 =?utf-8?Q?YjbUOgk+SnfC+lhNkGaL0T4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9f1323-3741-4349-0c12-08dd4162e5cc
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 19:18:37.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+UEq9j//B7ypOm12eReq93wIrPV5MzMIosimuCAGZuvXa+vBoHOR+lkjGEZJN2givukSCwDxqgqRx/nbv3b7vYHtIBnZQ0ul9QApqZHW/WsD7Yo0YaxiYsbRas4Tb/e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8599

Tested-by: Daniel Ferguson <danielf@os.amperecomputing.com> # arm64


