Return-Path: <linux-edac+bounces-2144-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB39A47E3
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 22:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769CF1F21B5D
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2024 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504ED20820A;
	Fri, 18 Oct 2024 20:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LImBmv/t"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B671185B48;
	Fri, 18 Oct 2024 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283137; cv=fail; b=HvyH8k897EoiZ+SGv5g6yyNzAncpsdna5z9tFjV4TzWiY9BUcntx2QIpwkKU/OqTK5TPqrN/OUilMImPJDeL4rLQwMQJT9e6hgzEsYLbbN17lQD3HS8MXq3TOmqaPoPF9G2FP2DX6PeH/EyaX9dMJuWkVxwK46P2augKb2yoU5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283137; c=relaxed/simple;
	bh=+KScUmgzVKnQE5j9wI2ay7kHf7/P9dMsp92gfFoV8uE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qIg/dLYYqAt9qUkUKg4b4tDfN/gEqQ5xvEHwQvcXSCwmIJX/JYu7dKBMKkdgxUKPZoq4gJwPEk1FIxahSWYbG7ajd62QyRJoz0I39i1VI9+CgGgX9wA6tiNPblROeOyPvlNDMmDL7XMj5p/OPJtdUjYdclLBXP8TgkQdown+wNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LImBmv/t; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729283136; x=1760819136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+KScUmgzVKnQE5j9wI2ay7kHf7/P9dMsp92gfFoV8uE=;
  b=LImBmv/tHtq9qZjENgwoLq2y2Y8Ij4f7laSY6EWettmYFG3G5OkMnTO8
   +AWkPQC2Aj36andbV3Tt4mASvbebeSRWl1JMsZCla6Kj679LiGQr8or5t
   NZQ2pGqN7v972UvGnRqxLI8CN++Phmq1e7rOQLVnXaZTp14EeyTvpR2P4
   p9VT15MjvL7tVHj45OeaPCY0pYYq/0IrarbWWeAQUhCgBpz4/jebzMCcG
   MNmYY/ZmO5itxBbbz2IxCh5VzRW92TXheUOUwW+w2xcPW2ZFNdrGEB2fI
   S4uJukBBtLbDVLFGO3wmla6GDecOzbMwb6txxORVi2B7F2zynU4V3Tn8F
   Q==;
X-CSE-ConnectionGUID: e0H70j+FSh2a+NWTyw08Lw==
X-CSE-MsgGUID: fnWYI6/+QI6GtUbTKc6SYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39381089"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39381089"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 13:25:35 -0700
X-CSE-ConnectionGUID: NyGDlzQkQiWfC4n58bJDUA==
X-CSE-MsgGUID: CcqrDGGJS+6kN51BstA1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; 
   d="scan'208";a="102266156"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 13:25:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 13:25:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 13:25:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:25:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwNfc46ykKfPKtldWjErP/fyis6y3Ll4/5qytilJd+Gg8hYwK50GzPidyyXRyt367NX/10+tsWYUOAXgdGGP/kAkrymO/4oJRdU5XFpyBA+e8dHTI7xH4SFCdGD72PuZKAj8v1WY469HELRazMmyGWNXeO9Ax8KzoW7J3y2I34sgfnwVgdiav9sLR1xPhUttFehOvqQ6mffwgAtSHdegiZV+mtLPx5+8sTcEyKNlEpcopDhTJM+jw0C4cLqL/Y45UTapOuEg8uaTJUyGR39gl0s2INJ2wyFBMvlEOizH0wPz4vhOYvQJuoylgXwLsJ2MQmRQ8IqsZOCjc/WbuOTiiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWbCoBBvP+QP0COaZ3FVre7cdHV+jmsnBcrPNRuxMjM=;
 b=pB85HlNlqsmmtz+l5iwYRkYq3W9COKjNt8aJsQ9rgaVO8STRwloGkwan8VReLKNIXL8U6050SVTJXHj/UjKDlkd08FjRmdq0PQPPeBW/yvAeyvdBlUOJn7G1jMiByTfAMJiQdb00SBqHfYU/iReED/c+3eIn6xSEeZHy8FHU0MT+mxQqkDYtGcloeW3dbuD4hu6iV1+++TlYCAL2kzxtOxTkyH+/9cgdwpHfOOK47m5b0wVev7fMXQ81Fo4yknsqpq11hhrko9oxoHJd8AdbuhGfPuIN1OXpgjn949zzkapXhnjnfIXYX4kyw7uprBRCcWjGuCPtOYsPx0IxFlCdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 20:25:31 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::e8c4:59e3:f1d5:af3b%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 20:25:30 +0000
Message-ID: <f5d4d763-0fa2-4d84-8501-28d8cd8a1dde@intel.com>
Date: Fri, 18 Oct 2024 13:25:29 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] x86/mce: Remove the redundant zeroing
 assignments
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<hpa@zytor.com>, <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20241010153202.30876-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-1-qiuxu.zhuo@intel.com>
 <20241016123036.21366-9-qiuxu.zhuo@intel.com>
Content-Language: en-US
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20241016123036.21366-9-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: c5374ac1-ad0b-477e-f6b2-08dcefb302db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmhQU3JSVGlKTkxWd2hEVy9hZ01YT2JLNGFNZU9UUVZRbUZGWjdGODJoVGo4?=
 =?utf-8?B?LzJ0TTFIKytsdTZaU0VJYnZiT004WEUrdjhxQkdXNWYvOWF5ZFpwYnlPeGp4?=
 =?utf-8?B?NWlRbGxzWWZ0MVNiWTNIUFBoVjNVTS9mYWppUDhCOVpBS0Z2T1JsUkZwNHM4?=
 =?utf-8?B?VU5oRVBoeW5EcTdnaTRpQ2RNeTJ4dWN3b3dSUjFiS2JQZ2NoMlBNQktrNC9L?=
 =?utf-8?B?aHNBUnlTNXp6bGdxd1RubE9ac0lJV3NVbCs0blE2eElKZ2NuSm0zME5valFj?=
 =?utf-8?B?alY2UmVxNmZnTy8yd05RY2xrZkxNU0xjMG83ak8zRmd1THlVOXlJY253cTFD?=
 =?utf-8?B?bHZGcFZXaXJVMVBMM013a241YVFZQlhXQXVoRGVSNzA4T0dXQWw5Z1VYd080?=
 =?utf-8?B?TlppYkJZZFJFTHpZYnZEcExnUHlBbzAwT2VlaExZTlhTaFpPOGx4Y0w5U3dB?=
 =?utf-8?B?UVF6QU14RVVQbGw3UmhEMjRqUis4WFl3cThYWW1vY0g0SktySnNMUnVMT2I2?=
 =?utf-8?B?SEY0Y1ZCcHFpSXJJVEE1VmtIdEM4aFNZbmpYNm9jUktvbjVTbkNRZFRpcjZF?=
 =?utf-8?B?cEIwdWpUT1Yrc080NXFvOFdienQrSlBXUTdhdThEQ29mNEtaZFhvUjZONU9n?=
 =?utf-8?B?ZEtIWWt5bUJPNlZMTXJ0cytDUm5ZRnAyTy9vM0hzUllWRU85MVJMMDhhNGl1?=
 =?utf-8?B?U0IvWUNjTDM4eUJyOVJucmd5ZktVMkUwb20wK2FUSWdZbzY0M2huUGxPTlNU?=
 =?utf-8?B?Wk5pazZYUm03Q0ZXbWU3TXZ4UGJqRGJnWmM4eldRdHF4L1U1NjJ1cUE3NnlX?=
 =?utf-8?B?dWw3ZHIxc29sWE5GdG1ROXhicGs0V2FzVnlpaTJSSFBBN0lRbFd2RWtxbW5H?=
 =?utf-8?B?YlN3clJMOWxEL2dKOGRZaUZRNXdRczdjWXYrbzNIS05LbWdRdWRMOFRmNWxN?=
 =?utf-8?B?eWJUNm54bWZFcjdxQThNbm16amVCaVVEL085WlFWWW1JNENyalovbWpsa3By?=
 =?utf-8?B?N2dzd0c3UVFvTkdhOFJsQ2tkbVhTK3ZoVVZIMWxCd0FOOUphK2xiNWxKOEhI?=
 =?utf-8?B?ZGZPc05yUnFsdHJyY3FkTGoweWRGQU1ocnppMlhxVjZmeGxPYzhTcDdUL0NW?=
 =?utf-8?B?NzVDTmJQdWJ1cDMrc1E0R1kwekNFZG9UdGZ5dWRiZUkrRnBrZFh3L2YvZDN3?=
 =?utf-8?B?QVRMRkdoWmhYaFUyQm1lTzl1TXlQcUlVTm85VXhyYlFLVUk3QkN3REZGa29t?=
 =?utf-8?B?VENETFpzeWhiY1I2VGMyOEs3cVpPc0VzeUJRYTJJNXRQQzN5N2ZBRnkxT20x?=
 =?utf-8?B?TXFJUmFQeTZMeFRDL2RBR3VvS3cyRmptanFNSllCc2kzZHhHZWhHSnJCY3I4?=
 =?utf-8?B?SVJLdVFwaWs4UVd4RnZHZ0xGcUcwTzAySUxzMVVvRU0rMGF4aE1Lc0RLTk0y?=
 =?utf-8?B?ejZvMHFHMjNEQzFvUDJzMHcvTjZRa1o1WEVaUC9meStwTi9RWDd3MStSMHVs?=
 =?utf-8?B?L0dqalNOMEhGWTU4K3R4dzJsTFdVOXdmNFlheFhYbWpQSkR4eHd1MmdxWXpn?=
 =?utf-8?B?SE9lYTgzNmxYMWxGakF0Y1ZGdkRhVjVOSEFTaEtTZmJxUEVDYkVVc1dHMXZm?=
 =?utf-8?B?Zy9RTk9SNUVkWlg0MTVnem9SMURZR2htdmdkaXIxOTdPY2tHVUU0c3B3di9t?=
 =?utf-8?B?M1B3WHQwM3FlcmZNQUt3eUc0cEYrOTVpNE12T2FScUdWRkp2TlBYd1ZEeFpC?=
 =?utf-8?Q?0S3ZMK8IeaHLtXUYLXA5o5ia5v1Nb+DerVE8RcS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDhDeit6Rkpza1cxQnRoZzloUFdXUkQ4alJNbjVvbUJEUE9sSmZEa2luc3Js?=
 =?utf-8?B?V3EveFNqNHRZbjlmUDhGRFIrMVhTQm0zR2lReUtodXFHcTNkYWtDTVRNb2hD?=
 =?utf-8?B?UGI5Z2FtL2MwUmIySkJreUphbDJhMGdRNkpUVkFQNWw2YU1ON0ZTTkorMHV6?=
 =?utf-8?B?MmU4VG91eS9scDhub0xQSEZCOFp4M01GWUxCUU14c2hoRXR4T0dROEI3WE1l?=
 =?utf-8?B?aGpJMktsUHFYWTJYVE9vWkMrYmZVMk1KZGV3bXVuNFJLSFZxRnRmK2R0U2tR?=
 =?utf-8?B?UlFxZklYSGw0SkhNOFZjWUdsYTI5UVZqWXRHUjF3TXlGQW1ham5VMU9PZFZH?=
 =?utf-8?B?MkcySkJ4cnZwU2xGYnBpSWcrWHMxaFdzb1RVYnAxNkhjRFllR1VEYUM1Z3Y3?=
 =?utf-8?B?WDJLK1FTb0FBeHI4S2liRlZabkVhTjRtZFFHNmZxV1E3a29vYmxrblBrZEJz?=
 =?utf-8?B?UnN0TlRldzJMMXl3MXpRZm1oY1BOdG1odm05SGpPU0t4Wkw4UnhEaEVhY09I?=
 =?utf-8?B?VFArMmowOG12QytqNXdnOXIyTkFTOFlMVU9uaEhHR0F1NkorQjVNek5IMGl5?=
 =?utf-8?B?dm96WjEycW53U3ZBSWNqVyttK0YzRUJKOXkyaVN3TEo4NzEwSnlZVWJGa1ho?=
 =?utf-8?B?dFZDMDh2WHhiQW5ZSHhERjhHY2I0bEVYaU1tSEFHeTNIMVU3ZjlEaGtnbFgr?=
 =?utf-8?B?RTV4aTNPbi84VHpHQlk4ZWE1NGduNlpNd1F2cm8xdTN1eVplbENUTzIvRjhQ?=
 =?utf-8?B?ZVUxdUN4N3RFdFl2SzF3WHVtbkFCeFcxTG01R3k4U3J4bmUzbEtISkxidzdM?=
 =?utf-8?B?aXlQcEhoa2dWVVpHSTY0RmtqQlhRa2NVZDBnU2c2ajZCajdhYllnZDR2Mm1n?=
 =?utf-8?B?clA1ZjVWK3JBclFjSTJvM3JXQWpoYVRoekx3MWJMbUdZeHJTVGNnczdSUHRF?=
 =?utf-8?B?V0o2TnBYT2hucHlxRW1zTDQxUVJCZlQvVGgzU2tuMEVMS1dqdEZIMEFibS9i?=
 =?utf-8?B?MlJGNm42eTZyY3hzVTlsUElZNnlSSzFhZnpjeHRQMW55cTJkbkNYbCsyV3Yy?=
 =?utf-8?B?VDhJZjFXd05BYWZwTVVuTjdWUXVqNElXSHcxYU5NMUpJejdzaFhTY2RVdlkv?=
 =?utf-8?B?R0phQ2h6SlJnbkpyUkF4c0xhOHY2cnNnM0Vad0p5eVh3T0hIZjRHZVc5MEdU?=
 =?utf-8?B?MTlvZ1dpR0VwaDhqOUlmTVRjWGxNVUx2QlFYZFBLNTlqSDdBamRNNmRMd1dR?=
 =?utf-8?B?SnowTU1iUFB0Ykw4dDl4Wkt6OUkzR2oyN2x4OEVhQmRaakcvZFhHNngyMjRh?=
 =?utf-8?B?bEFpb0g0SUF4SUgzUm14MzVpanZwQSsxY2JjSnIyU08xVVh5ZHpVeXZHOXpq?=
 =?utf-8?B?bE4wN2U3S0lhVlNPbjlkQmZyMnJseFp4WnVHODBWWlMwZEgxQk0rTmlPTGty?=
 =?utf-8?B?R0FRZ3pWQk56bWFERVBjKzhXZ2pRTkxhaDFURWFsODkzR1RWeUNEQ21pcFVH?=
 =?utf-8?B?aVo1dUpaTlhycXp6WFEwbXprOGJTOVA1VFREeGI5M3BDQU5IbXJzR21yQ0lh?=
 =?utf-8?B?SjFZaFJ0cjJsRkFBdWljK08zTEd6bE5ONHBCY1oyaVlsSEtITlp1RTM3dlp3?=
 =?utf-8?B?Tkc1RFZjaUswdnJQc2tmVmp3MEtnbStwM2RIMGQ0NTRzZFlPRVRua0NaYlBW?=
 =?utf-8?B?RGJTaDIvcFNaMGFLNEQ3RzZlOU5xZ1NLTXZqV1l6SUNyclB5NmlxWlNzSWQy?=
 =?utf-8?B?czczYTd6djBFTXVWb1cveENRam1BTUNZNTBmL04rQ1daU1dic09vNko4TXVS?=
 =?utf-8?B?d3k0OENxNHlwUlBqSWRkckFZVVRxRUZuNXJqUXhheUM1L1RrS3FMb3BEV1l6?=
 =?utf-8?B?VEZCWGZaenFuUW1US292dGNiRXFIN0dCanc0bFVWb2VRcGtmWTR6alRoQlk1?=
 =?utf-8?B?SjlFUm1NUS8yWXp1eU02bjhFaE9WNWZqTDhTTU0wb3BrVGhJTVhKT3hyam9u?=
 =?utf-8?B?RXFZM2lsMG8zNjIraGdLKzJUTlIzZmgrQVlKbXBkUVVBWFhLcGo0S2xDSDl5?=
 =?utf-8?B?eTVCUTZFcis4b1M4ajJpMnpZL2VaOSs5UG1rSW8wcTJxNy8yTVR2ZSsvb0J2?=
 =?utf-8?Q?DVzshqMzUkHCuht6KmijBhw6C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5374ac1-ad0b-477e-f6b2-08dcefb302db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:25:30.7071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3iu0jSoWkAQ6uZVUJ7WmFX2ap1STyS1c5GYOZWry8AMwTMCvmRWzV8zXjQ6c00TKw9ZiZWaXT4c0PUnEVaHEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com

On 10/16/2024 5:30 AM, Qiuxu Zhuo wrote:
> As the entire mce structure is initialized to zero using memset(0)
> within mce_gather_info(), remove the redundant zeroing assignments to
> mce->misc and mce->addr.
> 

...

> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index e718b9bbe8e5..844a6f8d6f39 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -706,8 +706,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		if (!mce_banks[i].ctl || !test_bit(i, *b))
>  			continue;
>  
> -		m.misc = 0;
> -		m.addr = 0;
>  		m.bank = i;
>  

This makes sense since mce_gather_info() happens in the same function.

>  		barrier();
> @@ -1284,8 +1282,6 @@ __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
>  		if (!mce_banks[i].ctl)
>  			continue;
>  
> -		m->misc = 0;
> -		m->addr = 0;
>  		m->bank = i;
>  

However, in this case, I am not fully convinced if the misc and addr
would already be 0 when we reach here.

There are potentially a lot of things that happen in do_machine_check()
between mce_gather_info() and __mc_scan_banks(). Especially,
mce_no_way_out() which could theoretically call mce_read_aux() in some
cases.

Maybe it doesn't matter, misc and addr would be overwritten anyway. But
I feel some more details in the commit message would be useful. It
doesn't seem as simple as the brief description makes it sound (at least
to me).


>  		m->status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));


